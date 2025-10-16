Return-Path: <netdev+bounces-230114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440FBBE4337
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C583A5A7E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0014343D86;
	Thu, 16 Oct 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kCcPqe/R"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618150276;
	Thu, 16 Oct 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628237; cv=none; b=LaClO81nnci2J5mn6exDJvmTz5XRE3ShX/RJP8FfGeZcWsR1SSVe2mL6If7UUm2wYpbdJCI//eKpKA9uaBDG48uqxpc5CCxX0NmP2eRLuDxYck62HP26s0oO30nk+ZcXPBSQclbOtidNooXswV/jGRgaOqZA5Jv9W26gFTYjY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628237; c=relaxed/simple;
	bh=lSQcrpJujZ2Zn7EyUkuhtA5+PREgv2QVaglp2zFRVu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfpSkdi49X/DHw40CSzA6hmygNlSXusVB+2AxU4jkBzo3bSx0PfUq51Qz9WTDFJpXcOUxCWcjFbDieSSIAoByyV3bLf6Ugf6R4nXYQsokvBXD2bMPJTKij6ZiMnsRtVYE/GLra4NtpmIVPvqWDSEIWDTpw0aYbgYN+s/aWPS39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kCcPqe/R; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jkpqIzFsR2xbDXaPyvHP1YHoJg8+h7JIzUZl2IlIIFU=; b=kCcPqe/RCt1u9eVBJ5LO7h8ekS
	bQPQKUD/JB/8ENc4ZIJj2e5OEGEHUH9XTwg76H4MZvmdfWv4V64AMT0DFrSV+0ao6YVhp3CCDy9wf
	dhCmYNUbtI9LWqDyjqzeJ9qMRRl5Abrh4OM1GfGTMNeWHsO9FgsSHa+a6UvHq52uw91muUBHmdL4A
	RYK4febFm1WKzOzj2M3YO4OTiFT/2EC7arNjdrSSmai20KfShui6OdTkb5L/uPa0Yw6GIioy9TXNE
	szRM7CknKwrNctK4HkvtctwOxLB6OZvCK3IwsOlk3elrOnKl0uUeXI/dlQZsyyHakl1altA1PP68Z
	1SYBTCHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49202)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v9PpX-000000006dn-2TqX;
	Thu, 16 Oct 2025 16:23:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v9PpV-000000003Nc-1A3r;
	Thu, 16 Oct 2025 16:23:49 +0100
Date: Thu, 16 Oct 2025 16:23:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [net-next PATCH] net: phy: as21xxx: fill in inband caps and
 better handle inband
Message-ID: <aPEOBRytURg6vKqN@shell.armlinux.org.uk>
References: <20251016152013.4004-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016152013.4004-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 16, 2025 at 05:20:07PM +0200, Christian Marangi wrote:
> +static int as21xxx_config_inband(struct phy_device *phydev,
> +				 unsigned int modes)
> +{
> +	if (modes == LINK_INBAND_ENABLE)
> +		return aeon_dpc_ra_enable(phydev);

So what happens when phylink requests inband to be disabled?

I really don't like implementations that enable something but then
provide no way to disable it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


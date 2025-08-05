Return-Path: <netdev+bounces-211679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F28B1B209
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074B47A9F4C
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D323B616;
	Tue,  5 Aug 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1OPuWg8/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44543B1AB;
	Tue,  5 Aug 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389835; cv=none; b=s1GkBH1CbCgfpRtU6nsWFOyAfin6mhmHcyyTU38L+YvZnWMqxIEkhAuZXySSxw3qIvj/rQc4OeUg+iZJnjTEMPOLIXa7lrJY+mvjata3aqznCqAfZJ54UFC6UcbrJb3d67zGUPxff5S/uKkVfVELCImnjBdnSNe1IOCEtyQaNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389835; c=relaxed/simple;
	bh=vaA+8/eR6MtsiPek7M3+mNf+dd23V7CR+smlKjGGmlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg4CfinmC6+fogDsY0TUJ6CGP3GLc4XDdIeJfFuDzY2m6dTqbZxBevZ9qjpPWetB2AmiMGaZEIM6MoPcQAekDiYD05PZN5GKNqVxoXt/kbyMvxKkbuJUu/vBjr4MBLPsJCp/MpyLmLXRn9fscveZ+dh/12OpN8WS3F4L86h/i5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1OPuWg8/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/N+pabulBvha5ZEhN29wupcgWLXk3sW2tBjPgU74Mpk=; b=1OPuWg8/x1VCIQSz1+viSjZdDU
	698zT2qyHXZDGe+4K8fpJnRl13r6a/YyMNqF2vKIljJk5TZcNu/3/OZICgz7kH/DyaQrIVvF/VOuO
	RKo7+PAI+2C5XKRTzqyaDg5Ruazmq2KWOTZoSvO8fEOtGYJnn2DyXUWQPBiSJPPEx3nssI3Z+r8cG
	OSv6ugU7fCyaZ7u2TA6RmftMbisSlWxNRnACxFJGob+lLOedoQ00kPZi7tvFZRZuVhx/A2itZraVB
	EdxsabgA+oGpGUEN24zU+HjT29x8mGZoUjfSBwORfixBnjRI23pCStEW6vmI9JfWbMJqamoD7B3Ky
	BZ66+4dA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53592)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ujEvw-0002us-1r;
	Tue, 05 Aug 2025 11:30:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ujEvs-00060p-2B;
	Tue, 05 Aug 2025 11:30:12 +0100
Date: Tue, 5 Aug 2025 11:30:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] drivers: net: stmmac: add
 STMMAC_RELATIVE_FLEX_PPS
Message-ID: <aJHdNMWPqNsU9AiK@shell.armlinux.org.uk>
References: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
 <20250724-relative_flex_pps-v1-1-37ca65773369@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-relative_flex_pps-v1-1-37ca65773369@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 24, 2025 at 02:31:18PM +0200, Gatien Chevallier wrote:
> +config STMMAC_RELATIVE_FLEX_PPS
> +	bool "Support for STMMAC system time relative flexible PPS generation"
> +	default n

There is no need for "default n" because the default default is n.

> +	help
> +	  Say Y to add the MAC system time to the arguments passed to the
> +	  PTP driver when requesting a flexible PPS generation. This avoids
> +	  the tedious task of passing an absolute time value when using sysfs
> +	  entry.

How does a distro decide whether to enable or disable this option? What
does it depend on?

If it's only for some platforms and not others (due to causing
regressions) then what is a distro supposed to do with their kernels
that support multiple platforms?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


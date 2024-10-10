Return-Path: <netdev+bounces-134242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18679987B8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8541F230C5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A315E1C9DE9;
	Thu, 10 Oct 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DTLmjqxT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61D1CB315;
	Thu, 10 Oct 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566982; cv=none; b=ARzv73UYmj7N4/qgWaO8me0m5DHeJSd4Yrs3wp1QjQYNG8ijS4DwbYM+CrL0EZSYcW+AtaYj8m7+Wcyy4IO/PAQifmI8czXYnSx/8x/9c+vJbapSKE5IqE7zrigbIBGKgRzvqQk1D9V67xn8zBoAsXj1hhlxiGkQ8w43yhF+QtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566982; c=relaxed/simple;
	bh=xHqG4InBXnZvDj8emKP4KA5JTJ1It4rddbTOZz+OF0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTD570PxteDPEmIMoouCcabWO8TbCdZ78nlBOqUR4w4hkjzhUtZMJ18hl6kzonby2+4U7saK9lLNVuQ3TGYIXe8eGmCz8D4V5n8VyfNmzShtNe80+nkYle5Ge2SJzLQ5u1iyUNCR+RA8cY3QBo2Kkzfawv7/ZpF84Ceh0S4OroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DTLmjqxT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HDLFWEm6yHMNFBa77x6Y8xTBBp+QWOFLt9inajnXMFc=; b=DTLmjqxTSs6pto7fnJJwCbCa9a
	ICj+MO7TCk2zFxbITkWRWJWQMlxUU6oLH+4mzzqy79ysVshQ9lSfX+y8oE/attj5ca0JbTxHI3ktL
	rCVtz0kQNvmYPWmKLaOmFoDPCnSFzs+ovlV05FAgbBMqmROlooGXlvvS5YdGXVYylEXxxbTIGIT7L
	a+7CMQlOAZdpOLGcFxGOnP/ZVU/hWSAqmnOU2SSrQHfk1ZF/6SiC288AFrW/r6CjutMszHmewoYnB
	vZNOaneVAMjMVieZ+M+WgF481u8ect8FiISf7bAjxy+U1b/W36X/yj0HVecEENBuKLO7gthBIYLwQ
	Gvasc5gw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39942)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sytES-0002TO-19;
	Thu, 10 Oct 2024 14:29:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sytEQ-0007Lu-0d;
	Thu, 10 Oct 2024 14:29:30 +0100
Date: Thu, 10 Oct 2024 14:29:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phylink: allow half-duplex modes with
 RATE_MATCH_PAUSE
Message-ID: <ZwfWuiCmlOzQGww_@shell.armlinux.org.uk>
References: <d6c1a15cdf2596c2f68eab912c79635854cede9b.1728566181.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c1a15cdf2596c2f68eab912c79635854cede9b.1728566181.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 10, 2024 at 02:17:53PM +0100, Daniel Golle wrote:
> PHYs performing rate-matching using MAC-side flow-control always
> perform duplex-matching as well in case they are supporting
> half-duplex modes at all.
> No longer remove half-duplex modes from their capabilities.
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>

Please change this to:

Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

It's important to get at least the () bit in there.

> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


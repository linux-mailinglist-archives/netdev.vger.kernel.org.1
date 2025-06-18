Return-Path: <netdev+bounces-199075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9895ADED7F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727263BB427
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2022E3B18;
	Wed, 18 Jun 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YMF1N/Dw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E884A2B;
	Wed, 18 Jun 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251708; cv=none; b=UpxvvwgolVRbFNQT/nsRGLvJgKcL6Y1P2xpPtRVClCwYYwqs3Qd151+NOQIRI4KXqI1RD2Kbz7xfGZL28/3lw5apXKf1B2Hxt4T219fxcalVxxBZ5gO3Lr4GWB1+h3vYIChtzkLUb8n9Bt6ubBdS1vOE1r8lL1uhuo1dNQ1udgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251708; c=relaxed/simple;
	bh=NYZYSSve7QHWHfqE4xO8B7PhBRaUetfbNJNkYtQ4ezY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSYpWzj0gf2pTzKB7VyHsBrl8E+Akh0xpS2TX2mcSEaAde/pBLIrCu7hLW8d6+oirgkyqu+nbqaDHSiULjpn2FEGSBG8wHJqTkiGF2RCA0hwh9/Z7B94GETkUgZddL3cA1oVdBzNjP8+YscsWUQEMOngUmF6kaAx2GZecQZQ1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YMF1N/Dw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NuZPEnGK2UT8OIemmJKYsUbIdmar41JE/LEfSfWAXkI=; b=YMF1N/DwVMLurWX8fHwWtdqhuG
	graSvGX8/nHXe7PrDRPdTnlk2XjMoajpw4QuVFJGfQJEN/W5nN/FcWlIFcvzJGQnIXVcEGXHD9gwf
	t65R+fBA41oPe40V9Paex4EgbGw5O4YWYON4BScYZbm9lsSZQedKIul14BbhMkFE9Qr9nCBkEL2B4
	4OvevnLF4eyDVtWBwq1luk29I7hSCQEIRvzpaZJBYLdSeIZ4cMbGJ8b5sjxU/j+yTz8k5qnB+BGul
	MbwhXZW+KBEqca8JY5N19OJOw/LS2b6sxkKdBvQGWZJS/gPi29KssQ+YJLJoewVQNnPJBVbu3YaYA
	o25T0bWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55674)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uRsQ7-0006Uk-0w;
	Wed, 18 Jun 2025 14:01:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uRsQ6-0006r5-09;
	Wed, 18 Jun 2025 14:01:38 +0100
Date: Wed, 18 Jun 2025 14:01:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v8 6/6] net: usb: lan78xx: remove unused struct
 members
Message-ID: <aFK4sc9d8e_vopcN@shell.armlinux.org.uk>
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
 <20250618122602.3156678-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618122602.3156678-7-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 18, 2025 at 02:26:02PM +0200, Oleksij Rempel wrote:
> Remove unused members from struct lan78xx_net, including:
> 
>     driver_priv
>     suspend_count
>     mdix_ctrl
> 
> These fields are no longer used in the driver and can be safely removed
> as part of a cleanup.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


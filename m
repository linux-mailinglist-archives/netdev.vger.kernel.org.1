Return-Path: <netdev+bounces-176158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A7A6931F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0784316424F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE815574E;
	Wed, 19 Mar 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CuZYG3Ka"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE8194A44;
	Wed, 19 Mar 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397275; cv=none; b=F43Jbq8akRBFHPX+i6TECcmS/CYi1sjT4jBFI9P8PN8Hf8OdRnl3UbLBDr2wY0V0dbdhvV4X7rJFUzdvOZ7PJbc5FRCnLLIl63fyqxuccDp7E6RvPuyL3ocTyIRVLq7/vgoEdsoMXqatNEHsXxLEONpjEcpxLRRozQ2owY2qaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397275; c=relaxed/simple;
	bh=mF/RZx1Yy1BkkxCgM2381e/rIkeBCqP+m+kFTLjeyN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns+AfvREUqgVsAPB4+u3xDKw74olaZnli3PPpg5CTp+32f34ri01LyDt04B4w0Z/CohHQ+hU5i8UTsDNpzzYkCDAjaSyu/bfCt3hyATQ5/L0GxgT8Gyozo1bqAr41jlGpdWRkJ8tUNRKXNmE0y7r/9k7lq+sKDdb+EQeWyt/ZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CuZYG3Ka; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z41GrnjJQtgPa0jA4wY3lEfrsRJ3lxR6kmWjvqrQo98=; b=CuZYG3KaRTjGweeZqzED97EuQo
	O9LKGTXEIj6HzdAIJJoReTsyO4ERHxTjQ0YsDwmwbdDDkOWJ8jttI7CGrnzzzx7Njt8AS0uotcTkV
	tvQF3usX57ayx8VnmRpbYNjr2v76wggE5BIjO6SqWQPVjYFuFkNFZRGISaj6r4nxFXLt51uCtI1EH
	HTdJR8aqUoRFoIBkngY+ftLI0p8qrZlhDwtQXv3C5WqsOphUbhUfXA76XA+Q5N3Ucl5J+JxAooi/i
	v73pkKUOg689C8Y5JKUdsPfKEWymJ2+qVOD3LdisgsYvLTUXG8eUvQnf+7AbpOM9QcyG8M72aEoKz
	uK06ACEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37282)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuv7d-0006a6-2q;
	Wed, 19 Mar 2025 15:14:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuv7b-0005i3-0C;
	Wed, 19 Mar 2025 15:14:19 +0000
Date: Wed, 19 Mar 2025 15:14:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 2/6] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z9rfSuUO8P7RECOn@shell.armlinux.org.uk>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
 <20250319084952.419051-3-o.rempel@pengutronix.de>
 <20250319114802.4d470655@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319114802.4d470655@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 11:48:02AM +0100, Maxime Chevallier wrote:
> Hi Oleksij,
> 
> On Wed, 19 Mar 2025 09:49:48 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Convert the LAN78xx driver to use the PHYlink framework for managing
> > PHY and MAC interactions.
> > 
> > Key changes include:
> > - Replace direct PHY operations with phylink equivalents (e.g.,
> >   phylink_start, phylink_stop).
> > - Introduce lan78xx_phylink_setup for phylink initialization and
> >   configuration.
> > - Add phylink MAC operations (lan78xx_mac_config,
> >   lan78xx_mac_link_down, lan78xx_mac_link_up) for managing link
> >   settings and flow control.
> > - Remove redundant and now phylink-managed functions like
> >   `lan78xx_link_status_change`.
> > - update lan78xx_get/set_pause to use phylink helpers
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> 
> [...]
> 
> > @@ -5158,7 +5137,7 @@ static int lan78xx_reset_resume(struct usb_interface *intf)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	phy_start(dev->net->phydev);
> > +	phylink_start(dev->phylink);
> 
> You need RTNL to be held when calling this function.
> 
> I'm not familiar with USB but from what I get, this function is part of
> the resume path (resume by resetting). I think you also need to
> address the suspend path, it still has calls to
> netif_carrier_off(dev->net), and you may need to use
> phylink_suspend() / phylink_resume() ? (not sure)

phylink_suspend/resume are very much preferred in suspend/resume paths
over stop/start.

Remember that phylink_resume() (and phylink_start()) may result in the
link coming up *immediately* so should be the last step. stmmac gets
this wrong, which can cause problems (as well as solving the lack of
RXC issue.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


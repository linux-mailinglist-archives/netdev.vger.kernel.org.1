Return-Path: <netdev+bounces-177590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7056EA70B11
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFA07A73A6
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA2267723;
	Tue, 25 Mar 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PV9bb6bG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CF2676F3;
	Tue, 25 Mar 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933218; cv=none; b=q2wcumHjuzd4RcrRjcXGEaDQBsSDVcr7bctPCQr2OAIVMq5pQ8rx57ka315++fjwrSyIkLsHC+z6uQpdS4Dkikia0qQfBoTCkYwMRYazScT550UhdB3C8JHmYjOR/Exj5dbBU1gGj9Ao0LvUKXxQcKqkf/U9bIJgSKdhpm8K/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933218; c=relaxed/simple;
	bh=l7C8LIRo3jzIHuUJ93UZmTfHkJn7Pu3Uak0d0iCS0yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA5/bt3lhdatHxORNDXuByt3OuBD9EpqfVM3enYh3H/nmJt/lw5Zdb320+WNQy+3B1fyIYUIf0ERDFf5IXfZfdYwO3/dKNCxPTFA6AAQvns7I1j64+gSkXydsbA1KnBnAgXAY2vAtM4jNJwbJRXva1e9kats48Ywk8ssYIlNb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PV9bb6bG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RAsui1tHpSbJgGexr5H0HED26l04puvhVJUKlrM78oU=; b=PV9bb6bGXb/fjjN4gsc629oAIo
	4eV1l1Pd79eugrcACzEeJZQ5Wnd8ktYgMTeBCBzBRs+5v5s7YSG/IIYlEMsyncYN0w7Y9RBQ3yQD7
	h3CH0ah22FLGTzbWfw69Dy4ZmcX7/WXetew5b9ILVo+FgvpBI/QONoJ4tMz828Mz+TOI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txAXv-00765D-Ba; Tue, 25 Mar 2025 21:06:47 +0100
Date: Tue, 25 Mar 2025 21:06:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rengarajan.S@microchip.com
Cc: andrew+netdev@lunn.ch, rmk+kernel@armlinux.org.uk, davem@davemloft.net,
	Thangaraj.S@microchip.com, Woojung.Huh@microchip.com,
	pabeni@redhat.com, o.rempel@pengutronix.de, edumazet@google.com,
	kuba@kernel.org, phil@raspberrypi.org, kernel@pengutronix.de,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v5 1/6] net: usb: lan78xx: Improve error
 handling in PHY initialization
Message-ID: <d1ce9f0d-9158-47ee-a60f-640822e35610@lunn.ch>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
 <20250319084952.419051-2-o.rempel@pengutronix.de>
 <5f9b4b549d45c1c1a422c6e683a566b7a125f2a5.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f9b4b549d45c1c1a422c6e683a566b7a125f2a5.camel@microchip.com>

> >  static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
> >  {
> > -       u32 buf;
> > -       int ret;
> >         struct fixed_phy_status fphy_status = {
> >                 .link = 1,
> >                 .speed = SPEED_1000,
> >                 .duplex = DUPLEX_FULL,
> >         };
> >         struct phy_device *phydev;
> > +       int ret;
> > 
> >         phydev = phy_find_first(dev->mdiobus);
> >         if (!phydev) {
> > @@ -2525,30 +2524,40 @@ static struct phy_device
> > *lan7801_phy_init(struct lan78xx_net *dev)
> >                 phydev = fixed_phy_register(PHY_POLL, &fphy_status,
> > NULL);
> >                 if (IS_ERR(phydev)) {
> >                         netdev_err(dev->net, "No PHY/fixed_PHY
> > found\n");
> > -                       return NULL;
> > +                       return ERR_PTR(-ENODEV);
> >                 }
> >                 netdev_dbg(dev->net, "Registered FIXED PHY\n");
> >                 dev->interface = PHY_INTERFACE_MODE_RGMII;
> >                 ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
> >                                         MAC_RGMII_ID_TXC_DELAY_EN_);
> > +               if (ret < 0)
> > +                       return ERR_PTR(ret);
> > +
> 
> I noticed that fixed_phy_register is removed in later patches. However,
> in the above implementation, if a failure occurs we exit without
> unregistering it. To avoid this issue, can we include the patch that
> removes fixed_phy_register first to avoid the cleanup scenario?

phylink itself implements fixed phy. So it is being removed later
because it is not needed once the conversation to phylink is
performed. If you remove it here, before the conversion to phylink,
you break the driver when it is using fixed phy.

With this sort of refactoring, you should not break the normal
case. But there is some wiggle room for error cases, which should not
happen, so long as by the end of the patch series, it is all clean.

So i personally don't care about this leak of a fixed link, at this
stage.

	Andrew


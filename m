Return-Path: <netdev+bounces-222640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66DB553C9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F55C171C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E231283E;
	Fri, 12 Sep 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pi3cyn4z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2B220F5E;
	Fri, 12 Sep 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691505; cv=none; b=rMKlH0BoMVtvP2OEQfWZzCNBmpiPpihLAyubIzNNgbLWdJKe+jfDfAr8BKtk0ylYbL/hGNlUM5g4gFYJeuDfoN46qs2hNjqi87DUwqNPBbNRGgG+oiKRr45hbHLLmttHtzLUo+/fv8WIJaVZwf1o/KUGjQ4L8CdIkHL+gWsgSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691505; c=relaxed/simple;
	bh=U3iC5vtTF1sdjSWhHISaKqkprAL/K5075s6FOjc8090=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqckSBOhCpTv79Och63IpGAaR3n37sMyQt/6sk1EqaLDDsnaq+uhZYfe4WEe1b1bfPoXajjpsghV3mi7ysFEFeFtzGmAnGp6weqIdedv+bgaMPxSIE0gdO4UGzBTgH8cSUBfYW44ITGkN4O1eWV4G0SeVxV9K0P1RPuHEl6T9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pi3cyn4z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xY6p/JCFndgzdcWAZlXcYogLPLmjN7VEQ6FhZTkrGe4=; b=Pi3cyn4zr3+RLY0VShr9spMvFy
	TGcyAhITqIU7vcemcTy0rWDDrk7ZGAseYhr399Gn4J64YRAKSl0hsZCo5TtvaCmi67kH7lh6B4a7z
	Lss8SNfy9VkpahEaB8/8vaPiIviYWoVhpu6upDXSjxmZTSAUFnqYI1ucVBkr1RkH1ybs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ux5qh-008ENQ-3k; Fri, 12 Sep 2025 17:38:07 +0200
Date: Fri, 12 Sep 2025 17:38:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <47ec4174-ca82-42f6-be52-f28e75c9f007@lunn.ch>
References: <20250912024620.4032846-1-mmyangfl@gmail.com>
 <20250912024620.4032846-4-mmyangfl@gmail.com>
 <ae9f7bb0-aef3-4c53-91a3-6631fea6c734@lunn.ch>
 <CAAXyoMPLRHfSUGboC4SO+gBD0TdHq19fNs7AK3W2ZQnHT48gyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMPLRHfSUGboC4SO+gBD0TdHq19fNs7AK3W2ZQnHT48gyA@mail.gmail.com>

> > > +static int
> > > +yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
> > > +{
> > > +     struct yt921x_priv *priv = mbus->priv;
> > > +     int res;
> > > +
> > > +     if (port >= YT921X_PORT_NUM)
> > > +             return 0;
> >
> > -ENODEV.
> >
> 
> mdio-tools complains a lot when returning an error code.

It should. There is no device there, so its an error.

> Also that is
> what dsa_user_phy_write() returns for a non-existing port.

I would say that is not ideal. If you are trying to write to a PHY
which does not exist, you want to know about it.

> > > +     unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
> > > +     struct device *dev = to_device(priv);
> > > +     struct yt921x_mib *mib = &pp->mib;
> > > +     struct yt921x_mib_raw raw;
> > > +     int port = pp->index;
> > > +     int res;
> > > +
> > > +     yt921x_reg_lock(priv);
> > > +     res = yt921x_mib_read(priv, port, &raw);
> > > +     yt921x_reg_unlock(priv);
> > > +
> > > +     if (res) {
> > > +             dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> > > +                     port, res);
> > > +             delay *= 4;
> > > +             goto end;
> > > +     }
> > > +
> > > +     spin_lock(&pp->stats_lock);
> > > +
> > > +     /* Handle overflow of 32bit MIBs */
> > > +     for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> > > +             const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> > > +             u32 *rawp = (u32 *)((u8 *)&raw + desc->offset);

One thing which might helper is make yt921x_mib_raw and a yt921x_mib
union. List all the fields, but also have a u32 array. You might also
consider a u64 array, so you don't need to construct a u64 from two
u32. But you need to check alignment.

> > > +static bool yt921x_dsa_support_eee(struct dsa_switch *ds, int port)
> > > +{
> > > +     struct yt921x_priv *priv = to_yt921x_priv(ds);
> > > +
> > > +     return (priv->pon_strap_cap & YT921X_PON_STRAP_EEE) != 0;
> >
> > What does the strapping actually tell you?
> >
> 
> Whether EEE capability is present.

This is really a strapping? A resistor pulling the pin high/low?

The silicon itself should know if it has EEE support or not. Strapping
is normally used for configuration, what are the reset defaults. So i
suspect this strapping says the design of the board would like EEE
on/off by default, not that the silicon supports EEE. And the user
should have the choice to enable/disable EEE, independent of the board
designs defaults.

> > What does a while (0) loop bring you here?
> >
> 
> break statement instead of goto err.

Which you only seem to do once, here, and nowhere else. And look at
other drivers, how many use a while (0) loop like this?

goto err is the standard way to do this.

	Andrew


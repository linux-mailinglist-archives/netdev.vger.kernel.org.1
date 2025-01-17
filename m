Return-Path: <netdev+bounces-159478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB09A1597A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D04F1690A9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45B1B042D;
	Fri, 17 Jan 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HwqwOcuf"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AF1ABED9;
	Fri, 17 Jan 2025 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737152232; cv=none; b=ThT0zzTLq+OHNvk5luuKqHUpNaIs9YGLhw8cP6fqDCy8nNC4X7NfxLu3LGYfi+YSe4Xr4c/FVouo3jzRbMUYnVXFLvO3Pse/TFzq0YwI5Fo12UYGjGQleS13C5gVRNWZMv9wkVjmqjec/U7ez3fw37X4FUCChGXzi2lITF7VQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737152232; c=relaxed/simple;
	bh=K8rRiUIbRxRCziTKV6CqOPuvOTbJlOoE1I6x9I3I/Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3M70VZ23QAMgEtrvtGkG6jn9fWAQU2XrFNWpMgsTs6ECUfaZuKyKP++nH2WwXUI7sNPjXFBBvTzlrOxdn9Y7mHXvAV3vRd4+B+S/pglsBg/LY6m+oJFbaS/a1smyIfnKjcZ48mI2+2TX+vw71U1Rq0wBqskpsiDE/ykLKW6X40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HwqwOcuf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1126EE0002;
	Fri, 17 Jan 2025 22:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737152221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twYtHsGqHSAOAV6lzegEL6a2pKx4wNSWRLavXNSIvvY=;
	b=HwqwOcufVi933w4D3ciOlqyVy08Obb9Iteo/AdfBrr374kCffWFbLahKvpTP7j64qV1mHa
	YqMh2B0uOaTDs5ZVBG2112MkwQdS+Z2dOUAyT+w6NqaW9WkWG1IXIerU+hxgJ2kb3V6PnF
	9t+TqdseLwYpxzCDGhrGxh273IL3pfBaU5sgFjjbvjjPGSIWRvhEi9FZU9DFptfoLQ3ZW3
	mtFvVR2mYGXS6TmhVvXReh9DZ6It877/VEokiXPj75P1xd6q4Vke3Y5ZEm3sW348iBiF5H
	SuxZSTp/DoG+6Nuc72skpfeeJ1eYbJ+x2HrpZDfXF1BUS2hk1lSw7F+xc1sFkw==
Date: Fri, 17 Jan 2025 23:16:59 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250117231659.31a4b7fa@kmaincent-XPS-13-7390>
In-Reply-To: <CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
References: <20250117173645.1107460-1-kory.maincent@bootlin.com>
	<CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 17 Jan 2025 20:06:28 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Jan 17, 2025 at 6:36=E2=80=AFPM Kory Maincent <kory.maincent@boot=
lin.com>
> wrote:
> >
> > The phy_detach function can be called with or without the rtnl lock hel=
d.
> > When the rtnl lock is not held, using rtnl_dereference() triggers a
> > warning due to the lack of lock context.
> >
> > Add an rcu_read_lock() to ensure the lock is acquired and to maintain
> > synchronization.
> >
> > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > Reported-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > Closes:
> > https://lore.kernel.org/netdev/4c6419d8-c06b-495c-b987-d66c2e1ff848@tux=
on.dev/
> > Fixes: 35f7cad1743e ("net: Add the possibility to support a selected
> > hwtstamp in netdevice") Signed-off-by: Kory Maincent
> > <kory.maincent@bootlin.com> ---
> >
> > Changes in v2:
> > - Add a missing ;
> > ---
> >  drivers/net/phy/phy_device.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 5b34d39d1d52..3eeee7cba923 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -2001,12 +2001,14 @@ void phy_detach(struct phy_device *phydev)
> >         if (dev) {
> >                 struct hwtstamp_provider *hwprov;
> >
> > -               hwprov =3D rtnl_dereference(dev->hwprov);
> > +               rcu_read_lock();
> > +               hwprov =3D rcu_dereference(dev->hwprov);
> >                 /* Disable timestamp if it is the one selected */
> >                 if (hwprov && hwprov->phydev =3D=3D phydev) {
> >                         rcu_assign_pointer(dev->hwprov, NULL);
> >                         kfree_rcu(hwprov, rcu_head);
> >                 }
> > +               rcu_read_unlock();
> >
> >                 phydev->attached_dev->phydev =3D NULL;
> >                 phydev->attached_dev =3D NULL;
> > --
> > 2.34.1
> > =20
>=20
> If not protected by RTNL, what prevents two threads from calling this
> function at the same time,
> thus attempting to kfree_rcu() the same pointer twice ?

I don't think this function can be called simultaneously from two threads,
if this were the case we would have already seen several issues with the ph=
ydev
pointer. But maybe I am wrong.

The rcu_lock here is to prevent concurrent dev->hwprov pointer modification=
 done
under rtnl_lock in net/ethtool/tsconfig.c.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


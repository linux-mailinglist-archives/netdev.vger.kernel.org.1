Return-Path: <netdev+bounces-205393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9841AAFE76B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA231C48194
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E72D5402;
	Wed,  9 Jul 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EQPCISu9"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0928EC15;
	Wed,  9 Jul 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059823; cv=none; b=htG3ZgZn+lwSjQ5VkAP/FpQHtpPLx0wVlb9pe9qruCOI80oATPKfjf9bD8xuZrvT7+aXvdzYDbXFZ0qu6WhFLghhRwzlBjbGlI7MD1G+F8OO/RXcpBvLCztj7MnRLo1H33ECxxIuELpDnOaAUozSsCmN0uokbPHEFXGGetW47sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059823; c=relaxed/simple;
	bh=4kWrX6sfCJUuN2vXbr68Zhu993cH/l/81QTPNlOuOAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIC+pddwuuFSQJ1jtwpBuYXaZnTVjTv+UoYgAr4o1DtiMG31s72W4Inj34mB82kGQoelHftv2eSfB9WwECXuUuTBY56rN/09qEwGJJpc+PdJl/8tY/YIZT1Us6upQ1zVlXb2MFcc3LobxFtollq9JaV2VKINpePgfH34ISNJwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EQPCISu9; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A026103972A7;
	Wed,  9 Jul 2025 13:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752059818; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZlieK/cQd1tQM5wheLqNTa+x9MmB1DmBV4uYwDd6FPY=;
	b=EQPCISu9IUIpn41IpH56igNNxb+zl7xu3O7CJcvRfljgmmuBw+zQp1ve/8sHhWLw2tC9aP
	qRLIyULgMRqX8uUG4Vzi5bpQpuab/7cM87KkCck2PnSYJynqDrJSeZgD4fH/+vxzObIYZ/
	9IA+6yabN2KYvRhdZmQOSKm3xbHTBHLrjNejYPkmTAjp4/bcGXZ7rbBQZCRpR9quD/SOC/
	TMl1zqcsgmXbxA6Zj4FLTJtkEk5nnEHbGqMWXRjWLkLz7/1aqAXMIYxfDSzD2aUuJTqsGm
	Rm79++WpyhFB+Gkt5+RlxDjhK1vkTdMOB/5iFvWI0lOm7Og7w7KlUBpX0mDzUQ==
Date: Wed, 9 Jul 2025 13:16:51 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v14 04/12] net: mtip: The L2 switch driver for imx287
Message-ID: <20250709131651.391e11c5@wsk>
In-Reply-To: <617d064e-99e4-491c-8fe7-d74d8174d9fb@redhat.com>
References: <20250701114957.2492486-1-lukma@denx.de>
	<20250701114957.2492486-5-lukma@denx.de>
	<617d064e-99e4-491c-8fe7-d74d8174d9fb@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mg/nfqRTFJ+kss8tYJWDWg=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/mg/nfqRTFJ+kss8tYJWDWg=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> > Changes for v14:
> > - Increase the maximal received frame size to 1536 (for VLAN)
> > - Use spin_{un}lock_irq{save|restore} when altering dynamic table
> > of the switch and mtip_adjust_link() as both cannot be done when
> > switch IRQ is potentially enabled =20
>=20
> Why?
>=20
>  (the previous one alters entries in switching table
> >   the latter one may reset the whole IP block) =20
>=20
> What really matters is the scope (process/atomic, bh, hardirq) of the
> relevant callers (the functions that do acquire the given locks).
>=20

Maybe I will explain the problem here case (function) by case:
- mtip_adjust_link()
  This function is called when link change is detected (speed, duplex,
  up/down link).

  The problem here is that:
	1. It is called for both MTIP ports (as both are managed by
	this driver)

	2. NXP's "legacy" driver advises reset of the whole IP block
	when such change is detected.=20

	Considering the above - interrupts shall be disabled as we may
	end up in undefined state of the IP block - especially that
	re-configuration of switch requires interrupts initialization.


- mtip_atable_dynamicms_learn_migration() - update of the switching
  table

	Can be called from:
	1. function triggered when timer fires (once per 100ms)

	2. mtip_switch_rx() which is called from mtip_rx_napi() callback
	  (which is protected by net core).

	It looks like the _irqsave/_irqrestore is an overkill here.
	Both above contexts seems to not require IRQs disabled. I can
	confirm that use of plain spin_{un}lock() functions works.

>=20
> > +/* dynamicms MAC address table learn and migration */
> > +static void
> > +mtip_atable_dynamicms_learn_migration(struct switch_enet_private
> > *fep,
> > +				      int curr_time, unsigned char
> > *mac,
> > +				      u8 *rx_port)
> > +{
> > +	u8 port =3D MTIP_PORT_FORWARDING_INIT;
> > +	struct mtip_port_info *port_info;
> > +	u32 rx_mac_lo =3D 0, rx_mac_hi =3D 0;
> > +	unsigned long flags;
> > +	int index;
> > +
> > +	spin_lock_irqsave(&fep->learn_lock, flags); =20
>=20
> If the _irqsave() part is needed (and I don't see why??!) than all the
> other `learn_lock` users should also use such variant, unless already
> in hardirq scope.
>=20
> [...]
> > +static void mtip_adjust_link(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct phy_device *phy_dev;
> > +	int status_change =3D 0, idx;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fep->hw_lock, flags); =20
>=20
> Same here.

Please see the explanation above.

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/mg/nfqRTFJ+kss8tYJWDWg=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhuT6MACgkQAR8vZIA0
zr2sMQgAmeWdQ83p6ZlFKroGNRoittaX6hv52A6/sPC741/r5Bs6bSXR0SiYIWIQ
oLqi0K6s1yin/VW7PCgSlxjez6pG1ZLVU0VbdU32bBZPO7cZN/gwP/9SkitR8gkB
2LViAZYDJpPSl98Z0CL+YEgPeZ6t7si0/xJTGs0sogpDqKnCZXhebCGmWAxfKPV2
jtf5EtJwnPezHuv1g5vLxpmZQku3LDXR6seg7M2pIOcMXWjMjulvSySvhWEjFsRx
KHZf5seGJqEj5KXSx3LAOrzf8kGqUpXzXLzPJnnsbnLVFbRJftYLKiBPfWztFr7a
1NJjD6ATeHM08A+mASs69xXk4XxveA==
=fJbi
-----END PGP SIGNATURE-----

--Sig_/mg/nfqRTFJ+kss8tYJWDWg=--


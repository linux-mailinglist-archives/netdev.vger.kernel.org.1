Return-Path: <netdev+bounces-205934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629C1B00D77
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397C61C48671
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCC2FD594;
	Thu, 10 Jul 2025 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NKoAhR2n"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE63271474;
	Thu, 10 Jul 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181472; cv=none; b=EV6uFQ98JQ3oLyotAN4+GO5clqaZhTBjYFD9yx71Tw0l3wmC/nFMF4y/EXpJkN9rbrLyU6J4nYt7hlzk6rGmvufiyofi09umeBPuq5jnn9AFkAJdlPYCTHQUxU3P1T82Hu8huzE4mZpjolfyrINrBmnOnV5cC3FL3AUYVWV0cfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181472; c=relaxed/simple;
	bh=X3w/Lmb4tCjm3BYfefbohBWkasM97PEphdqhUzf90po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJupyKXY5oIhPD3Ke9buEixHJByI/EQeIWIeccmHZmfI4RztKXqx4zC3P5JXdVwgzQ/P5Ip9LuPjHHjXcD76Ku2t5cofqWzNegPoRZ07YwIF5TjJEg6XBy9AI7oDUHdiBR8xVtZlVhfYrXqOezI3s2s5VF9rcj4LWCrNuWwrVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NKoAhR2n; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D96210380104;
	Thu, 10 Jul 2025 23:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752181460; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hEznsWOa6dCQ6qINcx3pqCiUfEhxMJkXZwCwsLHg0BI=;
	b=NKoAhR2nPBFfkuYKVaXMV1hlVbbaBvMMsxgB4L8meNIyaawoWY+qb/m/YnbvrBbzZt/5qh
	91ANS8GhzV4ryPkjFmdSUoLDd10tWu/XC1iVwBzeR+IotLoRDcKBMRQ7NtgJFCEsEs9zhr
	rLmMFB08IS99ST23K3z4MmigurNJEcztPB6G1qGHRyCqzOT9zbE0RNTHMJyM7vB1LNgOPU
	vZcOCZeJjMS7dGKtkETAJjL2gY0PmEOkTRblnC0N8UOm6CIXkNX4QyjRUbQS9cQqRw+iO8
	EbuvR2DBv739MI8UDnsCOnlxMPfxSBIQ5gV9mVjVigKWICFeC8Mywd5TohJbKQ==
Date: Thu, 10 Jul 2025 23:04:13 +0200
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
Message-ID: <20250710230413.3b6798f7@wsk>
In-Reply-To: <20250709131651.391e11c5@wsk>
References: <20250701114957.2492486-1-lukma@denx.de>
	<20250701114957.2492486-5-lukma@denx.de>
	<617d064e-99e4-491c-8fe7-d74d8174d9fb@redhat.com>
	<20250709131651.391e11c5@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bvMryEMKXN67+shfLzzO8Cd";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/bvMryEMKXN67+shfLzzO8Cd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> Hi Paolo,
>=20
> > On 7/1/25 1:49 PM, Lukasz Majewski wrote: =20
> > > Changes for v14:
> > > - Increase the maximal received frame size to 1536 (for VLAN)
> > > - Use spin_{un}lock_irq{save|restore} when altering dynamic table
> > > of the switch and mtip_adjust_link() as both cannot be done when
> > > switch IRQ is potentially enabled   =20
> >=20
> > Why?
> >=20
> >  (the previous one alters entries in switching table =20
> > >   the latter one may reset the whole IP block)   =20
> >=20
> > What really matters is the scope (process/atomic, bh, hardirq) of
> > the relevant callers (the functions that do acquire the given
> > locks).=20
>=20
> Maybe I will explain the problem here case (function) by case:
> - mtip_adjust_link()
>   This function is called when link change is detected (speed, duplex,
>   up/down link).
>=20
>   The problem here is that:
> 	1. It is called for both MTIP ports (as both are managed by
> 	this driver)
>=20
> 	2. NXP's "legacy" driver advises reset of the whole IP block
> 	when such change is detected.=20
>=20
> 	Considering the above - interrupts shall be disabled as we may
> 	end up in undefined state of the IP block - especially that
> 	re-configuration of switch requires interrupts initialization.
>=20
>=20
> - mtip_atable_dynamicms_learn_migration() - update of the switching
>   table
>=20
> 	Can be called from:
> 	1. function triggered when timer fires (once per 100ms)
>=20
> 	2. mtip_switch_rx() which is called from mtip_rx_napi()
> callback (which is protected by net core).
>=20
> 	It looks like the _irqsave/_irqrestore is an overkill here.
> 	Both above contexts seems to not require IRQs disabled. I can
> 	confirm that use of plain spin_{un}lock() functions works.
>=20
> >  =20
> > > +/* dynamicms MAC address table learn and migration */
> > > +static void
> > > +mtip_atable_dynamicms_learn_migration(struct switch_enet_private
> > > *fep,
> > > +				      int curr_time, unsigned
> > > char *mac,
> > > +				      u8 *rx_port)
> > > +{
> > > +	u8 port =3D MTIP_PORT_FORWARDING_INIT;
> > > +	struct mtip_port_info *port_info;
> > > +	u32 rx_mac_lo =3D 0, rx_mac_hi =3D 0;
> > > +	unsigned long flags;
> > > +	int index;
> > > +
> > > +	spin_lock_irqsave(&fep->learn_lock, flags);   =20
> >=20
> > If the _irqsave() part is needed (and I don't see why??!) than all
> > the other `learn_lock` users should also use such variant, unless
> > already in hardirq scope.
> >=20
> > [...] =20
> > > +static void mtip_adjust_link(struct net_device *dev)
> > > +{
> > > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > > +	struct switch_enet_private *fep =3D priv->fep;
> > > +	struct phy_device *phy_dev;
> > > +	int status_change =3D 0, idx;
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&fep->hw_lock, flags);   =20
> >=20
> > Same here. =20
>=20
> Please see the explanation above.
>=20

Is the explanation enough (and from other e-mails), so I can proceed
with next version of this patch set?

> >=20
> > /P
> >  =20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH, Managing Director: Johanna Denk,
> Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/bvMryEMKXN67+shfLzzO8Cd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhwKs0ACgkQAR8vZIA0
zr2/Vgf8CAqpAWYmJVhTy2njCpyqUymWCFVNmNXK6Gllt/Zw6SkfkIq7Mi1felFl
EJkW8NkrKNvDxmLEuj95mjwk8ICa449UxTacaOTIGSx7cf2NaHuHZ/C3uaPE7qXO
JRczFT5e/V94lznm06bF+Msp5anCRiP51OB8T3CT5jPuA3lBe3rv9Kib9QmqF/9y
8scAsy79+4aVtbsGcsghx7sxi/en9c2j2XkrJstKEJhpbYlRq3m/lUlKYzVLdkfq
YynjGqmcQJMdO4uyORkyyk0D9IqRrVhLKvrWjs7FzcBA+yjjz9XL1GjznewUqfM4
9GPDqpw9n7gaQxIB+WQj1EhhaJorrA==
=okWF
-----END PGP SIGNATURE-----

--Sig_/bvMryEMKXN67+shfLzzO8Cd--


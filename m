Return-Path: <netdev+bounces-183612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0203A9143F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99927ABF23
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA42066DD;
	Thu, 17 Apr 2025 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="afXSZzFL"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1432C205E2F;
	Thu, 17 Apr 2025 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872132; cv=none; b=OKEKF2BG/JXT3pkkbTkVsoi15t+ynt/W4AmUT9xMkimIII7hLzpQClu07ihIZoZwfDL26jWzEqsZeSSQNKe1EWQ/5SVK/0Ivh7/7/jTYRMN20apAdM+khOfYat1lal7kDnOTmuafVxO6wamKcaXZkQ4cXvdjK3EI6UEiF/b6908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872132; c=relaxed/simple;
	bh=qBPeov2ee89LdDp4bu5sttFc3P5GRCw9vxvmNL6dVTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTFE8h8shdD0NpbskUqJ5VgfOtLEX25V53xkX91SgcgZT1FC6BGylnq1clcGxcK7SQzYJ7W7X2wEjneiVf915AZ+/O71cJ9pVsuqjqR0JpvDeiNbIrDiPfL5QTrODho2R58ECbqhk/vRHtrJ6uRuzeKXyWP9EKw3rmXaM0tuvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=afXSZzFL; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88C5E1039EF2C;
	Thu, 17 Apr 2025 08:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744871623; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=pWQQRs0tNulqLLtU6X0X0rTBDfrE7GYWj3CFIceXYpw=;
	b=afXSZzFLb1a2k7ibreW8JrPnIz18s/tOxCEP8LPHLrvqzy7iC3k+Sb54OJvH8lETFgRDws
	34fOPk2HzF0pgqCpoaZj4GK/KcG+B8/i7PjxYjji8r94LTopk9GdDHreJXLjlNFKYgX++X
	ftVu6jWGAkW5Ijbq8gyaGCeCeGFVMQQHgF0ZS8pH0TN4/CUecPt1GPR38DhPVmTC75+xA2
	Xm+sQEE3XkfYb7055LhVq397AIuuz2aha661U55f2VUaUn2YhENdEu+uIWDpBEBMbD+az8
	sjOiiHPy/sWtJ1noGDjo0NJWR0kMBfLSSq2SbhO92Qmzx1Z3CuCZ/YmJRlufoQ==
Date: Thu, 17 Apr 2025 08:33:34 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [net-next v5 2/6] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2
 switch description
Message-ID: <20250417083334.69b565b0@wsk>
In-Reply-To: <2c9a5438-40f1-4196-ada9-bfb572052122@lunn.ch>
References: <20250414140128.390400-1-lukma@denx.de>
	<20250414140128.390400-3-lukma@denx.de>
	<06c21281-565a-4a2e-a209-9f811409fbaf@gmx.net>
	<2c9a5438-40f1-4196-ada9-bfb572052122@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4vV2OQm1rnprx1JCFrQMEAC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/4vV2OQm1rnprx1JCFrQMEAC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > > -		eth_switch: switch@800f8000 {
> > > -			reg =3D <0x800f8000 0x8000>;
> > > +		eth_switch: switch@800f0000 {
> > > +			compatible =3D "nxp,imx28-mtip-switch";
> > > +			reg =3D <0x800f0000 0x20000>;
> > > +			interrupts =3D <100>, <101>, <102>;
> > > +			clocks =3D <&clks 57>, <&clks 57>, <&clks
> > > 64>, <&clks 35>;
> > > +			clock-names =3D "ipg", "ahb", "enet_out",
> > > "ptp"; status =3D "disabled"; =20
> > from my understanding of device tree this file should describe the
> > hardware, not the software implementation. After this change the
> > switch memory region overlaps the existing mac0 and mac1 nodes.
> >=20
> > Definition in the i.MX28 reference manual:
> > ENET MAC0 ENET 0x800F0000 - 0x800F3FFF 16KB
> > ENET MAC1 ENET 0x800F4000 - 0x800F7FFF 16KB
> > ENT Switch SWITCH 0x800F8000 - 0x800FFFFF 32KB
> >=20
> > I'm not the expert how to solve this properly. Maybe two node
> > references to mac0 and mac1 under eth_switch in order to allocate
> > the memory regions separately. =20
>=20
> I get what you are saying about describing the hardware, but...
>=20
> The hardware can be used in two different ways.
>=20
> 1) Two FEC devices, and the switch it left unused.
>=20
> For this, it makes sense that each FEC has its own memory range, there
> are two entries, and each has a compatible, since there are two
> devices.
>=20
> 2) A switch and MAC conglomerate device, which makes use of all three
>    blocks in a single driver.
>=20
> The three hardware blocks have to be used as one consistent whole, by
> a single driver. There is one compatible for the whole. Given the
> ranges are contiguous, it makes little sense to map them individually,
> it would just make the driver needlessly more complex.
>=20
> It should also be noted that 1) and 2) are mutually exclusive, so i
> don't think it matters the address ranges overlap. Bad things are
> going to happen independent of this if you enable both at once.
>=20

+1

>       Andrew


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/4vV2OQm1rnprx1JCFrQMEAC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgAoL8ACgkQAR8vZIA0
zr1dXAf+KoIdy7wyBtKjBP15Tbe4F8OveobBmbcJKV0P6JQ5JNNxIFEwSKWjtTuk
BY6L/6XG6JF1r/k/kHMe6/RemX45J3eVx0YJlUDNo/ESLK6Eez9YZIkgcfuNom3w
XwkUNjydQLSEbB+tkY1fizdyBqIGBRiTLq0A2ZHuvklpu9TsgHoLZ7ebuvJaFANd
9ov3lp9/PRK7+0fQ13XMFoPoDv0Svu4LN0yXwR4d8uhYCxmy8bQbs2Ec40Cb2puN
DZcrSwXFw9GCgTMXW5NgoAR9Gx/SaOSmS9lBBqR1wIeu0QrPZ6bTsf/zIj8LO8HC
uiEW59nmY3d05Emg0PG7Wa9MIou19A==
=SqyS
-----END PGP SIGNATURE-----

--Sig_/4vV2OQm1rnprx1JCFrQMEAC--


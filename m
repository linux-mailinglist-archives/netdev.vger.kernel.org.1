Return-Path: <netdev+bounces-183610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F1FA91422
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F0F3BFF0E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794221F416D;
	Thu, 17 Apr 2025 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CM81Wz43"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858221DFD86;
	Thu, 17 Apr 2025 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744871788; cv=none; b=deHiMcEzmfpsUHDj3Jj2GYtBPGNDu0ocNDzmdKiHvHgATiQLRYL8j4dLwbVGRog6kUN3K1vGAcwAmrol6wmY8ZNL3Ksb9y0wh+O3mMId/eER1Pi1+8eFVQ8etjnFq1CVR+uNs8WMGtITgUHPOhTwylpcQXDH2ih+x2HdzlJRXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744871788; c=relaxed/simple;
	bh=qfsdvMQKMa6weBYznhuw0P3zXeNZrcaoAvug4vkw+lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFgrcmGZCV46UUva+fvwrpJztkgZz1/s+3y6xdT+SQqm3iYS6Wkd4w5UEMorbpR5x2Gdb27GhGl/zb5KMaMxWws1xcnSuYzDAAg/M9vzyavfNvI5agM3ol1BaUHOqAi7SIdQWUodRANT4c6u3IYSxooRxQ+abzTc5RrAbWfR684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CM81Wz43; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44F5A1039EF2D;
	Thu, 17 Apr 2025 08:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744871783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MHwCLJyDeuWx/JjQt62OR0Vto9JTS8LaVyPorlwv61A=;
	b=CM81Wz43G51dxJmGWG9E5VZzgOMqy4v5uVBHebc1PWgR3tHIRJsqZDPs6Ru/+Nn6K3N4eq
	778byT4teaB7knzj39mpJEAmHTEzPQlc+ZlRGVNB7SincnzMDsbjOIUMMQV35fCD08jmev
	OlG5jmPXKJ/qhY/9/9AhFUHGThrWc/5ADIa4t2rHhKYDzfEWNdYEm45+r5Mok+hF/V7OLv
	pki+AWGnMrJe1xoBEYrdazf/AMGQx/tiUN4kD/zEC6kyzWbW3NufDoGuyb0wbZ3DAkoaZK
	XQgao5QjAYa5hGeo+DQwuY0DDh3A2zqRC9Dbb/zI/Gb681FIfC4ghL0l3QA68w==
Date: Thu, 17 Apr 2025 08:36:20 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <20250417083620.6322d9a7@wsk>
In-Reply-To: <6511c88d-7876-4f69-81f1-1206056d061a@gmx.net>
References: <20250414140128.390400-1-lukma@denx.de>
	<20250414140128.390400-3-lukma@denx.de>
	<06c21281-565a-4a2e-a209-9f811409fbaf@gmx.net>
	<2c9a5438-40f1-4196-ada9-bfb572052122@lunn.ch>
	<6511c88d-7876-4f69-81f1-1206056d061a@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OP3qBt+f/mJ28tgoAZOMfOc";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/OP3qBt+f/mJ28tgoAZOMfOc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi Andrew,
>=20
> Am 16.04.25 um 23:58 schrieb Andrew Lunn:
> >>> -		eth_switch: switch@800f8000 {
> >>> -			reg =3D <0x800f8000 0x8000>;
> >>> +		eth_switch: switch@800f0000 {
> >>> +			compatible =3D "nxp,imx28-mtip-switch";
> >>> +			reg =3D <0x800f0000 0x20000>;
> >>> +			interrupts =3D <100>, <101>, <102>;
> >>> +			clocks =3D <&clks 57>, <&clks 57>, <&clks
> >>> 64>, <&clks 35>;
> >>> +			clock-names =3D "ipg", "ahb", "enet_out",
> >>> "ptp"; status =3D "disabled"; =20
> >> from my understanding of device tree this file should describe the
> >> hardware, not the software implementation. After this change the
> >> switch memory region overlaps the existing mac0 and mac1 nodes.
> >>
> >> Definition in the i.MX28 reference manual:
> >> ENET MAC0 ENET 0x800F0000 - 0x800F3FFF 16KB
> >> ENET MAC1 ENET 0x800F4000 - 0x800F7FFF 16KB
> >> ENT Switch SWITCH 0x800F8000 - 0x800FFFFF 32KB
> >>
> >> I'm not the expert how to solve this properly. Maybe two node
> >> references to mac0 and mac1 under eth_switch in order to allocate
> >> the memory regions separately. =20
> > I get what you are saying about describing the hardware, but...
> >
> > The hardware can be used in two different ways.
> >
> > 1) Two FEC devices, and the switch it left unused.
> >
> > For this, it makes sense that each FEC has its own memory range,
> > there are two entries, and each has a compatible, since there are
> > two devices.
> >
> > 2) A switch and MAC conglomerate device, which makes use of all
> > three blocks in a single driver.
> >
> > The three hardware blocks have to be used as one consistent whole,
> > by a single driver. There is one compatible for the whole. Given the
> > ranges are contiguous, it makes little sense to map them
> > individually, it would just make the driver needlessly more complex.
> >
> > It should also be noted that 1) and 2) are mutually exclusive, so i
> > don't think it matters the address ranges overlap. Bad things are
> > going to happen independent of this if you enable both at once.
> >
> >        Andrew =20
> i wasn't aware how critical possible overlapping memory regions are.
> I was just surprised because it wasn't mention in the commit message.
> As long as everyone is fine with this approach, please ignore my last
> comment.
>=20

Just for the record - there was an attempt to "re-use" FEC enet driver
in switch [1], but this approach has been rejected as one not very
robust and "clear by design" (i.e. similar to cpsw_new.c driver).

And I do agree with Andrew - that approach presented in this patch set
is the correct one.

Links:
[1] -
https://source.denx.de/linux/linux-imx28-l2switch/-/commits/imx28-v5.12-L2-=
upstream-switchdev-RFC_v1

> Regards
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/OP3qBt+f/mJ28tgoAZOMfOc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgAoWQACgkQAR8vZIA0
zr3Z0AgAjNWeG5547C9lxo+unXs8/onbMnCfQDJ3YSeCUfVD1VDsiEa2t0Mo/Fog
nX9eR7DL85CJOQE3xlThujPztb/8w18Kf8J1ABg53mDanqEvgcABhF0fxyBOlWsP
gSJ3fWaVflKSf43uvylKO0OoEU6Dzy26YRX3CaM3nHcBJL3YatBiXxZH/m/lGS5S
2qqjLyTj1751iu1Q0euhZkxric47TZkMqDh1oARuNu4LjMX3n1/RkoZPuHH+AS8E
8tmfzKYa3GDNF15Kkv2sx2QnljPfEA9kVLNrXB/adUESTwgVhH22GdIbSF7wYwus
6QupQoOBSRICo3cnVGDHkY4J6nSz7w==
=4Q3t
-----END PGP SIGNATURE-----

--Sig_/OP3qBt+f/mJ28tgoAZOMfOc--


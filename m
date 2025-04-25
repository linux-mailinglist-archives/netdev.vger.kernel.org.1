Return-Path: <netdev+bounces-185892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F055A9C017
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF249231DB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE58230BDF;
	Fri, 25 Apr 2025 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="W5mzngPW"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D25A79B;
	Fri, 25 Apr 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567357; cv=none; b=UJdI1gicxYojLMs5gM2A+/PV7mTKSPIE+cZwDriCJPza4JOKV6sF5s+Hf/lN8TedAP9Klaz/7NJY1+4Ycre46t1ZRa3Wwiz608rzkOVNH9GCzuloIq195eV9OrOfWkGKNRoqXEJK1KJL13G1SvAsowCWBDuxrNf/m9mX6gENrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567357; c=relaxed/simple;
	bh=FZiAbyedh3Hu4XRwOaYu0OJ85o9hgbMKwtwyNH+c43U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OroELYuNJV2BVc0NP3aO1PWSEt3Dgosn5HophvPk8AHK8yjTqM9xacqwhD6kB/gMvtfRtq1Dw+rIw/oSXF81EhpdyIg1t99/yN9y0NkNw5R1wIgikSpkSV/O95Od7/0g/uyScKak5F/xxLUa71QN/AXlpndtqr7wFrktlSDnrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=W5mzngPW; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F99710275AFE;
	Fri, 25 Apr 2025 09:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745567352; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/dXNASC/WIWqaw/KcaFHN25jpUIQ4813arUoFsnAA/w=;
	b=W5mzngPWSoevp/RkCHlrm6bIeICmfBGApQFzJ0GYblGaR6HMtVLH2FxtRBPpnBDPDuTvMu
	gGj/huEmIcEK+7lQIm6QDNgYvojSeuwBJC+IW/9AAz/26JOzVxaGchp3mN8rT0+4k+PHDg
	JA5+9KOV1Yn5cRq20sNAN9dUYRhzx1o4oa0J7Qr4i8mKibnDACG2XvcftijG+JK6neBKuz
	5nUduG0llbzLBYuz1oPnEez9otGn0mt2TSb1opiKqJGW/MPGR2gD+z71p0fsdAk902HIh7
	NtbcYJyrJ8+CKVCJYWlKOEF9QrmO7GO5KDspKWxPSrnkHe1KT000/vGRU+eC/A==
Date: Fri, 25 Apr 2025 09:49:07 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v7 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250425094907.27740d07@wsk>
In-Reply-To: <a5f54d46-6829-4d60-b453-9ee92e6b568c@kernel.org>
References: <20250423072911.3513073-1-lukma@denx.de>
	<20250423072911.3513073-5-lukma@denx.de>
	<20250424181110.2734cd0b@kernel.org>
	<0bf77ef6-d884-44d2-8ecc-a530fee215d1@kernel.org>
	<20250425080556.138922a8@wsk>
	<a5f54d46-6829-4d60-b453-9ee92e6b568c@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aD7bD6eqbseU9NHDSHb+3ZT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/aD7bD6eqbseU9NHDSHb+3ZT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof, Jakub

> On 25/04/2025 08:05, Lukasz Majewski wrote:
> > Hi Krzysztof, Jakub,
> >  =20
> >> On 25/04/2025 03:11, Jakub Kicinski wrote: =20
> >>> On Wed, 23 Apr 2025 09:29:08 +0200 Lukasz Majewski wrote:   =20
> >>>> This patch series provides support for More Than IP L2 switch
> >>>> embedded in the imx287 SoC.
> >>>>
> >>>> This is a two port switch (placed between uDMA[01] and
> >>>> MAC-NET[01]), which can be used for offloading the network
> >>>> traffic.
> >>>>
> >>>> It can be used interchangeably with current FEC driver - to be
> >>>> more specific: one can use either of it, depending on the
> >>>> requirements.
> >>>>
> >>>> The biggest difference is the usage of DMA - when FEC is used,
> >>>> separate DMAs are available for each ENET-MAC block.
> >>>> However, with switch enabled - only the DMA0 is used to
> >>>> send/receive data to/form switch (and then switch sends them to
> >>>> respecitive ports).   =20
> >>>
> >>> Lots of sparse warnings and build issues here, at least on x86.
> >>>
> >>> Could you make sure it's clean with an allmodconfig config,=20
> >>> something like:
> >>>
> >>> make C=3D1 W=3D1 drivers/net/ethernet/freescale/mtipsw/    =20
> >>
> >> ... and W=3D1 with clang as well.
> >> =20
> >=20
> > The sparse warnings are because of struct switch_t casting and
> > register =20
>=20
> clang W=3D1 fails on errors, so it is not only sparse:
>=20
> error: cast to smaller integer type 'uint' (aka 'unsigned int') from
> 'struct cbd_t *' [-Werror,-Wpointer-to-int-cast]
>=20
> You probably wanted there kenel_ulong_t.

This I did not catch earlier (probably because of my testing on
imx287). Thanks for spotting it.

>=20
> > access with this paradigm (as it is done with other drivers). =20
>=20
> I don't understand. I see code like:
>=20
> 	struct switch_t *fecp =3D fep->hwp;
>=20
> But this is not a cast - the same types.

For example:

The warning:

mtipl2sw.c:208:30: warning: incorrect type in argument 1 (different
address spaces) mtipl2sw.c:208:30:    expected void const volatile
[noderef] __iomem *addr mtipl2sw.c:208:30:    got unsigned int *

corresponds to:
 info->maclo =3D readl(&fecp->ESW_LREC0);   [*]

where:

struct switch_t {
        u32 ESW_REVISION;
        u32 ESW_SCRATCH;
	...
        /*from 0x420-0x4FC*/
        u32 esw_reserved9[57];
        /*0xFC0DC500---0xFC0DC508*/
        u32 ESW_LREC0;
        u32 ESW_LREC1;
        u32 ESW_LSR;
};


The 'u32' type seems to be valid here as this register is 32 bit wide.

To fix the sparse warnings - I think that I will replace [*] with:

info->maclo =3D readl((u32 __iomem *)&fecp->ESW_LREC0);

as such solution is used in a wide way in the mainline kernel.

Is this the acceptable solution?

> >=20
> > What is the advise here from the community?
> >  =20
> >> Best regards,
> >> Krzysztof =20
> >=20
> >=20
> >=20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > --
> >=20
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20
>=20
>=20
> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/aD7bD6eqbseU9NHDSHb+3ZT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgLPnMACgkQAR8vZIA0
zr2n/Af+LVw/038n6xkuDzEVw1Ws29jNVFmBbGwSS1Om+WVKtZVnR0MEJigZTpNh
Xw3M68InMX0jlbko1jdRMbhfzovDicEY9KYmg3pKQCZcWiFS93x+PIGFNY+ekeov
jXyoiQY1zaC1/FT3PWtOwK6Ls+yGL83vJm9O86c2dCa6/wnARvbWULW/uQPh0AlX
yTDzLR3RuRQqow6k+M+Rv3ruF0lx7cis6RCVOb3YkCwwBMrjUFQ/T05K5ZilZMr5
9N257fwmaKEtAqk9Sc7fXi/kGf2IvPtobVyWOxWpyIJVeyjjp3s6G4linPN8U46P
s2b/DM39xFJsCGTqF8rG0CJFUNM1FA==
=Id9L
-----END PGP SIGNATURE-----

--Sig_/aD7bD6eqbseU9NHDSHb+3ZT--


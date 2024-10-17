Return-Path: <netdev+bounces-136612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A475D9A24E7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F62B28B6D8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09E1DE892;
	Thu, 17 Oct 2024 14:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F881DE3AC
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174918; cv=none; b=VGpxQlLoNVqe8Pu5Xtx1vVOTJ3FzQG443t1O1GzId9Hr4MIiqLJr0L+6+ZuAl/1AiXbhmA/a5bdOlJ3dEEe6PCj8bS5tfeF9GiTLZUdDrR8kasxEkclcmj15NybgjbgeIrZCgZipwBY/AbESsojwOE6NxkkJLU1wNKxFpFGwvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174918; c=relaxed/simple;
	bh=zBt6/1o7agVZSX+rWNtucjO/KuWPeQZtxmwFF6XugPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YghT5cfgSZ966Vb2AOVQHX0ROqqFLJBbLcdWnsEFEBhspzLwZ1vjhUlMiXkglHCaNTts+yPx7rm54d0Tr+/J8TEnERBz0cJet14j52rTrhkgc2zUY7Xl2cXJP/dnIgMUQYojSEbEKxG4XAzByfZNVCyguFUcmmwGe9LV3iA7xHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1RNf-0000d3-6B; Thu, 17 Oct 2024 16:21:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1RNe-0003nc-02;
	Thu, 17 Oct 2024 16:21:34 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A246B355320;
	Thu, 17 Oct 2024 14:21:33 +0000 (UTC)
Date: Thu, 17 Oct 2024 16:21:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update
 quirk: bring IRQs in correct order
Message-ID: <20241017-rainbow-nifty-gazelle-9acee4-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
 <PAXPR04MB8510149D0E8AC39E048941F988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-manipulative-dove-of-renovation-88d00b-mkl@pengutronix.de>
 <ZxEZR2lmIbX6+xX2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qjhlnbg5enicegfn"
Content-Disposition: inline
In-Reply-To: <ZxEZR2lmIbX6+xX2@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--qjhlnbg5enicegfn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.10.2024 10:03:51, Frank Li wrote:
> > > > Yes, that is IMHO the correct description of the IP core, but the
> > > > i.MX8M/N/Q DTS have the wrong order of IRQs. And for compatibility
> > > > reasons (fixed DTS with old driver) it's IMHO not possible to chang=
e the
> > > > DTS.
> > > >
> > >
> > > I don't think it is a correct behavior for old drivers to use new DTB=
s or new
> > > drivers to use old DTBs. Maybe you are correct, Frank also asked the =
same
> > > question, let's see how Frank responded.
> >
> > DTBs should be considered stable ABI.
> >
>=20
> ABI defined at binding doc.
>   interrupt-names:
>     oneOf:
>       - items:
>           - const: int0
>       - items:
>           - const: int0
>           - const: pps
>       - items:
>           - const: int0
>           - const: int1
>           - const: int2
>       - items:
>           - const: int0
>           - const: int1
>           - const: int2
>           - const: pps
>=20
> DTB should align binding doc. There are not 'descriptions' at 'interrupt',
> which should match 'interrupt-names'. So IMX8MP dts have not match ABI,
> which defined by binding doc. So it is DTS implement wrong.

I follow your conclusion. But keep in mind, fixing the DTB would break
compatibility. The wrong DTS looks like this:

- const: int1
- const: int2
- const: int0
- const: pps

Currently we have broken DTS on the i.MX8M* and the
FEC_QUIRK_WAKEUP_FROM_INT2 that "fixes" this.

This patch uses this quirk to correct the IRQ <-> queue assignment in
the driver.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qjhlnbg5enicegfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcRHWoACgkQKDiiPnot
vG/STwgAhj7R/YH7PoO9JfIBXoNwyrWTFyN4vrRAwH4MyRPDxByKlcyaZq0Gmmwd
njOY6aiDDTcEiQTn9lq1LYOJlSfq1zxLh8vY9t9WmX3Sm6YdqnYNmwLqFbhe9vLM
qdpaxRL0ZqLNFjgzlduaBjEuTjC9AMoaXBGb5U6KJgMBvnrij6ubgNKk9qIzihhS
XKQ/eiVd0Vx8yydq2/7+YWJzOxK/zQli3G0/a9QTYyEfh6InIBvkLhbiL48Bw7PO
8ZfJN4W6Yf+IiCN6Ru6dmvomgGNUIE0Iptm06XRW5y5YMKjNX1EtVBLZjBey0Y6c
6O6KLb8atwIgdsjp0EdKAKqwLPSYig==
=dEJL
-----END PGP SIGNATURE-----

--qjhlnbg5enicegfn--


Return-Path: <netdev+bounces-136521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6999A1FA3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588651F22CF2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7EB1DA113;
	Thu, 17 Oct 2024 10:21:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF31D935A
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160491; cv=none; b=flEwlnWXbKGQOwglCE92waqSrFTZqCM7qFe6uNu95X5x7/Eh8ijBuDiiqexfStP9hGqwH6dn98MICereNUb8RsZmcaCXZSqIFu6Q9dzeq/Ae0cSXN/53oMmzNfkSB/kc/Z/TErHJ3wQ7Dw/GQnOYKifS5LG2ltMslM9nUiwu/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160491; c=relaxed/simple;
	bh=+MgRCFw9CRBVNuLmPgQwbgWY4iaSOd6df9Y5vpQXJtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjivPUuGrZjinCZ8xJn6zpUkz6dYr/I9DqEp7PvZZX1hpawqUJ12W+4jHORuD09R3+HFiR+rLaHOs8XMEb1d8fk3tNyhlDd9i33p8DB/CCDyLhHKLIU4uU7EBl7+EfrO1xcgtYM9w+lmDf/0rarWPQjgxxgZc2PROd06gHXVWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1Nd2-00043j-Kv; Thu, 17 Oct 2024 12:21:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1Nd0-002WRC-W2; Thu, 17 Oct 2024 12:21:11 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A3C39355053;
	Thu, 17 Oct 2024 10:21:10 +0000 (UTC)
Date: Thu, 17 Oct 2024 12:21:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update
 quirk: bring IRQs in correct order
Message-ID: <20241017-manipulative-dove-of-renovation-88d00b-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
 <PAXPR04MB8510149D0E8AC39E048941F988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="if6uf6fuhmiren6s"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510149D0E8AC39E048941F988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--if6uf6fuhmiren6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.10.2024 07:43:55, Wei Fang wrote:
> > > > Subject: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk=
: bring
> > IRQs
> > > > in correct order
> > > >
> > > > With i.MX8MQ and compatible SoCs, the order of the IRQs in the devi=
ce
> > > > tree is not optimal. The driver expects the first three IRQs to mat=
ch
> > > > their corresponding queue, while the last (fourth) IRQ is used for =
the
> > > > PPS:
> > > >
> > > > - 1st IRQ: "int0": queue0 + other IRQs
> > > > - 2nd IRQ: "int1": queue1
> > > > - 3rd IRQ: "int2": queue2
> > > > - 4th IRQ: "pps": pps
> > > >
> > > > However, the i.MX8MQ and compatible SoCs do not use the
> > > > "interrupt-names" property and specify the IRQs in the wrong order:
> > > >
> > > > - 1st IRQ: queue1
> > > > - 2nd IRQ: queue2
> > > > - 3rd IRQ: queue0 + other IRQs
> > > > - 4th IRQ: pps
> > > >
> > > > First rename the quirk from FEC_QUIRK_WAKEUP_FROM_INT2 to
> > > > FEC_QUIRK_INT2_IS_MAIN_IRQ, to better reflect it's functionality.
> > > >
> > > > If the FEC_QUIRK_INT2_IS_MAIN_IRQ quirk is active, put the IRQs back
> > > > in the correct order, this is done in fec_probe().
> > > >
> > >
> > > I think FEC_QUIRK_INT2_IS_MAIN_IRQ or FEC_QUIRK_WAKEUP_FROM_INT2
> > > is *NO* needed anymore. Actually, INT2 is also the main IRQ for i.MX8=
QM
> > and
> > > its compatible SoCs, but i.MX8QM uses a different solution. I don't k=
now
> > why
> > > there are two different ways of doing it, as I don't know the history=
=2E But you
> > can
> > > refer to the solution of i.MX8QM, which I think is more suitable.
> > >
> > > See arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi, the IRQ 258 is
> > > placed first.
> >=20
> > Yes, that is IMHO the correct description of the IP core, but the
> > i.MX8M/N/Q DTS have the wrong order of IRQs. And for compatibility
> > reasons (fixed DTS with old driver) it's IMHO not possible to change the
> > DTS.
> >=20
>=20
> I don't think it is a correct behavior for old drivers to use new DTBs or=
 new
> drivers to use old DTBs. Maybe you are correct, Frank also asked the same
> question, let's see how Frank responded.

DTBs should be considered stable ABI.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--if6uf6fuhmiren6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQ5RMACgkQKDiiPnot
vG+R0Qf/dzxXVRvh+Z9JPr2Jdy5B8+osttD+2QGvftI+k1uNHix9NpNYeAK+sngy
wOxHzaLOwFbKujUDkS+DkmRNuwS1V2Tdq2vvNX+lmV+ZYF3QMHijcc+yrW+gN91X
R1WNoO3k/VyGOWfQhAHlZAXz97lqSB95CJC1CjlyDjxrs9n0kxft2L8SSCs3Wgyp
siN/4e5zwil2CGggMsipL6gmtv6UnloCQSWRBRZgy915QuiON+RKhF3fmJKX1+Zi
FvYJ8yWCCEMZHp/lNr1xrstYq6ciw4vLImp8NqVS5wEx8hzb01HXkKemVyuSstPa
/DsvlxWa60Ri1dcosipadLBLp2j1Qw==
=0KhN
-----END PGP SIGNATURE-----

--if6uf6fuhmiren6s--


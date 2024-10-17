Return-Path: <netdev+bounces-136406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB899A1A99
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0275A28381C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2CC17D366;
	Thu, 17 Oct 2024 06:16:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECF770FE
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145790; cv=none; b=LtotsQKgp45zNmXJ2AD/uIaX3YclKDlSc2UBASLxvfbKBoU7XCe21HUGABlWlovo8HRrgKgV3c+Fqm8pVGxmXqRjtdj2BwRgOapHezA8yWQ9FP/Lb5JJaON9Habct7aG/SebkREapLnqz6tK7a7I6qNpUptAjVv8yqU5F8sOVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145790; c=relaxed/simple;
	bh=Z7kq+zIa733AZAmh1HmJzT65CyO4RNRAFi6LCphCXJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpMIrv87N0LE5RmiX9IL+C2KliGVTvpuu0hGjrSZKjdHjNws7wdaVc6TU9JdPbQgTLFUz3urdvC165wKMbe9ypTKsU80jZ1kMjr4QxvkHFdM+rDfuzaDdCN8Ubo37ndeNBW8fAWzmeS75rxxyziWsxCZm4mwHRtigNiZ3hSNUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1Jnx-0005hj-2s; Thu, 17 Oct 2024 08:16:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1Jnw-002TsS-JY; Thu, 17 Oct 2024 08:16:12 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3F3C4354D0D;
	Thu, 17 Oct 2024 06:16:12 +0000 (UTC)
Date: Thu, 17 Oct 2024 08:16:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk:
 bring IRQs in correct order
Message-ID: <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wi65hn3usen55a7x"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--wi65hn3usen55a7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.10.2024 03:09:15, Wei Fang wrote:
> > -----Original Message-----
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: 2024=E5=B9=B410=E6=9C=8817=E6=97=A5 5:52
> > To: Wei Fang <wei.fang@nxp.com>; Shenwei Wang <shenwei.wang@nxp.com>;
> > Clark Wang <xiaoning.wang@nxp.com>; David S. Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Richard
> > Cochran <richardcochran@gmail.com>
> > Cc: imx@lists.linux.dev; netdev@vger.kernel.org; linux-kernel@vger.kern=
el.org;
> > kernel@pengutronix.de; Marc Kleine-Budde <mkl@pengutronix.de>
> > Subject: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk: br=
ing IRQs
> > in correct order
> >=20
> > With i.MX8MQ and compatible SoCs, the order of the IRQs in the device
> > tree is not optimal. The driver expects the first three IRQs to match
> > their corresponding queue, while the last (fourth) IRQ is used for the
> > PPS:
> >=20
> > - 1st IRQ: "int0": queue0 + other IRQs
> > - 2nd IRQ: "int1": queue1
> > - 3rd IRQ: "int2": queue2
> > - 4th IRQ: "pps": pps
> >=20
> > However, the i.MX8MQ and compatible SoCs do not use the
> > "interrupt-names" property and specify the IRQs in the wrong order:
> >=20
> > - 1st IRQ: queue1
> > - 2nd IRQ: queue2
> > - 3rd IRQ: queue0 + other IRQs
> > - 4th IRQ: pps
> >=20
> > First rename the quirk from FEC_QUIRK_WAKEUP_FROM_INT2 to
> > FEC_QUIRK_INT2_IS_MAIN_IRQ, to better reflect it's functionality.
> >=20
> > If the FEC_QUIRK_INT2_IS_MAIN_IRQ quirk is active, put the IRQs back
> > in the correct order, this is done in fec_probe().
> >=20
>=20
> I think FEC_QUIRK_INT2_IS_MAIN_IRQ or FEC_QUIRK_WAKEUP_FROM_INT2
> is *NO* needed anymore. Actually, INT2 is also the main IRQ for i.MX8QM a=
nd
> its compatible SoCs, but i.MX8QM uses a different solution. I don't know =
why
> there are two different ways of doing it, as I don't know the history. Bu=
t you can
> refer to the solution of i.MX8QM, which I think is more suitable.
>=20
> See arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi, the IRQ 258 is
> placed first.

Yes, that is IMHO the correct description of the IP core, but the
i.MX8M/N/Q DTS have the wrong order of IRQs. And for compatibility
reasons (fixed DTS with old driver) it's IMHO not possible to change the
DTS.

> fec1: ethernet@5b040000 {
> 		reg =3D <0x5b040000 0x10000>;
> 		interrupts =3D <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wi65hn3usen55a7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQq6kACgkQKDiiPnot
vG/hxAf9EFOcg+9JNTCutVki4jjQfTWBDu93DOYJ45kqEF6Eu9yV8aR3M1fNOEIp
B9jve6WxZ5E9eBN1/usQLvXgGruaP311uRm8wGVyCIu8+/L4FqOkUUbLlbm+l/iS
lTZOCBwNxx13GpOo1wy48nVsOTxQjEF4bF17Sjdn/0OVwEgMdY2BoFr3pZTV6c8v
+B8tialcIFGLWgoQ1YqCgi6guSWYre9RT8ieltJI8CBqBDkB3ShoinFIL0hzRxKP
8zOpS7rVjdIuPC9yYPkQXH405JWfjDiNfoRYDBakKrJxjQ2LGWVz9KnW1Jc4s7qH
Cq9j6y+us1x70O38Se7HTU3x5bIMow==
=/2Ym
-----END PGP SIGNATURE-----

--wi65hn3usen55a7x--


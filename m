Return-Path: <netdev+bounces-136877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B839A3701
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062471F22BFA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE587186E3F;
	Fri, 18 Oct 2024 07:21:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AF189BA2
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236104; cv=none; b=Lp5mSLhiz6iXAi3nqo/zPzpqax/gwMsGCNw8wTdi5vK35fcES2m/8O0VtTd1FqVw7Cnk6BEOEs1ZbfFmeFJwtQ6n6H4NJepPRNs+FiBxMTFMdowmtW+Jxhmg47L3ST+2BYeKFbT2W9ATFDrz1hH6Khr/5tSQYXni6ZvEzNM88aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236104; c=relaxed/simple;
	bh=3Hc+QKWRe6CJdpdWi0kYQtpq7TAIE4a9KyFJhaDo2Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JedJwR1c1rN1wX2j/5kqUpyPNlg4HDCgr2+y1s+DVrwF9jtigIX6eiUthZkrKDv6B5XwfcRTDXMvqmZbyWJqN05a7q9jMlYmESb943q1CfCw0ODoagvXTU+ziaLQwAomDkZzwpdq0TrSCjrzbUpboyiu+ktBP2O9JCec4VSmRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1hId-0001VB-Ef; Fri, 18 Oct 2024 09:21:27 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1hIb-000Ajz-2u;
	Fri, 18 Oct 2024 09:21:25 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8038A355AEC;
	Fri, 18 Oct 2024 07:21:25 +0000 (UTC)
Date: Fri, 18 Oct 2024 09:21:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: [PATCH net-next 13/13] net: fec: fec_enet_rx_queue():
 factor out VLAN handling into separate function fec_enet_rx_vlan()
Message-ID: <20241018-thundering-cicada-of-prosperity-e29ec8-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-13-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85104DCA7DED14565615E4A588472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-fox-of-awesome-blizzard-544df5-mkl@pengutronix.de>
 <PAXPR04MB8510969C2BE65FD3D08ACBC788472@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cp2jxqpoyuqg4cys"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510969C2BE65FD3D08ACBC788472@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--cp2jxqpoyuqg4cys
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.10.2024 07:48:34, Wei Fang wrote:
> > > Why not move vlan_header into the if statement?
> >=20
> > I've an upcoming patch that adds NETIF_F_HW_VLAN_STAG_RX (a.k.a.
> > 801.2ad, S-VLAN) handling that changes this function.
> >=20
> > One hunk looks like this, it uses the vlan_header outside of the if:
> >=20
>=20
> You can move valn_header out of the 'if' when it happens.

Ok.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cp2jxqpoyuqg4cys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcSDG0ACgkQKDiiPnot
vG+lAQf+NwO+/a/yS8s35LmZ8JJuXTwoi8ta39vutpDPQYtHgOxWmjVR2ElMrrGe
B4l/W9zeATUFFZpRnriXWXIJOvn9A11K8Ddo6gyaORrMphlgJ/RefJdI6919vPQH
iV8+8m4pOpNaXBEj5Rau4ZFgoa0/C86O0eYbtgjUgJdkLWk9mdzfFlWDjTrCpiuY
4i4AnelJ29HHqqxPXTwIYBaNmFHJsA7JvAEF0L35NLQVxrIZJm1BH6ZG5KydP0rA
olUVm9Gthntvnzcbs67EDXQbM2JCvguXm4+dAdjBWvtG5aVKvJzEn1QUjQijV5WB
y4o2hwQ3204oxbEoFlZPdH5kH/Il5w==
=qorl
-----END PGP SIGNATURE-----

--cp2jxqpoyuqg4cys--


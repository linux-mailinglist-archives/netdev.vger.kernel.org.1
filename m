Return-Path: <netdev+bounces-136413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856889A1B12
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B63A1C212D9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0AC1BBBE3;
	Thu, 17 Oct 2024 06:53:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124A194AEA
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148037; cv=none; b=OgLNMWXtHrDdpcIIfNPXfBGL5eYLsK9CsCd0C+v54ckkSC0j4iUyDQhRmb+CYI4+ErC/gDKgIFntbYxJoZWrSJ3pinokynTW3GBZpCpZtU1DsEEQKJWJ5WJoCaWKsvWjwO2rIwOFaVFQ8AIHI5tBV7o76ApASP+lN5GFG60pr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148037; c=relaxed/simple;
	bh=t5Youc6wzd4Kk82D4EiRk12WiPSKIDBP+OePEjfuero=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4wwc0Vq7GRBBJFgWQIuo4fOv3MIQKFb/1EKa20QeZm1XjXsS/IBClJcPew4mV+hnb6ROG2FHEmlH1pSb6baQ1030G5iAqHputetqCqbdDQuH/BwBLnCBvwMIw53uuk3q8VHyEXRKHTl30M4+EMeAlI0ZY0f7yMI/kbOe7gA6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KO9-00086h-IN; Thu, 17 Oct 2024 08:53:37 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KO9-002U7V-3M; Thu, 17 Oct 2024 08:53:37 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C2F6E354D6A;
	Thu, 17 Oct 2024 06:53:36 +0000 (UTC)
Date: Thu, 17 Oct 2024 08:53:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 03/13] net: fec: add missing header files
Message-ID: <20241017-sparkling-natural-wolf-9d6afa-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-3-de783bd15e6a@pengutronix.de>
 <ZxBuvUFfLsBVXKWO@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4qxxt57zow6gt6m"
Content-Disposition: inline
In-Reply-To: <ZxBuvUFfLsBVXKWO@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--g4qxxt57zow6gt6m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 21:56:13, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:51PM +0200, Marc Kleine-Budde wrote:
> > The fec.h isn't self contained. Add missing header files, so that it
> > can be parsed by language servers without errors.
>=20
> nit: wrap at 75 char

Fixed,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g4qxxt57zow6gt6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtG0ACgkQKDiiPnot
vG/lbwgAkb4ZZt+bPGECIXqleM2dKEneJimAq/XAdcotKSzF0rbrZfWkE0VOyjhG
N78Z/nzcQrdtaxnH8dpxhe4km6Nm286P3s2m/3FgaQUxATqvOKGOMIwCLNbr/Sgt
/2Y2BeYx1DxPhZicKpNWdjwjSxXg3Wd4CelIHVqRQ+gSSze655pRHJ7nLuMZUMwe
eE63vUZ7NO5kwdQZx2lQB98AHk95CP5+/B2QMrwmcxjxGm9Th7BVyhXmbzWAMFKB
HkK1bqZfMAhcuAv+OTXM5E+h3fTs4+0N9aH3SAA0Tf7TyyLUxGJm1AMzrkEneeEr
fmSkjvIYJlcphRcj4df5+xt1gfUMLQ==
=59tc
-----END PGP SIGNATURE-----

--g4qxxt57zow6gt6m--


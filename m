Return-Path: <netdev+bounces-213698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69F6B265BF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E745C2B6E
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441852FE584;
	Thu, 14 Aug 2025 12:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE530146E
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175516; cv=none; b=BBAY0CTrgPbJN7UA7/QdVTVO42hNnHyLUCpNfYGVqCigYL15tETAhJ8xU0a0GORB82lCeIV06PTVeT5vGkzr1Nn/RdXTimttpOtOQ4acgxLfKq7vgd+bEeyKoiBBc/EJa3qH5xD5kh7kM4t0FP+so8nHaA+3nVPs0PeRwjs4gTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175516; c=relaxed/simple;
	bh=DdrNzEmhknH3r66Lcdr0TDADKa6Th8D1Nz3ZWj4VAWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8REjIKmLJ1yVBIP6hmnI9a0kIJLK9SjlaL6E5YM8gSoHmygX3wMi0LDh835ho/nqMf5/Gt/KkZ5C58wxhMwW64XDH0sgGaomZfe4Ieo9GtJEPCaUAZShDKBqZHPtqEuBKvBXkD+FH0BZUDzvoR1Ecxpd1tNhyEnltSwr8hBUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1umXKI-0004Nr-KI; Thu, 14 Aug 2025 14:45:02 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1umXKH-000FyS-2w;
	Thu, 14 Aug 2025 14:45:01 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A0D7D45775B;
	Thu, 14 Aug 2025 12:45:01 +0000 (UTC)
Date: Thu, 14 Aug 2025 14:45:01 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Olivier Sobrie <olivier@sobrie.be>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 5/6] can: esd_usb: Rework display of error messages
Message-ID: <20250814-uncovered-debonair-porpoise-28f516-mkl@pengutronix.de>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-6-stefan.maetje@esd.eu>
 <20250813-small-pampas-deer-ca14d9-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="55pxy4oamhnrh2ak"
Content-Disposition: inline
In-Reply-To: <20250813-small-pampas-deer-ca14d9-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--55pxy4oamhnrh2ak
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] can: esd_usb: Rework display of error messages
MIME-Version: 1.0

On 13.08.2025 10:12:03, Marc Kleine-Budde wrote:
> On 11.08.2025 23:06:10, Stefan M=C3=A4tje wrote:
> > - esd_usb_open(): Get rid of duplicate "couldn't start device: %d\n"
> >   message already printed from esd_usb_start().
> > - Added the printout of error codes together with the error messages
> >   in esd_usb_close() and some in esd_usb_probe(). The additional error
> >   codes should lead to a better understanding what is really going
> >   wrong.
> > - Fix duplicate printout of network device name when network device
> >   is registered. Add an unregister message for the network device
> >   as counterpart to the register message.
>=20
> If you want to print errors, please use '"%pE", ERR_PTR(err)', that will
> decode the error code into human readable form.

Sorry, I meant to say "%pe".

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--55pxy4oamhnrh2ak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmid2koACgkQDHRl3/mQ
kZzdFAgAqLnhFjujXVIrHlDsKbYnbSQB2siKl+fAb9uBvUZRe7kFnvlfBiZcQmiB
9EkwF/3p3y/2HzQ3rsyyVjUxKMVltoe1O2JrSoq3IX94J6Lr4ZJKPT+tzD0IzEjD
oRniDBMMtqYdaOAZwEX4sjrZ22gxmejpQOhSNYtRcVStrEYBMvUH5EY5e9H96hsY
js+/CaOWLcDE1WHaqlvcmDhOk0rwL02o3fISG8wFKNPGiyCwtfw4rEl39TQHOutw
VG4pDd9VOsVZNKvhLodIr/JGa/eOLJpgIzeyQrBx4xLDDB60tfQepznpLtix54z3
OJmE4JnIDqEw/mynDnUGiPVQrla58w==
=tX0x
-----END PGP SIGNATURE-----

--55pxy4oamhnrh2ak--


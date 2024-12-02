Return-Path: <netdev+bounces-148014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4229DFCBC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F89A16115A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C201F941B;
	Mon,  2 Dec 2024 09:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E21F8AEE
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130262; cv=none; b=l4YEZPWDxnleIDjZsK7ltf+nB9Qi/RQ3d6WqwwynGyTOA6ud4v5XKdY8PdKt96aIgjej0IEzOCmWqH4rvOughHH9f3kdIHyIn/O/ge05Saoc4AM3ek3dfDIUQwNl6ZzzAzUrVv+uo39H4okBPOKHkTNN7Cwt0psxPLWH7/bn5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130262; c=relaxed/simple;
	bh=NyOjJgK3ANMxtijaU7GELZluAOvG0y11W041vDVN7d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5Wu9Omp0A5PLaXjCSVjR5l0idZhM3f7f3ZX0Ymfffx66+I+yXwxcrBQFEefbuij4CtalGQyesEAvHbaOqfznvtEoTHQ3BkYKYvyhaNRQxZ7O+jpJjgYZhoECoG6ARfR9gVmd1zr/7sO0WHxvx2Cmt+D7NE1sNQbHK1XGF5TBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2Lp-0001g4-77; Mon, 02 Dec 2024 10:04:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2Lo-001Ge8-0c;
	Mon, 02 Dec 2024 10:04:16 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 88005383428;
	Mon, 02 Dec 2024 09:04:16 +0000 (UTC)
Date: Mon, 2 Dec 2024 10:04:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/14] pull-request: can 2024-11-29
Message-ID: <20241202-nickel-panda-of-argument-246281-mkl@pengutronix.de>
References: <20241129122722.1046050-1-mkl@pengutronix.de>
 <20241130142416.66e2caa2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ukmqvppoufracluz"
Content-Disposition: inline
In-Reply-To: <20241130142416.66e2caa2@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--ukmqvppoufracluz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/14] pull-request: can 2024-11-29
MIME-Version: 1.0

On 30.11.2024 14:24:16, Jakub Kicinski wrote:
> On Fri, 29 Nov 2024 13:16:47 +0100 Marc Kleine-Budde wrote:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/=
linux-can-fixes-for-6.12-20241104
>=20
> Looks like the tag here is stale?

Doh! That was obviously an old tag. I've send an updated PR:

https://lore.kernel.org/20241202090040.1110280-1-mkl@pengutronix.de

Sorry for the noise,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ukmqvppoufracluz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdNeAwACgkQKDiiPnot
vG+QDgf/SazZtYURExNRxKZf1vZnb5dL0o9Y5T1d/7upG9XY90MmpX8Ak6nGjbJg
KPnWLIa+HtzEANAf9sflfUii3zMcrJGkOX21QkPmvEEskgsPx5Nex3vRZLafuquI
4QS0N2VZ/8pjy/kffwT8GyxkEZaikd0QXUkaqIIQYpvbRQ+CFp/yoUfNmgH1KE9y
bzhRtdcj8ja+AIw95zeAMzokNXha1YLuKxzHef/ybOhBmycuYP2HOsVaXS/W4V0b
s9LGAT2jHEWrnPBpIf6xiwWaAdYMilGrBlFCzaeiBORYAugoyNK0bLmJQa0rSW2E
Jt3vUfcPLX+i64/qRS5btUybD0IzmQ==
=Da2m
-----END PGP SIGNATURE-----

--ukmqvppoufracluz--


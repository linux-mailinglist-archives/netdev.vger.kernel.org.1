Return-Path: <netdev+bounces-116389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32E94A4C0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59BAB27B36
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A21CB32D;
	Wed,  7 Aug 2024 09:51:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127F1C6899
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024303; cv=none; b=Z+x77Z0wK7arZ6u3Xl12Xto6vBRiX/ON4oni8fFOuRUnEYc1/RboFLsZjYczm3JE3/OIBJCmQ8NwUyVKvyR5x/O+JX9LQYUvLzmRg/1/plghU3hD+C7g8tWkPSOOSJ9fWAhOmXjPFg0aLcmkpeUt6u7w2+EjyKknbwwq+Fi1XAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024303; c=relaxed/simple;
	bh=TCxNvcFM95dEXhKuywWdQ4osqazRMl3b8p72efeJZUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCKuJsuJm5CzhCjDyh2ci3oJutaZXH2/3wTQo/+6aDKbe8ekQLmBhRvJpidfpy8mb1viM1PSL5yBXCkUQM3bQyUkxiRoTJt8Q8hbz+qxCaQc4BNqkPfMNlVV/QVfVOsiXNBF+EBo63sA/X01vDJu+pZnGMa3RHvn90ejJ9PqsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbdKR-0000j7-5E; Wed, 07 Aug 2024 11:51:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbdKP-005ABo-TG; Wed, 07 Aug 2024 11:51:33 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 818443189D9;
	Wed, 07 Aug 2024 09:51:33 +0000 (UTC)
Date: Wed, 7 Aug 2024 11:51:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH net-next 19/20] can: kvaser_usb: Remove struct variables
 kvaser_usb_{ethtool,netdev}_ops
Message-ID: <20240807-khaki-yak-of-wealth-a252f9-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
 <20240806074731.1905378-20-mkl@pengutronix.de>
 <20240806194332.28648126@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g6wrywl5gc6j6xwv"
Content-Disposition: inline
In-Reply-To: <20240806194332.28648126@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--g6wrywl5gc6j6xwv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.08.2024 19:43:32, Jakub Kicinski wrote:
> On Tue,  6 Aug 2024 09:42:10 +0200 Marc Kleine-Budde wrote:
> > From: Jimmy Assarsson <extja@kvaser.com>
> >=20
> > Remove no longer used struct variables, kvaser_usb_ethtool_ops and
> > kvaser_usb_netdev_ops.
>=20
> The last three patches in this series should really be a single one.
> I don't wanna make you redo the PR but it causes a transient warning
> which prevents our CI from trusting this series and doing anything
> beyond build testing on it.

Doh! Will take care that every commit in the series compiles w/o
warnings.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g6wrywl5gc6j6xwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmazQ6IACgkQKDiiPnot
vG+MzAf+KjtNsw9aha6dQ+EGqr3kQyJosfj5P2WrTsoJPUSIYm0XCt89wUu4zMtA
e/d0hn+4LKII3ixKjnipwmt8w3WHQEDqUcYvDc9keNcjz6ZRrNVp6nWHN2bPkUdo
cf9mpLXT2IwEIAkFmSC4unBz/wFPlrwYHAMTDIS1i2fXsGjDGBnym4j5CXXFGgdv
pGIUMqsNkyRqTHOTZraEZMwr7dv8fQnkpJzNT6ZmLjDDGpqGWl34d+ZaNTq/5Jga
CmBd6tr3IkNdEKaiR52thmc8HQaK+Wev+EC0/niHFe1zJHnjYjNuSGJ+ZL5yJWaY
+Ybm77hZfDk9eQLt0lQVHlvDEgBL2w==
=llPg
-----END PGP SIGNATURE-----

--g6wrywl5gc6j6xwv--


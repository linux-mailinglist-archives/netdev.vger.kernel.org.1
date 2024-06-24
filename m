Return-Path: <netdev+bounces-105988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80E914282
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2D828385C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 06:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2075225D9;
	Mon, 24 Jun 2024 06:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672B219E1
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209335; cv=none; b=O6rmrF+15TJfPYYMVrYSS1nY7zlooGY9fYLuyBxFD9ChvrFMljJyvk4aG+3vDfrvd7nsO7Js50O3st4lh9patUbbpB6aOt6f084m9i2XJWrd+ipVUtwkVa2UlQH4NhwozZcyWgWG5LtInlX4PeclK9dE4H6jE9aPHlutQmAdIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209335; c=relaxed/simple;
	bh=uqcv/aHeTQl9D7dU4EYZ7Ku6Q1CiTbRy9t97GNtn1p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaMj7sKC3TeipOL5wK9QxQBIFdTO0QKLasP9UX8oOuVV3dxBNpp3pQrZneGBVyF4N7i7IYa5kklaqxL8G8V+tF7ESVgyee3PhzFohzvSVRCmdjIpNPN2gxTKOe/54w8oyJrizobsigXgzUr8kyWSRKM5nMfyS4pV69woTpdf6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLcsS-0000Da-BK; Mon, 24 Jun 2024 08:08:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLcsP-004aCs-Me; Mon, 24 Jun 2024 08:08:29 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 53F332F07FC;
	Mon, 24 Jun 2024 06:08:29 +0000 (UTC)
Date: Mon, 24 Jun 2024 08:08:27 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] can: m_can: Constify struct m_can_ops
Message-ID: <20240624-cornflower-stoat-of-satiation-717464-mkl@pengutronix.de>
References: <a17b96d1be5341c11f263e1e45c9de1cb754e416.1719172843.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zlcot2btxy24qan"
Content-Disposition: inline
In-Reply-To: <a17b96d1be5341c11f263e1e45c9de1cb754e416.1719172843.git.christophe.jaillet@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--7zlcot2btxy24qan
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.06.2024 22:01:50, Christophe JAILLET wrote:
> 'struct m_can_ops' is not modified in these drivers.
>=20
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
>=20
> On a x86_64, with allmodconfig, as an example:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>    4806	    520	      0	   5326	   14ce	drivers/net/can/m_can/m_can_pci.o
>=20
> After:
> =3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>    4862	    464	      0	   5326	   14ce	drivers/net/can/m_can/m_can_pci.o
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to linuc-can-next.

Thanks,
Marc


--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7zlcot2btxy24qan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ5DVQACgkQKDiiPnot
vG9onggAjzcvQznEZasi4ojbK7VfBcU+q7wF0chZCy58b4piDm3E0XwFmV313AnF
JVdWPsZRTe6iKt4bh4ZnBeGOfPhKFs89Fqog52tW+8V80F1bIIi6IN3Wd15FoYuT
whfDJcEcyEdKDkfHdhP57bslbCiZC+5ORf6idElcPSY9B6U/X/OEYiiRP6WdMBZ4
yAj9SoX0BlKdiS8W8E9jWBGk3yAxclztj6BNuGzrd9gaTgdPvRVuxbK3ifEv5iEc
0ev8E0ZuEP8N304cLOvsTiM64vHHFxx1QNGHc1qgPv+VjKqDbRNPBN/SCM0RlEj8
L6hg2B7VFUweY5c+Myd14dV411nOPQ==
=Qckk
-----END PGP SIGNATURE-----

--7zlcot2btxy24qan--


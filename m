Return-Path: <netdev+bounces-92222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D68B602A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED4E1C216AE
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E76126F2C;
	Mon, 29 Apr 2024 17:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783E1272AE
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411881; cv=none; b=cJVsFqM6SOwKUJmr3IyxlFcH9HhiYU4hbKFjm7+Y4HYjEDtnKvOmb3uz2wgDTAT0QDI4jI9JBMdiTNcXZiWNxz5Ni0i8vgCGCVjuRX3M1dxziT1Icfn7Wz6SuFvkbDS8JyXZmqnuGolGM1GC2oXh4RKYLznwb9RTRL4LZVYApsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411881; c=relaxed/simple;
	bh=ZCmGqnlOT9L8Ho0Ol6vCJfREIgXEZnBOeAaAF8jLrXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzStVw8IP71atgCWKYIFfgtCWT9YkXoUXWlfFWk4KyQXGm1ZbiW5272JrzXMt8SIW2GCVMTx0gi+AhftbonT1OX/cm266IZ1jwzPqjwS+LzEKkGxK6ZNFMctnX6Ul0xQvLPQWwRzlVoE5BSypkuJ+m8t7jMCwRjD8s4rI8avlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UqO-0005j3-DD; Mon, 29 Apr 2024 19:31:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UqN-00F1OD-Dt; Mon, 29 Apr 2024 19:31:11 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 13D1B2C2355;
	Mon, 29 Apr 2024 17:31:11 +0000 (UTC)
Date: Mon, 29 Apr 2024 19:31:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Valla <valla.francesco@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Subject: Re: [PATCH v3 0/1] Documentation: networking: document ISO 15765-2
Message-ID: <20240429-mighty-starfish-of-speed-c76ddf-mkl@pengutronix.de>
References: <20240426151825.80120-1-valla.francesco@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qrvibkipuwdo6qk4"
Content-Disposition: inline
In-Reply-To: <20240426151825.80120-1-valla.francesco@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--qrvibkipuwdo6qk4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.04.2024 17:18:12, Francesco Valla wrote:
> While the in-kernel ISO 15765-2 (ISO-TP) stack is fully functional and
> easy to use, no documentation exists for it.
>=20
> This patch adds such documentation, containing the very basics of the
> protocol, the APIs and a basic example.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qrvibkipuwdo6qk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYv2VsACgkQKDiiPnot
vG+oOAf+PDoR2LAKTRWuRmBdSvihbML3BrYPD/yfhE72JUm1TNnpQCFySX12WDqq
7txdSogfzoqknNzh8qUgbkQFY9wvF+TeeqW049lgy2QSA8xEqGS/Cy8PrdlFlREc
0Fk0mNEHd8GshYoGBJjrhTLnjCe01TZVVOW9mWo9RHW/JVq0kv29rBh0skajqZr5
2YDJiO9ddn8Jb0OnjcAtK6rpzxEiFDFGz8ty1rEzVN6a4WQM1eY0CFnlA9V2wEmF
fQ6tBkrl7CFGZMR0pOPIJMRHoGhd56+FhTXSGfuAapxsUraMfODznIOuLVdUyzUx
BwJ4CsJS/TwfO+fPEhvr2K3QiB1ClQ==
=xidP
-----END PGP SIGNATURE-----

--qrvibkipuwdo6qk4--


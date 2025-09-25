Return-Path: <netdev+bounces-226347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F34B9F33E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4E61C22355
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004952FE055;
	Thu, 25 Sep 2025 12:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE352F658D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802714; cv=none; b=pGttXRGZjw2YR+LzdNWpan4CzncCqugJ1zH1vA57buOhuHBZUSnHsSyDOmaHeWwhCQ2p5Sae8kSwG/j46kRLKSAZrINpqYY+freIyKRN9GfIR1+M5aHGGLT+eMfA06XoJvyEMI7l/AHpXyhtD1Ntdnd7wztHt9C5WQMJD0KmLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802714; c=relaxed/simple;
	bh=TVBkYwEbbEkSC0zvizrsZYI7ZlPvKGbLY2MYIkEe5R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjZbzV5KKQLiflc/T7OdrKPXwr+vJo+lfrOjcX2WO/vi+M04Ov3i8QMvvfWm5mSszIJRrJnismCL4s4C/ZycSxbFTGe7icUs0GDfPdvoTZBDKY/71m3JDkLt5PJWDKO5kTY0AmHPxDzkiwXKM32JbMweNitRIwb4ESf9sOHndwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kve-0004SG-7T; Thu, 25 Sep 2025 14:18:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kvd-000Pyj-3C;
	Thu, 25 Sep 2025 14:18:30 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A7D8F479B14;
	Thu, 25 Sep 2025 12:18:29 +0000 (UTC)
Date: Thu, 25 Sep 2025 14:18:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/48] pull-request: can-next 2025-09-24
Message-ID: <20250925-real-mauve-hawk-50b918-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bs6ygkx25t7yr362"
Content-Disposition: inline
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--bs6ygkx25t7yr362
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/48] pull-request: can-next 2025-09-24
MIME-Version: 1.0

On 24.09.2025 10:06:17, Marc Kleine-Budde wrote:
> Hello netdev-team,
>=20
> this is a pull request of 48 patches for net-next/main.

This PR is obsolete, see new PR instead:

| https://lore.kernel.org/all/20250925121332.848157-1-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bs6ygkx25t7yr362
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjVMxIACgkQDHRl3/mQ
kZz+fwf9FIYKJR0Qqmm2XOtSHtWt+ztATQ7MM9zMcte0REV3iY5ol/N0/porVB95
cBhddXvfsQCJLkIOvCDpvol0g1Qc1AFrTRGksRMLtFE9MvfzEaUiIOwCVhcgyB/e
iFATDvVEO3550gmwwLWqNuckcboRjtFNS8XRqrXm31PseyudcM70FBtveHRIIxPa
a/YQdlRJfHYhRnOfQ4BDz+Q0A2QegYlRZkFXCGCs/RCxR1KQuLYWF53QOY4d1jIk
2hctHoh22mu18DVfJProqbjPIE9NrFdy8MezaaTH640/zEGy/nl5vcU2OXdZO6FN
KZX1IPMdCh8FeN+UzWkYVzeSz0TtdQ==
=+Bui
-----END PGP SIGNATURE-----

--bs6ygkx25t7yr362--


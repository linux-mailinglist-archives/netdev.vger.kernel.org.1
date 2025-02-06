Return-Path: <netdev+bounces-163405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE4A2A2DE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492ED1885786
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359C225410;
	Thu,  6 Feb 2025 08:03:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2C224AFF
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828984; cv=none; b=kfAm9BmQrUzfu5r8/Z5wq3uDo/t/dFBMPcyEgrtNxYX9VuQvvWGG1Az64pi+HrU5xypIpItdRvnFvhc3tbZ7sspSWaVxfEaBX6BDxr82bfsgSmwYO/XUXwf3qdpgyV68qLHpMOejlebVc5hOJnrIhHeFYhbuCxp+eOkeSzJ8/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828984; c=relaxed/simple;
	bh=t5ISdDJR/VEFHvOGril1zQ1eTns/6CK1nqON++9kuZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsKzloIihfoCdIm11mh2NGG3K4k8M1awK3dLoL2kAIWXUgzUwPWizHd7hG+VtP5zDF/quB4B5nmiu5MRU/WV67pRjK3vTdWhZ5vj0oudwTj6kjjmCxUwG+Lo1QaaNh/tvN2ByPKuBgVcDIB54LmApbwKVJiBcreiwW15RgNIBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tfwqX-0003w4-Tu; Thu, 06 Feb 2025 09:02:49 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tfwqX-003ljE-1j;
	Thu, 06 Feb 2025 09:02:49 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2FE7C3BB126;
	Thu, 06 Feb 2025 08:02:49 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:02:48 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Reyders Morales <reyders1@gmail.com>
Cc: kuba@kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/networking: Fix basic node example
 document ISO 15765-2
Message-ID: <20250206-light-brave-polecat-3290ac-mkl@pengutronix.de>
References: <20250203224720.42530-1-reyders1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vavlqxkz2rpr5b3f"
Content-Disposition: inline
In-Reply-To: <20250203224720.42530-1-reyders1@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--vavlqxkz2rpr5b3f
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Documentation/networking: Fix basic node example
 document ISO 15765-2
MIME-Version: 1.0

On 03.02.2025 23:47:20, Reyders Morales wrote:
> In the current struct sockaddr_can tp is member of can_addr.
> tp is not member of struct sockaddr_can.
>=20
> Signed-off-by: Reyders Morales <reyders1@gmail.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vavlqxkz2rpr5b3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmekbKYACgkQDHRl3/mQ
kZyqiwgAjN3IlKV06MiTRQNzwmKUCSVPUON3i1AgHOtESn6MJkQmEaHpiUjPIEEQ
6p6ZokumiGO0EHGw+MbKRAnerJzWt56QkOCoVer8DayWFl8THX5ufU5983SLLzY7
BrL/qJevmiX2Zn4+M41MWQo6knEKFl0N9JuyCb+ZZPvFXgcVCQgil0nyqLfLZZRg
kPww8YiZ8iWvDcU4jO3hJL6Khd3M/ERVH4A+aY3ovVIPv7tejdeVNa8o4H0iq6WH
I6LRz06dSWKPIeZZUDh7rziJZK0BlCQbn2utqRwWGlDSsGlWJIsMwrv1cZW+fwje
xERmZXyV/8XJ8TeaLrNBSkhytdoCVw==
=38XI
-----END PGP SIGNATURE-----

--vavlqxkz2rpr5b3f--


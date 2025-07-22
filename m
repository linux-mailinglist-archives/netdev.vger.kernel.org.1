Return-Path: <netdev+bounces-208875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C78B0D781
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A2B172D86
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E902E06D7;
	Tue, 22 Jul 2025 10:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9128B4E7
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181338; cv=none; b=utbQgRuR41ISpqIpt7RY5uKKU77MJW1Lq6xGUxs8kuy04q9e0hZxSHi2ipOf6q8VOGxUbYM+o5HenuLPYIQyNm7o4++o4CQqdrrSgIBvaU/EPsGguqGK+C+tiRS0b5gh+lMsONQI+yNSpzsTFAyavi3r3aGoThh6Bl3tlMrp4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181338; c=relaxed/simple;
	bh=M4a3CnajWkTCRJpY1bR4dL7q+kEv2Le34ZDb2gePCYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3fbxXh0UZ0u+2AH5FxQqtXGwoC8kv1t1voT8mt7KmMPO0NSJJv8XBc25zRnaRkDxv0hSMRx7MUrw69ufiDZvhKyuWLeECHTPhZflBmLG5jWT4M39ntU2EHAyz8D59KRx0Aizv0JPHDFrfkr4dH7clBhXuZWlN3hMLWyHotONB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueAY8-0004qY-7i; Tue, 22 Jul 2025 12:48:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueAY6-009i1I-20;
	Tue, 22 Jul 2025 12:48:42 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 422BA4463B4;
	Tue, 22 Jul 2025 10:48:42 +0000 (UTC)
Date: Tue, 22 Jul 2025 12:48:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "Andre B. Oliveira" <anbadeol@gmail.com>, 
	linux-can@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] can: tscan1: CAN_TSCAN1 can depend on PC104
Message-ID: <20250722-delectable-porcelain-partridge-a87134-mkl@pengutronix.de>
References: <20250721002823.3548945-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cghwqib7xmzk6zjf"
Content-Disposition: inline
In-Reply-To: <20250721002823.3548945-1-rdunlap@infradead.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--cghwqib7xmzk6zjf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: tscan1: CAN_TSCAN1 can depend on PC104
MIME-Version: 1.0

On 20.07.2025 17:28:23, Randy Dunlap wrote:
> Add a dependency on PC104 to limit (restrict) this driver kconfig
> prompt to kernel configs that have PC104 set.
>=20
> Add COMPILE_TEST as a possibility for more complete build coverage.
> I tested this build config on x86_64 5 times without problems.

I've already Vincent's patch [1] on my tree.

[1] https://lore.kernel.org/all/20250715-can-compile-test-v2-3-f7fd566db86f=
@wanadoo.fr/

So this doesn't apply any more. Fixing the merge conflicts result in:

index ba16d7bc09ef..e061e35769bf 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
=20
 config CAN_TSCAN1
         tristate "TS-CAN1 PC104 boards"
-        depends on ISA || (COMPILE_TEST && HAS_IOPORT)
+        depends on (ISA && PC104) || (COMPILE_TEST && HAS_IOPORT)
         help
           This driver is for Technologic Systems' TSCAN-1 PC104 boards.
           https://www.embeddedts.com/products/TS-CAN1

Should be ok?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cghwqib7xmzk6zjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh/bIYACgkQDHRl3/mQ
kZyzVQgAgWnMz8k/e537y3SKvLLRuvHRG0VMsNOQ4maAcQMIFWQ9Ht1Y5Zma+hix
GXGcp0fc7WTYQrviwW6jrXSVsuyVO56M10P9JPYfOiESCmsFvC7APBhvUSvOYzC1
19ovZ9SheYFgIXXsA6gJ8+/4V+W0n6hfJZRJqo5Ej2seigX1Ubi+GIyzRKYdWqps
PZ3/iUj84fTVgxlXhjPplv+5sFHENkmnPvUlKJrVtRLy/xfTFogOKyMt1QRpXlXL
56ow4zOiwpD8VMecE9a7mpsrgnTc6jGnGdNDrKBhIOyNoyLA09cBMJnefpb/fa8q
ETSpll0XGiNN/xRPyPkclj4irjEc5A==
=XeRL
-----END PGP SIGNATURE-----

--cghwqib7xmzk6zjf--


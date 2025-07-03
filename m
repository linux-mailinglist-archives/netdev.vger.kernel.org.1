Return-Path: <netdev+bounces-203907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB4AF7FE6
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 20:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F04567343
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65CF2F549A;
	Thu,  3 Jul 2025 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="lONNnLqh"
X-Original-To: netdev@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB22F509F;
	Thu,  3 Jul 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566881; cv=none; b=pNSQM7+5b0zFl3SSJZylBnyR7Vq8scWRBAD52yCDVEL6/ySK+42Lp9lNeLCH/s5C63QQ6Ty295+MwTDdjocvamY9ITPP5D1HuAauA6sFfP3qm03iU/x0ZhnY39ox7YawhDWHxCx96XGps8na/jpVEiE/5wto6ZFks5pclK6xMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566881; c=relaxed/simple;
	bh=FF2x/28XJUnk5eS0Smdkvo3YNlb+ZyKmV07f5R0f6VQ=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bVu1/3h68Wy2hDN7d9f63N1+yjgXZ/ak3EcHHYn+GvwpY1fEuSCk26bpSKXQe/MRRjF2kwcH8zhnFw1fe+1hvQmXRL5jUiHPhtB3xEsyB6cSMKmpXftqRhviOD/oUN/k9lmUyHyjE+FhX1sVYuoTdBcgtPYnvd84LVajH7xt5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=lONNnLqh; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1751566876;
	bh=FF2x/28XJUnk5eS0Smdkvo3YNlb+ZyKmV07f5R0f6VQ=;
	h=Date:From:Cc:Subject:From;
	b=lONNnLqhJ0KitUUpjBZa/OZoHJk37bxbaxHnF+JWOqEQVBUj3KM1tb589togSNXJx
	 6r96k88vXm0MfxGL3v3PUQDGtH9FDVrW2XwGnNFYWvjeF6R/5gMcZ7VR0NM3Dhgipi
	 CZ/AGJMeV0m+sKtLZYheeiUL/RtHm41SLOcxDi9BDRxua3Sw+jrc7BdKR+FFhys6ed
	 jD3NZ5Y8Y6vqWSMkkqgB6rvyTrvT8G5f6gMZJ54nRBSvjt54z6Ss887jQuQL8+RksH
	 uclXNyLsjHD2xRj94X0JgFb/btinTVSXfhi3qqOb5TP5uaYKH0Z+T4jVuv48zGJIhh
	 1X9+/662JwwPw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CEFD26B4;
	Thu,  3 Jul 2025 20:21:16 +0200 (CEST)
Date: Thu, 3 Jul 2025 20:21:16 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Chas Williams <3chas3@gmail.com>, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] atm: lanai: fix "take a while" typo
Message-ID: <mn5rh6i773csmcrpfcr6bogvv2auypz2jwjn6dap2rxousxnw5@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rcjykay5rnmkaem3"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--rcjykay5rnmkaem3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnr=
ufop6tch@tarta.nabijaczleweli.xyz/t/#u

 drivers/atm/lanai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index 2a1fe3080712..0dfa2cdc897c 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -755,7 +755,7 @@ static void lanai_shutdown_rx_vci(const struct lanai_vc=
c *lvcc)
 /* Shutdown transmitting on card.
  * Unfortunately the lanai needs us to wait until all the data
  * drains out of the buffer before we can dealloc it, so this
- * can take awhile -- up to 370ms for a full 128KB buffer
+ * can take a while -- up to 370ms for a full 128KB buffer
  * assuming everone else is quiet.  In theory the time is
  * boundless if there's a CBR VCC holding things up.
  */
--=20
2.39.5

--rcjykay5rnmkaem3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhmyhwACgkQvP0LAY0m
WPFhBw//QYc1hyRpocO5wKStP3c0G519ANKWysbhqHlkw5/sYp1VyoKzTDCZZ/im
rDRHXA95tYp0Xjr8lB6yUcjQ5oCxXGEgRUzuLowY01E37cQuAkpoHLVZApcsf5x6
qhp5bG+draBhzeYQc2Y5WHx3oA6FczZdV+KyvZ+XqYbQsQmnxqhEET+0MT4wqcG6
9h7gqMCAKDW6sqrXMzoitAXV5AdSpBS9xEDKAdzD53/NM8D5PdN1/l4EKl9xfrDd
spgtWkf5BGIVEtYkzAaV0Pd6GpFXd17qhNPfkf6gzUFRd6ks+fmlMlpc4i0uNmhH
XtbghkJ4rUiKOwOQlVCX/iTyooTS1wCMVvD1AXSiDKusKr8r6RqB+IGJTAjG6BBp
ed+S+uk/daPScVKA2XS9c168wL+DiSt0f/ypUyg6tkPV0c2zmhRxFUrxr+Lm3wXk
Hxxz5wDAKnotSlMHr9krzLjAqS2jPaHX+gyMHWKhrx6jYvOSYxBAwi14Ywn/Vlaz
pJuxvdADaNRh4yf+4dAA+n/FyuQhRhsoGe0zHEBf31Jti9twpFr8D5eGHbdFvzMs
2/5/H65IgrMOUzGK23gWJA8BW2/rsUDImlKuou36Rpml1vMRU1bs5X0aGU8Sje6N
npeh9ackoAlyvtJndgZxHhNgRyOWDwHoH4lPN89/4rfEyutF+Hk=
=wSrb
-----END PGP SIGNATURE-----

--rcjykay5rnmkaem3--


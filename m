Return-Path: <netdev+bounces-176315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80CA69B8A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59B69807AE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD021B9CA;
	Wed, 19 Mar 2025 21:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A0219E8C
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421122; cv=none; b=pXbwnGO+s3z4RV0+/g0oqfdQN5/OH6u05CZoM0ENrl2+SKa3DyxIcsWtoUg+xvCUepLJbCGgx64ugkmaVNtQLGXUGm7OSnndkuPpO69qaLbDUsLMD468kDOpuk4lClAiSFvv5yMUDrFh6rdmdXUxfDntHm+c3rc48Dtbe3dsDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421122; c=relaxed/simple;
	bh=fovONEDMtM7seNcbOra/8SfscccH4qtd4sJJZ0rt9Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt6I8cZscgXIDqm3z7FsDhhRyZVU4TxRm9CUrAxBu4VY+qKje6eoT89Oxag2NpBBzI1JRQH5ygGt34R85jIXxVoYEFj03TQaH8J0aeZk74oaNbeJakmXw1uVM8u4qlzRn3nVQWFT8v1oop77R7B0bKcHOoXbqcF+HzoWA4eahzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tv1KQ-009oev-2Z;
	Wed, 19 Mar 2025 21:51:58 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tv1KP-00000002bLb-2qAw;
	Wed, 19 Mar 2025 22:51:57 +0100
Date: Wed, 19 Mar 2025 22:51:57 +0100
From: Ben Hutchings <benh@debian.org>
To: netdev@vger.kernel.org
Cc: 1088739@bugs.debian.org
Subject: [PATCH iproute2 2/2] color: Handle NO_COLOR environment variable in
 default_color_opt()
Message-ID: <Z9s8fb6-0Oysrc5j@decadent.org.uk>
References: <Z9s8RSix3wtE8QPf@decadent.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5L834/9D49Mwmqwo"
Content-Disposition: inline
In-Reply-To: <Z9s8RSix3wtE8QPf@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--5L834/9D49Mwmqwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The NO_COLOR environment variable is a widely supported way for users
to disable coloured text output.  See <https://no-color.org/>.  In
case iproute2 is configured to use colours by default, allow this to
be overridden by setting NO_COLOR.

This is done in default_color_opt() so that colours can still be
explicitly enabled with a command-line option.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 lib/color.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/color.c b/lib/color.c
index 5c4cc329..3c6db08d 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -83,6 +83,13 @@ static void enable_color(void)
=20
 int default_color_opt(void)
 {
+	const char *no_color;
+
+	/* If NO_COLOR has a non-empty value, coloured output is never wanted */
+	no_color =3D getenv("NO_COLOR");
+	if (no_color && *no_color)
+		return COLOR_OPT_NEVER;
+
 	return CONF_COLOR;
 }
=20

--5L834/9D49Mwmqwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfbPH0ACgkQ57/I7JWG
EQmPwhAApp49IYC2Ji3rWBOW7/Yu3/xdLdQeK7DPN2uMyIfO/ZX7EXsy29OrgLWu
xtHYqI/TOud4YvfVlYJQyFAuhAhYldWdaAKjB+1z8C2z3HUHWqHRLNfYktnVhQYb
yGRo4/28mmC6U2UzFwWurQWAe9QM+DMaMsFNaUK1bTwwX72pd8cW0ZS8aMzvaVrP
rKDVbT5jX5d6F2N2iyObcGIYyWibJxeKp1Z5QAU9HFxMyJsCnSdqA7SFAA9NNY27
APBLinUIMoAwL8sq78ENhqL6fmQj7REFh1AA7gad87g69Vn0Z/P+QwKxnay61PDi
EtoZKdRSSBtFDDKHcy8xu64+1vnJrmmgnDh1o8engZ5nHBxcaWIr+MddJFbKLLM1
5+DKzgEYk04TzumnIvPSFETi67DoreqMlhYgUC1xiMUBjIxrBAp2D6rXmtLV+W6w
2WeZsc98BmQUhcrc3fs9l9t18pd0Yf2dOEN71Ehuhc62UE+3ML5o4UXPLxJIpZys
cB/1zVGaZXAKJt8ecsr8J1XlKqHBYGNpZXxPA67tIju7r4fRBIfdZ+HKGwPkHbIt
HW2yRyvGTAaQBnVkRW3b69q6WQG9CJTj27JIRmf8CtB1InybeK4NmKSeHvzV3VvY
ZNQJg3fxIod/60G7Q8bFYhnic+dGOWcJJGmelJMV2S4UpHxTIak=
=hUF8
-----END PGP SIGNATURE-----

--5L834/9D49Mwmqwo--


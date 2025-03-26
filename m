Return-Path: <netdev+bounces-177742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BDA7181C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E68A189C79F
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA001EDA34;
	Wed, 26 Mar 2025 14:08:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81369187876
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998081; cv=none; b=Tf63xHPznC69mGzszKoXwrr/4ELfI3v6uwZz8l+4DGr5AwGuR6/93ARChdaYDx9WRrydruMc+tsCAvkACr3N4AooQz6AAhW60YzQ/RqyuWIlZzUNj+DwJchXuRDnY8ZOg7xIA5c5E/7ceKmF/cZu86TgBjTtgbUH4B6cTP505iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998081; c=relaxed/simple;
	bh=QggIoZuH5E7KHex1Wg+QXjPlk++7IuMC/G7tn8fZus4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jR0n4NsPZsLUaHjRGy9WcwGoVOsm0jTfEeTvKL70VIuBtQ5YkTTdcSUGddzPTf4MSBRDW9ylMdXK8Uy5/JW5LvmYCIfd+4Btfe69+s7QymjNvpG4lddea3eGHjaNyLu+YXPqLXgIYpmpeUnoVtHX9VwqZZvXgeWM5q77cTGlCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1txRQ6-00Aa5x-0A;
	Wed, 26 Mar 2025 14:07:50 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1txRQ5-00000004jRz-2idH;
	Wed, 26 Mar 2025 15:07:49 +0100
Date: Wed, 26 Mar 2025 15:07:49 +0100
From: Ben Hutchings <benh@debian.org>
To: netdev@vger.kernel.org
Cc: 1088739@bugs.debian.org
Subject: [PATCH iproute2 0/2] Improve coloured text readability
Message-ID: <Z-QKNa7_nHKoh9Gl@decadent.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="okxEBqTJKsoIfmjU"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--okxEBqTJKsoIfmjU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently coloured text output isn't very readable in GNOME Terminal
or xterm with a dark background:

- These terminals don't set $COLORFGBG, so we end up using the
  light-background palette.

- The standard (dark) blue is also too close to black in their default
  dark palettes.

Ben.

Ben Hutchings (2):
  color: Assume background is dark if unknown
  color: Do not use dark blue in dark-background palette

 lib/color.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)


--okxEBqTJKsoIfmjU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfkCjEACgkQ57/I7JWG
EQme3w//SyFIhH4XemA/BXbpk/zTFpn4zh4TT3Qyc1ONY1KQWInI3/Sy9kuokXkD
0h6xLi/7I0k2vz0uJlFF5efUOKwscX01r2YZToDN6LnXNRngZ6ppYCNrCOGH6ns1
PXSC5ZV4JjcueJx7HOILSQDdevPKVlqWAJfdNXWcglKRuocaxeBaKoN9NxcedACc
Yn6bTPxmkITGf7qHAEJtyhVzuzYFyq6TgX5qrYKn7VoqjGhqBlHKZ96LgoqClpU9
b/BCChdR8Rve/NttfW7ZGpEwQbCdxWtUI3sdcd60tALXCHyAPr6e9U8oLE49apP2
EnOn6230wqQwdQoCpnXJwDMH9xm4gebkMBKVw6wrB//Z9HDxJgq3tzQCabbV65RL
Fow4I+aQ4sHB/o9WS6Maj782GwnLKlV5g3BLVeo+Rojx6IAM2AJjVLZcW8MfKfRb
P0FlVNS3qitNbPaPGiOwtpC500eeDRM2IUDmMVYCR2cWSl7cBqnPbzZBjlw1Swyg
1bQYVOcqimbNltxXf1hP5pJk9/Ahda3MjEq6ZVQiWuUHVYezq0oJeA+KUaSBQXWZ
X+Ak306akWrozBezDt4iQPHU9KGlUL97OieVR0n0EVGfBI66r3grv1jHbkpf9zpt
kUIUMKdb1o4UoZCPg2YR2Kf3gpYMtJ8ON+Bwhej6ASgEuLo/wpA=
=3f35
-----END PGP SIGNATURE-----

--okxEBqTJKsoIfmjU--


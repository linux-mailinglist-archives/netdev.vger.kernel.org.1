Return-Path: <netdev+bounces-168024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3DA3D24D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E509C16A493
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459B1E633C;
	Thu, 20 Feb 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmYMJVO1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j7C265Kb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB71C5D5E
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036705; cv=none; b=UiUwGVFNqE1jnc4o5Ho+EabrSYMye09UInN+LfAgcov1VOCVTha6wzR2+Ivwt/lss8uMFvrsK71QY5Sf6icTgIHQ9pCBdSNr91tBqr5L3+vpIcX+ZWSEYl6YLG0nHbSOCtt9MC1KrarS/t1dZi4riLhZCnqdq+niJ3SvQhnQd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036705; c=relaxed/simple;
	bh=y/6iQ7POPZewdLoJBXAbYy6cc/DGn4QrqMuOH7bHnQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7+ZhpebfBZEuwfTBNj/GnRjei2L+x/6j2kY5welBNeXhwH4O+M1K7cFsze7jOIRH4jv+9wz9BRnW3WVqQ30akz0P8vkDyD+PupJqEQoIt+tLOJ3xwHEgqWBavlZbVLj5VTUMf7570aBiDjYxHOK5B0V7yQipH+q3fE+9+4qHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmYMJVO1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j7C265Kb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740036701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxagemPcm4RnM+Hfi872Mf3A+58zxeRdtzcz5jKpQaA=;
	b=AmYMJVO1FVizEnemRLWuQCaWFisQjiIw9C0URxZyxl6pStWJ4kLccfIePh6NX+Kvfy84Pn
	vkT71DqXpte52H38zaQC5IKOdgKbsZo6htnvlIL/MMKtuNE3k1Tm0WWXT5OJOyn4h0espK
	H4DYBRmBf6TJp5hu1upwiquFzvjDO9A1CZhB4jLQ6blALbMzyrUg8/TTVwhC0l5fNb0NAZ
	EQrHiiWeCRQxb0U4yhrZ/VWWVr18yt1V7yc8bU5aXwodjjCYwJXvfGxWUSGsWrtB6IXO8d
	/NE60mK7hJp5hERzcsVvh10X8xNVCmDeKET/KeF0dR7DxkI2SsO+Th+mmY2eVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740036701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxagemPcm4RnM+Hfi872Mf3A+58zxeRdtzcz5jKpQaA=;
	b=j7C265KbIEA7QG+2tg6nTXk4SXP7u1etAufpHbikMuGGkPvGqp5efR5S2svgyy+F7fqbsM
	7VFXNv5Uzb4VuVCA==
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com,
 stfomichev@gmail.com, petrm@nvidia.com, Jakub Kicinski <kuba@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 6/7] selftests: drv-net: improve the use of
 ksft helpers in XSK queue test
In-Reply-To: <20250219234956.520599-7-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-7-kuba@kernel.org>
Date: Thu, 20 Feb 2025 08:31:39 +0100
Message-ID: <87h64p3wdg.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed Feb 19 2025, Jakub Kicinski wrote:
> Avoid exceptions when xsk attr is not present, and add a proper ksft
> helper for "not in" condition.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/queues.py | 9 +++++----
>  tools/testing/selftests/net/lib/py/ksft.py    | 5 +++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testin=
g/selftests/drivers/net/queues.py
> index 7af2adb61c25..a49f1a146e28 100755
> --- a/tools/testing/selftests/drivers/net/queues.py
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>=20=20
>  from lib.py import ksft_disruptive, ksft_exit, ksft_run
> -from lib.py import ksft_eq, ksft_raises, KsftSkipEx, KsftFailEx
> +from lib.py import ksft_eq, ksft_not_in, ksft_raises, KsftSkipEx, KsftFa=
ilEx
>  from lib.py import EthtoolFamily, NetdevFamily, NlError
>  from lib.py import NetDrvEnv
>  from lib.py import bkg, cmd, defer, ip
> @@ -47,10 +47,11 @@ import struct
>                  if q['type'] =3D=3D 'tx':
>                      tx =3D True
>=20=20
> -                ksft_eq(q['xsk'], {})
> +                ksft_eq(q.get('xsk', None), {},
> +                        comment=3D"xsk attr on queue we configured")

Thanks. That's much better than getting exceptions in the case where no
xsk attribute is available:

Tested-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAme22lsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguehD/9VhExbOIEhI+JjK9xMk35kWdQqTi1r
KJxQ5gPBiU6KUbK7t5EhAjZngz8pVc2B/GVR+p5KgtSCF0LTe4TSP5b5COVkaMBZ
/nAKGze0GTRIm+8/vRZj6mSMwRHRITPbj5q5tL9nd1LEFx927AgZV46IOje4IeX2
QMusBsG0HQldkFlZaY7DmQU1VUZKa11wbHf0BhTScc1wSBeitSQx7nz101JUjUcs
pHCgdilgRwt4gcxZYsnHh3SyfJ/pkG1Q7+QDux7FEWUwLli62VGPnkJrk20stESM
DuNrdsmfmB+Y1PQEDJuYDxvPyicnLJ9SPBh8kXyteZqF2if/vGc0+4LUsJ9/UuH8
Nroy29BX/4mHZK9Cqmeu5vjR1aOoRwY4MK/ERK+mIuEPKVRXLpxbxCPurqStFqEl
sWoy769+wok2vO6C+3YvJ57dtjuAwpYY7ylwgziVDnHZ+SH/+XWm52K4LP4xWlCu
2BUxal2mtThthUedQuWbh27y0ZNAW4XuaFk20TBjJsRBuTMTmfMRNcP9Ttdedyif
lywHhqHJ+P42ev4MEmaRIWy7/a77dsMp2v1F1WhS3O6q3Cn3KZdTZvBJJi3Xxpb/
pSN+OZLtHyuDzJsKmmid8jYz3TD6ZQtY/G2fmhEMeAvdat2UKhKrNlgykGa3D51i
UXMmtioV5QVtVg==
=oM9K
-----END PGP SIGNATURE-----
--=-=-=--


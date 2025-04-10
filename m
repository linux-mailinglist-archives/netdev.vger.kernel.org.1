Return-Path: <netdev+bounces-181272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52CA843B1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDFC8A69E4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484D28153D;
	Thu, 10 Apr 2025 12:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BC78C9C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289417; cv=none; b=YGskiDTXdiXnifdfIJSD1voz2wXWR728T54XM2SHDBj5IqJluAPMe00TbsapYJo5BTNb5/413vO3irc+jISwJ3jV6UJxLcupeI8GMqCwKO2dkT3sY6twQsV0Hb9zT71rQe6Z49Y/M3p+9KPgqDAWJvOf87PZ1frQg8dNfQRP2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289417; c=relaxed/simple;
	bh=Sxu8te6S9LFhrZbW6Z6FMiUL2WeXiEzS7rrngp1m7PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3SpzMcftyDaoBBk/vMkGCrrUpHcR9PdAkNB2/Bn0q0Fx9DK637hZH2kcM00s/TlwyhZhWjk5nYtg4eUWygNbd4aaYUmts6oG2tT2wSbH76iWnzRzhdQ6FIr6A10Rj/5Fnl2j/5Aqa+vgZXAGSF7VWgo7eRjcJpkphdMGWKjO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from prime.localnet (p200300C597093Cd87726aB52A670a41a.dip0.t-ipconnect.de [IPv6:2003:c5:9709:3cd8:7726:ab52:a670:a41a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 5F756FA131;
	Thu, 10 Apr 2025 14:42:39 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Sven Eckelmann <sven@narfation.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net v3] batman-adv: Fix double-hold of meshif when getting enabled
Date: Thu, 10 Apr 2025 14:42:34 +0200
Message-ID: <1957790.GKX7oQKdZx@prime>
In-Reply-To:
 <CANn89iJgmwTfQBi7aaMY40_JnA47MjzCF2+Md89dgyE9Cgt9DA@mail.gmail.com>
References:
 <20250409073524.557189-1-sven@narfation.org>
 <d72376b8-a794-4c47-b981-11df6e17e417@redhat.com>
 <CANn89iJgmwTfQBi7aaMY40_JnA47MjzCF2+Md89dgyE9Cgt9DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2389592.bcXerOTE6V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2389592.bcXerOTE6V
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 10 Apr 2025 14:42:34 +0200
Message-ID: <1957790.GKX7oQKdZx@prime>
MIME-Version: 1.0

On Thursday, April 10, 2025 1:20:21 PM CEST Eric Dumazet wrote:
> On Thu, Apr 10, 2025 at 12:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > On 4/9/25 9:35 AM, Sven Eckelmann wrote:
> > > It was originally meant to replace the dev_hold with netdev_hold. But
> > > this
> > > was missed in this place and thus there was an imbalance when trying =
to
> > > remove the interfaces.
> > >=20
> > > Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
> > > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> >=20
> > You must wait at least 24h before reposting, see:
> >=20
> > https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/process=
/ma
> > intainer-netdev.rst#L15
> >=20
> > Also this is somewhat strange: the same patch come from 2 different
> > persons (sometimes with garbled SoBs), and we usually receive PR for
> > batman patches.
> >=20
> > @Svev, @Simon: could you please double check you are on the same page
> > and clarify the intent here?
>=20
> Also I do not see credits given to syzbot  team ?
>=20
> https://lkml.org/lkml/2025/4/8/1988

Sorry, there were some mistakes on our side. We'll take a deep breath and=20
repost this on another day, most likely as part of a usual pull request. So=
rry=20
for the noise.

Cheers,
       Simon
--nextPart2389592.bcXerOTE6V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmf3vLoACgkQoSvjmEKS
nqF+sQ/+I+jW0AD5GLxFY59vidp/iAU2XbPy1yIAqiezts5KdOBXDUSadaIM8s8G
sfnzEdG9h4Ew8az2cDIG44nZwIG9ICYj5taFZhksRrTE32CbFXHno8ANIz1ma6Qt
1KQDcaLDwdYIii8Zr4HIDogCHBG9okk3yyoOxK+BveCkbQlW9W0JGsdEh5uGdSRP
lt5KBhQPypOjlkgztBRr9QcUMe/hxOdGd5o2JzL07F69dDQy95aTMLsxQ3Ygzn0O
MgO77k/PJtVf2f4dRgp+6/7DDstBO2dkExh2+m93bEuOk7zvr3aiokbWx2WxiLyI
f2Le9zwara5jLRZ+shBJMXmUmC8J5LWs4mzcN3pgYSL6bBbT7/A+dlbg2miOW51E
9khHgcNCLYLjNXvtEtsSJ0AQ1J3A8fTLI5ROhGD9x3S+EfjGeU5AVm3A+CeJVCCr
OLpYvEv24JpFUTtTWDl+kX+IpZqGEDq2Lh2jCsQduutaWxRgSx0z5Rg9VQ9929ZP
/k7S4XrbqHPcr/xphq3FYQS0kSG8tE53xYpytjaRHJ2LjaIF0V3GG6sVNAP0Dkef
1y4psxhiz2rJL9E+blstAVf4CSIM34udBT1l7FjmUu4vr2UP1oKTwJxxotvMfmn5
/8xFvQ8mdg/z/Zhon0+vWpAxtnJe+B9pu7uBDL3SgNN/A3pa2+g=
=zsNs
-----END PGP SIGNATURE-----

--nextPart2389592.bcXerOTE6V--





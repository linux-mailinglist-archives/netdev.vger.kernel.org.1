Return-Path: <netdev+bounces-106213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A99154F5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D011B20EED
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6F919E83E;
	Mon, 24 Jun 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC3OXm3w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E719E819;
	Mon, 24 Jun 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248577; cv=none; b=iWjptrdSws8gsx7tbVYDlrt1iky/9ngsFBHVp4nXvYF2QBciyq1V1qG7ipI0jM5+uhAKPm0dRGd83z13wAP3REkz/QsguvyDPXQ7GdORykAzu6nNOfClqwu2tE9LJYsFeA3MeKRhcINUxgfUoji3nWAGpFY/HQ4Zpfd5KMZhsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248577; c=relaxed/simple;
	bh=Mdg5As9UY0BgHfcSp2GV2BTdUCd+Qg/tyf8Tn9vybVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lN3pFDE4zdNCb2GlimYqbUUFbOE56YYFxfEoMNe+yrU2HLD/LMWPIlD1saIaHX4GBnNXorOamtiNzUtJaY/hgBE4K6nru6Z8Kyn/qCaf46GGE0DlUR2mmKvDg+Pfu4K1Foa4SwvdsUf4w5jFM8oQLLH/OD+cgdB4XhFcKqtSw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC3OXm3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A46C32782;
	Mon, 24 Jun 2024 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719248577;
	bh=Mdg5As9UY0BgHfcSp2GV2BTdUCd+Qg/tyf8Tn9vybVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sC3OXm3wYz56odM3igvJXPm0RgohOk6iJa/QUerFrtOfbe3U+/Z1K8JQUlO369i8s
	 f6XUi+ZutZc6R8r51oiWHl3j0BOvBuic1NEq/fu3WppwxJV0mOHpMHBcf5OUBnH50P
	 D8EbGUW0XR0Po5roPSGyipnwM7h+Na3wCglsvzxsfdtK8ZAHegMB0uMddjXNptXjzt
	 gld/veNdmRyRRhSJMuRiHTE1DPONGFACNTZdnK2YRtpMrMOndbp9j8jSww0qN+wULD
	 kx0eqet4mI8FF61bzB82vFy///JqXTeUmDjf8C8QBvUyMAN4UtZgBCH3oT0fYSKBVQ
	 RlOnk4HZ5EQBw==
Date: Mon, 24 Jun 2024 18:02:51 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] dt-bindings: net: dsa: mediatek,mt7530: Minor grammar
 fixes
Message-ID: <20240624-supernova-obedient-3a2ba2a42188@spud>
References: <20240624025812.1729229-1-chris.packham@alliedtelesis.co.nz>
 <704f4b95-2aed-4b76-87cb-83002698471c@arinc9.com>
 <20240624-radiance-untracked-29369921c468@spud>
 <68961d4f-10d8-4769-94d3-92ce709aa00a@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yTXZVHo95QP3ORO0"
Content-Disposition: inline
In-Reply-To: <68961d4f-10d8-4769-94d3-92ce709aa00a@arinc9.com>


--yTXZVHo95QP3ORO0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 07:59:48PM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> On 24/06/2024 19.29, Conor Dooley wrote:
> > On Mon, Jun 24, 2024 at 10:00:25AM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wro=
te:
> > > On 24/06/2024 05.58, Chris Packham wrote:

> > > >      and the switch registers are directly mapped into SoC's memory=
 map rather than
> > > >      using MDIO. The DSA driver currently doesn't support MT7620 va=
riants.
> > > >      There is only the standalone version of MT7531.
> > > > -  Port 5 on MT7530 has got various ways of configuration:
> > > > +  Port 5 on MT7530 supports various configurations:
> > >=20
> > > This is a rewrite, not a grammar fix.
> >=20
> > In both cases "has got" is clumsy wording,
>=20
> We don't use "have/has" on the other side of the Atlantic often.

Uh, which side do you think I am from?

--yTXZVHo95QP3ORO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmmuwAKCRB4tDGHoIJi
0h9sAP41oI15yoaVudwy0Xy3OyKWadApaBz7EVKFYuiYTgA39wD+P9tSKDtm7Xq2
7tvsk70QFoUvjxOQOka8SD7x5ENzAwc=
=EIsV
-----END PGP SIGNATURE-----

--yTXZVHo95QP3ORO0--


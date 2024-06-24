Return-Path: <netdev+bounces-106214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DEC9154FE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78EBB24E01
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C4019E83E;
	Mon, 24 Jun 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzZD5H5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B413E024;
	Mon, 24 Jun 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248733; cv=none; b=HwDRu37VEwnSCEenU2PVatO2rilVmB+gxNgyMW7T+5gCWBUKhdj8b0obePtHoS9cHyymkWKs50wbtG+uYUBB/MSltlv5TbwgQUGFKvlVEBS7RJLxXoFWSjIY6oXpAKuQvP+Krycl0+UTzkkMHGgUnyx+XuABRtNRLAbIFQsmGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248733; c=relaxed/simple;
	bh=hluDMmNHYy/31BF0jtrB4YwFGOBufdjYalZYHdQHg6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD1WzVOrSNwSIb7XTtUaEok2U4HqQbBGu3TjEXbeKD+YyLC62258RUgLLSlXhLhfKRyBOFcnodKmMxofYhwfcZOze8vho5RWHAam2g7AI1L9C4oaMk87Et1l+7Q2CezGx+oe6XQ4xHqHj6UnN88mIyRR4XI5bvNTrnMNUk/MhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzZD5H5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245ACC2BBFC;
	Mon, 24 Jun 2024 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719248733;
	bh=hluDMmNHYy/31BF0jtrB4YwFGOBufdjYalZYHdQHg6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzZD5H5bE9b1+6J4DTJZ2nVQNgmvcELEIZ9S36BDXLNgWP9nmp61OvsfgK4qwLNv/
	 aRXeYfl9TVdrrtRBfVqHYdki2HFXD9OVRux+m10O7yAYQSTQe2nacQokh9mfYaf34E
	 tBu4lfUllOlYBcIPCAkRjpRQkSsAgFrym+RCsIXsTgYoF/TWSNUCm/fLl3YZ/N5+K6
	 Ssdd0k1ypEJ1P2tL/Qe/QwXJFxqZhNr4aOScZZl0M/7V71vMepusL4i3yqFU1UVDLa
	 sAR1Gd5n8tNvsUqWXnKikr8Pp3Rh/zyMh8LhXSGzC+u/Hw6NDy5awjO/1qCebjv+x8
	 qO8c9hfWm4WGA==
Date: Mon, 24 Jun 2024 18:05:27 +0100
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
Message-ID: <20240624-erratic-monoxide-c32da937048d@spud>
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
	protocol="application/pgp-signature"; boundary="v0BnrTxic9uZfq14"
Content-Disposition: inline
In-Reply-To: <68961d4f-10d8-4769-94d3-92ce709aa00a@arinc9.com>


--v0BnrTxic9uZfq14
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 07:59:48PM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> On 24/06/2024 19.29, Conor Dooley wrote:
> > On Mon, Jun 24, 2024 at 10:00:25AM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wro=
te:
> > > On 24/06/2024 05.58, Chris Packham wrote:
> > > > Update the mt7530 binding with some minor updates that make the doc=
ument
> > > > easier to read.
> > > >=20
> > > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > > ---
> > > >=20
> > > > Notes:
> > > >       I was referring to this dt binding and found a couple of plac=
es where
> > > >       the wording could be improved. I'm not exactly a techical wri=
ter but
> > > >       hopefully I've made things a bit better.
> > > >=20
> > > >    .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml        | 6 =
+++---
> > > >    1 file changed, 3 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7=
530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > > > index 1c2444121e60..6c0abb020631 100644
> > > > --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > > > @@ -22,16 +22,16 @@ description: |
> > > >      The MT7988 SoC comes with a built-in switch similar to MT7531 =
as well as four
> > > >      Gigabit Ethernet PHYs. The switch registers are directly mappe=
d into the SoC's
> > > > -  memory map rather than using MDIO. The switch got an internally =
connected 10G
> > > > +  memory map rather than using MDIO. The switch has an internally =
connected 10G
> > > >      CPU port and 4 user ports connected to the built-in Gigabit Et=
hernet PHYs.
> > > > -  MT7530 in MT7620AN, MT7620DA, MT7620DAN and MT7620NN SoCs has go=
t 10/100 PHYs
> > > > +  MT7530 in MT7620AN, MT7620DA, MT7620DAN and MT7620NN SoCs have 1=
0/100 PHYs
> > >=20
> > > MT7530 is singular, the sentence is correct as it is.
> >=20
> > Actually, the sentence is missing a definite article, so is not correct
> > as-is.
>=20
> The definite article is omitted for the sake of brevity. I don't believe
> omitting the definite article renders the sentence incorrect.

I figured if we were gonna nitpick wording, we should nitpick it
properly :)

--v0BnrTxic9uZfq14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmnVgAKCRB4tDGHoIJi
0taJAP9HVBBJpTuZ+D8xH36TsRm8Pn+cA8UNRO8+Z0hdJuy+hwD/VFYEu91AsBId
VyK+YAk3vdfcKAyrqwo2gXLJb7SrywQ=
=oTWe
-----END PGP SIGNATURE-----

--v0BnrTxic9uZfq14--


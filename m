Return-Path: <netdev+bounces-106210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F00C9153D6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0AD287B33
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6F19DF63;
	Mon, 24 Jun 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKfKKjQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5717BCC;
	Mon, 24 Jun 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246592; cv=none; b=elPqLYzFYQDFp4RNugits4wtnP1awn4jmGQrB7T8+4qI4/p3Rcuo0UBvW8ALHpHwKW8MR2S6KRF7UQk7JxHU9N3xM8C04o12sYlKlIl8XF6OcPX/qTmNbpjN797TF77hEynVUhDE0Hx/bNSaSKJWB7q2+C++XVzhRSTgC/FmR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246592; c=relaxed/simple;
	bh=X/rMjN+CKsJhOirRD2eijjnLJTdEH19Dqw1djQrGiEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHq4jzzxaxSro6i9nccsEwiHilqe8vq7uTckMdzaNpFZY04eASH1Yib/zoR+1JOnLR1h1ar6nXDLT+7CcJZTZi0b+0vLis/cUybmklzYZJ5WsRl6peXbq3F6p3Z9xXIWpu8ATnVc9/dDfyxYXzuMubo43NzgS0OjgDhDL1LnnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKfKKjQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBFAC2BBFC;
	Mon, 24 Jun 2024 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246591;
	bh=X/rMjN+CKsJhOirRD2eijjnLJTdEH19Dqw1djQrGiEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKfKKjQKErKRle4L4qZor2AIEwUXmTDEr/XT+Nt3HoFf/jajYbs+kP7onhqYWhHfX
	 T2BpJca6IBS5fdXH3eykDKUk4gMaVcnQs3RJGyyg+1gan81rxIfK5hFzTCHBNaf20x
	 448cE14YBNpeUpTx2Usxh/lvTFIMpSs185vMVDeH5TtpVi79pYKVjV4S+Sw9galRNg
	 OXflTR15kaxYhc99jCC9aw0wXkbpllKn9u7JyFm14UZ/nIg+jRKsFoZ5YoGTohHsbT
	 5oDFrkB8OIj3Rn5NdogLI5Tr171ZT40Ux60xjuKeVr0ruojfF2F0XRZVH+/i5qkiaH
	 hAonwZL7bW9sQ==
Date: Mon, 24 Jun 2024 17:29:45 +0100
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
Message-ID: <20240624-radiance-untracked-29369921c468@spud>
References: <20240624025812.1729229-1-chris.packham@alliedtelesis.co.nz>
 <704f4b95-2aed-4b76-87cb-83002698471c@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5G+CYpX+s72EcPeQ"
Content-Disposition: inline
In-Reply-To: <704f4b95-2aed-4b76-87cb-83002698471c@arinc9.com>


--5G+CYpX+s72EcPeQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:00:25AM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> On 24/06/2024 05.58, Chris Packham wrote:
> > Update the mt7530 binding with some minor updates that make the document
> > easier to read.
> >=20
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >=20
> > Notes:
> >      I was referring to this dt binding and found a couple of places wh=
ere
> >      the wording could be improved. I'm not exactly a techical writer b=
ut
> >      hopefully I've made things a bit better.
> >=20
> >   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml        | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.=
yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > index 1c2444121e60..6c0abb020631 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > @@ -22,16 +22,16 @@ description: |
> >     The MT7988 SoC comes with a built-in switch similar to MT7531 as we=
ll as four
> >     Gigabit Ethernet PHYs. The switch registers are directly mapped int=
o the SoC's
> > -  memory map rather than using MDIO. The switch got an internally conn=
ected 10G
> > +  memory map rather than using MDIO. The switch has an internally conn=
ected 10G
> >     CPU port and 4 user ports connected to the built-in Gigabit Etherne=
t PHYs.
> > -  MT7530 in MT7620AN, MT7620DA, MT7620DAN and MT7620NN SoCs has got 10=
/100 PHYs
> > +  MT7530 in MT7620AN, MT7620DA, MT7620DAN and MT7620NN SoCs have 10/10=
0 PHYs
>=20
> MT7530 is singular, the sentence is correct as it is.

Actually, the sentence is missing a definite article, so is not correct
as-is.

>=20
> >     and the switch registers are directly mapped into SoC's memory map =
rather than
> >     using MDIO. The DSA driver currently doesn't support MT7620 variant=
s.
> >     There is only the standalone version of MT7531.
> > -  Port 5 on MT7530 has got various ways of configuration:
> > +  Port 5 on MT7530 supports various configurations:
>=20
> This is a rewrite, not a grammar fix.

In both cases "has got" is clumsy wording, "supports" is an improvement
to readability, even if it might not qualify as a grammar fix.

--5G+CYpX+s72EcPeQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnme+QAKCRB4tDGHoIJi
0jayAP9QYPuQa14ospqghSRwh8Za6YGTODSI60an4wYfh+2zYAD/ccgLUsq74wfN
kltsgO7yuo3NMEZPJMLGAg5ZqlyWlQc=
=6noq
-----END PGP SIGNATURE-----

--5G+CYpX+s72EcPeQ--


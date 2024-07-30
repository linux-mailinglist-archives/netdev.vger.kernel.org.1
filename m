Return-Path: <netdev+bounces-114137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8E941217
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B91283629
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9BE1A01BF;
	Tue, 30 Jul 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHQw2keq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103E19EEA1;
	Tue, 30 Jul 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343352; cv=none; b=r0zUvka7KP55qiCw3yqFQ3ahv45o2IaQFpznUWO8NAsgJiebjWd1up6Cg84rZROhsuF0JRCWGF8dmg3a/uvtGYstPUYX0j4aeD9yXmh01MzPKnDsFEQ8kxMwRfQtbeNr49rrOAtRcJqskS8ethVcekrS84qs+w6DggbjRZ8bUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343352; c=relaxed/simple;
	bh=bYnUpP7Mmu+3DjXN8Jp/cEq686gvZ7Y4PhqtstpNYYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBjOiRJu4tA4+89s5Efu/nZkWQuYz4sMf76tyXC3nmWy/cqgEmiW+v0pfwt1algAFnrwPDg8oPY4aSougy5yryLDYyuaiuvGFpt0S4v4T1K/NcGo3HOGk1ZJxcMwGraJUbD91lF2EJX1dGSlEiL6M5a3qthgAeu80PkPbq9GwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHQw2keq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5372CC32782;
	Tue, 30 Jul 2024 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343351;
	bh=bYnUpP7Mmu+3DjXN8Jp/cEq686gvZ7Y4PhqtstpNYYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHQw2keqogAbOhnbmPpqTqC3S6Uuj+59BEz1Cw6n6nEZd0uhhcl964PrjxPbj3Iia
	 vYuYUmvIbKbV/6u4yOe538iK9x6oaln80arKlUP2StxknSvZC91qlboQs1X9SFJdEf
	 6kBN0hHIjZzjkhMrRUD5pJnaZew/pBYCuE5NgjC3iivc4sKiS84A6uxEcAvc8TVxM2
	 b3crpyA/5E6KcjD9UXkJJSvLxPMrvy27NBU6fD7A8vrChiMAxIxG8QQl1zlyOn1xft
	 ydLW6FXls1JjAONqwikdnchXgfqhOfctK33mqEuKCh/LEno3WgYGxhwGr0BJ7yp5re
	 mFZYWjD60B9NA==
Date: Tue, 30 Jul 2024 14:42:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
	sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: mediatek,mt7530: Add
 airoha,en7581-switch
Message-ID: <ZqjftJJZpSa4_atg@lore-desk>
References: <cover.1722325265.git.lorenzo@kernel.org>
 <63f5d56a0d8c81d70f720c9ad2ca3861c7ce85e8.1722325265.git.lorenzo@kernel.org>
 <3d0e39a3-02e9-42b4-ad49-7c1778bfa874@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmJ3g8aJy3cwZr9o"
Content-Disposition: inline
In-Reply-To: <3d0e39a3-02e9-42b4-ad49-7c1778bfa874@arinc9.com>


--rmJ3g8aJy3cwZr9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 30/07/2024 10:46, Lorenzo Bianconi wrote:
> > Add documentation for the built-in switch which can be found in the
> > Airoha EN7581 SoC.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml     | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.=
yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > index 7e405ad96eb2..aa89bc89eb45 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > @@ -92,6 +92,10 @@ properties:
> >             Built-in switch of the MT7988 SoC
> >           const: mediatek,mt7988-switch
> > +      - description:
> > +          Built-in switch of the Airoha EN7581 SoC
> > +        const: airoha,en7581-switch
> > +
> >     reg:
> >       maxItems: 1
> > @@ -284,7 +288,10 @@ allOf:
> >     - if:
> >         properties:
> >           compatible:
> > -          const: mediatek,mt7988-switch
> > +          contains:
> > +            enum:
> > +              - mediatek,mt7988-switch
> > +              - airoha,en7581-switch
>=20
> The compatible string won't be more than one item. So this would be a
> better description:
>=20
> compatible:
>   oneOf:
>     - const: mediatek,mt7988-switch
>     - const: airoha,en7581-switch
>=20
> Ar=C4=B1n=C3=A7

ack, I will fix it in v2.

Regards,
Lorenzo

--rmJ3g8aJy3cwZr9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZqjftAAKCRA6cBh0uS2t
rH5cAP93Dtt6PHl6bZl3bXLMM7y0eddjamO6oouR/zhyZJeRzwD5AfitMaRnL09b
PkLA9hXs4iAvS/UrWXjPkrQKBLxH1wY=
=b1Gg
-----END PGP SIGNATURE-----

--rmJ3g8aJy3cwZr9o--


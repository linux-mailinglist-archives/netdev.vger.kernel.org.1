Return-Path: <netdev+bounces-207439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E0B07410
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E876505935
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49BD2F3645;
	Wed, 16 Jul 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaXmIeDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04B2F3640;
	Wed, 16 Jul 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663308; cv=none; b=NbxAIbobobNF/nCK5+GHfnzuBbubVMbmMpXZIV4F/3nqVjxUGHpkBS9kNkkeIU/Y3fgOFuN7AUDUkdZZqC5ElAbatrdH1aI5iIioxdGH5ezWCOhgx3qy6fM5CSPjN/XtEbMxwtBCNoGNCYxJydejJasQFhESUUkRmRfRmtUf/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663308; c=relaxed/simple;
	bh=s/qODGloHS8A6X+Kd2P5c0fXlx0swt4d3mPhst1www8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOU3GTX7+m6OTDMurRuwDfXoOYDeutDm/jmCzjS+ocCdLHhnVr2sadd+3jGZ5HyamYT9diHjyfR4FHDlgZ+fSzBpNFoOC8YD1M++mGZEOzWc0MUiXdKjafSeblrZ6rYdywfsGMNqOKT7ze1Txxkl5DV3xsZx7pgxvYFTdKIw66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaXmIeDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F36C4CEF7;
	Wed, 16 Jul 2025 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752663308;
	bh=s/qODGloHS8A6X+Kd2P5c0fXlx0swt4d3mPhst1www8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AaXmIeDzxUjpLD8/kVuv5Q1vETO0s8srl0M9EM7uqSBrWlApGEhJfzRcbLg6dOJwc
	 98V+b2Z1PuIGvxxsXXVD0zRWhiBMQFP6kvJeMEaoBGBnWihHDU6j1hSAyHPRBTAK7N
	 a3GZ70moRvWKjvOhLPD1QTxrKyEOGAGiUYetPArroJrH1f6m9scc9YjT/yebas3Gyn
	 sTfA/IU/xK7Ei0ABIImay2LjcKYvFfzkX1Th8Br8XFoAvjXBGWq7Ei1XUsPKWtMqsv
	 3JpFXSMGYJqjCNjY0ay5541eMU2BkoKYcda3dV9BZYU+KrJxh/bx8aJXFXqBjkyoKl
	 lYtZR/m0gU6Og==
Date: Wed, 16 Jul 2025 12:55:05 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <aHeFCZ3Z9E15pSeL@lore-desk>
References: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
 <20250714-airoha-en7581-wlan-offlaod-v3-1-80abf6aae9e4@kernel.org>
 <20250715035419.GA11704-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ejVKjvWudJw3Rkcf"
Content-Disposition: inline
In-Reply-To: <20250715035419.GA11704-robh@kernel.org>


--ejVKjvWudJw3Rkcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 14, Rob Herring wrote:
> On Mon, Jul 14, 2025 at 05:25:14PM +0200, Lorenzo Bianconi wrote:
> > Document memory regions used by Airoha EN7581 NPU for wlan traffic
> > offloading.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/net/airoha,en7581-npu.yaml    | 19 +++++++++++=
++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > index 76dd97c3fb4004674dc30a54c039c1cc19afedb3..f99d60f75bb03931a1c4f35=
066c72c709e337fd2 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > @@ -41,9 +41,18 @@ properties:
> >        - description: wlan irq line5
> > =20
> >    memory-region:
> > -    maxItems: 1
> > -    description:
> > -      Memory used to store NPU firmware binary.
> > +    items:
> > +      - description: NPU firmware binary region
> > +      - description: NPU wlan offload RX buffers region
> > +      - description: NPU wlan offload TX buffers region
> > +      - description: NPU wlan offload TX packet identifiers region
>=20
> 1 entry was valid before, but not anymore? If so, justify it in the=20
> commit message.

ack, I will do it in v4.

Regrads,
Lorenzo

>=20
> > +
> > +  memory-region-names:
> > +    items:
> > +      - const: firmware
> > +      - const: pkt
> > +      - const: tx-pkt
> > +      - const: tx-bufid
> > =20
> >  required:
> >    - compatible
> > @@ -79,6 +88,8 @@ examples:
> >                       <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> > -        memory-region =3D <&npu_binary>;
> > +        memory-region =3D <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
> > +                        <&npu_txbufid>;
> > +        memory-region-names =3D "firmware", "pkt", "tx-pkt", "tx-bufid=
";
> >        };
> >      };
> >=20
> > --=20
> > 2.50.1
> >=20

--ejVKjvWudJw3Rkcf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaHeFCQAKCRA6cBh0uS2t
rAnDAQDc4K8cm9ezsu4s25+kmtqhZht/BBBftBY73/9r+XfLhgEAz5X7/1w62Db+
3oZ18L1Bo0L+qo8227Ivg56sgkDPXQ0=
=YHee
-----END PGP SIGNATURE-----

--ejVKjvWudJw3Rkcf--


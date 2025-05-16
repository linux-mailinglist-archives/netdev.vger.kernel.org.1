Return-Path: <netdev+bounces-190942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE96AB95F9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80EA164327
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DE2223DC7;
	Fri, 16 May 2025 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEQyfGs9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1BA2222A0;
	Fri, 16 May 2025 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376941; cv=none; b=mPF/vBoNJ2686uGfawz8tn6k6RDN3sQGdkPduwXKM+DL2B+64P+KhHjahoqLk+EK9Us8YM2ZCSjeO1+ZtckuiCmmwKTIfTSj+HWBPnL2AhnO/yOKTc2cdOY2GYLYBcc1XBVf7iWnRpm4PPouZFlJ/EHRtsmhSSghPoYEiZN9gvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376941; c=relaxed/simple;
	bh=+pKFCaJzpi3RXKEOsIsDQB809uH9lChwZMdgj0ruLfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmVde5q8yRJBusl015O0nD0oFdzowCyKdDMU+otrTZOV/lHGF7SifO+rDcLkQ9SZqW82lvC1ZvsMV2jyh9ltofslhz5j8EiZ1e/lAfPaOqwe/Tx32zNhta7oyJ/3yoyodNufgrpmSUSbR5kCyZdXPS9FdO2Y+H2n7yO3mQ/N3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEQyfGs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C86C4CEE4;
	Fri, 16 May 2025 06:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747376940;
	bh=+pKFCaJzpi3RXKEOsIsDQB809uH9lChwZMdgj0ruLfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEQyfGs9yj3sOyJCGe3v3OeFiaTgXo7fiD2eMDAmxT6SxUWT9TLRlI6XB+seY0n3B
	 nW/+XVkR3XFCcobCBC9o12uJDnsR3uXUhQO9uIPcSAg2g5Wqul+kXDvKU8z6RRH6CK
	 0LQ/mw1xKscs8kF7pdUqHmh8r9wvxVtCFb2F7pOeP7DqsN/OZ1MR67MTok3/mgWPvy
	 uh1JJ9WEAvPXX5Kj0YNbCENBZ37uckpxlR7/LS65Za8kqjWzjlveEoJogA959iim+W
	 wEOebNE2C00cAgzasgDbnhz+EsgHv0EVk5a599z67eEtCd5y3dDGBu+HbayB41C9QW
	 zIM6HNdW1eHug==
Date: Fri, 16 May 2025 08:28:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: Add EN7581
 memory-region property
Message-ID: <aCbbKfpsKoDK8cuW@lore-desk>
References: <20250509-airopha-desc-sram-v2-0-9dc3d8076dfb@kernel.org>
 <20250509-airopha-desc-sram-v2-1-9dc3d8076dfb@kernel.org>
 <20250514200816.GA2934563-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aID1bXHpUUZXCMrP"
Content-Disposition: inline
In-Reply-To: <20250514200816.GA2934563-robh@kernel.org>


--aID1bXHpUUZXCMrP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, May 09, 2025 at 04:51:33PM +0200, Lorenzo Bianconi wrote:
> > Introduce the memory-region and memory-region-names properties for the
> > ethernet node available on EN7581 SoC. In order to improve performances,
> > EN7581 SoC supports allocating buffers for hw forwarding queues in SRAM
> > instead of DRAM if available on the system.
>=20
> But 'reserved-memory' is generally for system memory which is DRAM=20
> though we unfortunately don't enforce that. For small onchip SRAM, you=20
> should be using the mmio-sram binding and the 'sram' property.

ack, thx for pointing this out, I will look into it.

Regards,
Lorenzo

>=20
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/net/airoha,en7581-eth.yaml          | 13 +++++=
++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > index 0fdd1126541774acacc783d98e4c089b2d2b85e2..6d22131ac2f9e28390b9e78=
5ce33e8d983eafd0f 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > @@ -57,6 +57,16 @@ properties:
> >        - const: hsi-mac
> >        - const: xfp-mac
> > =20
> > +  memory-region:
> > +    items:
> > +      - description: QDMA0 buffer memory
> > +      - description: QDMA1 buffer memory
> > +
> > +  memory-region-names:
> > +    items:
> > +      - const: qdma0-buf
> > +      - const: qdma1-buf
> > +
> >    "#address-cells":
> >      const: 1
> > =20
> > @@ -140,6 +150,9 @@ examples:
> >                       <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > =20
> > +        memory-region =3D <&qdma0_buf>, <&qdma1_buf>;
> > +        memory-region-names =3D "qdma0-buf", "qdma1-buf";
> > +
> >          airoha,npu =3D <&npu>;
> > =20
> >          #address-cells =3D <1>;
> >=20
> > --=20
> > 2.49.0
> >=20

--aID1bXHpUUZXCMrP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCbbKQAKCRA6cBh0uS2t
rN6TAP9Z+nC7Q2ksXcMUfrSAkCjOIrRj47Vf5ANb+75cp7DY1gEAiYs5yFLjSGez
2D3qidhzzh0w41nH19Ti61rMTknwIQM=
=5mPp
-----END PGP SIGNATURE-----

--aID1bXHpUUZXCMrP--


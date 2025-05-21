Return-Path: <netdev+bounces-192185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E7ABECC7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B143BE30B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEEB22FAD3;
	Wed, 21 May 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riByxiuN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673F21CA04;
	Wed, 21 May 2025 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811272; cv=none; b=QIt3ufmz35vNQGNWwdEpW42FUDsOsZE+cZ3g4LXYQ4/Ub3/VZmulEDPW8czWAig1PtsPKsN5E4rEHHppR5XbsOcJOLh++kV40XwVGolZ3IorDZhkG8i1vQz3AjHUWg0P1tvOx5srkpMI8Vsnnr9vKQQp9IiwZWiVvfvS0Cigqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811272; c=relaxed/simple;
	bh=96Md/VEB9O7eASfK338AzVXaq8Pdtv6dMy+GnK3LdD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1gtB71HdoyXmMV3KNQ+L/rJz5HOvDmkfaLYnUKH7pIw+y89lEdxei+pk0t69cI0UnBdb/y0US2U1lWfOmPuTD+brEKozpTDiG7jO5D+nzvFlgYOqFmQqFT7UWNy0riwNJQtdAydic1+7H9/NULQxOhO5aHWaSq3VcueAEOQ7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riByxiuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85ABC4CEE4;
	Wed, 21 May 2025 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747811272;
	bh=96Md/VEB9O7eASfK338AzVXaq8Pdtv6dMy+GnK3LdD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riByxiuNfv/MNrR4LU1FCcXQFSsPBgNZ7hKDVpykbrHvPiAgxgsjX+6iOgDEcNAzT
	 GT/YCJeec/oKBkNY6TZdQJHUXS6cxsNa9G+zeKJoegioii5KY56Q5k9k9MssgXX0jl
	 FGwk6o+NWcO/Au5VzLoVOg6jL5kk782k3gocXOCGcbYdHmqWrKzFliUQeL7QRmbKqA
	 Xq259qQQy3IxX10P0UiAMQLEhB7ZUcH++38ruHqKSaKyFgLRgt/A+rK6aO8uVnnv9o
	 NShUOmNENCedEECbslDDTp31ST0W2tX8sjfOCjRxjEdZYiWWZcvov+GbTDaO1rhMHz
	 8L8N7j/JPvp5w==
Date: Wed, 21 May 2025 09:07:49 +0200
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
Message-ID: <aC17xaFuF7-1Sf0F@lore-desk>
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
	protocol="application/pgp-signature"; boundary="tSXozertU+zsFhIv"
Content-Disposition: inline
In-Reply-To: <20250514200816.GA2934563-robh@kernel.org>


--tSXozertU+zsFhIv
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

Reviewing the vendor sdk my understanding was wrong (sorry for the noise).
Here we just want to add the capability to allocate hw forwarding buffers q=
ueue
defining the memory region in the DTS instead of using dmam_alloc_coherent()
since in some configurations QDMA blocks require a contiguous block of
system memory for hwfd buffers queue.
Moreover, EN7581 SoC supports consuming SRAM instead of DRAM for hw forward=
ing
descriptors queue. This is managed in hw, we just need to request it in the
flowtable entry configuration.
I will fix it in v2.

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

--tSXozertU+zsFhIv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaC17xQAKCRA6cBh0uS2t
rFV3AQCwSAkPgSXG/RyB/TBSGzLQUzuQ1DO+anR9XFemzgJlGwEApgIOqZxT4P/6
k6/EaUKbliUTPhf1joJ1o/xHxlCu9Q0=
=j8mL
-----END PGP SIGNATURE-----

--tSXozertU+zsFhIv--


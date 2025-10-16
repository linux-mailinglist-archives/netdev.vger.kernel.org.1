Return-Path: <netdev+bounces-230160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E4BE4C91
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FD754EF6C3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD933468B;
	Thu, 16 Oct 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StUZULop"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D60334684;
	Thu, 16 Oct 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634368; cv=none; b=eAZqslSws5cQffG+acNyfdwpA1VrxCVZFDBR+QCVA0wI/tk4MMrDz1EIngGLYLg+1uyCPNiWjK/nuyAdqZdoCblqwtnffRIATLOkjhMtRvIMjNQVv9BpIoAvmpJr3nmUkAl2jxmBpDnLJVZinYWQOqzBWHN0wENUvcZhrk1b4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634368; c=relaxed/simple;
	bh=eskJgEswuM2KIOvIt6RczPdi3+e/Gu7TEutaJgkQaNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du5eMpzYNWDf+oi2E4H44+t+ALmCeGzRCGYJPvbIRCGi8xiLgpiFEwG688QyXOjU/yHpfRV8KeFmQBV0viuepM1PSFoxpVu7MsKuGcV79WzJRNmrnzdZ3ct3PqO4j58AEu+6+nv1hqI1rgLnm4qmJ9WtDnMVLiyQUSWvTIt33cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StUZULop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44AFC4CEF1;
	Thu, 16 Oct 2025 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760634367;
	bh=eskJgEswuM2KIOvIt6RczPdi3+e/Gu7TEutaJgkQaNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StUZULop3yfuwZFzcgU07+8rl7AoDfRwDxWR3fVzNsMYuJICsLtbGlFjtpIiEOOok
	 30mfl50ly7MNR/gJg/ejoZob8b2r5MH7ITg7BKQQs+CEKcJ6ogATPsK0mQPRK03yZW
	 vsuUhrCV/HAEDcZiZhQL82KEas1KB4yPtifk7O7bhgi7OKc2ipDr/w8jw/D5ySOlDg
	 eblw3vtIX5gF4pTjTdZZ2/PNXcsXhHMaZxY+8btMw4AO3tE2JTIFHiNbdFZOT6mQEn
	 bhwweXE/4/mvIV6UZ2QEfol6YddUhfs44cydLebviPgifWzeQMuPNd9dRdEuRlL5iO
	 W+qgskq36+qZg==
Date: Thu, 16 Oct 2025 18:06:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	g@spud.smtp.subspace.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 01/13] dt-bindings: net: airoha: Add AN7583
 support
Message-ID: <20251016-hypnoses-caucasian-5d08812740a6@spud>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
 <20251016-an7583-eth-support-v2-1-ea6e7e9acbdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9mL+XRXQMatgZUrQ"
Content-Disposition: inline
In-Reply-To: <20251016-an7583-eth-support-v2-1-ea6e7e9acbdb@kernel.org>


--9mL+XRXQMatgZUrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:28:15PM +0200, Lorenzo Bianconi wrote:
> Introduce AN7583 ethernet controller support to Airoha EN7581
> device-tree bindings. The main difference between EN7581 and AN7583 is
> the number of reset lines required by the controller (AN7583 does not
> require hsi-mac).
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-eth.yaml | 60 ++++++++++++++++=
++----
>  1 file changed, 51 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml=
 b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> index 6d22131ac2f9e28390b9e785ce33e8d983eafd0f..7b258949a76d5c603a8e66e18=
1895c4a4ae95db8 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - airoha,en7581-eth
> +      - airoha,an7583-eth
> =20
>    reg:
>      items:
> @@ -44,18 +45,12 @@ properties:
>        - description: PDMA irq
> =20
>    resets:
> +    minItems: 7
>      maxItems: 8
> =20
>    reset-names:
> -    items:
> -      - const: fe
> -      - const: pdma
> -      - const: qdma
> -      - const: xsi-mac
> -      - const: hsi0-mac
> -      - const: hsi1-mac
> -      - const: hsi-mac
> -      - const: xfp-mac

Pretty sure most of this diff can just be avoided by changing this list
to be
  reset-names:
    items:
      - const: fe
      - const: pdma
      - const: qdma
      - const: xsi-mac
      - const: hsi0-mac
      - const: hsi1-mac
      - enum: [ hsi-mac, xfp-mac ]
      - const: xfp-mac
    minItems: 7

All of these -names properties IIRC are arrays of unique strings, so doing
8 with xfp-mac twice would not pass. Your conditional portion of the
binding then need only set min to 8 for the old device and max to 7 for
the new one.

> =20
>    memory-region:
>      items:
> @@ -81,6 +76,53 @@ properties:
>        interface to implement hardware flow offloading programming Packet
>        Processor Engine (PPE) flow table.
> =20
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - airoha,en7581-eth
> +    then:
> +      properties:
> +        resets:
> +          minItems: 8
> +          maxItems: 8

Same here fwiw, just need to set the min for this, and...

> +
> +        reset-names:
> +          items:
> +            - const: fe
> +            - const: pdma
> +            - const: qdma
> +            - const: xsi-mac
> +            - const: hsi0-mac
> +            - const: hsi1-mac
> +            - const: hsi-mac
> +            - const: xfp-mac
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - airoha,an7583-eth
> +    then:
> +      properties:
> +        resets:
> +          minItems: 7
> +          maxItems: 7

=2E..max to 7 here. Re-setting min here is redudant, since it matches the
outermost/widest constraint that you set when defining the property
outside the conditional.

pw-bot: changes-requested

Cheers,
Conor.

> +
> +        reset-names:
> +          items:
> +            - const: fe
> +            - const: pdma
> +            - const: qdma
> +            - const: xsi-mac
> +            - const: hsi0-mac
> +            - const: hsi1-mac
> +            - const: xfp-mac
> +
>  patternProperties:
>    "^ethernet@[1-4]$":
>      type: object
>=20
> --=20
> 2.51.0
>=20

--9mL+XRXQMatgZUrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEl+gAKCRB4tDGHoIJi
0on2AQCsGgDtbOnKMfcJ3xtmRPlJ8e6bbOl2Ha5gG8JXUfO1CgD/QxseQkLse1bg
s5COTpsvRS3yGcjqbh/LziflXULgVgc=
=rwvg
-----END PGP SIGNATURE-----

--9mL+XRXQMatgZUrQ--


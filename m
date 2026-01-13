Return-Path: <netdev+bounces-249367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EB8D17542
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2F22300816B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CF2F12A3;
	Tue, 13 Jan 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEKP2mr8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF929BD8C;
	Tue, 13 Jan 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293242; cv=none; b=ZOzwXzIIuQQGaOthwbLUOedkeeeXYU8ZjAp0DCbLA3aXSfFDb4VZR5G/6dS7ZQ6JwaUMIzfmcjZExyDqL5U9Ljuo4Ekgm16CFhcsz6kmpkzqHyvNHZY62uO3hL851wMFhfr1nVMwutWySVova5vhGZaS2NzBAR/PmHcRE5+2u/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293242; c=relaxed/simple;
	bh=jjUCjRQRE+P4dpfL4pcQVDUjSJrZEHUP4TE7rk2uXEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX5sAcByHj1b77lKOydNV1EJ7QN79U2vI5kYkLAJ11o3J248fq1DQJmBQJkJlyx3JLhTAPspSCebytFSfpc/ieh13sMqFEa8pAkj4dh3+NjDHPsRRcXqFN4e+oKdrXhAIpVdO+PiEKtKaWVOAdtPopctPE7o9UHa5YweuvWstY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEKP2mr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B693DC116C6;
	Tue, 13 Jan 2026 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768293242;
	bh=jjUCjRQRE+P4dpfL4pcQVDUjSJrZEHUP4TE7rk2uXEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEKP2mr8PVEGjqZ/tiSEGkd/4F0WoFrcus8hDFhcRnbYyTHQyUcDORMuCxhHlqMbz
	 gDhlQWTcxfOyvkYOKfsiRayJCm60lC3tZOnSe5DXnmTFAsHi6NnbC0K9jbhZKUL1h7
	 tqWc6xVz16UOvQSC8JVAdzAymwaahi86G2ikDCcJvKuaTt9wXFac0pmwUmxXiO5XJp
	 rlQ1LkM9/UUHFj8/tTO5pdM8ec8DrWXW2P2UxU0Ncj7Z0QdKrce7PMlecimOLIZ6pg
	 giqHUrxeWLUEk1XtoG+8aN4fWlFdqzZ62NIwpKsve8RZ4ewwDiL4H0uHDiIQk/f2IF
	 6eWKUjnncmS4Q==
Date: Tue, 13 Jan 2026 09:33:59 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: airoha: npu: Add BA
 memory region
Message-ID: <aWYDd4Pwi84gA6zy@lore-desk>
References: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
 <20260108-airoha-ba-memory-region-v3-1-bf1814e5dcc4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yz3hkU5huftspXAr"
Content-Disposition: inline
In-Reply-To: <20260108-airoha-ba-memory-region-v3-1-bf1814e5dcc4@kernel.org>


--yz3hkU5huftspXAr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce Block Ack memory region used by NPU MT7996 (Eagle) offloading.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-npu.yaml  | 21 +++++++++++----=
------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Hi Rob, Krzysztof and Conor,

Since this patch has been marked as 'needs ack' on patchwork, do you have a=
ny
comments on it? Thanks in advance.

Regards,
Lorenzo

>=20
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml=
 b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..19860b41286fd42f2a5ed15d5=
dc75ee0eb00a639 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> @@ -42,14 +42,13 @@ properties:
>        - description: wlan irq line5
> =20
>    memory-region:
> -    oneOf:
> -      - items:
> -          - description: NPU firmware binary region
> -      - items:
> -          - description: NPU firmware binary region
> -          - description: NPU wlan offload RX buffers region
> -          - description: NPU wlan offload TX buffers region
> -          - description: NPU wlan offload TX packet identifiers region
> +    items:
> +      - description: NPU firmware binary region
> +      - description: NPU wlan offload RX buffers region
> +      - description: NPU wlan offload TX buffers region
> +      - description: NPU wlan offload TX packet identifiers region
> +      - description: NPU wlan Block Ack buffers region
> +    minItems: 1
> =20
>    memory-region-names:
>      items:
> @@ -57,6 +56,8 @@ properties:
>        - const: pkt
>        - const: tx-pkt
>        - const: tx-bufid
> +      - const: ba
> +    minItems: 1
> =20
>  required:
>    - compatible
> @@ -93,7 +94,7 @@ examples:
>                       <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
>          memory-region =3D <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
> -                        <&npu_txbufid>;
> -        memory-region-names =3D "firmware", "pkt", "tx-pkt", "tx-bufid";
> +                        <&npu_txbufid>, <&npu_ba>;
> +        memory-region-names =3D "firmware", "pkt", "tx-pkt", "tx-bufid",=
 "ba";
>        };
>      };
>=20
> --=20
> 2.52.0
>=20

--yz3hkU5huftspXAr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWYDdwAKCRA6cBh0uS2t
rFtBAQD0yo69p4xD8JEzaHh0K8d8OYSRtrHkmX343xvu19+f8wEA9FbT9Hg1SDZr
MxzoKUFGCDbNaLfe1G88bl8Ds5L68QQ=
=FNzg
-----END PGP SIGNATURE-----

--yz3hkU5huftspXAr--


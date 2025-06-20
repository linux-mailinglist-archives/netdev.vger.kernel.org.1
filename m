Return-Path: <netdev+bounces-199798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3F1AE1D35
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F0A7A7582
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5E28C2AC;
	Fri, 20 Jun 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQSIIlp3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D684C79;
	Fri, 20 Jun 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429367; cv=none; b=agbuMJxNMj/X+OSKEY1RrVW05CEslqsLX/GX+EGcr/w1rRyupbm3jfcchGHdXcyJEvzNPpXSJ9rTn9GsUXVB0Gxb1R2ASTcTLYop+mk2iNz+hP79AR4jhH0OqM4/wAE/NtVFI6NbKrSGoVfDk7t9GChi4QpoP2O6OlUfnraiRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429367; c=relaxed/simple;
	bh=eGxHfyeE9o00L+BIdTzrAWlPzQaJp+kjyTjmC6hWtig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W05YMFNRIbZR/KMN+pAz734pwurMxssqtDcBXKLP1bcrmNndFhUpGdnD8JIIyDrthdk8u50wKXBsMzTGRLofI7L9QBrUWAyuK+PqynppIwjZd9p2UuF9zSRBbsQt34pfNPvGaAykfmvAsYw9JdyQMK7OxZ1ZjXNFIo19lb1eMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQSIIlp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222EEC4CEE3;
	Fri, 20 Jun 2025 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750429366;
	bh=eGxHfyeE9o00L+BIdTzrAWlPzQaJp+kjyTjmC6hWtig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQSIIlp34NkiVdqt1m4jSFP/RwjZeneA5lxU1anonztSaNY0S7eR0vxDJO82GtIe6
	 GduLWP6HDkS/RHEyI0unEVWP1aizZDlLtSIJr0MCtFSHYZFEpA4mGRXa6fEXE0sed3
	 /G8dcHSzjyEhVhaCVk1pj7zw2F5mm/qKzw9+Bt+DbS78lREivZPVrOZJ+6OpNx5qM/
	 g7Z1bOta6EEkrqBLGtMgL7j+VLO+d+9OnlNarmWLuP9Qi1xQbG1bNcZ3ZP2kR+0I/4
	 kubjMWpJKzIHnRadJPxuVAaipXTqHL0EAEDImhwkWvsLlrbXiMdbT0BbLntkFtoIK/
	 hXVFFqk45oy6g==
Date: Fri, 20 Jun 2025 15:22:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: net: cdns,macb: Add external REFCLK
 property
Message-ID: <20250620-giveaway-crazily-e8afbe8a7b5a@spud>
References: <cover.1750346271.git.Ryan.Wanner@microchip.com>
 <7f9c7308e404a6bcebdc8cc65ccf188dde435924.1750346271.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SmErXyrqfDynvb+c"
Content-Disposition: inline
In-Reply-To: <7f9c7308e404a6bcebdc8cc65ccf188dde435924.1750346271.git.Ryan.Wanner@microchip.com>


--SmErXyrqfDynvb+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 10:04:13AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>=20
> REFCLK can be provided by an external source so this should be exposed
> by a DT property. The REFCLK is used for RMII and in some SoCs that use
> this driver the RGMII 125MHz clk can also be provided by an external
> source.
>=20
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Docum=
entation/devicetree/bindings/net/cdns,macb.yaml
> index 8d69846b2e09..e69f60c37793 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -114,6 +114,13 @@ properties:
>    power-domains:
>      maxItems: 1
> =20
> +  cdns,refclk-ext:
> +    type: boolean
> +    description:
> +      This selects if the REFCLK for RMII is provided by an external sou=
rce.
> +      For RGMII mode this selects if the 125MHz REF clock is provided by=
 an external
> +      source.

If this gets a v2, is the distinction between RMII and RGMII worth
mentioning? Or is that mentioned because the property has no effect for
!{RGMII,RMII} usecases?
I'm okay with the property existing, though so
Acked-by: Conor Dooley <conor.dooley@microchip.com>
if it's the latter or with an improved description for the former.

> +
>    cdns,rx-watermark:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> --=20
> 2.43.0
>=20

--SmErXyrqfDynvb+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFVusQAKCRB4tDGHoIJi
0nqPAP4moM+gyh8DOK+EXqfh43QvWzlWVSATNddHyMMwg2IYUQEAvJ99X3USDuF5
2TdrWniYXWy1OyBMsaBalrukGfdFTAM=
=IRil
-----END PGP SIGNATURE-----

--SmErXyrqfDynvb+c--


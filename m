Return-Path: <netdev+bounces-50619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74757F653A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E781A1C20E8C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F9A405C0;
	Thu, 23 Nov 2023 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TauTI7yX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4F33CC9;
	Thu, 23 Nov 2023 17:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC74C433C8;
	Thu, 23 Nov 2023 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700760054;
	bh=HZ2it2SDpc8JXOsPY263SXF+iKCLC0kpnH0sDhz3fiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TauTI7yXz/EXK19sGpqXQIgeQSXWk/7tN1aZXr8i97YqI4fGEAFMoL4QD4jgJgLoO
	 BDUnxt6Ty380NwBjw6btK2JI8oU/fWfEX1mIDN9xTa1IPdYpmJ0BEVFJfSZEb+Szsz
	 sDhkyR8NQ+YMweQNFJrrr+0qSqt6YT5eU43vEWKLq/Dh10SFwUCLj4vuBn10U8gCAV
	 lWPwy2WeOTnTOTGnz+33/XXlDlx7vLbna1/0ygieyz62GwgVJWnST9zalRgrdKMkXR
	 RN0+I4MdzkOTOVf8sO+xANqjUk0MqpAGi98RRZrv5bWgbwRZwJh4dB2XXDjfaNOgIq
	 KWjPCPfKAm2jw==
Date: Thu, 23 Nov 2023 17:20:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	David Wu <david.wu@rock-chips.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH RFC WIP 1/2] dt-bindings: net: rockchip-dwmac: add
 rockchip,phy-wol property
Message-ID: <20231123-operable-frustrate-6c71ab0dafbf@spud>
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
 <20231123-dwmac-rk_phy_wol-v1-1-bf4e718081b9@wolfvision.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bTHzhB7hdNw7bvKU"
Content-Disposition: inline
In-Reply-To: <20231123-dwmac-rk_phy_wol-v1-1-bf4e718081b9@wolfvision.net>


--bTHzhB7hdNw7bvKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 01:14:13PM +0100, Javier Carrasco wrote:
> This property defines if PHY WOL is preferred. If it is not defined, MAC
> WOL will be preferred instead.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/=
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 70bbc4220e2a..fc4b02a5a375 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -91,6 +91,12 @@ properties:
>        The phandle of the syscon node for the peripheral general register=
 file.
>      $ref: /schemas/types.yaml#/definitions/phandle
> =20
> +  rockchip,phy-wol:
> +    type: boolean
> +    description:
> +      If present, indicates that PHY WOL is preferred. MAC WOL is prefer=
red
> +      otherwise.

Although I suspect this isn't, it sounds like software policy. What
attribute of the hardware determines which is preferred?

--bTHzhB7hdNw7bvKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+J8AAKCRB4tDGHoIJi
0myVAQCJk+QzYHl+/O3ThabjS9+O5WSkS3WxXLaSPMYQlO5sSAEA4U1Db0x5jGIy
glMeVXSf9fk0MYLSsWmvHvpZkUexmwI=
=CSe+
-----END PGP SIGNATURE-----

--bTHzhB7hdNw7bvKU--


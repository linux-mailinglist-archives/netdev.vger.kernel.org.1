Return-Path: <netdev+bounces-36914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEEA7B2392
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 19:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 501D528213E
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B271051252;
	Thu, 28 Sep 2023 17:17:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C913AFB;
	Thu, 28 Sep 2023 17:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6DCC433C8;
	Thu, 28 Sep 2023 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695921449;
	bh=kp48/6NY2s2Fwy7SPTbkm1Qxejl2zfg3J9xsj/VLKl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frwM8cmwFgXPPt6PQw33IXpDzfdefGVZdi/irC1N2cQJEBvz17+e9WaCpC6UKZCKq
	 S+yHTjowoARHIOm0Gaizj5BqYC/eUFb994s7vYCM/NvFo3hFiyR1flVnlv3AWtZAp2
	 sdyfP3XMlm+nSwtbyXHiqArvrmdFERQpF2CJeVxwt4RCzIFVTj9Cmza/unomjPzsDo
	 t7fwMaJW8dhoh9YZCQjN3GstiXyrkWfTsSd23eSkvxEHnJnNkt7j6lmMt1iKvcM4/B
	 KHUIfbPYBM2nxM1X62LiBWFOOTl9ZiEGW6KR7opg7xwwndszH8Yl2SIyg7NdAabq74
	 ahJxwYu5Iomew==
Date: Thu, 28 Sep 2023 18:17:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/12] dt-bindings: net: add new property
 st,ext-phyclk in documentation for stm32
Message-ID: <20230928-ruse-parsnip-ce691bd4d0c9@spud>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
 <20230928151512.322016-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GZ6Z6SVMMl7xgZNo"
Content-Disposition: inline
In-Reply-To: <20230928151512.322016-3-christophe.roullier@foss.st.com>


--GZ6Z6SVMMl7xgZNo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 05:15:02PM +0200, Christophe Roullier wrote:
> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
> This property can be used with RMII phy without cristal 50Mhz and when we
> want to select RCC clock instead of ETH_REF_CLK
> Can be used also with RGMII phy with no cristal and we select RCC clock
> instead of ETH_CLK125
> This new property replace st,eth-clk-sel and st,eth-ref-clk-sel

I don't really see a response to Rob's comment on v2, either here or in
a reply to his email on v2:
| Certainly 1 property is better than 2 for me, but carrying 3 is not
| great. I don't understand why the we need a new property. What can't be
| supported with the existing properties?

A sentence saying explaining exactly what the old properties do not
support that this one does, would be very helpful.

Thanks,
Conor.

>=20
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Doc=
umentation/devicetree/bindings/net/stm32-dwmac.yaml
> index ca976281bfc22..67840cab02d2d 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -78,12 +78,21 @@ properties:
>        encompases the glue register, the offset of the control register a=
nd
>        the mask to set bitfield in control register
> =20
> +  st,ext-phyclk:
> +    description:
> +      set this property in RMII mode when you have PHY without crystal 5=
0MHz and want to
> +      select RCC clock instead of ETH_REF_CLK. or in RGMII mode when you=
 want to select
> +      RCC clock instead of ETH_CLK125.
> +    type: boolean
> +
>    st,eth-clk-sel:
> +    deprecated: true
>      description:
>        set this property in RGMII PHY when you want to select RCC clock i=
nstead of ETH_CLK125.
>      type: boolean
> =20
>    st,eth-ref-clk-sel:
> +    deprecated: true
>      description:
>        set this property in RMII mode when you have PHY without crystal 5=
0MHz and want to
>        select RCC clock instead of ETH_REF_CLK.
> --=20
> 2.25.1
>=20

--GZ6Z6SVMMl7xgZNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRW1IwAKCRB4tDGHoIJi
0rNRAP9awNrP3aiGsCbGuiS8lMmRYwhVF+LyYev2PPrjoiD9mwD/XczIb1gqXTpN
dTxeIbKTupCl7S7dTc2C+xJDpScgrA8=
=YoXR
-----END PGP SIGNATURE-----

--GZ6Z6SVMMl7xgZNo--


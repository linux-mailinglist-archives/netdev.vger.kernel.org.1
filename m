Return-Path: <netdev+bounces-36562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A87B0777
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id AC711B2099D
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CD4347B3;
	Wed, 27 Sep 2023 14:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DD15A8;
	Wed, 27 Sep 2023 14:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD49C433C8;
	Wed, 27 Sep 2023 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695826778;
	bh=J5WMHeQmOYa9DaNiL6kj1L9JZ8CZSajg8MxP1uoMKSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQmBq3PQj4PKvUzkHXkkFH9/JcpmiCxSZ2WWd1Rqwr/OIjrCqal+CfgHOkmWb/dEw
	 z4+x6qdDG1mLyQF1GXNZslivHxCxIloJMsAzgePtAAQ8SoVJdqWbknQZMZEbb3v1l/
	 MpGF3+38TNA9lMfj4wVNYQQGgW9CpoKVnB1yM9FGp+erUuI36ngPz0DaUb8+uaw7cm
	 7dwzy7GrXYHz8q+qdee56LVDhvoAPsSEgmDWy6ruOMr/KQasD81JDXYCMqGed26LsW
	 MP5UdZSko+ftXTax8zedAE2iRfR4+hQbZGEyw1CoAgRRWh/1MYXIsPmrizuO4uZDpg
	 HI1KsWr0aDtwA==
Date: Wed, 27 Sep 2023 15:59:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: net: snps,dwmac: DMA
 Arbitration scheme
Message-ID: <20230927-dense-scoundrel-22ede0e27973@spud>
References: <20230927122928.22033-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="00CqfJ64cfG+S8hl"
Content-Disposition: inline
In-Reply-To: <20230927122928.22033-1-ansuelsmth@gmail.com>


--00CqfJ64cfG+S8hl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 02:29:27PM +0200, Christian Marangi wrote:
> Document new binding snps,arbit to program the DMA to use Arbitration
> scheme. (Rx has priority over Tx)
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..4499f221c29b 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -442,6 +442,12 @@ properties:
>      description:
>        Use Address-Aligned Beats
> =20
> +  snps,arbit:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Program the DMA to use Arbitration scheme.
> +      (Rx has priority over Tx)

Can you explain please what makes this a property of the hardware, or
otherwise makes it suitable for inclusion in DT?

> +
>    snps,fixed-burst:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> --=20
> 2.40.1
>=20

--00CqfJ64cfG+S8hl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRDVAAKCRB4tDGHoIJi
0vXYAQD67f4By+s5MP5vlHvV6WZ1uTkpsDKRXlhwiGwhPFF9aAD8CRBHJ1ufdl98
4zTcZIm8hVr0NdUOXt28M5x1qXtgmgg=
=JEy+
-----END PGP SIGNATURE-----

--00CqfJ64cfG+S8hl--


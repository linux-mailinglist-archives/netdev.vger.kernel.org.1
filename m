Return-Path: <netdev+bounces-20512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BC75FD78
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FE8281472
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1951E574;
	Mon, 24 Jul 2023 17:23:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C1F514
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D8C433C8;
	Mon, 24 Jul 2023 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690219398;
	bh=OKnfsi7SbxV3y3/SPI75aMywZMXuayUur6Ej80BIsR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jydDktQIuXY6UVtiIoIHjnpRq93L2hxMOk8stRNn4hoZxqztsvMDa5PNnd+PM06fE
	 sIajf5jQ7Wsq2JzJvTEt6CDWeEw9Q9xWKgeLsKCReuSnGi0ELT4tV+wdsIZBguivXL
	 iT+NQ7voUzu19KcI47ZCNzhX4zBzCycOlQXTHnnwrBqbG8apiOug7kfMufB01V1uFM
	 LDmPImBTyvB96kCPYxxrZHj0RUhXqkzkFLujmLa7z8/oUV3Nsch/xDjGoOp9i79HZu
	 ccSMcNz0VOBkY6+BWqoMLe/TPdqr/PalMacLsL6B9KFpk2ipr98j0JCpmSMZaliGE8
	 OMVPlRhX4OsoA==
Date: Mon, 24 Jul 2023 18:23:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 07/10] dt-bindings: net: snps,dwmac: add safety
 irq support
Message-ID: <20230724-cleat-tricolor-e455afa60b14@spud>
References: <20230723161029.1345-1-jszhang@kernel.org>
 <20230723161029.1345-8-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fqqukai8rpLna7CS"
Content-Disposition: inline
In-Reply-To: <20230723161029.1345-8-jszhang@kernel.org>


--fqqukai8rpLna7CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 12:10:26AM +0800, Jisheng Zhang wrote:
> The snps dwmac IP support safety features, and those Safety Feature
> Correctible Error and Uncorrectible Error irqs may be separate irqs.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..bb80ca205d26 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -107,6 +107,8 @@ properties:
>        - description: Combined signal for various interrupt events
>        - description: The interrupt to manage the remote wake-up packet d=
etection
>        - description: The interrupt that occurs when Rx exits the LPI sta=
te
> +      - description: The interrupt that occurs when Safety Feature Corre=
ctible Errors happen
> +      - description: The interrupt that occurs when Safety Feature Uncor=
rectible Errors happen
> =20
>    interrupt-names:
>      minItems: 1
> @@ -114,6 +116,8 @@ properties:
>        - const: macirq
>        - enum: [eth_wake_irq, eth_lpi]
>        - const: eth_lpi
> +      - const: sfty_ce_irq
> +      - const: sfty_ue_irq

Putting _irq in an interrupt name seems rather redundant to me although,
clearly not the first time for it here.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--fqqukai8rpLna7CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL6zgQAKCRB4tDGHoIJi
0vkYAP9J8lPgD4xupXtsbQ1efG2n9/QVww6TtsOCmWLaKw64kQEAvrv88XWaAORI
GW9S99iXG7nk2yZwWIPw+pGskFn0zAU=
=3/uV
-----END PGP SIGNATURE-----

--fqqukai8rpLna7CS--


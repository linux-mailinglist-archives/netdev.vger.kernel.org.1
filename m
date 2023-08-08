Return-Path: <netdev+bounces-25262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B87738A4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 09:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47051C20E83
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79461FD6;
	Tue,  8 Aug 2023 07:40:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15320EF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 07:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A0AC433C7;
	Tue,  8 Aug 2023 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691480403;
	bh=eeHnU9sbaREHfqMBo/78Xdyc8QmRfoP3LwM2oF3Vyok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+hgCruQm2uu/S7DddPGDxVKQgZvYiSoMBPLPwLN1VBSNtr1u+085A9QUxiiQx+JK
	 ihi46jANzuFJVh09X1hBEsF3bxP2GSt83pj3cuGRAyOe9h6LM9eXBxkutgo1IgrvDL
	 f3yo2TgB2qyRua3/sXAXbwzhVMdhV8sqzKqIYPA1Xj8Or1oo37VODb2bCuePorzrNF
	 34O/jZcESdCYCDASlx6PMDnfLROZAlprRs/E8YvlwqZEn0AIsxOIgA0BRAWg72/yUq
	 jVSwW/JCR38PnZWOuHI+BA/nUboHh4EBAouw3W1ljvmg6T6MCcVWNqxKj3/kHuX5QR
	 g9kS4Mu6EAj8A==
Date: Tue, 8 Aug 2023 08:39:58 +0100
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
Subject: Re: [PATCH net-next v2 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <20230808-clapper-corncob-0af7afa65752@spud>
References: <20230807164151.1130-1-jszhang@kernel.org>
 <20230807164151.1130-10-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KvLkMguropyELtMw"
Content-Disposition: inline
In-Reply-To: <20230807164151.1130-10-jszhang@kernel.org>


--KvLkMguropyELtMw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 12:41:50AM +0800, Jisheng Zhang wrote:
> The IP supports per channel interrupt, add support for this usage case.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5d81042f5634..5a63302ad200 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -109,6 +109,7 @@ properties:
>        - description: The interrupt that occurs when Rx exits the LPI sta=
te
>        - description: The interrupt that occurs when Safety Feature Corre=
ctible Errors happen
>        - description: The interrupt that occurs when Safety Feature Uncor=
rectible Errors happen
> +      - description: All of the rx/tx per-channel interrupts
> =20
>    interrupt-names:
>      minItems: 1
> @@ -118,6 +119,38 @@ properties:
>        - const: eth_lpi
>        - const: sfty_ce
>        - const: sfty_ue
> +      - const: rx0
> +      - const: rx1
> +      - const: rx2
> +      - const: rx3
> +      - const: rx4
> +      - const: rx5
> +      - const: rx6
> +      - const: rx7
> +      - const: rx8
> +      - const: rx9
> +      - const: rx10
> +      - const: rx11
> +      - const: rx12
> +      - const: rx13
> +      - const: rx14
> +      - const: rx15
> +      - const: tx0
> +      - const: tx1
> +      - const: tx2
> +      - const: tx3
> +      - const: tx4
> +      - const: tx5
> +      - const: tx6
> +      - const: tx7
> +      - const: tx8
> +      - const: tx9
> +      - const: tx10
> +      - const: tx11
> +      - const: tx12
> +      - const: tx13
> +      - const: tx14
> +      - const: tx15

I don't think Rob's comment about having added 2 interrupts but 32
interrupt names has been resolved.
Did you actually test putting this many interrupts into a node?
AFAICT, any more than 6 will cause complaints.

Thanks,
Conor.

--KvLkMguropyELtMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNHxTgAKCRB4tDGHoIJi
0onpAPsG6snh0PH1bQ597oct8Uh4jQLMK5o7U0UogD2+jX8qKQD+Mew24QNaxdd5
CIffFZC7Y1NgpuTfzG6Dej4xrzYwBAU=
=WzEI
-----END PGP SIGNATURE-----

--KvLkMguropyELtMw--


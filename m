Return-Path: <netdev+bounces-25261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4AF773896
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 09:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844BA2816BD
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 07:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84617C7;
	Tue,  8 Aug 2023 07:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2610F5
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 07:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95548C433C8;
	Tue,  8 Aug 2023 07:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691479702;
	bh=RdAScwYlQbKFjCynaCzGyIqpOLXi5HTfM61jXRC5qNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCaX5vfTNteeYwn0mRM/82W4iAZTVE0CK0WPc2s4D0/jQVxYDhjAXdCc9hlJ/Q1K/
	 tTw9BwQ8fdS9SXQFjmL17IjhfNatxVIZ4STGwRiV6PZ6ccDfkMmFBaMewlLaBnJUeb
	 QH/WiBN6a779Q6E2Dtsuao3G9JkMGPoIeojf9TPHx6qOjwcP/76JvCR79In2hbGAw1
	 pltGnW0Mz2Y7Y8g41j1d/F2xrh5OKceWpuu2++vp0Wun9d0NA3f2IQ3pDptmCBACLT
	 jMevdDnVSNqzO+RsmsQF2JNxrV9UyagzP6cDzvfUjwZI4n2IacakOdnIpCKLUfNy1I
	 nDA7flO6HOVlA==
Date: Tue, 8 Aug 2023 08:28:17 +0100
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
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: snps,dwmac: add
 safety irq support
Message-ID: <20230808-guidance-propose-407154f8bff4@spud>
References: <20230807164151.1130-1-jszhang@kernel.org>
 <20230807164151.1130-8-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CcVArbuGnTOxANs0"
Content-Disposition: inline
In-Reply-To: <20230807164151.1130-8-jszhang@kernel.org>


--CcVArbuGnTOxANs0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 12:41:48AM +0800, Jisheng Zhang wrote:
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
> index ddf9522a5dc2..5d81042f5634 100644
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
> +      - const: sfty_ce
> +      - const: sfty_ue

Did I not already ack this?

--CcVArbuGnTOxANs0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNHukQAKCRB4tDGHoIJi
0q8sAQDdMaiGwRgtoaOMOSoYM8rEhQWRBaqsZ9Sqog8hWbs5CAEAyV2Y7L7++Dz6
xHP/9iGKo8Kh8UMNTMtcAUByYyRAXA0=
=0Pro
-----END PGP SIGNATURE-----

--CcVArbuGnTOxANs0--


Return-Path: <netdev+bounces-26004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D98776688
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE77281BF2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BD91D2F3;
	Wed,  9 Aug 2023 17:38:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230D1AA83
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF67C433C7;
	Wed,  9 Aug 2023 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691602721;
	bh=JEJkyDA9mNcPNMW2BuJGF6PgKkgkGalfSfXFkQWZKhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq1eoIkfdHy3ArOqTDn4u16YGaskMie+zV/Px2pdMO+p7mwSk2jIcXc84UbQ3naLy
	 AZL/dX+Xl1TrhwZLNDXZbzjQgkouCcptFeZQlqWaIYf+4HY0hgy0PqKYxONzT3JbvU
	 1YRJbD1aqnZZ/1vN97f7npFMQjU8q4HCvZfeLB38+JHNub2soLcZ+cnTuS0muSkMSA
	 U5zu5gNFUdIx+ghF0n8KC7XLYXAT4xHnKhyFqB8gxeWJl9S/yD8YBTVzj6KGq8p1Xn
	 TXJtNajuj2YmQ2342YfUNUZ/8RFSooDTJImjgBtyd0Z1MVGJEXXHdlZtriKkmMZPDx
	 0j0mY4L9sRysQ==
Date: Wed, 9 Aug 2023 18:38:36 +0100
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
Subject: Re: [PATCH net-next v3 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <20230809-scabby-cobweb-bb825dffb309@spud>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-10-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xjvlQWsUfSJ189eD"
Content-Disposition: inline
In-Reply-To: <20230809165007.1439-10-jszhang@kernel.org>


--xjvlQWsUfSJ189eD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 12:50:06AM +0800, Jisheng Zhang wrote:
> The IP supports per channel interrupt, add support for this usage case.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

I do not see a response to
<https://lore.kernel.org/all/20230808-clapper-corncob-0af7afa65752@spud/>
in my mailbox or on lore, nor is there any changes in v3 on this front.

Thanks,
Conor.

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
> =20
>    clocks:
>      minItems: 1
> --=20
> 2.40.1
>=20

--xjvlQWsUfSJ189eD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNPPHAAKCRB4tDGHoIJi
0uDFAP4qH8Xnk1lWdOwlIW0fWCJyaXgG1F8zPUQ2Gsb4MgpJXAD/aFtaJoIkYfZ/
21lPuNeab/ZdCafUEILwlmTgvCUFsw0=
=r6X8
-----END PGP SIGNATURE-----

--xjvlQWsUfSJ189eD--


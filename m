Return-Path: <netdev+bounces-221511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F79B50AF9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A505F1BC719A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A7A23B63F;
	Wed, 10 Sep 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQxScFZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7243815E5D4;
	Wed, 10 Sep 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470954; cv=none; b=apeIf/1sZDxenY/06RlqiMz7DGnKPcLvjEvjqAmuKhmgUBqq5rwRs1iCqXVpoIJZaW9pKQwDFzm/kc7r82iEuqpOl9OPFVBc533/ReZfHQtiGOwkYylxNdxHkdJHEpg9J2fXfLZJtndRtIlwaF3Cs0hA4erN3bsnJ5fxbUcdPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470954; c=relaxed/simple;
	bh=oWlqndBd3eq4k+3ghnP4AOom/bFf4tXLD4z+QR1ca4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWOS5Q4HYodnmFrLO1cylmDQa/sPZDQYflOz/kfEJRq6z/J0D1TmdSgpAwZUcf3xj9jcJqdVBzWd8m9DkrelsBjO7irQTSpsq86I+HhyoxTCVvKUnvGbAd0mEMbHWs7TzQ147NZYQHGsp54WeJne0nc85xwc8ajz3YYOXbLqpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQxScFZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFFDC4CEF4;
	Wed, 10 Sep 2025 02:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757470952;
	bh=oWlqndBd3eq4k+3ghnP4AOom/bFf4tXLD4z+QR1ca4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQxScFZMdOBLa3xHO6K22mBmbwmsx3oPkoU+o85x9RyqQziu16MlTeR8NTPBNM4bG
	 W1x/PEx8BWo+PJB9oSS7l5WD+NbswC8bv7KasFvlkgPsvMOOhyP54e0h8D97ShEf9f
	 +0V8m5zbdbCL33CT5osJinQ6zV8lrjs7kiVul4tSdj+j8V6pEjuoxZBmdi0XtAy6MX
	 6s3g33HrDbaq5k862b9kZlug+CQouoB92Qm5WtkmJOuHWiNoc5zw0Xc6t3OySodd7j
	 MYsNJU2AC1OG2O8gtn0qcOPy0W64oldeZM+ssA5MF5Qo6G9CfKZzCALwR6W3ZJ5pSl
	 Pl4A7et32MwMA==
Date: Tue, 9 Sep 2025 21:22:30 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v4 01/10] dt-bindings: net: sun8i-emac: Add A523
 GMAC200 compatible
Message-ID: <20250910022230.GA3646514-robh@kernel.org>
References: <20250908181059.1785605-1-wens@kernel.org>
 <20250908181059.1785605-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908181059.1785605-2-wens@kernel.org>

On Tue, Sep 09, 2025 at 02:10:50AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Allwinner A523 SoC family has a second Ethernet controller, called
> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> numbering. This controller, according to BSP sources, is fully
> compatible with a slightly newer version of the Synopsys DWMAC core.
> The glue layer around the controller is the same as found around older
> DWMAC cores on Allwinner SoCs. The only slight difference is that since
> this is the second controller on the SoC, the register for the clock
> delay controls is at a different offset. Last, the integration includes
> a dedicated clock gate for the memory bus and the whole thing is put in
> a separately controllable power domain.
> 
> Add a compatible string entry for it, and work in the requirements for
> a second clock and a power domain.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v2:
> - Added "select" to avoid matching against all dwmac entries
> Changes since v1:
> - Switch to generic (tx|rx)-internal-delay-ps properties
> ---
>  .../net/allwinner,sun8i-a83t-emac.yaml        | 96 ++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> index 2ac709a4c472..9d205c5d93ca 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> @@ -10,6 +10,21 @@ maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
>    - Maxime Ripard <mripard@kernel.org>
>  
> +# We need a select here so we don't match all nodes with 'snps,dwmac'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - allwinner,sun8i-a83t-emac
> +          - allwinner,sun8i-h3-emac
> +          - allwinner,sun8i-r40-gmac
> +          - allwinner,sun8i-v3s-emac
> +          - allwinner,sun50i-a64-emac
> +          - allwinner,sun55i-a523-gmac200
> +  required:
> +    - compatible
> +
>  properties:
>    compatible:
>      oneOf:
> @@ -26,6 +41,9 @@ properties:
>                - allwinner,sun50i-h616-emac0
>                - allwinner,sun55i-a523-gmac0
>            - const: allwinner,sun50i-a64-emac
> +      - items:
> +          - const: allwinner,sun55i-a523-gmac200
> +          - const: snps,dwmac-4.20a
>  
>    reg:
>      maxItems: 1
> @@ -37,14 +55,19 @@ properties:
>      const: macirq
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    clock-names:
> -    const: stmmaceth
> +    minItems: 1
> +    maxItems: 2

minItems: 1
items:
  - const: stmmaceth
  - const: mbus

>  
>    phy-supply:
>      description: PHY regulator
>  
> +  power-domains:
> +    maxItems: 1
> +
>    syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -191,6 +214,45 @@ allOf:
>              - mdio-parent-bus
>              - mdio@1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun55i-a523-gmac200
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +        clock-names:
> +          items:
> +            - const: stmmaceth
> +            - const: mbus

Just 'minItems: 2' here.

> +        tx-internal-delay-ps:
> +          default: 0
> +          minimum: 0
> +          maximum: 700
> +          multipleOf: 100
> +          description:
> +            External RGMII PHY TX clock delay chain value in ps.
> +        rx-internal-delay-ps:
> +          default: 0
> +          minimum: 0
> +          maximum: 3100
> +          multipleOf: 100
> +          description:
> +            External RGMII PHY TX clock delay chain value in ps.
> +      required:
> +        - power-domains
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: stmmaceth

maxItems: 1

> +        power-domains: false
> +
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -323,4 +385,34 @@ examples:
>          };
>      };
>  
> +  - |
> +    ethernet@4510000 {
> +        compatible = "allwinner,sun55i-a523-gmac200",
> +                     "snps,dwmac-4.20a";
> +        reg = <0x04510000 0x10000>;
> +        clocks = <&ccu 117>, <&ccu 79>;
> +        clock-names = "stmmaceth", "mbus";
> +        resets = <&ccu 43>;
> +        reset-names = "stmmaceth";
> +        interrupts = <0 47 4>;
> +        interrupt-names = "macirq";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&rgmii1_pins>;
> +        power-domains = <&pck600 4>;
> +        syscon = <&syscon>;
> +        phy-handle = <&ext_rgmii_phy_1>;
> +        phy-mode = "rgmii-id";
> +        snps,fixed-burst;
> +        snps,axi-config = <&gmac1_stmmac_axi_setup>;
> +
> +        mdio {
> +            compatible = "snps,dwmac-mdio";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ext_rgmii_phy_1: ethernet-phy@1 {
> +                reg = <1>;
> +            };
> +        };
> +    };
>  ...
> -- 
> 2.39.5
> 


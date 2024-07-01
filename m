Return-Path: <netdev+bounces-108229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D0691E75B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47B11F20EC7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A05D16EB67;
	Mon,  1 Jul 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X01SANG/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98D2BB04;
	Mon,  1 Jul 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858113; cv=none; b=l7orVeUzc9s8p6gvgY6iGkMBJxnpU2TRyMWbla3w8ts2fMo7FALuD61/g79B+2uM0P8aNXFKL2FsVdT2/TpG4ca81mKVvGrFypwYxAYYE6Tk/VSevM7XtjlfcIa1PLAcYpBdbRlXAg3zfeg//t+Ylv98GgpEfyZ0BWqH+ewlFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858113; c=relaxed/simple;
	bh=ZS1M09pR2e89i2/x0GjF/RUkGIJBxm9gVRdcxXpYdMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK9KOPhl34dYu7DZ7J8jppfOzbTuuznesXyCEhDCK0RVFyW0oMMrPY8gF1rg1hwKW3HDQhdnqebfdNRmsw2CCG9nj+VZ4sZtNOCvinlneTibWM78edFL8jS/s/HDn/6k9lT8BXtEGokW2NtNbN2ME4Xl0UxfVpZn9olzzKDhfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X01SANG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DD1C116B1;
	Mon,  1 Jul 2024 18:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719858112;
	bh=ZS1M09pR2e89i2/x0GjF/RUkGIJBxm9gVRdcxXpYdMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X01SANG/MsX/TCJKLM73Ob4M+abTasVmecgoFTT0yOI9RGboFcJsf7Ak3InrgXlyk
	 PLHYxcs8mBODuBG1+hIVBIa7QIW8v7v9KLD0omu48Pb13tk0uyKf2QraE6tdPiwmsl
	 n/xr4TlzW2TTgzP5T74oa3Q+2I4hOSy/zJn7hhpvhuG4+Zxo9C3nMD6cA9e26fysxt
	 Qi4MXITPKP+aZ4bcImNxXg9dO2fD1KqCvPTf/GhRJU0FQjAhOONHRBVy+wmcCE+Rw2
	 AIvBsgOiB6V9n+EFnVf/iPUI1eBe/WJxu68ey9tzeyQJ3tLZ+qg+smyBYlPFIiLReN
	 AwtEE4OQfvAEA==
Date: Mon, 1 Jul 2024 12:21:51 -0600
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
	horms@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: net: airoha: Add EN7581 ethernet
 controller
Message-ID: <20240701182151.GA320555-robh@kernel.org>
References: <cover.1719672695.git.lorenzo@kernel.org>
 <20d103799a20d9d61a1c378eb27e61748859e978.1719672695.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d103799a20d9d61a1c378eb27e61748859e978.1719672695.git.lorenzo@kernel.org>

On Sat, Jun 29, 2024 at 05:01:37PM +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 ethernet
> mac controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/airoha,en7581-eth.yaml       | 171 ++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> new file mode 100644
> index 000000000000..e2c0da02ccf2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -0,0 +1,171 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,en7581-eth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7581 Frame Engine Ethernet controller
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +maintainers:
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +
> +description:
> +  The frame engine ethernet controller can be found on Airoha SoCs.
> +  These SoCs have dual GMAC ports.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - airoha,en7581-eth
> +
> +  reg:
> +    items:
> +      - description: Frame engine base address
> +      - description: QDMA0 base address
> +      - description: QDMA1 base address
> +
> +  reg-names:
> +    items:
> +      - const: fe
> +      - const: qdma0
> +      - const: qdma1
> +
> +  interrupts:
> +    items:
> +      - description: QDMA lan irq0
> +      - description: QDMA lan irq1
> +      - description: QDMA lan irq2
> +      - description: QDMA lan irq3
> +      - description: QDMA wan irq0
> +      - description: QDMA wan irq1
> +      - description: QDMA wan irq2
> +      - description: QDMA wan irq3
> +      - description: FE error irq
> +      - description: PDMA irq
> +
> +  resets:
> +    maxItems: 8
> +
> +  reset-names:
> +    items:
> +      - const: fe
> +      - const: pdma
> +      - const: qdma
> +      - const: xsi-mac
> +      - const: hsi0-mac
> +      - const: hsi1-mac
> +      - const: hsi-mac
> +      - const: xfp-mac
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^mac@[1-4]$":

ethernet@

> +    type: object
> +    unevaluatedProperties: false
> +    allOf:

Can drop 'allOf'

> +      - $ref: ethernet-controller.yaml#

Which node represents an ethernet controller? This one or the parent? 
Most likely it is not both.

> +    description:
> +      Ethernet MAC node
> +    properties:
> +      compatible:
> +        const: airoha,eth-mac
> +
> +      reg:
> +        maxItems: 1

Based on the unit-address, you need instead:

minimum: 1
maximum: 4

But what does 1-4 represent? There are no MMIO registers associated with 
the MACs? Please describe.

> +
> +    required:
> +      - reg
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/en7523-clk.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      eth0: ethernet@1fb50000 {
> +        compatible = "airoha,en7581-eth";
> +        reg = <0 0x1fb50000 0 0x2600>,
> +              <0 0x1fb54000 0 0x2000>,
> +              <0 0x1fb56000 0 0x2000>;
> +        reg-names = "fe", "qdma0", "qdma1";
> +
> +        resets = <&scuclk 44>,
> +                 <&scuclk 30>,
> +                 <&scuclk 31>,
> +                 <&scuclk 6>,
> +                 <&scuclk 15>,
> +                 <&scuclk 16>,
> +                 <&scuclk 17>,
> +                 <&scuclk 26>;
> +        reset-names = "fe", "pdma", "qdma", "xsi-mac",
> +                      "hsi0-mac", "hsi1-mac", "hsi-mac",
> +                      "xfp-mac";
> +
> +        interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mac1: mac@1 {
> +          compatible = "airoha,eth-mac";
> +          reg = <1>;
> +          phy-mode = "2500base-x";
> +          phy-handle = <&phy0>;
> +        };
> +
> +        mac2: mac@2 {
> +          compatible = "airoha,eth-mac";
> +          reg = <2>;
> +          phy-mode = "2500base-x";
> +          phy-handle = <&phy1>;
> +        };
> +      };
> +
> +      mdio: mdio-bus {

mdio {

But really, drop this if it is not part of this device (binding). What 
is the control interface for this MDIO bus? If it is part of this 
device, then the mdio node needs to be within the device's node.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        phy0: ethernet-phy@0 {
> +            compatible = "ethernet-phy-id67c9.de0a";
> +            reg = <0>;
> +            phy-mode = "2500base-x";
> +        };
> +
> +        phy1: ethernet-phy@1 {
> +            compatible = "ethernet-phy-id67c9.de0a";
> +            reg = <1>;
> +            phy-mode = "2500base-x";
> +        };
> +      };
> +    };
> -- 
> 2.45.2
> 


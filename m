Return-Path: <netdev+bounces-146326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64B9D2E4E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E33B2B538
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463561D14FA;
	Tue, 19 Nov 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjyjfgPE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9891CDFCA;
	Tue, 19 Nov 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039960; cv=none; b=drkWmKvwP1RdPBcISg/enWdJZeAtwQIyLkxtt1TK4t4KteXe/UyIV0gB7GOEI4yMYjhkn4TfoadVww6ffO+n+FIF/K68b+aYrbKy5ozCFvFVmvy6VQOVXcdAIBCkE4LDo7CrxQ6MdMWorW3DNqZdYZuTkrrnm65ixTY4aFrwx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039960; c=relaxed/simple;
	bh=+wbYj1AcnlE6pU8bR4zENHUExkruGEtGXcEXeHgtAlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgEBDH5u+k56u52nwvbMG2ckX60A5Y0e2gVtOGUMWZHEYUXgEtqHoayaYhZ9KqjeQJvJwmeMY0qPgN+v6v9ATMhlyMT5sjCPjUnygYXQqcD0EuqV72QIPPzq+yYzcEpkkxprrVus0LMVi9pfPOL98P7J2x/hAoNJF1mpNHtVqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjyjfgPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736BAC4CECF;
	Tue, 19 Nov 2024 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732039959;
	bh=+wbYj1AcnlE6pU8bR4zENHUExkruGEtGXcEXeHgtAlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjyjfgPEAoxFatLZFmGR2PBmelIKrLaBAqYHegwKX+KelbP31+plkliWveQbHJHJx
	 h+r+tlCjkoQMjFwAFqAC5KTr3xyo7PhyGQe6j/LAEfrXAUdbrBTnL8x61RNogiclOh
	 0VCcpb/pnnxzSZSxOLxUrNTWV9Sk2zkMTRh0PkHCbv7u0keiWqQg6dPNheodVQn2N/
	 TwSUMUOnSK+k6YsMpFtNFPnlWNUC9HCmSYGxkNRvrAAiW4c7Dnc1qIVuQwOdFnIUOi
	 v0lRhl9MQsf8Rblk5Y+qsrLSaB41wL/L6foueUoHGNnd+4e3xJwXzXBts5U+VOQQ3z
	 hU+ZE9CjWVVQA==
Date: Tue, 19 Nov 2024 12:12:37 -0600
From: Rob Herring <robh@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
Message-ID: <20241119181237.GA1871579-robh@kernel.org>
References: <20241118082707.8504-1-a0987203069@gmail.com>
 <20241118082707.8504-2-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118082707.8504-2-a0987203069@gmail.com>

On Mon, Nov 18, 2024 at 04:27:05PM +0800, Joey Lu wrote:
> Create initial schema for Nuvoton MA35 family Gigabit MAC.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 173 ++++++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> new file mode 100644
> index 000000000000..92cbbcc72f2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton DWMAC glue layer controller
> +
> +maintainers:
> +  - Joey Lu <yclu4@nuvoton.com>
> +
> +description:
> +  Nuvoton 10/100/1000Mbps Gigabit Ethernet MAC Controller is based on
> +  Synopsys DesignWare MAC (version 3.73a).
> +
> +# We need a select here so we don't match all nodes with 'snps,dwmac'

You mean snps,dwmac-3.70a?

> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - nuvoton,ma35d1-dwmac
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:

oneOf is not correct. I think you wanted 'items'.

> +      - enum:
> +          - nuvoton,ma35d1-dwmac
> +      - const: snps,dwmac-3.70a

But you said above the h/w is 3.73a.

Really, I'd prefer to just drop this because it's not useful on its own. 
But the driver does check for snps,dwmac-3.70a. All those 
of_device_is_compatible() calls in the driver should really be replaced 
with static match data structs.

> +
> +  reg:
> +    description:
> +      Register range should be one of the GMAC interface.

Need to define how many entries and what they are if more than 1.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: MAC clock
> +      - description: PTP clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: ptp_ref
> +
> +  nuvoton,sys:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to access syscon registers.
> +          - description: GMAC interface ID.
> +            enum:
> +              - 0
> +              - 1
> +    description:
> +      A phandle to the syscon with one argument that configures system registers
> +      for MA35D1's two GMACs. The argument specifies the GMAC interface ID.
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: stmmaceth
> +
> +  phy-mode:
> +    enum:
> +      - rmii
> +      - rgmii
> +      - rgmii-id
> +      - rgmii-txid
> +      - rgmii-rxid
> +
> +  phy-handle:
> +    $ref: /schemas/types.yaml#/definitions/phandle

The type is already defined. Drop.

> +    description:
> +      Specifies a reference to a node representing a PHY device.
> +
> +  tx-internal-delay-ps:
> +    enum: [0, 2000]
> +    default: 0
> +    description:
> +      RGMII TX path delay used only when PHY operates in RGMII mode with
> +      internal delay (phy-mode is 'rgmii-id' or 'rgmii-txid') in pico-seconds.
> +
> +  rx-internal-delay-ps:
> +    enum: [0, 2000]
> +    default: 0
> +    description:
> +      RGMII RX path delay used only when PHY operates in RGMII mode with
> +      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - nuvoton,sys
> +  - resets
> +  - reset-names
> +  - phy-mode
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +    //Example 1

Not a useful comment.

> +    gmac0: ethernet@40120000 {

Drop unused labels.

> +        compatible = "nuvoton,ma35d1-dwmac";
> +        reg = <0x0 0x40120000 0x0 0x10000>;
> +        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "macirq";
> +        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
> +        clock-names = "stmmaceth", "ptp_ref";
> +
> +        nuvoton,sys = <&sys 0>;
> +        resets = <&sys MA35D1_RESET_GMAC0>;
> +        reset-names = "stmmaceth";
> +
> +        phy-mode = "rgmii-id";
> +        phy-handle = <&eth_phy0>;
> +        mdio0: mdio {
> +            compatible = "snps,dwmac-mdio";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            eth_phy0: ethernet-phy@0 {
> +                reg = <0>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    //Example 2
> +    gmac1: ethernet@40130000 {

Drop the example. It's almost the same as the first one.

> +        compatible = "nuvoton,ma35d1-dwmac";
> +        reg = <0x0 0x40130000 0x0 0x10000>;
> +        interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "macirq";
> +        clocks = <&clk EMAC1_GATE>, <&clk EPLL_DIV8>;
> +        clock-names = "stmmaceth", "ptp_ref";
> +
> +        nuvoton,sys = <&sys 1>;
> +        resets = <&sys MA35D1_RESET_GMAC1>;
> +        reset-names = "stmmaceth";
> +
> +        phy-mode = "rmii";
> +        phy-handle = <&eth_phy1>;
> +        mdio1: mdio {
> +            compatible = "snps,dwmac-mdio";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            eth_phy1: ethernet-phy@1 {
> +                reg = <1>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 4e2ba1bf788c..aecdb3d37b53 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -66,6 +66,7 @@ properties:
>          - ingenic,x2000-mac
>          - loongson,ls2k-dwmac
>          - loongson,ls7a-dwmac
> +        - nuvoton,ma35d1-dwmac
>          - qcom,qcs404-ethqos
>          - qcom,sa8775p-ethqos
>          - qcom,sc8280xp-ethqos
> -- 
> 2.34.1
> 


Return-Path: <netdev+bounces-195303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D352ACF61B
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205253A24EF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66B127978D;
	Thu,  5 Jun 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o33czuK9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803615747D;
	Thu,  5 Jun 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146390; cv=none; b=iF/ktBJsECVrHeAapJUv04cDBSzEVovzdWX3kVQyxLJ+T98VrcntHPWF53tEFFbyOiuIuYF/0xT3qRPD5kvJ+DpIzTum65GdxvSNskH6cqNhQSlGy3JzgAtf/NsaKVwbJiFKbUWs3ONZicrlNrZBGvAmjG/3n6zA2ZXZjxkSjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146390; c=relaxed/simple;
	bh=CE4oXtn8XY0w4ysW/AqEXyAzkZMZ38p/cIxAade1xDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHLWVWItKLV5kJnNcEqzs4TqQSSnnTlKlDDBr4jQItrx9xPmRreAwAsu4gwjFi8QzJAP09mzfeKodsOgEqn/PhwOS2ydvKNBFpWLqoL81xpFYgpYjcK+WNt+n/H0LWpPNQ93T1PvjCNfcPZKafDZUzRN7UMrSUePimnbM483S0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o33czuK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7709C4CEE7;
	Thu,  5 Jun 2025 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749146390;
	bh=CE4oXtn8XY0w4ysW/AqEXyAzkZMZ38p/cIxAade1xDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o33czuK9hbDLuuu3OezwnXnaPN9lX2ksXVYfxcfl+uO09o2UGIH9DmWJ0xuMhtcNc
	 n/zB0vdXspzbdHJ0/uGgr/4J9BAVgb8msFKfaKDTtlYZNk26bPWUNeRoZa99hoPy0L
	 YXLJ2UKFr6nOCRgrP/tBk66qVNWwYEzcAe4TFWb6LFr1wKgwVJSBYzZW4BaSSEs4tt
	 5LumWYGjEkclAKpa/BbgkKzuo1mvmlNg7k9b0k0hdvUvYYjX97JF1dRbhlbG0m9W+m
	 /ecEKEiY8ENC5WywQLcF0cG5CzjIhKvzPwsCgpTwLscnJAsTd12R+VFFx2i2HgYc5r
	 bF/3N5I0So4zQ==
Date: Thu, 5 Jun 2025 12:59:48 -0500
From: Rob Herring <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, maxime.chevallier@bootlin.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: Re: [PATCH v3] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <20250605175948.GA2927628-robh@kernel.org>
References: <20250530153241.8737-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530153241.8737-1-matthew.gerlach@altera.com>

On Fri, May 30, 2025 at 08:32:41AM -0700, Matthew Gerlach wrote:
> From: Mun Yew Tham <mun.yew.tham@altera.com>
> 
> Convert the bindings for socfpga-dwmac to yaml.
> 
> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v3:
>  - Add missing supported phy-modes.
> 
> v2:
>  - Add compatible to required.
>  - Add descriptions for clocks.
>  - Add clock-names.
>  - Clean up items: in altr,sysmgr-syscon.
>  - Change "additionalProperties: true" to "unevaluatedProperties: false".
>  - Add properties needed for "unevaluatedProperties: false".
>  - Fix indentation in examples.
>  - Drop gmac0: label in examples.
>  - Exclude support for Arria10 that is not validating.
> ---
>  .../bindings/net/socfpga,dwmac.yaml           | 153 ++++++++++++++++++

Filename should be altr,socfpga-stmmac.yaml

Don't forget the $id

>  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 -------
>  2 files changed, 153 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> new file mode 100644
> index 000000000000..29dad0b58e1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/socfpga,dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera SOCFPGA SoC DWMAC controller
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@altera.com>
> +
> +description:
> +  This binding describes the Altera SOCFPGA SoC implementation of the
> +  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
> +  of chips.
> +  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
> +  # does not validate against net/snps,dwmac.yaml.
> +
> +select:
> +  properties:
> +    compatible:
> +      oneOf:
> +        - items:
> +            - const: altr,socfpga-stmmac
> +            - const: snps,dwmac-3.70a
> +            - const: snps,dwmac
> +        - items:
> +            - const: altr,socfpga-stmmac-a10-s10
> +            - const: snps,dwmac-3.74a
> +            - const: snps,dwmac

This should be defined under 'properties'. The select just needs:

contains:
  enum:
    - altr,socfpga-stmmac
    - altr,socfpga-stmmac-a10-s10

> +
> +  required:
> +    - compatible
> +    - altr,sysmgr-syscon
> +
> +properties:
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: GMAC main clock
> +      - description:
> +          PTP reference clock. This clock is used for programming the
> +          Timestamp Addend Register. If not passed then the system
> +          clock will be used and this is fine on some platforms.
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    contains:
> +      enum:
> +        - stmmaceth
> +        - ptp_ref

stmmaceth clock is not required? Looks like it is from 'clocks' schema. 
I'd expect this:

minItems: 1
items:
  - const: stmmaceth
  - const: ptp_ref

> +
> +  iommus:
> +    maxItems: 1
> +
> +  phy-mode:
> +    enum:
> +      - gmii
> +      - mii
> +      - rgmii
> +      - rgmii-id
> +      - rgmii-rxid
> +      - rgmii-txid
> +      - sgmii
> +      - 1000base-x
> +
> +  rxc-skew-ps:
> +    description: Skew control of RXC pad
> +
> +  rxd0-skew-ps:
> +    description: Skew control of RX data 0 pad
> +
> +  rxd1-skew-ps:
> +    description: Skew control of RX data 1 pad
> +
> +  rxd2-skew-ps:
> +    description: Skew control of RX data 2 pad
> +
> +  rxd3-skew-ps:
> +    description: Skew control of RX data 3 pad
> +
> +  rxdv-skew-ps:
> +    description: Skew control of RX CTL pad
> +
> +  txc-skew-ps:
> +    description: Skew control of TXC pad
> +
> +  txen-skew-ps:
> +    description: Skew control of TXC pad
> +
> +  altr,emac-splitter:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should be the phandle to the emac splitter soft IP node if DWMAC
> +      controller is connected an emac splitter.
> +
> +  altr,f2h_ptp_ref_clk:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to Precision Time Protocol reference clock. This clock is
> +      common to gmac instances and defaults to osc1.
> +
> +  altr,gmii-to-sgmii-converter:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should be the phandle to the gmii to sgmii converter soft IP.
> +
> +  altr,sysmgr-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Should be the phandle to the system manager node that encompass
> +      the glue register, the register offset, and the register shift.
> +      On Cyclone5/Arria5, the register shift represents the PHY mode
> +      bits, while on the Arria10/Stratix10/Agilex platforms, the
> +      register shift represents bit for each emac to enable/disable
> +      signals from the FPGA fabric to the EMAC modules.
> +    items:
> +      - items:
> +          - description: phandle to the system manager node
> +          - description: offset of the control register
> +          - description: shift within the control register
> +
> +patternProperties:
> +  "^mdio[0-9]$":
> +    type: object
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ethernet@ff700000 {
> +            compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
> +            "snps,dwmac";
> +            altr,sysmgr-syscon = <&sysmgr 0x60 0>;
> +            reg = <0xff700000 0x2000>;
> +            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "macirq";
> +            mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
> +            clocks = <&emac_0_clk>;
> +            clock-names = "stmmaceth";
> +            phy-mode = "sgmii";
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> deleted file mode 100644
> index 612a8e8abc88..000000000000
> --- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -Altera SOCFPGA SoC DWMAC controller
> -
> -This is a variant of the dwmac/stmmac driver an inherits all descriptions
> -present in Documentation/devicetree/bindings/net/stmmac.txt.
> -
> -The device node has additional properties:
> -
> -Required properties:
> - - compatible	: For Cyclone5/Arria5 SoCs it should contain
> -		  "altr,socfpga-stmmac". For Arria10/Agilex/Stratix10 SoCs
> -		  "altr,socfpga-stmmac-a10-s10".
> -		  Along with "snps,dwmac" and any applicable more detailed
> -		  designware version numbers documented in stmmac.txt
> - - altr,sysmgr-syscon : Should be the phandle to the system manager node that
> -   encompasses the glue register, the register offset, and the register shift.
> -   On Cyclone5/Arria5, the register shift represents the PHY mode bits, while
> -   on the Arria10/Stratix10/Agilex platforms, the register shift represents
> -   bit for each emac to enable/disable signals from the FPGA fabric to the
> -   EMAC modules.
> - - altr,f2h_ptp_ref_clk use f2h_ptp_ref_clk instead of default eosc1 clock
> -   for ptp ref clk. This affects all emacs as the clock is common.
> -
> -Optional properties:
> -altr,emac-splitter: Should be the phandle to the emac splitter soft IP node if
> -		DWMAC controller is connected emac splitter.
> -phy-mode: The phy mode the ethernet operates in
> -altr,sgmii-to-sgmii-converter: phandle to the TSE SGMII converter
> -
> -This device node has additional phandle dependency, the sgmii converter:
> -
> -Required properties:
> - - compatible	: Should be altr,gmii-to-sgmii-2.0

You need a binding schema for this node.

> - - reg-names	: Should be "eth_tse_control_port"
> -
> -Example:
> -
> -gmii_to_sgmii_converter: phy@100000240 {
> -	compatible = "altr,gmii-to-sgmii-2.0";
> -	reg = <0x00000001 0x00000240 0x00000008>,
> -		<0x00000001 0x00000200 0x00000040>;
> -	reg-names = "eth_tse_control_port";
> -	clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
> -	clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
> -};
> -
> -gmac0: ethernet@ff700000 {
> -	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
> -	altr,sysmgr-syscon = <&sysmgr 0x60 0>;
> -	reg = <0xff700000 0x2000>;
> -	interrupts = <0 115 4>;
> -	interrupt-names = "macirq";
> -	mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
> -	clocks = <&emac_0_clk>;
> -	clock-names = "stmmaceth";
> -	phy-mode = "sgmii";
> -	altr,gmii-to-sgmii-converter = <&gmii_to_sgmii_converter>;
> -};
> -- 
> 2.35.3
> 


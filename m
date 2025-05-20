Return-Path: <netdev+bounces-192015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A89ABE41A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088BC1BC1D44
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E2283128;
	Tue, 20 May 2025 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTCCX8XV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC02820CC;
	Tue, 20 May 2025 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770777; cv=none; b=ph/3Xdb6o7pKet51Hc8S35Ie/CVDOeSmP2tH86w+TALFU7PJE+Q3UicN4bf3dr7gMPOHtsxx3kwuaDtG9Z5Ck8wd90O6KQunlP8GZe3ebZ/uNKQJCTlIr1JbpvMTqBmbiwr8IhYTC1EOoSfC25lKWYOeNQm4VuXrmnGuPmS50Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770777; c=relaxed/simple;
	bh=sVuIV87vGQNNhBH1C+IifHHMly6qW45dro2WlmwqoKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFuHdpghk3X/Qc4GYyzakjlUIwzrv94Nj3EqblvWvZCDYQgynzOulWbLgZeZeMIhuznvB78nRgcYt1UK+iDAy63JTY9BNcXh07kD+0IqbJPDVNx2LUGT0dcO00mJHa12F0M90/l+2dhps77KxHgRPd4RIzMbrD7FG4YlMlg9u5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTCCX8XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FCDC4CEE9;
	Tue, 20 May 2025 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747770776;
	bh=sVuIV87vGQNNhBH1C+IifHHMly6qW45dro2WlmwqoKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTCCX8XVM9CEiOBZ79VhWuUwWU6FGvo2W901AQ4LYk4O44bVdXPD+YcX2kmgyjLTi
	 1+LgeF8JMlSIvH5ORHHLppC0LhPgisAd7j6rUtJjbnzyaocoljL7ga8x3l5MpXgwvv
	 cQ0Oq8LN6prykF704uEZjAHRpdLmYqqOm68GjPaZJNhaAXvEM4x1esIYkFZwsYc4pP
	 QopYcvL3vU8OnP1iDQI6WUY+n8EDsWXgTeZxc395GqVkr4fumvmRTBI1ucbDqObCCg
	 OHMZhAneCp7TFzKEcFdGySTnVre2k5G2siQs4gTpPRPU7cKCLcoe8q1W6wlqT2bfuB
	 r5JD92U70lgeQ==
Date: Tue, 20 May 2025 14:52:54 -0500
From: Rob Herring <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: Re: [PATCH] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
Message-ID: <20250520195254.GA1247930-robh@kernel.org>
References: <20250513152237.21541-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513152237.21541-1-matthew.gerlach@altera.com>

On Tue, May 13, 2025 at 08:22:37AM -0700, Matthew Gerlach wrote:
> From: Mun Yew Tham <mun.yew.tham@altera.com>
> 
> Convert the bindings for socfpga-dwmac to yaml.
> 
> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  .../bindings/net/socfpga,dwmac.yaml           | 109 ++++++++++++++++++
>  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ---------
>  2 files changed, 109 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> new file mode 100644
> index 000000000000..68ad580dc2da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> @@ -0,0 +1,109 @@
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
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - altr,socfpga-stmmac
> +          - altr,socfpga-stmmac-a10-s10
> +  required:
> +    - altr,sysmgr-syscon

Should be 'compatible' here.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: altr,socfpga-stmmac
> +          - const: snps,dwmac-3.70a
> +          - const: snps,dwmac
> +      - items:
> +          - const: altr,socfpga-stmmac-a10-s10
> +          - const: snps,dwmac-3.74a
> +          - const: snps,dwmac
> +      - items:
> +          - const: altr,socfpga-stmmac-a10-s10
> +          - const: snps,dwmac-3.72a
> +          - const: snps,dwmac

The last 2 lists can be combined.

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4

You need to define what each entry is.

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4

And the name for each entry.

> +
> +  phy-mode:
> +    enum:
> +      - rgmii
> +      - sgmii
> +      - gmii
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
> +    minItems: 1
> +    items:
> +      - description: phandle to the system manager node
> +      - description: offset of the control register
> +      - description: shift within the control register

items:
  - items:
      - description: phandle to the system manager node
      - ...
      - ...

And drop minItems.

> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +additionalProperties: true

unevaluatedProperties: false

> +
> +examples:
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    soc {
> +            #address-cells = <1>;

Use 4 space indent.

> +            #size-cells = <1>;
> +            gmac0: ethernet@ff700000 {

Drop the label.

> +                    compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
> +                    "snps,dwmac";
> +                    altr,sysmgr-syscon = <&sysmgr 0x60 0>;
> +                    reg = <0xff700000 0x2000>;
> +                    interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +                    interrupt-names = "macirq";
> +                    mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
> +                    clocks = <&emac_0_clk>;
> +                    clock-names = "stmmaceth";
> +                    phy-mode = "sgmii";
> +            };
> +    };


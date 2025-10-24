Return-Path: <netdev+bounces-232724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ED6C08496
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA3A3A832B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9883303CB7;
	Fri, 24 Oct 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcE2rYBV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A292367A2;
	Fri, 24 Oct 2025 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348014; cv=none; b=Vn+5zzhabvUtnZyg7Jfm6ULNyWdNk3cd1uUw2oLOpKezinKX3bRPdh+pjQk9vfDSkXJFc4x9TlK/MqeaM2V50y12zfSxN77aXzJXWA4nMuVOr9hF+OTvgy2gipoMX+Hbdhmnr7hXm9owRt+2F2a2t/Z1SPXaRstD6gjDDH1oIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348014; c=relaxed/simple;
	bh=tLA5jyid0OLGc5stZNuAdXz2e7J1KGmxNd8vsBF0Zt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwA6SEPz0+vjnwBljq8rqOX6O6vOtCZO1cM8igEJsHHdb0v/Mv9RWEAEqJaX3331DAnBK7l0jMGkn7rPja1/9gBHQdzFPUlml1mw2BtXZhyNmSVhd/Me7770AH0YQS3yDguMYqsFj3D6VboJfZldQi9sSQiSWvktTwehL8jakDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcE2rYBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F0DC4CEF1;
	Fri, 24 Oct 2025 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761348012;
	bh=tLA5jyid0OLGc5stZNuAdXz2e7J1KGmxNd8vsBF0Zt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcE2rYBV+8SF+uK4Osnktu++d2o0facDxdwHWqB/PpkbZ/6KoffZKmHoup17jMVWJ
	 WrOVrolyGlcQahOXb2e3t1Z40BETyImS4thBLvMh5WEWKfULQkXfEP5+cW0h6BN9Uw
	 QJtSqqpDji24j/VYzoArmotAghm+EjKjE+QsVqv9LJb2/hheVFSjAXzF7IKu469lsp
	 x67Z0fEWZX/DZYBB0qBwvMoc81eOwTOVwFYgseSS7QpMzydnrxoPUQkpwZp6xqcdsD
	 u6ZqCtO5MV8pe0YehLfD2AKXk6ZQBs5+7/RqVgQUXQDNVwtuVp/52cJD2Lgj656O/c
	 0iiKmxPeu8ARg==
Date: Fri, 24 Oct 2025 18:20:10 -0500
From: Rob Herring <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next] dt-bindings: net: phy: vsc8531: Convert to DT
 schema
Message-ID: <20251024232010.GA2992158-robh@kernel.org>
References: <20251024201836.317324-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024201836.317324-1-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Oct 24, 2025 at 09:18:36PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert VSC8531 Gigabit ethernet phy binding to DT schema format. While
> at it add compatible string for VSC8541 PHY which is very much similar
> to the VSC8531 PHY and is already supported in the kernel. VSC8541 PHY
> is present on the Renesas RZ/T2H EVK.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Inspired from the DT warnings seen while running dtbs check [0],
> took an opportunity to convert this binding to DT schema format.
> As there was no entry in the maintainers file Ive added myself
> as the maintainer for this binding.
> [0] https://lore.kernel.org/all/176073765433.419659.2490051913988670515.robh@kernel.org/
> 
> Note,
> 1] dt_binding_check reports below warnings. But this looks like
> the same for other DT bindings too which have dependencies defined.
> ./Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml:99:36: [warning] too few spaces after comma (commas)
> <path>/mscc-phy-vsc8531.example.dtb: ethernet-phy@0 (ethernet-phy-id0007.0772): 'vsc8531' is a dependency of 'vsc8531,edge-slowdown'
> 	from schema $id: http://devicetree.org/schemas/net/mscc-phy-vsc8531.yaml
> <path>/mscc-phy-vsc8531.example.dtb: ethernet-phy@0 (ethernet-phy-id0007.0772): 'vddmac' is a dependency of 'vsc8531,edge-slowdown'
> 2] As there is no entry in maintainers file for this binding, Ive added myself
> as the maintainer for this binding.
> ---
>  .../bindings/net/mscc-phy-vsc8531.txt         |  73 ----------
>  .../bindings/net/mscc-phy-vsc8531.yaml        | 125 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +-
>  3 files changed, 126 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> deleted file mode 100644
> index 0a3647fe331b..000000000000
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -* Microsemi - vsc8531 Giga bit ethernet phy
> -
> -Optional properties:
> -- vsc8531,vddmac	: The vddmac in mV. Allowed values is listed
> -			  in the first row of Table 1 (below).
> -			  This property is only used in combination
> -			  with the 'edge-slowdown' property.
> -			  Default value is 3300.
> -- vsc8531,edge-slowdown	: % the edge should be slowed down relative to
> -			  the fastest possible edge time.
> -			  Edge rate sets the drive strength of the MAC
> -			  interface output signals.  Changing the
> -			  drive strength will affect the edge rate of
> -			  the output signal.  The goal of this setting
> -			  is to help reduce electrical emission (EMI)
> -			  by being able to reprogram drive strength
> -			  and in effect slow down the edge rate if
> -			  desired.
> -			  To adjust the edge-slowdown, the 'vddmac'
> -			  must be specified. Table 1 lists the
> -			  supported edge-slowdown values for a given
> -			  'vddmac'.
> -			  Default value is 0%.
> -			  Ref: Table:1 - Edge rate change (below).
> -- vsc8531,led-[N]-mode	: LED mode. Specify how the LED[N] should behave.
> -			  N depends on the number of LEDs supported by a
> -			  PHY.
> -			  Allowed values are defined in
> -			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
> -			  Default values are VSC8531_LINK_1000_ACTIVITY (1),
> -			  VSC8531_LINK_100_ACTIVITY (2),
> -			  VSC8531_LINK_ACTIVITY (0) and
> -			  VSC8531_DUPLEX_COLLISION (8).
> -- load-save-gpios	: GPIO used for the load/save operation of the PTP
> -			  hardware clock (PHC).
> -
> -
> -Table: 1 - Edge rate change
> -----------------------------------------------------------------|
> -| 		Edge Rate Change (VDDMAC)			|
> -|								|
> -| 3300 mV	2500 mV		1800 mV		1500 mV		|
> -|---------------------------------------------------------------|
> -| 0%		0%		0%		0%		|
> -| (Fastest)			(recommended)	(recommended)	|
> -|---------------------------------------------------------------|
> -| 2%		3%		5%		6%		|
> -|---------------------------------------------------------------|
> -| 4%		6%		9%		14%		|
> -|---------------------------------------------------------------|
> -| 7%		10%		16%		21%		|
> -|(recommended)	(recommended)					|
> -|---------------------------------------------------------------|
> -| 10%		14%		23%		29%		|
> -|---------------------------------------------------------------|
> -| 17%		23%		35%		42%		|
> -|---------------------------------------------------------------|
> -| 29%		37%		52%		58%		|
> -|---------------------------------------------------------------|
> -| 53%		63%		76%		77%		|
> -| (slowest)							|
> -|---------------------------------------------------------------|
> -
> -Example:
> -
> -        vsc8531_0: ethernet-phy@0 {
> -                compatible = "ethernet-phy-id0007.0570";
> -                vsc8531,vddmac		= <3300>;
> -                vsc8531,edge-slowdown	= <7>;
> -                vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
> -                vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
> -		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
> -        };
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
> new file mode 100644
> index 000000000000..60691309b6a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/mscc-phy-vsc8531.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsemi VSC8531 Gigabit Ethernet PHY
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  The VSC8531 is a Gigabit Ethernet PHY with configurable MAC interface
> +  drive strength and LED modes.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ethernet-phy-id0007.0570 # VSC8531
> +          - ethernet-phy-id0007.0772 # VSC8541
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ethernet-phy-id0007.0570 # VSC8531
> +          - ethernet-phy-id0007.0772 # VSC8541
> +      - const: ethernet-phy-ieee802.3-c22
> +
> +  vsc8531,vddmac:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The VDDMAC voltage in millivolts. This property is used in combination
> +      with the edge-slowdown property to control the drive strength of the
> +      MAC interface output signals.
> +    enum: [3300, 2500, 1800, 1500]
> +    default: 3300
> +
> +  vsc8531,edge-slowdown:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:

Use '>' if you have formatting.

> +      Percentage by which the edge rate should be slowed down relative to
> +      the fastest possible edge time. This setting helps reduce electromagnetic
> +      interference (EMI) by adjusting the drive strength of the MAC interface
> +      output signals. Valid values depend on the vddmac voltage setting
> +      according to the edge rate change table in the datasheet.
> +      For vddmac=3300mV valid values are 0, 2, 4, 7, 10, 17, 29, 53. (7 recommended)
> +      For vddmac=2500mV valid values are 0, 3, 6, 10, 14, 23, 37, 63. (10 recommended)
> +      For vddmac=1800mV valid values are 0, 5, 9, 16, 23, 35, 52, 76. (0 recommended)
> +      For vddmac=1500mV valid values are 0, 6, 14, 21, 29, 42, 58, 77. (0 recommended)

Indent lists by 2 more spaces and a blank line before.

> +    enum: [0, 2, 3, 4, 5, 6, 7, 9, 10, 14, 16, 17, 21, 23, 29, 35, 37, 42, 52, 53, 58, 63, 76, 77]
> +    default: 0
> +
> +  vsc8531,led-0-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: LED[0] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
> +      for available modes.
> +    minimum: 0
> +    maximum: 15
> +    default: 1
> +
> +  vsc8531,led-1-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: LED[1] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
> +      for available modes.
> +    minimum: 0
> +    maximum: 15
> +    default: 2
> +
> +  vsc8531,led-2-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: LED[2] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
> +      for available modes.
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  vsc8531,led-3-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: LED[3] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
> +      for available modes.
> +    minimum: 0
> +    maximum: 15
> +    default: 8
> +
> +  load-save-gpios:
> +    description: GPIO phandle used for the load/save operation of the PTP hardware
> +      clock (PHC).
> +    maxItems: 1
> +
> +dependencies:
> +  vsc8531,edge-slowdown: [ vsc8531,vddmac ]

You either need quotes on 'vsc8531,vddmac' or use this style:

vsc8531,edge-slowdown:
  - vsc8531,vddmac

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/net/mscc-phy-vsc8531.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@0 {
> +            compatible = "ethernet-phy-id0007.0772", "ethernet-phy-ieee802.3-c22";
> +            reg = <0>;
> +            vsc8531,vddmac = <3300>;
> +            vsc8531,edge-slowdown = <7>;
> +            vsc8531,led-0-mode = <VSC8531_LINK_1000_ACTIVITY>;
> +            vsc8531,led-1-mode = <VSC8531_LINK_100_ACTIVITY>;
> +            load-save-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 54ba517d7e79..1af57177a747 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -20,7 +20,7 @@ patternProperties:
>    "^(keypad|m25p|max8952|max8997|max8998|mpmc),.*": true
>    "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
>    "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
> -  "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
> +  "^(simple-audio-card|st-plgpio|st-spics|ts|vsc8531),.*": true
>    "^pool[0-3],.*": true
>  
>    # Keep list in alphabetical order.
> -- 
> 2.43.0
> 


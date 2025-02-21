Return-Path: <netdev+bounces-168697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E2A40385
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D993A355C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970420A5EE;
	Fri, 21 Feb 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxXzFf/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2251E282D;
	Fri, 21 Feb 2025 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180926; cv=none; b=rrNmpEmgjqcJL7+XAqKBWtsMxm8FJ6ZlbOhRiACuDUTXJvSF9KZYE3ZdImAAJXu3g6BMs1soj/CYO7Y9hb1hckti1ljq5h2cn/ccwaIPq6xhbxzzfWwpeauzGteFJh95d/0uXU6/CNfUTHIN4iW426EczLsIhhgAP9c9ysFeKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180926; c=relaxed/simple;
	bh=2BXKvKN+NIlL2XxsOK9qTOUnB+5mVH/ECw+o7ix1FKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjOBGJK/uqToEKy+mHB2uJ/IkYoViyeZvyhe51xEPxCx/3M0AIx6v/dQiBfVdk/6Tu1HjG7ChK+6FPC7gPhNOuUnuXRHg5ptqXV1OuD7iRZVhnJsie4EqZpmwS9C0OTcWdcveN2nKTkD50XnlpVXXe/uLEZ9RvulqCgQOYsRw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxXzFf/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603C0C4CED6;
	Fri, 21 Feb 2025 23:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740180925;
	bh=2BXKvKN+NIlL2XxsOK9qTOUnB+5mVH/ECw+o7ix1FKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxXzFf/WX6xRDeNHibxGerQWt1dEOSTG3Nu3jp/+6YQnfjyu018nm0c13MnMHktAt
	 egjEaJtffukq50v46M1QiY1rW/Vkj8VL1bD3ZUo9M6C3F9FCbNaB1S31R00D5+rZ9U
	 chv7bURqh63DS1FIQkfc+jxQCR5YTSioZq/wkQX+u9lt21rE9VmSAfyMsVLZl2g1FN
	 KB2XTuXJMO5yXhfn+xp8RBdCxgGHeqe79DtQgi5eiXpsUQhXUn140sKwJHbiQfTfOK
	 OXmb6LC+clATkAgLsd6fHriaL0tf0gGGmFGPIfgbAAjimWbQ9EnaiN8mNk4DotSw4w
	 YG2cwQX4Xi0Yw==
Date: Fri, 21 Feb 2025 17:35:23 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
Message-ID: <20250221233523.GA372501-robh@kernel.org>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>

On Thu, Feb 20, 2025 at 06:29:23PM +0100, J. Neuschäfer wrote:
> Add a binding for the "Gianfar" ethernet controller, also known as
> TSEC/eTSEC.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/net/fsl,gianfar.yaml       | 242 +++++++++++++++++++++
>  .../devicetree/bindings/net/fsl-tsec-phy.txt       |  39 +---
>  2 files changed, 243 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,gianfar.yaml b/Documentation/devicetree/bindings/net/fsl,gianfar.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..dc75ceb5dc6fdee8765bb17273f394d01cce0710
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,gianfar.yaml
> @@ -0,0 +1,242 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,gianfar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Three-Speed Ethernet Controller (TSEC), "Gianfar"
> +
> +maintainers:
> +  - J. Neuschäfer <j.ne@posteo.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - gianfar
> +      - fsl,etsec2
> +
> +  device_type:
> +    const: network
> +
> +  model:
> +    enum:
> +      - FEC
> +      - TSEC
> +      - eTSEC
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  "#address-cells": true

enum: [ 1, 2 ]

because 3 is not valid here.

> +
> +  "#size-cells": true

enum: [ 1, 2 ]

because 0 is not valid here.


> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  interrupts:
> +    maxItems: 3

Based on the if/then schema, you need 'minItems' here if the min is not 
3.

Really, move the descriptions here and make them work for the combined 
interrupt case (just a guess).

> +
> +  dma-coherent:
> +    type: boolean

dma-coherent: true

> +
> +  fsl,magic-packet:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, indicates that the hardware supports waking up via magic packet.
> +
> +  fsl,wake-on-filer:
> +    type: boolean
> +    description:
> +      If present, indicates that the hardware supports waking up by Filer
> +      General Purpose Interrupt (FGPI) asserted on the Rx int line. This is
> +      an advanced power management capability allowing certain packet types
> +      (user) defined by filer rules to wake up the system.
> +
> +  bd-stash:
> +    type: boolean
> +    description:
> +      If present, indicates that the hardware supports stashing buffer
> +      descriptors in the L2.
> +
> +  rx-stash-len:
> +    type: boolean
> +    description:
> +      Denotes the number of bytes of a received buffer to stash in the L2.
> +
> +  tx-stash-len:
> +    type: boolean
> +    description:
> +      Denotes the index of the first byte from the received buffer to stash in
> +      the L2.
> +
> +  fsl,num_rx_queues:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Number of receive queues

Constraints? I assume there's at least more than 0.

> +
> +  fsl,num_tx_queues:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Number of transmit queues

Constraints?

> +
> +  tbi-handle:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference (phandle) to the TBI node
> +
> +required:
> +  - compatible
> +  - model
> +
> +patternProperties:
> +  "^mdio@[0-9a-f]+$":
> +    type: object
> +    # TODO: reference to gianfar MDIO binding
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +  # compatible = "gianfar" requires device_type = "network"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: gianfar
> +    then:
> +      required:
> +        - device_type
> +
> +  # eTSEC2 controller nodes have "queue group" subnodes and don't need a "reg"
> +  # property.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,etsec2
> +    then:
> +      patternProperties:
> +        "^queue-group@[0-9a-f]+$":
> +          type: object
> +
> +          properties:
> +            "#address-cells": true
> +
> +            "#size-cells": true

These have no effect if there are not child nodes or a 'ranges' 
property.

> +
> +            reg:
> +              maxItems: 1
> +
> +            interrupts:
> +              maxItems: 3

Need to define what each one is.

> +
> +          required:
> +            - reg
> +            - interrupts
> +
> +          additionalProperties: false
> +    else:
> +      required:
> +        - reg
> +
> +  # TSEC and eTSEC devices require three interrupts
> +  - if:
> +      properties:
> +        model:
> +          contains:
> +            enum: [ TSEC, eTSEC ]
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: Transmit interrupt
> +            - description: Receive interrupt
> +            - description: Error interrupt
> +
> +
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet@24000 {
> +        device_type = "network";
> +        model = "TSEC";
> +        compatible = "gianfar";
> +        reg = <0x24000 0x1000>;
> +        local-mac-address = [ 00 E0 0C 00 73 00 ];
> +        interrupts = <29 2>, <30 2>, <34 2>;
> +        interrupt-parent = <&mpic>;
> +        phy-handle = <&phy0>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc1 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;

You don't need the soc1 node.

> +
> +        ethernet@24000 {
> +            compatible = "gianfar";
> +            reg = <0x24000 0x1000>;
> +            ranges = <0x0 0x24000 0x1000>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            cell-index = <0>;
> +            device_type = "network";
> +            model = "eTSEC";
> +            local-mac-address = [ 00 00 00 00 00 00 ];
> +            interrupts = <32 IRQ_TYPE_LEVEL_LOW>,
> +                         <33 IRQ_TYPE_LEVEL_LOW>,
> +                         <34 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-parent = <&ipic>;
> +
> +            mdio@520 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                compatible = "fsl,gianfar-mdio";
> +                reg = <0x520 0x20>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc2 {

bus {

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        ethernet {
> +            compatible = "fsl,etsec2";
> +            ranges;
> +            device_type = "network";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            interrupt-parent = <&gic>;
> +            model = "eTSEC";
> +            fsl,magic-packet;
> +            dma-coherent;
> +
> +            queue-group@2d10000 {
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                reg = <0x0 0x2d10000 0x0 0x1000>;
> +                interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +            };
> +
> +            queue-group@2d14000  {
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                reg = <0x0 0x2d14000 0x0 0x1000>;
> +                interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
> +            };
> +        };
> +    };
> +
> +...


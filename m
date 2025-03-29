Return-Path: <netdev+bounces-178188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C5A75746
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD17E168F20
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD0F149C55;
	Sat, 29 Mar 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2e1lVzE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89B134B0;
	Sat, 29 Mar 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743268178; cv=none; b=N8hhCqRPnCTCVXXIoiXA4o4/9lTAoO8tluJA/mltEXDLdE/Y0xCI0gzqdk9zreFQFPRgF2ept2ivOLofsmY35Ls61claYUzW+IhBIiOnDrkpr3ZP5vrZUao2GRtgSNkURdvNQo5o40gz1Jdyl2qK9Mkzdk7XTfDhov4dgwf+2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743268178; c=relaxed/simple;
	bh=Yrw919Z8v9sEOEODycWBG0VcN6JIS2JIx7r8X2SNbqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afm+7GbCCdgHg55C6hYkxuQ0KHWDT6cOvF4lK9maGgKi6SaqoCtwBcguUmuuTvZ9GMHVe7OPhQXXgvvA5RwbUyW4FxyhbB1rt7mU6Hb9LssYGy8M8KIRTqau1eFcYuH4BywjEWdS+O5qjuSI9tzJQga2xRJ1XKCHjRIOlEgjz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2e1lVzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620FFC4CEE2;
	Sat, 29 Mar 2025 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743268177;
	bh=Yrw919Z8v9sEOEODycWBG0VcN6JIS2JIx7r8X2SNbqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2e1lVzEIvqf8lTsrBOSozuxtbCArwAs8UQRY23wwkrO922x4WOT97/YmYE1kBx1h
	 hrVMXalk0q6ylxGuY63GwGj7vkUCTafxVvG+KXeW0+LpkmXoXfAPjdw+ZqHFaFbS/m
	 p0km9gIq2073Orqk0UMuOroc/9WQi1mZFq8RtD1mPY76N3y4LD4uk1PUmOGCIMGkoS
	 U/bt8VATBZu9+hSBrfVxZ0zG9WASaNewvAakSIzZ13y2Dzu1j5r4WEwL1gdY7Asa1y
	 Xe/km4URkWd6FU13FL6jv4jaXkN5+sKt5bUpMlooiEHVVLugz7mmuJ7G1vnvOMnLbS
	 xUONiztU+GCmA==
Date: Sat, 29 Mar 2025 12:09:36 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <20250329170936.GA2246988-robh@kernel.org>
References: <20250328133544.4149716-1-lukma@denx.de>
 <20250328133544.4149716-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328133544.4149716-2-lukma@denx.de>

On Fri, Mar 28, 2025 at 02:35:41PM +0100, Lukasz Majewski wrote:
> This patch provides description of the MTIP L2 switch available in some
> NXP's SOCs - e.g. imx287.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Rename the file to match exactly the compatible
>   (nxp,imx287-mtip-switch)
> ---
>  .../bindings/net/nxp,imx287-mtip-switch.yaml  | 165 ++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> new file mode 100644
> index 000000000000..a3e0fe7783ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nxp,imx287-mtip-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP switch)
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +description:
> +  The 2-port switch ethernet subsystem provides ethernet packet (L2)
> +  communication and can be configured as an ethernet switch. It provides the
> +  reduced media independent interface (RMII), the management data input
> +  output (MDIO) for physical layer device (PHY) management.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx287-mtip--switch
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      The physical base address and size of the MTIP L2 SW module IO range
> +
> +  phy-supply:
> +    description:
> +      Regulator that powers Ethernet PHYs.
> +
> +  clocks:
> +    items:
> +      - description: Register accessing clock
> +      - description: Bus access clock
> +      - description: Output clock for external device - e.g. PHY source clock
> +      - description: IEEE1588 timer clock
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: ahb
> +      - const: enet_out
> +      - const: ptp
> +
> +  interrupts:
> +    items:
> +      - description: Switch interrupt
> +      - description: ENET0 interrupt
> +      - description: ENET1 interrupt
> +
> +  pinctrl-names: true
> +
> +  ethernet-ports:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^port@[0-9]+$":
> +        type: object
> +        description: MTIP L2 switch external ports
> +
> +        $ref: ethernet-controller.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            items:
> +              - enum: [1, 2]
> +            description: MTIP L2 switch port number
> +
> +          label:
> +            description: Label associated with this port
> +
> +        required:
> +          - reg
> +          - label
> +          - phy-mode
> +          - phy-handle
> +
> +  mdio:
> +    type: object
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Specifies the mdio bus in the switch, used as a container for phy nodes.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - mdio
> +  - ethernet-ports
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include<dt-bindings/interrupt-controller/irq.h>
> +    switch@800f0000 {
> +        compatible = "nxp,imx287-mtip-switch";
> +        reg = <0x800f0000 0x20000>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
> +        phy-supply = <&reg_fec_3v3>;
> +        interrupts = <100>, <101>, <102>;
> +        clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
> +        clock-names = "ipg", "ahb", "enet_out", "ptp";
> +        status = "okay";
> +
> +        ethernet-ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                mtip_port1: port@1 {
> +                        reg = <1>;
> +                        label = "lan0";
> +                        local-mac-address = [ 00 00 00 00 00 00 ];
> +                        phy-mode = "rmii";
> +                        phy-handle = <&ethphy0>;
> +                };
> +
> +                mtip_port2: port@2 {
> +                        reg = <2>;
> +                        label = "lan1";
> +                        local-mac-address = [ 00 00 00 00 00 00 ];
> +                        phy-mode = "rmii";
> +                        phy-handle = <&ethphy1>;
> +                };
> +        };
> +
> +        mdio_sw: mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                reset-gpios = <&gpio2 13 0>;
> +                reset-delay-us = <25000>;
> +                reset-post-delay-us = <10000>;
> +
> +                ethphy0: ethernet-phy@0 {
> +                        reg = <0>;
> +                        smsc,disable-energy-detect;

With a custom property, you should have a specific compatible.

> +                        /* Both PHYs (i.e. 0,1) have the same, single GPIO, */
> +                        /* line to handle both, their interrupts (AND'ed) */
> +                        interrupt-parent = <&gpio4>;
> +                        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;

The error report is because the examples have to guess the number of 
provider interrupt cells and only 1 guess is supported. It guessed 1 
from above.

In any case, unless the phys are built-in and fixed, they are out of 
scope of this binding. So perhaps drop the interrupts and smsc property.

Rob


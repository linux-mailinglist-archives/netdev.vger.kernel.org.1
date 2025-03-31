Return-Path: <netdev+bounces-178462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E4AA77190
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AEB7A18C9
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482B21C9E5;
	Mon, 31 Mar 2025 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHDDz8SV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA93232;
	Mon, 31 Mar 2025 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465321; cv=none; b=hqOnaxti7GI71CbbrMRJWiM7diERrJZ0RYtFgpEyVV1Q62RtR6+muQ8pKN7sG8qcwoKCyezwVZCAL/4bevYRwbVUdCzsjewIDqKW32JQDYeh4d5ZmPnoddmxvJcIXUJA8yi0hVYUKR/epFydfwKBsDGFqWDGqbYdEhrCGGjj9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465321; c=relaxed/simple;
	bh=JdSp6kFwin/i7mnHMSnOd2RVt7VK6HD80ILiGQo5gMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+Re9Zm9EKOJ8yDNjI/saf8s9N5R+chSfOzq6oJ3el9DvgTKwnAneNl+DtIGpnOs+//ZDBUMkb9CC6X8j9vBwIogJXNlJhDF5Xl0Iq7ZlScobRAp6txQ72kdj4507g8thhRJslOrdD8VDMfi8+JFtAKQrOK9rWkpnkIltEGUePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHDDz8SV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170D6C4CEE5;
	Mon, 31 Mar 2025 23:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743465319;
	bh=JdSp6kFwin/i7mnHMSnOd2RVt7VK6HD80ILiGQo5gMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHDDz8SV6vszt08Lsqy5BvxReOYcxncujzPlqWcLXpmrKq4mH6nWeyEuvG/HXcRxn
	 t6XFFVMrBl3/M8xPDsKJXzYXf7nnbkJoLbFTb4mNRwiI6kthHlNRYa5w5hTTlYiNuT
	 IXpqa2XqGn2F54BmhW/mNrjWo1ORYcD4M1u7JAYJji4bGrBGUEd5N2AJIkemzLjl/b
	 DrI+6sCxT1ifA3huldlmiP9CBE8nE4B1dyL6i1r0DzhFUUiTp5eygjyj7XRYmr0SZr
	 n4ITR6Jgf0EODRQA0bWOA4nHTGfgaAyN3kciceBQ04axLvArnH+xu4MrCkAsm1caNZ
	 OsFWB1/AW004Q==
Date: Mon, 31 Mar 2025 18:55:18 -0500
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
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <20250331235518.GA2823373-robh@kernel.org>
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331103116.2223899-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331103116.2223899-2-lukma@denx.de>

On Mon, Mar 31, 2025 at 12:31:13PM +0200, Lukasz Majewski wrote:
> This patch provides description of the MTIP L2 switch available in some
> NXP's SOCs - e.g. imx287.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Rename the file to match exactly the compatible
>   (nxp,imx287-mtip-switch)
> 
> Changes for v3:
> - Remove '-' from const:'nxp,imx287-mtip-switch'
> - Use '^port@[12]+$' for port patternProperties
> - Drop status = "okay";
> - Provide proper indentation for 'example' binding (replace 8
>   spaces with 4 spaces)
> - Remove smsc,disable-energy-detect; property
> - Remove interrupt-parent and interrupts properties as not required
> - Remove #address-cells and #size-cells from required properties check
> - remove description from reg:
> - Add $ref: ethernet-switch.yaml#
> ---
>  .../bindings/net/nxp,imx287-mtip-switch.yaml  | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> new file mode 100644
> index 000000000000..98eba3665f32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> @@ -0,0 +1,154 @@
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
> +$ref: ethernet-switch.yaml#

This needs to be: ethernet-switch.yaml#/$defs/ethernet-ports

With that, you can drop much of the below part. More below...

> +
> +properties:
> +  compatible:
> +    const: nxp,imx287-mtip-switch
> +
> +  reg:
> +    maxItems: 1
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
> +      '^port@[12]+$':

Note that 'ethernet-port' is the preferred node name though 'port' is 
allowed.

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

All the above under 'ethernet-ports' can be dropped though you might 
want to keep 'required' part.

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
> +
> +        ethernet-ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            mtip_port1: port@1 {
> +                reg = <1>;
> +                label = "lan0";
> +                local-mac-address = [ 00 00 00 00 00 00 ];
> +                phy-mode = "rmii";
> +                phy-handle = <&ethphy0>;
> +            };
> +
> +            mtip_port2: port@2 {
> +                reg = <2>;
> +                label = "lan1";
> +                local-mac-address = [ 00 00 00 00 00 00 ];
> +                phy-mode = "rmii";
> +                phy-handle = <&ethphy1>;
> +            };
> +        };
> +
> +        mdio_sw: mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            reset-gpios = <&gpio2 13 0>;
> +            reset-delay-us = <25000>;
> +            reset-post-delay-us = <10000>;
> +
> +            ethphy0: ethernet-phy@0 {
> +                reg = <0>;
> +            };
> +
> +            ethphy1: ethernet-phy@1 {
> +                reg = <1>;
> +            };
> +        };
> +    };
> -- 
> 2.39.5
> 


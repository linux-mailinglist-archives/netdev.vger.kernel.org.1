Return-Path: <netdev+bounces-167909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33FDA3CCA5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C2D1896F4F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A2625B678;
	Wed, 19 Feb 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvbsmTmn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A725B677;
	Wed, 19 Feb 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005492; cv=none; b=oSGurg4jZX1DjnFHZ8QjWFsOg+SQr9fdODoKGqVMfuMRr+5KLFVr0ThFlRRomAoVRC1tn/evSYUrgjyNl0MPV78hs2okzMq08fyo8pY9jIK3b/oew9Ub+hoIEYxP0APUc47BEvPwTxRyQyWzcT5pEZqlARI2nX3Wh57NQWGvz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005492; c=relaxed/simple;
	bh=Zap5Q8U3NvRKtb3BaBHfuppCFF0CLTTHqKU72qwaZsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogUOD4Bzsye1lvRiJnNQrUXlA7XTn0/JMqECL2j1fr+Xw8wZbSlpnD1lxKh86L4BHDKAi/9PHzoQduCD7EalaInB/7D+vJZhxWM1zWs0Usa6Ul2PklqcwXFJm0nWEQ2NluXwGEEC8ZU/SG4yUj00Wshaxs6OBpNWt1rUyOJ+B0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvbsmTmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB46C4CEE0;
	Wed, 19 Feb 2025 22:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005491;
	bh=Zap5Q8U3NvRKtb3BaBHfuppCFF0CLTTHqKU72qwaZsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvbsmTmnxNCQXIi1inbOFUgaaN81cUz6TwXcxsWnkeDgCOs0z4Y9oAU2/Cdrfagps
	 EerMR9+63F0qq0vWB6DuHa9VKDLb5rnyDBiNUZV39NWqbpovjicoc1/Gzs/riaF8l2
	 ivGBNGVjePqpsifZ5Jo/bwl//G2Ivh0TA0vgmDLFcgs4xO88LJIXM3K2/Ko9ODsf3J
	 GsHeQD2rrJkKfWW4IevWWgenNnsgwUHQEEn5yS80DWicP9oksB1CghzFR/lMkZQmFv
	 p2QAEyKjMrRQ+vpe2Du6Ws+DtSjs89Vic/9YS7PuGlyo1cShX79ADtV5T56lybk6pz
	 CFnpN2seZuhKg==
Date: Wed, 19 Feb 2025 16:51:30 -0600
From: Rob Herring <robh@kernel.org>
To: parvathi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	nm@ti.com, ssantosh@kernel.org, richardcochran@gmail.com,
	basharath@couthit.com, schnelle@linux.ibm.com,
	diogo.ivo@siemens.com, m-karicheri2@ti.com, horms@kernel.org,
	jacob.e.keller@intel.com, m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com, afd@ti.com, s-anna@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
	srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v3 01/10] dt-bindings: net: ti: Adds DUAL-EMAC
 mode support on PRU-ICSS2 for AM57xx SOCs
Message-ID: <20250219225130.GA3107198-robh@kernel.org>
References: <20250214054702.1073139-1-parvathi@couthit.com>
 <20250214054702.1073139-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214054702.1073139-2-parvathi@couthit.com>

On Fri, Feb 14, 2025 at 11:16:53AM +0530, parvathi wrote:
> From: Parvathi Pudi <parvathi@couthit.com>
> 
> Documentation update for the newly added "pruss2_eth" device tree
> node and its dependencies along with compatibility for PRU-ICSS
> Industrial Ethernet Peripheral (IEP), PRU-ICSS Enhanced Capture
> (eCAP) peripheral and using YAML binding document for AM57xx SoCs.
> 
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>

The sender of the patch S-o-b goes last. And maybe you want a 
Co-developed-by tag here too?

> ---
>  .../devicetree/bindings/net/ti,icss-iep.yaml  |   4 +-
>  .../bindings/net/ti,icssm-prueth.yaml         | 147 ++++++++++++++++++
>  .../bindings/net/ti,pruss-ecap.yaml           |  32 ++++
>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   9 ++
>  4 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> index e36e3a622904..858d74638167 100644
> --- a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> @@ -8,6 +8,8 @@ title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
>  
>  maintainers:
>    - Md Danish Anwar <danishanwar@ti.com>
> +  - Parvathi Pudi <parvathi@couthit.com>
> +  - Basharath Hussain Khaja <basharath@couthit.com>
>  
>  properties:
>    compatible:
> @@ -19,7 +21,7 @@ properties:
>            - const: ti,am654-icss-iep
>  
>        - const: ti,am654-icss-iep
> -
> +      - const: ti,am5728-icss-iep

Use enum adding to the prior entry.

>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> new file mode 100644
> index 000000000000..1dffa6bd7a88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,icssm-prueth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ICSSM PRUSS Ethernet
> +
> +maintainers:
> +  - Roger Quadros <rogerq@ti.com>
> +  - Andrew F. Davis <afd@ti.com>
> +  - Parvathi Pudi <parvathi@couthit.com>
> +  - Basharath Hussain Khaja <basharath@couthit.com>
> +
> +description:
> +  Ethernet based on the Programmable Real-Time Unit and Industrial
> +  Communication Subsystem.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,am57-prueth     # for AM57x SoC family
> +
> +  sram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to OCMC SRAM node
> +
> +  ti,mii-rt:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to MII_RT module's syscon regmap
> +
> +  ti,iep:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSS
> +
> +  ti,ecap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to Enhanced Capture (eCAP) event for ICSS
> +
> +  interrupts:
> +    items:
> +      - description: High priority Rx Interrupt specifier.
> +      - description: Low priority Rx Interrupt specifier.
> +
> +  interrupt-names:
> +    items:
> +      - const: rx_hp
> +      - const: rx_lp
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
> +      ^ethernet-port@[0-1]$:
> +        type: object
> +        description: ICSSM PRUETH external ports
> +        $ref: ethernet-controller.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            items:
> +              - enum: [0, 1]
> +            description: ICSSM PRUETH port number
> +
> +          interrupts:
> +            maxItems: 3
> +
> +          interrupt-names:
> +            items:
> +              - const: rx
> +              - const: emac_ptp_tx
> +              - const: hsr_ptp_tx
> +
> +        required:
> +          - reg
> +
> +    anyOf:
> +      - required:
> +          - ethernet-port@0
> +      - required:
> +          - ethernet-port@1
> +
> +required:
> +  - compatible
> +  - sram
> +  - ti,mii-rt
> +  - ti,iep
> +  - ti,ecap
> +  - ethernet-ports
> +  - interrupts
> +  - interrupt-names
> +
> +allOf:
> +  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    /* Dual-MAC Ethernet application node on PRU-ICSS2 */
> +    pruss2_eth: pruss2-eth {

Drop unused labels.

> +      compatible = "ti,am57-prueth";
> +      ti,prus = <&pru2_0>, <&pru2_1>;
> +      sram = <&ocmcram1>;
> +      ti,mii-rt = <&pruss2_mii_rt>;
> +      ti,iep = <&pruss2_iep>;
> +      ti,ecap = <&pruss2_ecap>;
> +      interrupts = <20 2 2>, <21 3 3>;
> +      interrupt-names = "rx_hp", "rx_lp";
> +      interrupt-parent = <&pruss2_intc>;
> +
> +      ethernet-ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pruss2_emac0: ethernet-port@0 {
> +          reg = <0>;
> +          phy-handle = <&pruss2_eth0_phy>;
> +          phy-mode = "mii";
> +          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
> +          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
> +          /* Filled in by bootloader */
> +          local-mac-address = [00 00 00 00 00 00];
> +        };
> +
> +        pruss2_emac1: ethernet-port@1 {
> +          reg = <1>;
> +          phy-handle = <&pruss2_eth1_phy>;
> +          phy-mode = "mii";
> +          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
> +          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
> +          /* Filled in by bootloader */
> +          local-mac-address = [00 00 00 00 00 00];
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
> new file mode 100644
> index 000000000000..42f217099b2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,pruss-ecap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments PRU-ICSS Enhanced Capture (eCAP) event module
> +
> +maintainers:
> +  - Murali Karicheri <m-karicheri2@ti.com>
> +  - Parvathi Pudi <parvathi@couthit.com>
> +  - Basharath Hussain Khaja <basharath@couthit.com>
> +
> +properties:
> +  compatible:
> +    const: ti,pruss-ecap
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pruss2_ecap: ecap@30000 {
> +        compatible = "ti,pruss-ecap";
> +        reg = <0x30000 0x60>;
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> index 927b3200e29e..594f54264a8c 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> @@ -251,6 +251,15 @@ patternProperties:
>  
>      type: object
>  
> +  ecap@[a-f0-9]+$:
> +    description:
> +      PRU-ICSS has a Enhanced Capture (eCAP) event module which can generate
> +      and capture periodic timer based events which will be used for features
> +      like RX Pacing to rise interrupt when the timer event has occurred.
> +      Each PRU-ICSS instance has one eCAP modeule irrespective of SOCs.
> +
> +    type: object
> +
>    mii-rt@[a-f0-9]+$:
>      description: |
>        Real-Time Ethernet to support multiple industrial communication protocols.
> -- 
> 2.34.1
> 


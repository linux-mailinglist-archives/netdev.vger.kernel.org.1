Return-Path: <netdev+bounces-102585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFF903D4A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016461C2443B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D05F17CA0D;
	Tue, 11 Jun 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUG6kue0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322B17BB35;
	Tue, 11 Jun 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112451; cv=none; b=P1v9juTObHGhRrdmO9wQ9ogv30rIKCmjLXona2yPcpcRetT2Hn+R5TaXXbeYmbWGJMbwcG/CkqBAfqdw3OWPh5yVM7wXIBplraV4TAkSLpQP/at7ZHELofnFnQSdQ+qEBsds3w17U03U6EZ5KG9M5WPWSKC3btRGaaafg3wrA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112451; c=relaxed/simple;
	bh=OpC7I0pSsrw6fQRy+mUwVbIxCCVWBNYcad1O/OpGWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuZCzNZDbI6xJRwCxsgEgx/IWj8yKNVZao4iMtIWxBOR7U/ed2PuOiVqsWfHqODkpWtuPTelEGCeri8gezQAJad09u+3kmyiQT8jREzbQ6902Prks3h1vgbt8cwlMG1yORqnabQqGJSXKV2o7FXabeR2+Jb/5++kqCscOKEPO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUG6kue0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A25C2BD10;
	Tue, 11 Jun 2024 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718112451;
	bh=OpC7I0pSsrw6fQRy+mUwVbIxCCVWBNYcad1O/OpGWv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUG6kue0JFzAKfk/uqYXytKGlY66YsSebCAyhpvK4Or93SzhEAswUxxijEUHrNa+q
	 gXKmypZTb+Fifpt8NbHDyVUZvNzDmaMBc75jXv1b0oJQQ7XAokiXTnq0Suktrcz8B6
	 VJoFEgRytT+2jqDWtvVxHD4QuL4PiDZY0i6Ug1S1CyvJsInPOkt1h+I/CXdTMe7iW9
	 LsfV7dnsY8JyiMfbXO3HEMeXgrPSYbRXmU+yQ7lU3g6X+/mYMcl0VRpifhtcWFZJwN
	 5O5wEftb5DCDZndQhzxl8j10d2n14gjHkmd5FxoIYEhcOHT/btQmlDRHlcPOH5kjdU
	 KXlz/NUaHVF3w==
Date: Tue, 11 Jun 2024 07:27:30 -0600
From: Rob Herring <robh@kernel.org>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/13] dt-bindings: net: dsa: lantiq,gswip:
 convert to YAML schema
Message-ID: <20240611132730.GA1683993-robh@kernel.org>
References: <20240611114027.3136405-1-ms@dev.tdt.de>
 <20240611114027.3136405-2-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611114027.3136405-2-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 01:40:15PM +0200, Martin Schiller wrote:
> Convert the lantiq,gswip bindings to YAML format.
> 
> Also add this new file to the MAINTAINERS file.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 195 ++++++++++++++++++
>  .../bindings/net/dsa/lantiq-gswip.txt         | 146 -------------
>  MAINTAINERS                                   |   1 +
>  3 files changed, 196 insertions(+), 146 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> new file mode 100644
> index 000000000000..14ef48d6a0ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -0,0 +1,195 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lantiq GSWIP Ethernet switches
> +
> +allOf:
> +  - $ref: dsa.yaml#/$defs/ethernet-ports
> +
> +maintainers:
> +  - Hauke Mehrtens <hauke@hauke-m.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lantiq,xrx200-gswip
> +      - lantiq,xrx300-gswip
> +      - lantiq,xrx330-gswip
> +
> +  reg:
> +    minItems: 3
> +    maxItems: 3

blank line

> +  reg-names:
> +    items:
> +      - const: switch
> +      - const: mdio
> +      - const: mii
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      compatible:
> +        const: lantiq,xrx200-mdio
> +
> +    required:
> +      - compatible
> +
> +  gphy-fw:
> +    type: object
> +    properties:
> +      '#address-cells':
> +        const: 1

blank line

> +      '#size-cells':
> +        const: 0
> +
> +      compatible:
> +        allOf:

Don't need allOf.

> +          - items:
> +              - enum:
> +                  - lantiq,xrx200-gphy-fw
> +                  - lantiq,xrx300-gphy-fw
> +                  - lantiq,xrx330-gphy-fw
> +              - const: lantiq,gphy-fw
> +
> +      lantiq,rcu:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to the RCU syscon
> +
> +    patternProperties:
> +      "^gphy@[0-9a-f]+$":

"^gphy@[0-9a-f]{1,2]$"

> +        type: object
> +
> +        properties:
> +          reg:
> +            minimum: 0
> +            maximum: 255
> +            description:
> +              Offset of the GPHY firmware register in the RCU register range
> +
> +          resets:
> +            items:
> +              - description: GPHY reset line
> +
> +          reset-names:
> +            items:
> +              - const: gphy
> +
> +        required:
> +          - reg
> +
> +        additionalProperties: false

For indented cases, it is preferred to put this before 'properties'.

> +
> +    required:
> +      - compatible
> +      - lantiq,rcu
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    switch@e108000 {
> +            compatible = "lantiq,xrx200-gswip";
> +            reg = <0xe108000 0x3100>,  /* switch */
> +                  <0xe10b100 0xd8>,    /* mdio */
> +                  <0xe10b1d8 0x130>;   /* mii */
> +            dsa,member = <0 0>;
> +
> +            ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                            reg = <0>;
> +                            label = "lan3";
> +                            phy-mode = "rgmii";
> +                            phy-handle = <&phy0>;
> +                    };
> +
> +                    port@1 {
> +                            reg = <1>;
> +                            label = "lan4";
> +                            phy-mode = "rgmii";
> +                            phy-handle = <&phy1>;
> +                    };
> +
> +                    port@2 {
> +                            reg = <2>;
> +                            label = "lan2";
> +                            phy-mode = "internal";
> +                            phy-handle = <&phy11>;
> +                    };
> +
> +                    port@4 {
> +                            reg = <4>;
> +                            label = "lan1";
> +                            phy-mode = "internal";
> +                            phy-handle = <&phy13>;
> +                    };
> +
> +                    port@5 {
> +                            reg = <5>;
> +                            label = "wan";
> +                            phy-mode = "rgmii";
> +                            phy-handle = <&phy5>;
> +                    };
> +
> +                    port@6 {
> +                            reg = <0x6>;
> +                            ethernet = <&eth0>;
> +                    };
> +            };
> +
> +            mdio {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    compatible = "lantiq,xrx200-mdio";
> +
> +                    phy0: ethernet-phy@0 {
> +                            reg = <0x0>;
> +                    };
> +                    phy1: ethernet-phy@1 {
> +                            reg = <0x1>;
> +                    };
> +                    phy5: ethernet-phy@5 {
> +                            reg = <0x5>;
> +                    };
> +                    phy11: ethernet-phy@11 {
> +                            reg = <0x11>;
> +                    };
> +                    phy13: ethernet-phy@13 {
> +                            reg = <0x13>;
> +                    };
> +            };
> +
> +            gphy-fw {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    compatible = "lantiq,xrx200-gphy-fw", "lantiq,gphy-fw";
> +                    lantiq,rcu = <&rcu0>;
> +
> +                    gphy@20 {
> +                            reg = <0x20>;
> +
> +                            resets = <&reset0 31 30>;
> +                            reset-names = "gphy";
> +                    };
> +
> +                    gphy@68 {
> +                            reg = <0x68>;
> +
> +                            resets = <&reset0 29 28>;
> +                            reset-names = "gphy";
> +                    };
> +            };
> +    };


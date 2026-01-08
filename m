Return-Path: <netdev+bounces-248247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFB6D05A79
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBDDB301711F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F82FFDEC;
	Thu,  8 Jan 2026 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5CiaR/K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D8230BCB;
	Thu,  8 Jan 2026 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898126; cv=none; b=MXhjVNjekNss9LraoNxp5E5JeULOJ2Ue1r3/68WpXBEP/VP3ngOmOgXqGRFOpamZvdpcI83s3RL9IwtpE1JOxfEmFIGudz8t5o59AgoyAlPk+Yk+w9fQV6DSUstUk0AfGRoeKGchOxMYyhpD3/BOLDUKUdY4rs7dRk5Qre4sX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898126; c=relaxed/simple;
	bh=iaKLxH1eWMLIWQCBMyurZPxJrCh6SelDIBA5lqfVKFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLZaPjq1q7QuYvJYWHvu5y6vXV/jr2dgkZl2bS+hizLnPd5OHE/oT9CUVkT5yCGyu15pvTUOH46KhxJ7SdKFbMiYpFlR3AwK0axn7zGtOxda/maXMZWkCm1O6VI5Dyv2PtJ8glxKeLwcZ2xfjkF22SQtyUzI7ieX9Q/8RyCy9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5CiaR/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E19C116C6;
	Thu,  8 Jan 2026 18:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767898126;
	bh=iaKLxH1eWMLIWQCBMyurZPxJrCh6SelDIBA5lqfVKFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5CiaR/KOo4BuHLVpDduKTti7k2pTbaFx5PSfaIKJqs+uz11Zzm+yg2Qsau2sQow8
	 EmSheYn6EX3jMXhx3kPigpazRhAvChWG5uEdBO4XDm1ziQpLnomt2mQSKaf5UBlKjz
	 3a+2q9vuc4HsXwQ8VEOrss93VYyGvwkWoJcjq04Ebaz3OFLXm14I/idUb/35gu1fm/
	 e85kQrMRgf/kh4z9Wshu6AwIQhcYKW5EM08EURrKCK2+0A5pY9mNU2quZnzN+rfhMX
	 CBVO9yQaasThvN1frLxLaMIfwj9Hz9Z1CC0/mFGkJR6xdQvtSQXXEMhUXgBWvXnzeY
	 JGAQUUE2rYgsQ==
Date: Thu, 8 Jan 2026 12:48:45 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <20260108184845.GA758009-robh@kernel.org>
References: <20260108125208.29940-1-eichest@gmail.com>
 <20260108125208.29940-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108125208.29940-2-eichest@gmail.com>

On Thu, Jan 08, 2026 at 01:51:27PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the devicetree bindings for the Micrel PHYs and switches to DT
> schema.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  .../devicetree/bindings/net/micrel.txt        |  57 --------
>  .../devicetree/bindings/net/micrel.yaml       | 133 ++++++++++++++++++
>  2 files changed, 133 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
>  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
> deleted file mode 100644
> index 01622ce58112..000000000000
> --- a/Documentation/devicetree/bindings/net/micrel.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -Micrel PHY properties.
> -
> -These properties cover the base properties Micrel PHYs.
> -
> -Optional properties:
> -
> - - micrel,led-mode : LED mode value to set for PHYs with configurable LEDs.
> -
> -	Configure the LED mode with single value. The list of PHYs and the
> -	bits that are currently supported:
> -
> -	KSZ8001: register 0x1e, bits 15..14
> -	KSZ8041: register 0x1e, bits 15..14
> -	KSZ8021: register 0x1f, bits 5..4
> -	KSZ8031: register 0x1f, bits 5..4
> -	KSZ8051: register 0x1f, bits 5..4
> -	KSZ8081: register 0x1f, bits 5..4
> -	KSZ8091: register 0x1f, bits 5..4
> -	LAN8814: register EP5.0, bit 6
> -
> -	See the respective PHY datasheet for the mode values.
> -
> - - micrel,rmii-reference-clock-select-25-mhz: RMII Reference Clock Select
> -						bit selects 25 MHz mode
> -
> -	Setting the RMII Reference Clock Select bit enables 25 MHz rather
> -	than 50 MHz clock mode.
> -
> -	Note that this option is only needed for certain PHY revisions with a
> -	non-standard, inverted function of this configuration bit.
> -	Specifically, a clock reference ("rmii-ref" below) is always needed to
> -	actually select a mode.
> -
> - - clocks, clock-names: contains clocks according to the common clock bindings.
> -
> -	supported clocks:
> -	- KSZ8021, KSZ8031, KSZ8081, KSZ8091: "rmii-ref": The RMII reference
> -	  input clock. Used to determine the XI input clock.
> -
> - - micrel,fiber-mode: If present the PHY is configured to operate in fiber mode
> -
> -	Some PHYs, such as the KSZ8041FTL variant, support fiber mode, enabled
> -	by the FXEN boot strapping pin. It can't be determined from the PHY
> -	registers whether the PHY is in fiber mode, so this boolean device tree
> -	property can be used to describe it.
> -
> -	In fiber mode, auto-negotiation is disabled and the PHY can only work in
> -	100base-fx (full and half duplex) modes.
> -
> - - coma-mode-gpios: If present the given gpio will be deasserted when the
> -		    PHY is probed.
> -
> -	Some PHYs have a COMA mode input pin which puts the PHY into
> -	isolate and power-down mode. On some boards this input is connected
> -	to a GPIO of the SoC.
> -
> -	Supported on the LAN8814.
> diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> new file mode 100644
> index 000000000000..52d1b187e1d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/micrel.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Micrel KSZ series PHYs and switches
> +
> +maintainers:
> +  - Andrew Lunn <andrew@lunn.ch>
> +  - Stefan Eichenberger <eichest@gmail.com>
> +
> +description:
> +  The Micrel KSZ series contains different network phys and switches.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ethernet-phy-id000e.7237  # KSZ8873MLL
> +      - ethernet-phy-id0022.1430  # KSZ886X
> +      - ethernet-phy-id0022.1435  # KSZ8863
> +      - ethernet-phy-id0022.1510  # KSZ8041
> +      - ethernet-phy-id0022.1537  # KSZ8041RNLI
> +      - ethernet-phy-id0022.1550  # KSZ8051
> +      - ethernet-phy-id0022.1555  # KSZ8021
> +      - ethernet-phy-id0022.1556  # KSZ8031
> +      - ethernet-phy-id0022.1560  # KSZ8081, KSZ8091
> +      - ethernet-phy-id0022.1570  # KSZ8061
> +      - ethernet-phy-id0022.161a  # KSZ8001
> +      - ethernet-phy-id0022.1720  # KS8737
> +
> +  micrel,fiber-mode:
> +    type: boolean
> +    description: |
> +      If present the PHY is configured to operate in fiber mode.
> +
> +      The KSZ8041FTL variant supports fiber mode, enabled by the FXEN
> +      boot strapping pin. It can't be determined from the PHY registers
> +      whether the PHY is in fiber mode, so this boolean device tree
> +      property can be used to describe it.
> +
> +      In fiber mode, auto-negotiation is disabled and the PHY can only
> +      work in 100base-fx (full and half duplex) modes.
> +
> +  micrel,led-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      LED mode value to set for PHYs with configurable LEDs.
> +
> +      Configure the LED mode with single value. The list of PHYs and the
> +      bits that are currently supported:
> +
> +      KSZ8001: register 0x1e, bits 15..14
> +      KSZ8041: register 0x1e, bits 15..14
> +      KSZ8021: register 0x1f, bits 5..4
> +      KSZ8031: register 0x1f, bits 5..4
> +      KSZ8051: register 0x1f, bits 5..4
> +      KSZ8081: register 0x1f, bits 5..4
> +      KSZ8091: register 0x1f, bits 5..4
> +
> +      See the respective PHY datasheet for the mode values.
> +    minimum: 0
> +    maximum: 3
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: ethernet-phy-id0022.1510
> +    then:
> +      properties:
> +        micrel,fiber-mode: false
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - ethernet-phy-id0022.1510
> +                - ethernet-phy-id0022.1555
> +                - ethernet-phy-id0022.1556
> +                - ethernet-phy-id0022.1550
> +                - ethernet-phy-id0022.1560
> +                - ethernet-phy-id0022.161a
> +    then:
> +      properties:
> +        micrel,led-mode: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ethernet-phy-id0022.1555
> +              - ethernet-phy-id0022.1556
> +              - ethernet-phy-id0022.1560
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1

This has no effect because ethernet-phy.yaml already defines this.

> +        clock-names:
> +          const: rmii-ref
> +          description:
> +            The RMII reference input clock. Used to determine the XI input
> +            clock.
> +        micrel,rmii-reference-clock-select-25-mhz:
> +          type: boolean
> +          description: |
> +            RMII Reference Clock Select bit selects 25 MHz mode
> +
> +            Setting the RMII Reference Clock Select bit enables 25 MHz rather
> +            than 50 MHz clock mode.

These should be defined at the top-level. Then use the if/then schema to 
disallow the properties.

> +
> +dependentRequired:
> +  micrel,rmii-reference-clock-select-25-mhz: [ clock-names ]
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@5 {
> +            compatible = "ethernet-phy-id0022.1510";
> +            reg = <5>;
> +            micrel,led-mode = <2>;
> +            micrel,fiber-mode;
> +        };
> +    };
> -- 
> 2.51.0
> 


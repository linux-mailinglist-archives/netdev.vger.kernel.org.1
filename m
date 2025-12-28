Return-Path: <netdev+bounces-246184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8FBCE51EC
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 16:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69973300A36D
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FD29A9F9;
	Sun, 28 Dec 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZus05Gt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4693BB40;
	Sun, 28 Dec 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766936171; cv=none; b=oBNazbZoFp/+SVsv4qYA2jZfCuE1uQLN4KYbNPtusrZ36kjEko1SyC5/crpmNl54ZwfGd3lCY85LP0yZkyvTDm7AWQYUinVlymh0kuverlkpMB2Ct6NspBPeedeE9qoYkHvCO6buooDGDPovn7+eHCd+EkNecq1wOVOkn2vWGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766936171; c=relaxed/simple;
	bh=tRKTQiWnt1XEYDzwoA8IJDDryekjMxsKq6xOlVxHhkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLUnDDAze2NgmtHRoXM6Cz7j6ERIm7jmO2qCg1o7cWcq2eaATX73r3L35NhBbtTN2cxdneIyr1OCyX1I/t45XeeJPCxUJDxryFJKku7QH9EeFXZktfbOhd9PsCRg8pEJAWAHV20/8z9Iv0c1vOgHGgHSqjZRIR2NQLd8MbbXhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZus05Gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F261C4CEFB;
	Sun, 28 Dec 2025 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766936170;
	bh=tRKTQiWnt1XEYDzwoA8IJDDryekjMxsKq6xOlVxHhkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZus05Gt0xze5D6k6Cf4oliWnX2lQ+Fr4SRuisfqXco7L/g1c0otppnuScHhWBIta
	 nnRIS63AkaywM3gxweaeposmrJfY9Xk0xR6U/M/hmlcrFzWmRN8Xylw3m500NC98n5
	 i0mHvJhNjwfi7anv1Y7Q3RyYq/jlmX7NcUljbezwFrqATQ7Y2EstpIJSbIct+rOacg
	 yqygAA3x3GOiH0s93X9OUheC/TPUD9KtM9TDKB6NeCU6gH0eYzUAZYeb6FGKapCE4t
	 3nP/u1pcWVj5ew94Gw6FtB1CXK9nj6pLssIFJNIFWIawQrSv0KBKEVWNcIu6hE70bD
	 jb+ZWpUSl/fNQ==
Date: Sun, 28 Dec 2025 09:36:09 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <20251228153609.GA2198936-robh@kernel.org>
References: <20251223133446.22401-1-eichest@gmail.com>
 <20251223133446.22401-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223133446.22401-2-eichest@gmail.com>

On Tue, Dec 23, 2025 at 02:33:39PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the devicetree bindings for the Micrel PHYs and switches to DT
> schema.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  .../devicetree/bindings/net/micrel.txt        |  57 --------
>  .../devicetree/bindings/net/micrel.yaml       | 132 ++++++++++++++++++
>  2 files changed, 132 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
>  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
> deleted file mode 100644
> index 01622ce58112e..0000000000000
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
> index 0000000000000..a8e532fbcb6f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> @@ -0,0 +1,132 @@
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
> +description: |

Don't need '|' if no formatting to preserve.

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

blank line

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

blank line

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
> +        clock-names:
> +          const: rmii-ref
> +          description: |
> +            supported clocks:

Drop this line.

> +              - The RMII reference input clock. Used to determine the XI
> +                input clock.
> +        micrel,rmii-reference-clock-select-25-mhz:
> +          type: boolean
> +          description: |
> +            RMII Reference Clock Select bit selects 25 MHz mode
> +
> +            Setting the RMII Reference Clock Select bit enables 25 MHz rather
> +            than 50 MHz clock mode.
> +
> +dependentRequired:
> +  micrel,rmii-reference-clock-select-25-mhz: [ clock-names ]
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet {
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


Return-Path: <netdev+bounces-240496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F338AC75C32
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id ECB593252F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9852E9EAD;
	Thu, 20 Nov 2025 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0Xd3qxc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59FF2E03F3;
	Thu, 20 Nov 2025 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659816; cv=none; b=ccqbCZ2UL7epEyOUHapF1Iagrx1oadKrrWIacIWJxMoDm/03ZGtg2vtAUEEVUWGMlUKnbQ3XSBjcrnSzzfvoWUqQgrJU+CtwYxGpdvRUivIVI+19E7sAx8E5yfXKSfRqwNGdSZbIX0JjlqGftOjXmuDuL3PNj6gyT6w2Uj9QjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659816; c=relaxed/simple;
	bh=pIZqPi/mXGe/GNfKv8c4XGgpFEpKm6p5bQCRorVwhsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuAylFBU2TdwHuxjzMpOe78mUHlu+7OaPA2fXL537bBEMRqgjqFUXTCYbBnIg98b5kzvBJqrazKRfsOSjAiDoDePforw7ditxkpFpTQqJFymDR5a7ZekBZDQZiHCLtTJ4Jovif+eOJRjhB9Tql10Wexx69BXxNPIvgW1Jsm7xjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0Xd3qxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F13C4CEF1;
	Thu, 20 Nov 2025 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763659814;
	bh=pIZqPi/mXGe/GNfKv8c4XGgpFEpKm6p5bQCRorVwhsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0Xd3qxcEOro3m2faDUanniB5vub6VASfuaAD38GMVZjvrAop5JSehVcv5wLs/lB7
	 6EVEyyAboRD+rfGyv0cFxwaxlGKMhUIr1LSHaRidO1wsS4Y0bT2X+7u0z8Ts0X/awU
	 tE+ya3+kswujHlhW/yokKfY+vTEXppX1wpFX4WG199/3UuAk7LIxfIBuAvXfXRth6/
	 qKedynzxUulcVVFKwZh7gIXmEU2pQqTOi7OeFVfFvObG6Xqers4eEto3XCtX4G7Jkz
	 wyLz6BS/lKHR8eQXlPFM244eSQMxRSYdHWvll4rbwNXWoz42ogUHL1X7eSQX7YZi6S
	 PcXadKpoxFMFg==
Date: Thu, 20 Nov 2025 11:30:12 -0600
From: Rob Herring <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 12/15] dt-bindings: net: dsa: sja1105: document
 the PCS nodes
Message-ID: <20251120173012.GA1563834-robh@kernel.org>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-13-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118190530.580267-13-vladimir.oltean@nxp.com>

On Tue, Nov 18, 2025 at 09:05:27PM +0200, Vladimir Oltean wrote:
> The XPCS blocks in NXP SJA1105 and SJA1110 may be described in the
> device tree, and they follow the same bindings as the other instances
> which are memory-mapped using an APB3 or MCI interface.
> 
> Document their compatible string, positioning in the switch's "regs"
> subnode, and the pcs-handle to them.
> 
> The "type: object" addition in the ethernet-port node is to suppress
> a dt_binding_check warning that states "node schemas must have a type
> or $ref". This is fine, but I don't completely understand why it started
> being required just now (apparently, the presence of "properties" under
> the port node affects this).

Yes. It's related to quirks in how json-schema works. You would think 
'properties' would require the instance to be an object, but no, such a 
schema defining properties would pass even for a boolean property. So 
requiring 'type: object' is necessary. In this case, we already do that 
elsewhere so it's not strictly needed here, but figuring that out is 
complicated.

> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../bindings/net/dsa/nxp,sja1105.yaml         | 28 +++++++++++++++++++
>  .../bindings/net/pcs/snps,dw-xpcs.yaml        |  8 ++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> index 607b7fe8d28e..ee1a95d6b032 100644
> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> @@ -85,11 +85,31 @@ properties:
>            - compatible
>            - reg
>  
> +  regs:
> +    type: object
> +    description:
> +      Optional container node for peripherals in the switch address space other
> +      than the switching IP itself. This node and its children only need to be
> +      described if board-specific properties need to be specified, like SerDes
> +      lane polarity inversion. If absent, default descriptions are used.
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 1
> +
> +    patternProperties:
> +      "^ethernet-pcs@[0-9a-f]+$":
> +        $ref: /schemas/net/pcs/snps,dw-xpcs.yaml#
> +
>  patternProperties:
>    "^(ethernet-)?ports$":
>      additionalProperties: true
>      patternProperties:
>        "^(ethernet-)?port@[0-9]$":
> +        type: object
>          allOf:
>            - if:
>                properties:
> @@ -107,6 +127,14 @@ patternProperties:
>                  tx-internal-delay-ps:
>                    $ref: "#/$defs/internal-delay-ps"
>  
> +        properties:
> +          pcs-handle:
> +            $ref: /schemas/types.yaml#/definitions/phandle

This already has a type, so drop the $ref.

> +            description:
> +              Phandle to a PCS device node from the "regs" container.
> +              Can be skipped if the PCS description is missing - in that case,
> +              the connection is implicit.
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> index e77eec9ac9ee..46e4f611f714 100644
> --- a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> +++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> @@ -25,6 +25,14 @@ description:
>  properties:
>    compatible:
>      oneOf:
> +      - description:
> +          Synopsys DesignWare XPCS in NXP SJA1105 switch (direct APB3 access
> +          via SPI) with custom PMA
> +        const: nxp,sja1105-pcs
> +      - description:
> +          Synopsys DesignWare XPCS in NXP SJA1110 switch (indirect APB3 access
> +          via SPI) with custom PMA
> +        const: nxp,sja1110-pcs
>        - description: Synopsys DesignWare XPCS with none or unknown PMA
>          const: snps,dw-xpcs
>        - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
> -- 
> 2.34.1
> 


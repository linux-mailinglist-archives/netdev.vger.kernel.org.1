Return-Path: <netdev+bounces-168620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8EBA3FBC3
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14813189ED31
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B511921149F;
	Fri, 21 Feb 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9oYJyXx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593C20012D;
	Fri, 21 Feb 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155813; cv=none; b=TZwh07ejTVZqeXt6axfYYBaoPVdfPuPpTXG2mgQQ/hYQpEf5qhfKvpI95CqQad+NEFuIe/OT8AqX/qaygakYKeXwirLcV9xmgEozqa5HxQ13eLlcfBpAb+6tpaLhUOwVdZ3idZsOc5DCAE7uYtH2uqGA9TyQsz9kDH+5QD8q3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155813; c=relaxed/simple;
	bh=h95P4AcDHTPKa8n4KBUFfHZ3f+SCiz2fCZdKlS89CWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrmXqh9OUOppoUq/cJIin2wdTUm99tnLRd8OI7qO4Kg6krdg6LtHlgpaQnno9zgh61XJs9lHKPdvxuYQ8fi9mGwp93mBVx9sxTxklmGCGoUXIS9TaS9/boZ6hvnxrYbjetu0terSCj0JAgMBcTaMkMtnsUew7r0xbaV169bLY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9oYJyXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ECBC4CED6;
	Fri, 21 Feb 2025 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740155812;
	bh=h95P4AcDHTPKa8n4KBUFfHZ3f+SCiz2fCZdKlS89CWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9oYJyXxX4MdcyAuOisFvnDlgwwDcb5BH5LlKs2wk8v2pCx9rLsEHijLRegH6EPqk
	 JXL/8iZapYZZXHInsOQ7/E4RY1RQ1PQ+qn5bHLm/FfUDNWG8dJgmHUBBM7SookSnfI
	 psfIYVIwviM2wIQf6YpMqnl4v5JZgjPF6lcYaFjWD0YA5P5fcqHfCQbE4kPNVdp0yw
	 JojTcAladLZDa8tVjXGYuOZjvAi3VQ8FDiEsQZq0Qq+9mKSo2/j964WTUOrDb0fdEj
	 W4rsSNAOZARO2kxwfFuvj5c9UN3ZA4MhNsfU/Aq+0jqXsgGG8/ek7G/G9WGWGAQS0z
	 cBU8TxvC3RQ3g==
Date: Fri, 21 Feb 2025 10:36:51 -0600
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
Subject: Re: [PATCH 1/3] dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to
 YAML
Message-ID: <20250221163651.GA4130188-robh@kernel.org>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-1-0ba97fd1ef92@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220-gianfar-yaml-v1-1-0ba97fd1ef92@posteo.net>

On Thu, Feb 20, 2025 at 06:29:21PM +0100, J. Neuschäfer wrote:
> Move the information related to the Freescale Gianfar (TSEC) MDIO bus
> and the Ten-Bit Interface (TBI) from fsl-tsec-phy.txt to a new binding
> file in YAML format, fsl,gianfar-mdio.yaml.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> dt-bindings: net: Convert fsl,gianfar-tbi to YAML
> ---
>  .../devicetree/bindings/net/fsl,gianfar-mdio.yaml  | 94 ++++++++++++++++++++++
>  .../devicetree/bindings/net/fsl-tsec-phy.txt       | 41 +---------
>  2 files changed, 96 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..2dade7f48c366b7f5c7408e1f7de1a6f5fc80787
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Gianfar (TSEC) MDIO Device
> +
> +description:
> +  This binding describes the MDIO is a bus to which the PHY devices are
> +  connected. For each device that exists on this bus, a child node should be
> +  created.
> +
> +  As of this writing, every TSEC is associated with an internal Ten-Bit
> +  Interface (TBI) PHY. This PHY is accessed through the local MDIO bus. These
> +  buses are defined similarly to the mdio buses, except they are compatible
> +  with "fsl,gianfar-tbi". The TBI PHYs underneath them are similar to normal
> +  PHYs, but the reg property is considered instructive, rather than
> +  descriptive. The reg property should be chosen so it doesn't interfere with
> +  other PHYs on the bus.
> +
> +maintainers:
> +  - J. Neuschäfer <j.ne@posteo.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,gianfar-tbi
> +      - fsl,gianfar-mdio
> +      - fsl,etsec2-tbi
> +      - fsl,etsec2-mdio
> +      - fsl,ucc-mdio
> +      - gianfar

Can you just comment out this to avoid the duplicate issue.

Though I think if you write a custom 'select' which looks for 
'device_type = "mdio"' with gianfar compatible and similar in the other 
binding, then the warning will go away. 

> +      - ucc_geth_phy
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description:
> +          Offset and length of the register set for the device
> +
> +      - description:
> +          Optionally, the offset and length of the TBIPA register (TBI PHY
> +          address register). If TBIPA register is not specified, the driver
> +          will attempt to infer it from the register set specified (your
> +          mileage may vary).
> +
> +  device_type:
> +    const: mdio
> +

> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

These are defined in mdio.yaml, so drop them here.

> +
> +required:
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +allOf:
> +  - $ref: mdio.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - gianfar
> +              - ucc_geth_phy
> +    then:
> +      required:
> +        - device_type

Essentially, move this to the 'select' schema and add that property 
device_type must be 'mdio'. You won't need it here anymore because it 
had to be true for the schema to be applied.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        mdio@24520 {
> +            reg = <0x24520 0x20>;
> +            compatible = "fsl,gianfar-mdio";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ethernet-phy@0 {
> +                reg = <0>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
> index 9c9668c1b6a24edff7b7cf625b9f14c3cbc2e0c8..0e55e0af7d6f59cfb571dd3fcff704b7f4c140d2 100644
> --- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
> +++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
> @@ -1,47 +1,10 @@
>  * MDIO IO device
>  
> -The MDIO is a bus to which the PHY devices are connected.  For each
> -device that exists on this bus, a child node should be created.  See
> -the definition of the PHY node in booting-without-of.txt for an example
> -of how to define a PHY.
> -
> -Required properties:
> -  - reg : Offset and length of the register set for the device, and optionally
> -          the offset and length of the TBIPA register (TBI PHY address
> -	  register).  If TBIPA register is not specified, the driver will
> -	  attempt to infer it from the register set specified (your mileage may
> -	  vary).
> -  - compatible : Should define the compatible device type for the
> -    mdio. Currently supported strings/devices are:
> -	- "fsl,gianfar-tbi"
> -	- "fsl,gianfar-mdio"
> -	- "fsl,etsec2-tbi"
> -	- "fsl,etsec2-mdio"
> -	- "fsl,ucc-mdio"
> -	- "fsl,fman-mdio"
> -    When device_type is "mdio", the following strings are also considered:
> -	- "gianfar"
> -	- "ucc_geth_phy"
> -
> -Example:
> -
> -	mdio@24520 {
> -		reg = <24520 20>;
> -		compatible = "fsl,gianfar-mdio";
> -
> -		ethernet-phy@0 {
> -			......
> -		};
> -	};
> +Refer to Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
>  
>  * TBI Internal MDIO bus
>  
> -As of this writing, every tsec is associated with an internal TBI PHY.
> -This PHY is accessed through the local MDIO bus.  These buses are defined
> -similarly to the mdio buses, except they are compatible with "fsl,gianfar-tbi".
> -The TBI PHYs underneath them are similar to normal PHYs, but the reg property
> -is considered instructive, rather than descriptive.  The reg property should
> -be chosen so it doesn't interfere with other PHYs on the bus.
> +Refer to Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
>  
>  * Gianfar-compatible ethernet nodes
>  
> 
> -- 
> 2.48.0.rc1.219.gb6b6757d772
> 


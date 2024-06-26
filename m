Return-Path: <netdev+bounces-106800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C9917AE0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E921C21D79
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699DF16630E;
	Wed, 26 Jun 2024 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcLHQOKc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5A166304;
	Wed, 26 Jun 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390285; cv=none; b=gzHITFQjG1SZye+0vGxKHzCyCHfs4EMzlGQXDiVdHJFRdFjlLN15SL+6k2tCNabXErGvwPDy9EOtvFgJvf/z3Fx/Ak2P1dSDlFBH1Afrt9jFs/AYZuZF9KNoB6PQ58pwh3gI76M6BRdazrRsOniZv9Pjz3CbgRNFygndusr8CEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390285; c=relaxed/simple;
	bh=Pdr8Rjiwz8TRtPy9SYdKH4mQx2KSlVG9IqwB5bOTorw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ma9Sd2SlHYEj7/IpHxvmzIAysDYIUHBuQxVCx6AOMy7q9QbIurxLhdk052ngjmulOqV1GVNTOilg3Tr47QB+WqkhdY9JVutk2zhFAieGIXDotFg1kiPKBs0mh7q+/VSFg/qff6pzuNenW4s+/5x/csIz39hvsC+BauITx6ZhcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcLHQOKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B5AC4AF09;
	Wed, 26 Jun 2024 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719390284;
	bh=Pdr8Rjiwz8TRtPy9SYdKH4mQx2KSlVG9IqwB5bOTorw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RcLHQOKcvCWhWZ8nRuOAQVvJ3GQXNUGHd201s1uTKr+dpX/+8uuXDMmCpL44ByoYw
	 yHbeuQEzelvqB/WX9mrgpokXOcBAUO87PT04mm9UM7ce/drwKCr+Vzr2cC8mcfoLfu
	 Io0Xp/uVwkGA3E/YgQDFgkfSeWteTpRbsz9hof2aKbrdKnnlez5rPV5kB3A5XtlZhT
	 28vxWmyPbw9WGaxGDAzSwPuIpjXNYzis+5C1RaM0QdmDe0Q+5eoR6lzdbdWgKOC2HE
	 NKWeWq5jI2eLk7fOpG2piQSay38Z96F9zH88CF18OxpEZULKAGFssk89ETaoMbbA94
	 4FAm07iWIbTlg==
Message-ID: <171cb592-1f5b-414d-bee2-ece87931f6cb@kernel.org>
Date: Wed, 26 Jun 2024 10:24:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: net: convert enetc to yaml
To: Frank Li <Frank.Li@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240625202255.3946515-1-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20240625202255.3946515-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2024 22:22, Frank Li wrote:
> Convert enetc device binding file to yaml. Split to 3 yaml files,
> fsl-enetc.yaml, fsl-enetc-mdio.yaml, fsl-enetc-ierb.yaml.
> 
> Additional Changes:
> - Add pci<vendor id>,<production id> in compatible string.
> - Ref to common ethernet-controller.yaml and mdio.yaml.
> - Remove fixed-link part.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/fsl-enetc-ierb.yaml          |  35 ++++++
>  .../bindings/net/fsl-enetc-mdio.yaml          |  46 +++++++
>  .../devicetree/bindings/net/fsl-enetc.txt     | 119 ------------------
>  .../devicetree/bindings/net/fsl-enetc.yaml    |  43 +++++++
>  4 files changed, 124 insertions(+), 119 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc-ierb.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc-mdio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
>  create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.yaml

Filename matching compatible, so vendor prefixes+coma+device name.

> 
> diff --git a/Documentation/devicetree/bindings/net/fsl-enetc-ierb.yaml b/Documentation/devicetree/bindings/net/fsl-enetc-ierb.yaml
> new file mode 100644
> index 0000000000000..bb083b2f8f399
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl-enetc-ierb.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl-enetc-ierb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Integrated Endpoint Register Block
> +
> +description:
> +  The fsl_enetc driver can probe on the Integrated Endpoint Register
> +  Block, which preconfigures the FIFO limits for the ENETC ports.
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,ls1028a-enetc-ierb
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
> +    ierb@1f0800000 {
> +        compatible = "fsl,ls1028a-enetc-ierb";
> +        reg = <0xf0800000 0x10000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/net/fsl-enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl-enetc-mdio.yaml
> new file mode 100644
> index 0000000000000..e8d0d4aa1112f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl-enetc-mdio.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl-enetc-mdio.yaml#

fsl,enetc-mdio.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ENETC the central MDIO PCIe endpoint device
> +
> +description:
> +  In this case, the mdio node should be defined as another PCIe
> +  endpoint node, at the same level with the ENETC port nodes
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - pci1957,ee01
> +      - const: fsl,enetc-mdio
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: mdio.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio@0,3 {
> +        compatible = "pci1957,ee01", "fsl,enetc-mdio";
> +        reg = <0x000300 0>;

The ranges do not match unit address, at least for simple case of
address/size-cells=1. Looks like this should be enclosed in pci {} node
and then with proper ranges. Otherwise it is a bit confusing.


> diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
> deleted file mode 100644
> index 9b9a3f197e2d3..0000000000000
> --- a/Documentation/devicetree/bindings/net/fsl-enetc.txt
> +++ /dev/null
> @@ -1,119 +0,0 @@
> -* ENETC ethernet device tree bindings
> -
> -Depending on board design and ENETC port type (internal or
> -external) there are two supported link modes specified by
> -below device tree bindings.
> -
> -Required properties:
> -
> -- reg		: Specifies PCIe Device Number and Function
> -		  Number of the ENETC endpoint device, according
> -		  to parent node bindings.
> -- compatible	: Should be "fsl,enetc".
> -
> -1. The ENETC external port is connected to a MDIO configurable phy
> -
> -1.1. Using the local ENETC Port MDIO interface
> -
> -In this case, the ENETC node should include a "mdio" sub-node
> -that in turn should contain the "ethernet-phy" node describing the
> -external phy.  Below properties are required, their bindings
> -already defined in Documentation/devicetree/bindings/net/ethernet.txt or
> -Documentation/devicetree/bindings/net/phy.txt.
> -
> -Required:
> -
> -- phy-handle		: Phandle to a PHY on the MDIO bus.
> -			  Defined in ethernet.txt.
> -
> -- phy-connection-type	: Defined in ethernet.txt.
> -
> -- mdio			: "mdio" node, defined in mdio.txt.
> -
> -- ethernet-phy		: "ethernet-phy" node, defined in phy.txt.
> -
> -Example:
> -
> -	ethernet@0,0 {
> -		compatible = "fsl,enetc";
> -		reg = <0x000000 0 0 0 0>;
> -		phy-handle = <&sgmii_phy0>;
> -		phy-connection-type = "sgmii";
> -
> -		mdio {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			sgmii_phy0: ethernet-phy@2 {
> -				reg = <0x2>;
> -			};
> -		};
> -	};
> -
> -1.2. Using the central MDIO PCIe endpoint device
> -
> -In this case, the mdio node should be defined as another PCIe
> -endpoint node, at the same level with the ENETC port nodes.
> -
> -Required properties:
> -
> -- reg		: Specifies PCIe Device Number and Function
> -		  Number of the ENETC endpoint device, according
> -		  to parent node bindings.
> -- compatible	: Should be "fsl,enetc-mdio".
> -
> -The remaining required mdio bus properties are standard, their bindings
> -already defined in Documentation/devicetree/bindings/net/mdio.txt.
> -
> -Example:
> -
> -	ethernet@0,0 {
> -		compatible = "fsl,enetc";
> -		reg = <0x000000 0 0 0 0>;
> -		phy-handle = <&sgmii_phy0>;
> -		phy-connection-type = "sgmii";
> -	};
> -
> -	mdio@0,3 {
> -		compatible = "fsl,enetc-mdio";
> -		reg = <0x000300 0 0 0 0>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		sgmii_phy0: ethernet-phy@2 {
> -			reg = <0x2>;
> -		};
> -	};
> -
> -2. The ENETC port is an internal port or has a fixed-link external
> -connection
> -
> -In this case, the ENETC port node defines a fixed link connection,
> -as specified by Documentation/devicetree/bindings/net/fixed-link.txt.
> -
> -Required:
> -
> -- fixed-link	: "fixed-link" node, defined in "fixed-link.txt".
> -
> -Example:
> -	ethernet@0,2 {
> -		compatible = "fsl,enetc";
> -		reg = <0x000200 0 0 0 0>;
> -		fixed-link {
> -			speed = <1000>;
> -			full-duplex;
> -		};
> -	};
> -
> -* Integrated Endpoint Register Block bindings
> -
> -Optionally, the fsl_enetc driver can probe on the Integrated Endpoint Register
> -Block, which preconfigures the FIFO limits for the ENETC ports. This is a node
> -with the following properties:
> -
> -- reg		: Specifies the address in the SoC memory space.
> -- compatible	: Must be "fsl,ls1028a-enetc-ierb".
> -
> -Example:
> -	ierb@1f0800000 {
> -		compatible = "fsl,ls1028a-enetc-ierb";
> -		reg = <0x01 0xf0800000 0x0 0x10000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.yaml b/Documentation/devicetree/bindings/net/fsl-enetc.yaml
> new file mode 100644
> index 0000000000000..e60b375395fcc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl-enetc.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/fsl-enetc.yaml#

fsl,enetc.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ENETC ethernet


Best regards,
Krzysztof



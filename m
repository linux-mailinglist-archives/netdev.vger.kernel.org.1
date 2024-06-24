Return-Path: <netdev+bounces-105986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15CC9141C9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1ED2809A7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 05:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF0171CD;
	Mon, 24 Jun 2024 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smUCOf1d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9817BA2;
	Mon, 24 Jun 2024 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205635; cv=none; b=I+w4H4bpRUHABy0OeChhZis258Ulo1dP1h34uMy7Ljmtf7x38Rz4YBHRB1vAqLA98gy1KUPAkqNtBMi1QGYu0roo8L3sCId4fH6XNw9YM0GI5LOrQdJc9EHyaO2BdBMHm/cSYpYUEQQvPm9FWRCYG8daCqhPrdY9T67BuF7KP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205635; c=relaxed/simple;
	bh=1gOZaWm3GAfk4u41uZS9ULFrEddZl1lqVBX6hsWwPKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orUHhoRJnOHAn1wYaNKPByJMG7ety42o17ZMFtBP4zbKM+bXMYscRNXdFuVz3Xbnyzt31B5Ri/VBw5a+vuDfpzmG+wSS1Otoq3SQpXiF0l6OEHM51BAxcYpwMVW8w8QUZEZsIQhd8VzMjVZLGLTtIXYgagnQQChKzn/x3zQtiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smUCOf1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2ECC2BBFC;
	Mon, 24 Jun 2024 05:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719205635;
	bh=1gOZaWm3GAfk4u41uZS9ULFrEddZl1lqVBX6hsWwPKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=smUCOf1dQHM65S3sKH06RJa66gT/kawMziiPFnrPoiToT7MRLNjIJQdZAwT9C6ttd
	 IO0opivUw38e0krJtZCD5m7NQS8i3DfyTkX7bcH0Dk5dtQ5f+9L6kvLdAMvHSmpzDS
	 G42zLQtxbTUB+f+jgUMu/4XBlvFUjKVnBn5deuK9+Miw5BuO9MBrkLRMP+6CFU9hOL
	 Bsjtsj4TR9yoyRocQd+R1BO33dJ1DXJI17A+n7Px8MNC6L4kuCwOr643f0ev1grHmO
	 kf3qrJistgzwTdMbTuhdokgjHCi0XdjJ1gfVJNV6lvYhrX/Ium5oQKNvojLyv9q3cJ
	 CxLsSwSM3zFmA==
Message-ID: <3f970d67-5f14-428e-b8ea-02c62e1b5f82@kernel.org>
Date: Mon, 24 Jun 2024 07:07:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: davinci_emac: Convert to yaml version
 from txt
To: Adam Ford <aford173@gmail.com>, devicetree@vger.kernel.org
Cc: woods.technical@gmail.com, aford@beaconembedded.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Adam Ford <aford@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240623170933.63864-1-aford173@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240623170933.63864-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/06/2024 19:09, Adam Ford wrote:
> The davinci_emac is used by several devices which are still maintained,
> but to make some improvements, it's necessary to convert from txt to yaml.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/net/davinci_emac.txt b/Documentation/devicetree/bindings/net/davinci_emac.txt
> deleted file mode 100644
> index 5e3579e72e2d..000000000000
> --- a/Documentation/devicetree/bindings/net/davinci_emac.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -* Texas Instruments Davinci EMAC
> -
> -This file provides information, what the device node
> -for the davinci_emac interface contains.
> -
> -Required properties:
> -- compatible: "ti,davinci-dm6467-emac", "ti,am3517-emac" or
> -  "ti,dm816-emac"
> -- reg: Offset and length of the register set for the device
> -- ti,davinci-ctrl-reg-offset: offset to control register
> -- ti,davinci-ctrl-mod-reg-offset: offset to control module register
> -- ti,davinci-ctrl-ram-offset: offset to control module ram
> -- ti,davinci-ctrl-ram-size: size of control module ram
> -- interrupts: interrupt mapping for the davinci emac interrupts sources:
> -              4 sources: <Receive Threshold Interrupt
> -			  Receive Interrupt
> -			  Transmit Interrupt
> -			  Miscellaneous Interrupt>
> -
> -Optional properties:
> -- phy-handle: See ethernet.txt file in the same directory.
> -              If absent, davinci_emac driver defaults to 100/FULL.
> -- ti,davinci-rmii-en: 1 byte, 1 means use RMII
> -- ti,davinci-no-bd-ram: boolean, does EMAC have BD RAM?
> -
> -The MAC address will be determined using the optional properties
> -defined in ethernet.txt.
> -
> -Example (enbw_cmc board):
> -	eth0: emac@1e20000 {
> -		compatible = "ti,davinci-dm6467-emac";
> -		reg = <0x220000 0x4000>;
> -		ti,davinci-ctrl-reg-offset = <0x3000>;
> -		ti,davinci-ctrl-mod-reg-offset = <0x2000>;
> -		ti,davinci-ctrl-ram-offset = <0>;
> -		ti,davinci-ctrl-ram-size = <0x2000>;
> -		local-mac-address = [ 00 00 00 00 00 00 ];
> -		interrupts = <33
> -				34
> -				35
> -				36
> -				>;
> -		interrupt-parent = <&intc>;
> -	};
> diff --git a/Documentation/devicetree/bindings/net/davinci_emac.yaml b/Documentation/devicetree/bindings/net/davinci_emac.yaml
> new file mode 100644
> index 000000000000..4c2640aef8a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/davinci_emac.yaml

Filename matching compatible format. Missing vendor prefix. Underscores
are not used in names or compatibles.


> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/davinci_emac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Davici EMAC
> +
> +maintainers:
> +  - Adam Ford <aford@gmail.com>
> +
> +description:
> +  Ethernet based on the Programmable Real-Time Unit and Industrial
> +  Communication Subsystem.
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:


That's just enum, no need for items here.

> +      - enum:
> +          - ti,davinci-dm6467-emac # da850
> +          - ti,dm816-emac
> +          - ti,am3517-emac
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 4

You need to list and describe the items.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ick
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  local-mac-address: true

Drop

> +  mac-address: true

Drop

You miss top-level $ref to appropriate schema.

> +
> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the global system controller on
> +      to enable/disable interrupts

Drop entire property. There was no such property in old binding and
nothing explains why it was added.

> +
> +  ti,davinci-ctrl-reg-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to control register
> +
> +  ti,davinci-ctrl-mod-reg-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to control module register
> +
> +  ti,davinci-ctrl-ram-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Offset to control module ram
> +
> +  ti,davinci-ctrl-ram-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of control module ram
> +
> +  ti,davinci-rmii-en:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      RMII enable means use RMII
> +
> +  ti,davinci-no-bd-ram:
> +    type: boolean
> +    description:
> +      Enable if EMAC have BD RAM
> +
> +additionalProperties: false

Look at example-schema. This goes after required, although anyway should
be unevaluatedProperties after adding proper $ref.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - ti,davinci-ctrl-reg-offset
> +  - ti,davinci-ctrl-mod-reg-offset
> +  - ti,davinci-ctrl-ram-offset
> +  - ti,davinci-ctrl-ram-size
> +
> +examples:
> +  - |
> +    eth0: ethernet@220000 {

Drop label.

> +      compatible = "ti,davinci-dm6467-emac";
> +      reg = <0x220000 0x4000>;
> +      ti,davinci-ctrl-reg-offset = <0x3000>;
> +      ti,davinci-ctrl-mod-reg-offset = <0x2000>;
> +      ti,davinci-ctrl-ram-offset = <0>;
> +      ti,davinci-ctrl-ram-size = <0x2000>;
> +      local-mac-address = [ 00 00 00 00 00 00 ];
> +      interrupts = <33>, <34>, <35>,<36>;
> +      clocks = <&psc1 5>;
> +      power-domains = <&psc1 5>;
> +      status = "disabled";

Drop. It cannot be disabled, otherwise what would be the point of this
example?


Best regards,
Krzysztof



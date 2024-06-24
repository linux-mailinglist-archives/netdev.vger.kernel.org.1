Return-Path: <netdev+bounces-106115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF8914E0D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0432C1F2369C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254C13D60A;
	Mon, 24 Jun 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1jwy1dv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF313D531;
	Mon, 24 Jun 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234688; cv=none; b=hz+Hwsl75IjKRYAt4wNRzfvQgOi7jCysLG/Nz+BS8GJ6xJ03Yp4kW3uI5HxEGuIORwgyzOiWEccvuNBHR8qh5vpo7YCUgn5FmXVGbb6sLc2Hv6T4RNmmNIR5lI5SkhLkJEZRQJvCcz8EKwkq4VdMG+th8X+EtWYGPrHov5vy840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234688; c=relaxed/simple;
	bh=OdUKOz7iD3AdShJaWL+yS4vKUsMDJUpjy94W7g3UQWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3PXey1mnDRL0shxBj3XHdJthKpgr9IEIpi8PnOaGDU8ibkanUQ8mDUClI285AcqNaUm5/kxWqIeQmwkCy1xreD9Tqj8AL5r7pNinc+Yowo2QAeENW1Emj/jXblRAYH+VzCpCS2x0Jio6M79GaNhGiCTF/p3X/vvKenYt72ukLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1jwy1dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98217C2BBFC;
	Mon, 24 Jun 2024 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719234688;
	bh=OdUKOz7iD3AdShJaWL+yS4vKUsMDJUpjy94W7g3UQWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s1jwy1dvK7pumzYS2M5ybH8gszPpC5UHpkc6ZG1UPifI8W74DPeKC4hanfaJMZHrV
	 urJodNGG8hSHOSXRVyxF2JeN4R3XoL2PRzuwoXvesmJ2p0F9Sy2tDTwGAcsSNm5vId
	 Hz+AHaO13qmxmPq27mGeCRQTzsPQlcTIgfLgd2lCxQ6a2u3hwIICCNqAEJIoJ+PH8b
	 xOeHal/99tB+qsdCSOZ7c/1WIuEAPOfL7Y73v5lOZ2HjbsTkQC4QoNHJe/Rh+wlP6n
	 Mr1Sken5S5pGaVaxNGVsnt1NDefJgozRobsgdlOpiknodejJ2EyYR1ikZE/MAljLbr
	 rirMmMTATzdRw==
Message-ID: <74620c16-f5a4-4782-aa46-0bd5d8c656c0@kernel.org>
Date: Mon, 24 Jun 2024 15:11:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: davinci_emac: Convert to yaml version
 from txt
To: Adam Ford <aford173@gmail.com>
Cc: devicetree@vger.kernel.org, woods.technical@gmail.com,
 aford@beaconembedded.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adam Ford <aford@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240623170933.63864-1-aford173@gmail.com>
 <3f970d67-5f14-428e-b8ea-02c62e1b5f82@kernel.org>
 <CAHCN7xKTnbDec2uJu0vJMY-NMTDvhb=C_FPM+5QeDNBwwRgZeA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAHCN7xKTnbDec2uJu0vJMY-NMTDvhb=C_FPM+5QeDNBwwRgZeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/06/2024 13:59, Adam Ford wrote:

>>> diff --git a/Documentation/devicetree/bindings/net/davinci_emac.yaml b/Documentation/devicetree/bindings/net/davinci_emac.yaml
>>> new file mode 100644
>>> index 000000000000..4c2640aef8a1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/davinci_emac.yaml
>>
>> Filename matching compatible format. Missing vendor prefix. Underscores
>> are not used in names or compatibles.
> 
> Thank you for the review.
> 
> Would a proper name be ti,davinci-emac.yaml?

Yes, it's fine.

> 
>>
>>
>>> @@ -0,0 +1,111 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/davinci_emac.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments Davici EMAC
>>> +
>>> +maintainers:
>>> +  - Adam Ford <aford@gmail.com>
>>> +
>>> +description:
>>> +  Ethernet based on the Programmable Real-Time Unit and Industrial
>>> +  Communication Subsystem.
>>> +
>>> +allOf:
>>> +  - $ref: ethernet-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>
>>
>> That's just enum, no need for items here.
>>
>>> +      - enum:
>>> +          - ti,davinci-dm6467-emac # da850
>>> +          - ti,dm816-emac
>>> +          - ti,am3517-emac
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    minItems: 4
>>
>> You need to list and describe the items.
>>
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: ick
>>> +
>>> +  power-domains:
>>> +    maxItems: 1
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +  local-mac-address: true
>>
>> Drop
>>
>>> +  mac-address: true
>>
>> Drop
>>
>> You miss top-level $ref to appropriate schema.
>>
>>> +
>>> +  syscon:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: a phandle to the global system controller on
>>> +      to enable/disable interrupts
>>
>> Drop entire property. There was no such property in old binding and
>> nothing explains why it was added.
> 
> The am3517.dtsi emac node has a syscon, so I didn't want to break it.
> I'll take a look to see what the syscon node on the am3517 does.  I
> struggle with if statements in yaml, but if it's necessary for the
> am3517, can we keep it if I elaborate on it in the commit message?

Explain in commit msg changes to the binding done during conversion.
With a rationale why these are needed (e.g. existing DTS and Linux
drivers use them).


Best regards,
Krzysztof



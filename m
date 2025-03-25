Return-Path: <netdev+bounces-177390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B69A6FE4C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8A0177807
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80B27D76D;
	Tue, 25 Mar 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+/0HeFV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0012571D1;
	Tue, 25 Mar 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905469; cv=none; b=ZtabhQvZpK7rLxUHnhOZL/JmtmdWgkxItI7QJfJJFl9Q4iLuMqyTSEp7tWAV7hQ2PVnq1hyPOrVRRUB7ZSOBlYVHurxuE98vSzlqc2Uxq+pI4ljXZD5JSOaLf9kM9wZt3Yfo44xoPtANn99l+hbAP+GeR0J+hmgFXhKLIyIq21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905469; c=relaxed/simple;
	bh=Mf0PY1BZwER+HJ9Mbh8TvIu8FULZZyssZyyQhg3Lxog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0canlWlTc9P+7pQCEAUjUwByCWEFW9FKshssW3cZmj61qMtYL2g1zp6/rX8KT0YKSZIDbayC1fN8cpJUw1Yughk6iK1s6oxlv7R12NReei1vEUAOy5n73C4txiFAwW1Xsi2sD/GGGgrUCj+lo51A/kvJNCT8jONa3Pj1C3Yxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+/0HeFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB37C4CEE9;
	Tue, 25 Mar 2025 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905468;
	bh=Mf0PY1BZwER+HJ9Mbh8TvIu8FULZZyssZyyQhg3Lxog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s+/0HeFVYw6E9ENxuZrurwBQZjTKxbCYZUpzZpQQkhJ/91XayRTQsrh0ZrPcxL6VT
	 kWPsswaWOu92ibYtKPVQ8cCX8tI/AovpWLUHxbRfI0/LYO+BNEKvw0jz9tSM+iNekY
	 vYO8pjYDmfb/z5KEqYkNLmTBUw5TNSgx7s3Tm+/YAcmPn6gD38V4dkw/SWkZ+YlcxW
	 su7X/NDNRXtlVjRTXmyVRJXFZaFDSzVdX/xcyiKo4eSPgyWNkviNI88lTVQL8Pypxt
	 ZQYp+1CfBBYtXUeraYsyNCniBCJqLg9oYiWYeeJrfpwq4Grdag9K+D7WLkJGrdzDGX
	 yL7UoRVqqlcPQ==
Message-ID: <bf6d066c-f0dd-471a-bb61-9132476b515a@kernel.org>
Date: Tue, 25 Mar 2025 13:24:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: net: Add MTIP L2 switch description
 (fec,mtip-switch.yaml)
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew+netdev@lunn.ch>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20250325115736.1732721-1-lukma@denx.de>
 <20250325115736.1732721-3-lukma@denx.de>
 <2bf73cc2-c79a-4a06-9c5f-174e3b846f1d@kernel.org>
 <20250325131507.692804cd@wsk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250325131507.692804cd@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2025 13:15, Lukasz Majewski wrote:
> Hi Krzysztof,
> 
>> On 25/03/2025 12:57, Lukasz Majewski wrote:
>>> This patch provides description of the MTIP L2 switch available in
>>> some NXP's SOCs - imx287, vf610.
>>>
>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>> ---
>>>  .../bindings/net/fec,mtip-switch.yaml         | 160
>>> ++++++++++++++++++  
>>
>> Use compatible as filename.
> 
> I've followed the fsl,fec.yaml as an example. This file has description
> for all the device tree sources from fec_main.c


That's a 14 year old binding, so clear antipattern.

> 
> I've considered adding the full name - e.g. fec,imx287-mtip-switch.yaml
> but this driver could (and probably will) be extended to vf610.

Unless you add vf610 now, this should follow the compatible name.

> 
> So what is the advised way to go?
> 
>>
>>>  1 file changed, 160 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
>>> b/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml new
>>> file mode 100644 index 000000000000..cd85385e0f79 --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
>>> @@ -0,0 +1,160 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/fsl,mtip-switch.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Freescale MTIP Level 2 (L2) switch
>>> +
>>> +maintainers:
>>> +  - Lukasz Majewski <lukma@denx.de>
>>> +  
>>
>> description?
> 
> Ok.
> 
>>
>>> +allOf:
>>> +  - $ref: ethernet-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:  
>>
>> Drop, you have only one variant.
> 
> Ok, for imx287 this can be dropped, and then extended with vf610.
> 
>>
>>> +      - enum:
>>> +	  - imx287-mtip-switch  
>>
>> This wasn't tested. Except whitespace errors, above compatible does
>> not have format of compatible. Please look at other NXP bindings.
>>
>> Missing blank line.
>>
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 3  
>>
>> Need to list items instead.
>>
>>> +
>>> +  clocks:
>>> +    maxItems: 4
>>> +    description:
>>> +      The "ipg", for MAC ipg_clk_s, ipg_clk_mac_s that are for
>>> register accessing.
>>> +      The "ahb", for MAC ipg_clk, ipg_clk_mac that are bus clock.
>>> +      The "ptp"(option), for IEEE1588 timer clock that requires
>>> the clock.
>>> +      The "enet_out"(option), output clock for external device,
>>> like supply clock
>>> +      for PHY. The clock is required if PHY clock source from SOC.
>>>  
>>
>> Same problems. This binding does not look at all as any other
>> binding. I finish review here, but the code has similar trivial
>> issues all the way, including incorrect indentation. Start from well
>> reviewed existing binding or example-schema.
> 
> As I've stated above - this code is reduced copy of fsl,fec.yaml...

Don't take the worst, old code with all the anti-patterns we point out
on each review, as an example.

Take the most recent, well reviewed binding as an example. Or
example-schema.

Best regards,
Krzysztof


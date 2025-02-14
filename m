Return-Path: <netdev+bounces-166320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F0A357E9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 08:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E172116BE7D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1279207DED;
	Fri, 14 Feb 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjOlCJp4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B315573F;
	Fri, 14 Feb 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518311; cv=none; b=PF58HZDVEh7JPCyCE2Mfs3GoFdj/aQdmjCf1sGWs+SZRv77gIrm1WwksxxnlvfiD9Pa0GJA1GwtHuuz+lXAM5ORObvXfTX/qSV6e23rY8lWudfYUH/ARSh8gmcD0+mMAUn/h5pW0QQIYINnNkfPYJ8Ye6iewUGTcFWi35mJLBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518311; c=relaxed/simple;
	bh=EsbfD+8oMBZkVT1buE8QyRwtFHnJ7VZicSc4qxAQLDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGFPkqxNY6rhZQh2z1mvoNGDRRRE7SZpbeT/PgtbTJFDkPiJYRi4a3gV31w4THdioUCMXWykOPU2VNhMsaGvYRRHkx5PLrqfO2nzz/VwKO9y1rwG3bMRAxjag5Z2WAbJMs6lxA6UK5VKaPyU/4nUiHMoGz2G0vl9IgKh9boVl6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjOlCJp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D125C4CED1;
	Fri, 14 Feb 2025 07:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739518311;
	bh=EsbfD+8oMBZkVT1buE8QyRwtFHnJ7VZicSc4qxAQLDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YjOlCJp45+yDX9k1uwXIa1NHpftUNJtyfYG0hmKABYAbro0g5pIf5VsHJGD2XKbNH
	 Zh2TdyV+4jUhT0YHXMPDGRLs21J4cSbafY9uSKecbSq865Kea/aK+cg5E27coCG8pV
	 CugXfYtw7xLQn8waXZoIA7tRs0yPxoQXyQ1f2N+gF3bEP3n0w3ojxk04uMx/UBoChm
	 TDqHUnyg1C6oxt6BzfZ9sz6eOlRmVB+gEKTecAS1mo9CY7ZYP86OrCRMQyu29Ybarl
	 HVI43Pntwv+/XrDliP3PgcmDpy6rfI6N+7CN9WC5Rf7JAoV5xU3RnO9Jp6vweyFznd
	 MYPv8XNJ+OJwQ==
Message-ID: <7d50f55d-d0cd-4741-ab55-2f54dc45d6ab@kernel.org>
Date: Fri, 14 Feb 2025 08:31:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250213044624.37334-1-swathi.ks@samsung.com>
 <CGME20250213044955epcas5p110d1e582c8ee02579ead73f9686819ff@epcas5p1.samsung.com>
 <20250213044624.37334-2-swathi.ks@samsung.com>
 <20250213-adorable-arboreal-degu-6bdcb8@krzk-bin>
 <009a01db7e07$132feb60$398fc220$@samsung.com>
 <27b0f5c5-ae51-4192-8847-20e471c55be7@kernel.org>
 <00ad01db7e9c$76c288a0$644799e0$@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <00ad01db7e9c$76c288a0$644799e0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2025 05:53, Swathi K S wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: 13 February 2025 17:31
>> To: Swathi K S <swathi.ks@samsung.com>
>> Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch; davem@davemloft.net;
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>> robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
>> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
>> rmk+kernel@armlinux.org.uk; netdev@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
>> bindings
>>
>> On 13/02/2025 12:04, Swathi K S wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Sent: 13 February 2025 13:24
>>>> To: Swathi K S <swathi.ks@samsung.com>
>>>> Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch;
>> davem@davemloft.net;
>>>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>>>> robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
>>>> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
>>>> rmk+kernel@armlinux.org.uk; netdev@vger.kernel.org;
>>>> devicetree@vger.kernel.org; linux-stm32@st-md-
>> mailman.stormreply.com;
>>>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device
>>>> tree bindings
>>>>
>>>> On Thu, Feb 13, 2025 at 10:16:23AM +0530, Swathi K S wrote:
>>>>> +  clock-names:
>>>>> +    minItems: 5
>>>>> +    maxItems: 10
>>>>> +    contains:
>>>>> +      enum:
>>>>> +        - ptp_ref
>>>>> +        - master_bus
>>>>> +        - slave_bus
>>>>> +        - tx
>>>>> +        - rx
>>>>> +        - master2_bus
>>>>> +        - slave2_bus
>>>>> +        - eqos_rxclk_mux
>>>>> +        - eqos_phyrxclk
>>>>> +        - dout_peric_rgmii_clk
>>>>
>>>> This does not match the previous entry. It should be strictly ordered
>>>> with
>>>> minItems: 5.
>>>
>>> Hi Krzysztof,
>>> Thanks for reviewing.
>>> In FSD SoC, we have 2 instances of ethernet in two blocks.
>>> One instance needs 5 clocks and the other needs 10 clocks.
>>
>> I understand and I do not think this is contradictory to what I asked.
>> If it is, then why/how?
>>
>>>
>>> I tried to understand this by looking at some other dt-binding files
>>> as given below, but looks like they follow similar approach
>>> Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>>> Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>>>
>>> Could you please guide me on how to implement this?
>>> Also, please help me understand what is meant by 'strictly ordered'
>>
>> Every other 99% of bindings. Just like your clocks property.
> 
> Hi Krzysztof,
> Thanks for your feedback.
> I want to make sure I fully understand your comment. 
> I can see we have added clocks and clock names in the same order.

No, you did not. You can see syntax is very different - one uses items,
other uses contains-enum. And now test it, change the order in DTS and
see if you see any warning.

> Could you please help in detail what specifically needs to be modified regarding the ordering and minItems/maxItems usage?
You did not try hard enough.

Open other bindings and look how they list clocks. For example any
Samsung clock controller bindings. Or any qcom bindings.

Best regards,
Krzysztof


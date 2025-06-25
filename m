Return-Path: <netdev+bounces-201133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829DBAE82FB
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C73D164F34
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F7D25F99B;
	Wed, 25 Jun 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kUvKEvfP"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1E25CC47;
	Wed, 25 Jun 2025 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855342; cv=none; b=WLoKJoKArIvyGwN2BdqenAQhq6AdqSxtq4b1qWih/rcQiMcXVzDy/Y2tkL3O67mQdNJfEf2MMC+SaMb9hcge+iP7hQJsL6RTVj0FqdvrdeakoYV8y1qMP9GPzEEJ5MLWnROfyhsxs6SWhD6i8LL2n+wq+wMv8Qj4VnSI0tRDRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855342; c=relaxed/simple;
	bh=3HMbk0mlakx6BcqWOIOd4rz9lzz+qzLD1ex6XrftVc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbB8QaDH5Y54nOg+ZqdDTaQJBjouQHlUG0uF0b+FCcYYbFHiGBVQq+Y7N8/OXLsPlLOf7w1Qx9ly+12nZdMRqn9KWbQ+1n7UdgelEr6M2/tUC8flklUQQRFkmdbsa5uhsanOaz+7CIlWU+SARVAPBMTKvUi4SE0gm9snywaVwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kUvKEvfP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750855336;
	bh=3HMbk0mlakx6BcqWOIOd4rz9lzz+qzLD1ex6XrftVc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kUvKEvfP28rCadwxCPxPAhgINhFv3i+gKsNHbIxhS6lgOKanUqqojUkYpmTFl+2qU
	 xKEFQ6Mftpep0s/y/DE2CLmB6jJc3tq3tKgFS2Y5SAn+TAjuElOcRu5r07h2agLESi
	 GbsR+DcVn808Nybdup+HbY5g1/X58/38H3JO04TKrM8Sm7S+1XSfYCyiuv3wSHmxAT
	 P/Y7+hwzIZplzxTq0Pb9T8krjfgSN/7Az2Dw2fQrGlxvdXUkGE7Kb+bgXjMWj82z63
	 tbRQQePrDju6i22poUBAYZXHQGhVw7OQNkhV9lMBG4fw4Z8xepWyff7IidpBO+aAe5
	 9p5OceBXbSxGA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E0BE117E0202;
	Wed, 25 Jun 2025 14:42:15 +0200 (CEST)
Message-ID: <312f321f-2e49-48ac-bc41-a741f5e3b3a5@collabora.com>
Date: Wed, 25 Jun 2025 14:42:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/29] dt-bindings: clock: mediatek: Describe MT8196
 peripheral clock controllers
To: Krzysztof Kozlowski <krzk@kernel.org>, Laura Nao
 <laura.nao@collabora.com>, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250624143220.244549-1-laura.nao@collabora.com>
 <20250624143220.244549-10-laura.nao@collabora.com>
 <7dfba01a-6ede-44c2-87e3-3ecb439b48e3@kernel.org>
 <284a4ee5-806b-45f9-8d57-d02ec291e389@collabora.com>
 <0870a2ba-936b-4eb2-a570-f2c9dea471b8@kernel.org>
 <9fc32523-5009-4f48-8d82-6c3fd285801d@collabora.com>
 <29eeae4f-59ed-4781-88b1-4fd76714ecb6@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <29eeae4f-59ed-4781-88b1-4fd76714ecb6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/06/25 13:05, Krzysztof Kozlowski ha scritto:
> On 25/06/2025 11:45, AngeloGioacchino Del Regno wrote:
>> Il 25/06/25 10:57, Krzysztof Kozlowski ha scritto:
>>> On 25/06/2025 10:20, AngeloGioacchino Del Regno wrote:
>>>> Il 24/06/25 18:02, Krzysztof Kozlowski ha scritto:
>>>>> On 24/06/2025 16:32, Laura Nao wrote:
>>>>>> +  '#reset-cells':
>>>>>> +    const: 1
>>>>>> +    description:
>>>>>> +      Reset lines for PEXTP0/1 and UFS blocks.
>>>>>> +
>>>>>> +  mediatek,hardware-voter:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>>> +    description:
>>>>>> +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
>>>>>> +      MCU manages clock and power domain control across the AP and other
>>>>>> +      remote processors. By aggregating their votes, it ensures clocks are
>>>>>> +      safely enabled/disabled and power domains are active before register
>>>>>> +      access.
>>>>>
>>>>> Resource voting is not via any phandle, but either interconnects or
>>>>> required opps for power domain.
>>>>
>>>> Sorry, I'm not sure who is actually misunderstanding what, here... let me try to
>>>> explain the situation:
>>>>
>>>> This is effectively used as a syscon - as in, the clock controllers need to perform
>>>> MMIO R/W on both the clock controller itself *and* has to place a vote to the clock
>>>> controller specific HWV register.
>>>
>>> syscon is not the interface to place a vote for clocks. "clocks"
>>> property is.
>>>
>>>>
>>>> This is done for MUX-GATE and GATE clocks, other than for power domains.
>>>>
>>>> Note that the HWV system is inside of the power domains controller, and it's split
>>>> on a per hardware macro-block basis (as per usual MediaTek hardware layout...).
>>>>
>>>> The HWV, therefore, does *not* vote for clock *rates* (so, modeling OPPs would be
>>>> a software quirk, I think?), does *not* manage bandwidth (and interconnect is for
>>>> voting BW only?), and is just a "switch to flip".
>>>
>>> That's still clocks. Gate is a clock.
>>>
>>>>
>>>> Is this happening because the description has to be improved and creating some
>>>> misunderstanding, or is it because we are underestimating and/or ignoring something
>>>> here?
>>>>
>>>
>>> Other vendors, at least qcom, represent it properly - clocks. Sometimes
>>> they mix up and represent it as power domains, but that's because
>>> downstream is a mess and because we actually (at upstream) don't really
>>> know what is inside there - is it a clock or power domain.
>>>
>>
>> ....but the hardware voter cannot be represented as a clock, because you use it
>> for clocks *or* power domains (but at the same time, and of course in different
>> drivers, and in different *intertwined* registers).
>>
>> So the hardware voter itself (and/or bits inside of its registers) cannot be
>> represented as a clock :\
>>
>> In the context of clocks, it's used for clocks, (and not touching power domains at
>> all), but in the context of power domains it's used for power domains (and not
>> touching clocks at all).
> 
> I don't understand this. Earlier you mentioned "MUX-GATE and GATE
> clocks", so these are clocks, right? How these clocks are used in other
> places as power domains?

I think you've misread, or I've explained badly enough to make you misread...
let me describe some more to try to let you understand this properly.

The hardware voter is a unit that is used to vote for "flipping various switches",
in particular, you can vote for, *either*:
  - Enabling or disabling a *clock*; or
  - Enabling or disabling a *power domain*.

There may be multiple (by hardware, in-silicon) copies of the Hardware Voter; in
the specific case of the MediaTek Dimensity 9400 MT6991 and of the MediaTek MT8196
Chromebook SoC, there is only one instance.

The Hardware Voter, there, is located in the SCPSYS macro-block.

The SCPSYS macro-block contains:
  - A system controller
  - A Hardware Voter IP (new in MT6991/MT8196)
  - A power domains controller
  - Other hardware that is not relevant for this discussion

The HWV is MMIO-accessible, and there is one (small, for now) set of registers,
allowing to vote for turning on/off one (or maybe multiple too, not sure about
that as there's no documentation and when I tried with multi-votes it didn't work)
clk/pd at a time.

Probably not important but worth mentioning: the HWV can vote for clocks or for
power domains in macro-blocks outside of its own (so, outside of the SCPSYS block,
for example - it can vote to turn on a clock or a power domain in HFRPSYS as well).

The register set in the HWV is *not* split between clock voters and PDs voters,
in the sense that the register set of clock voters is *not contiguous*; trying
to be as clear as possible, you have something like (mock register names ahead):
  0x0 - CLOCK_VOTER_0 (each bit is a clock)
  0x4 - PD_VOTER_0 (each bit is a power domain)
  0x8 - SECURE_WORLD_CLOCK_VOTER_1
  0xc - PD_VOTER_1
  0x10 - SECURE_WORLD_PD_VOTER_0

...etc etc.

 >> If they are, this either has to be fixed or
> apparently this is a power domain and use it as power domain also here.

So no, clocks are not used as power domains, and power domains are not used as
clocks; we are talking purely about something that aggregates votes internally
and decides to turn on/off "whatever thing it is" (one of the clocks, or one of
the power domains) - and to do that, you flip a bit in a register, and then you
read another two registers to know the status of the internal state machine....

....and you do that atomically, this can't sleep, the system has to lock up
until HWV is done (I think I know what you're thinking, and yes, it's really
like this) otherwise you're surely racing.

> 
> Really, something called as hardware voter is not that uncommon and it
> does fit existing bindings.
> 

Do you mean the interconnect/qcom/bcm-voter.c?

That one seems to aggregate votes in software to place a vote in a hardware voter
(the Bus Clock Manager) and I see it as being really convoluted.

For MediaTek's HWV, you don't need to aggregate anything - actually, the HWV itself
is taking care of aggregating requests internally...

Also, checking sdx75 and x1e80100 DTs, I see a virtual clock controller described,
placing votes through the bcm-voter, and with clocks that looks like being kind
of disguised/faked as interconnects?

That's a bit unclear, and even if I'm wrong about those being disguised as icc,
and not virtual, purely looking at the usage of the clk_virt and bcm-voters, I
seriously don't think that any similar structure with interconnect would fit
MediaTek SoCs in any way...

>>
>> I'm not sure what qcom does - your reply makes me think that they did it such that
>> the clocks part is in a MMIO and the power domains part is in a different MMIO,
>> without having clock/pd intertwined voting registers...
> 
> No, you just never have direct access to hardware. You place votes and
> votes go to the firmware. Now depending on person submitting it or
> writing internal docs, they call it differently, but eventually it is
> the same. You want to vote for some specific signal to be active or
> running at some performance level.
> 

Okay then there is one similarity, but it's different; MTK HWV is only arbitering
a on/off request; Nothing else.

No RATE votes.
No performance levels.
Literally, that's it.

You have direct access to the hardware, and you can also access the same HW that is
arbitered by HWV, effectively overriding whatever HWV is voting for, and you're
free to race with HWV if you want, even (why would you want that I don't know, but
anyway..!).

Am I still missing anything, or have you got any other doubt, question,
consideration, (etc)?

Cheers,
Angelo



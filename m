Return-Path: <netdev+bounces-211573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3FAB1A335
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD4A1890550
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174AB266EFE;
	Mon,  4 Aug 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EyfmxvdX"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A999259CA0;
	Mon,  4 Aug 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314033; cv=none; b=CwK9G3UbPtC/K75aFRXx7QRQGVs0zJZEDitnb0K/dV6NgGVe5t2kiXHUB0k9bZ36FFVb3kZjV5xvGf/kDZHSJ40cPbeThRRuZUOzLRb2jaq33laOpVnYoyu+WfQgFFBSC1jyBxRyWM40DYbszasUy75/90Pv3gwTcJ948HUyWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314033; c=relaxed/simple;
	bh=HdvT5261gzhE4aRSmJHv+tFzObgX93mplUmVc06GufI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJi/S4/2XfIOi0dgcKAhS5b1Zo9+2BUnVVgw2SivzCa6hv8pvdC8BRebuBuUo71VIx0Y2JAOwew7KB0FS8odAgTj0WS9qqcAn9ShplmdqCH3a6yPJQ/bPm86Cl/ZFQYGD8NPceyx428vCW2f9VS27tH6cu/m3ucwDrePhtNWKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EyfmxvdX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754314028;
	bh=HdvT5261gzhE4aRSmJHv+tFzObgX93mplUmVc06GufI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EyfmxvdXZ+NzDsRzzPqikBca7aExVvjMxp9273QrCTmQDt5W03Ujk77tESdn04Cko
	 0xSGbdjRQJHSijFEarIcVioaWZakdnvAoCCaSPc/gxCt1hPn64sI47ckjYMeHCmtw/
	 VRfHcDkV2IjUclj1M2UBJ8IwGDrns57lcScN4xdZbM0UwsciK4xIrPk7151HRdQlmx
	 lZT6iYkRYJZVLKZq40Ihoygwa70YWtTLZ75HCHrewFFF7J1RtLmn4tIg5xD1HgGJBU
	 XP2U1JXD+JLDo8+oFCuob8guMEtN+qP5Wn4fxuCJOx727NVTWfCtWG0nC5xNkuFeIC
	 m42FsuLYnQlzQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A25817E01CC;
	Mon,  4 Aug 2025 15:27:07 +0200 (CEST)
Message-ID: <00a12553-b248-4193-8017-22fea07ee196@collabora.com>
Date: Mon, 4 Aug 2025 15:27:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/27] dt-bindings: clock: mediatek: Describe MT8196
 clock controllers
To: Krzysztof Kozlowski <krzk@kernel.org>, Laura Nao
 <laura.nao@collabora.com>, wenst@chromium.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 guangjie.song@mediatek.com, kernel@collabora.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, mturquette@baylibre.com, netdev@vger.kernel.org,
 nfraprado@collabora.com, p.zabel@pengutronix.de, richardcochran@gmail.com,
 robh@kernel.org, sboyd@kernel.org
References: <fbe7b083-bc3f-4156-8056-e45c9adcb607@kernel.org>
 <20250804083540.19099-1-laura.nao@collabora.com>
 <373f44c3-8a6a-4d52-ba6b-4c9484e2eac1@kernel.org>
 <1db77784-a59a-49bd-89b5-9e81e6d3bafc@collabora.com>
 <e9ee33b0-d6b0-4641-aeeb-9803b4d1658a@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e9ee33b0-d6b0-4641-aeeb-9803b4d1658a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/08/25 13:01, Krzysztof Kozlowski ha scritto:
> On 04/08/2025 11:27, AngeloGioacchino Del Regno wrote:
>> Il 04/08/25 11:16, Krzysztof Kozlowski ha scritto:
>>> On 04/08/2025 10:35, Laura Nao wrote:
>>>> Hi,
>>>>
>>>> On 8/3/25 10:17, Krzysztof Kozlowski wrote:
>>>>> On 01/08/2025 15:57, Rob Herring wrote:
>>>>>>> +  reg:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  '#clock-cells':
>>>>>>> +    const: 1
>>>>>>> +
>>>>>>> +  '#reset-cells':
>>>>>>> +    const: 1
>>>>>>> +    description:
>>>>>>> +      Reset lines for PEXTP0/1 and UFS blocks.
>>>>>>> +
>>>>>>> +  mediatek,hardware-voter:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>>>> +    description:
>>>>>>> +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
>>>>>>> +      MCU manages clock and power domain control across the AP and other
>>>>>>> +      remote processors. By aggregating their votes, it ensures clocks are
>>>>>>> +      safely enabled/disabled and power domains are active before register
>>>>>>> +      access.
>>>>>>
>>>>>> I thought this was going away based on v2 discussion?
>>>>>
>>>>> Yes, I asked to drop it and do not include it in v3. There was also
>>>>> discussion clarifying review.
>>>>>
>>>>> I am really surprised that review meant nothing and code is still the same.
>>>>>
>>>>
>>>> This has been re-submitted as-is, following the outcome of the discussion
>>>> here: https://lore.kernel.org/all/242bf682-cf8f-4469-8a0b-9ec982095f04@collabora.com/
>>>>
>>>> We haven't found a viable alternative to the current approach so far, and
>>>> the thread outlines why other options don’t apply. I'm happy to continue
>>>> the discussion there if anyone has further suggestions or ideas on how
>>>> to address this.
>>>>
>>>
>>> And where is any of that resolution/new facts in the commit msg? You
>>> must clearly reflect long discussions like that in the commit msg.
>>
>> On that, I agree. That's a miss.
>>
>>>
>>> There was no objection from Chen to use clocks or power domains as I
>>> requested.
>>
>> Sorry Krzysztof, but now I really think that you don't understand the basics of
>> MediaTek SoCs and how they're split in hardware - and I'm sorry again, but to me
>> it really looks like that you're not even trying to understand it.
> 
> There is no DTS here. No diagrams or some simplified drawings to help me
> understand.
> 
>>
>>> The objection was about DUPLICATING interfaces or nodes.
>>
>> I don't see that duplication. The interface to each clock controller for each
>> of the hardware subdomains of each controller is scattered all around the (broken
>> by hardware and by concept, if you missed that in the discussion) HW Voter MMIO.
>>
>> There are multiple clock controllers in the hardware.
>> Each of those has its own interface to the HWV.
>>
>> And there are some that require you to write to both its HWV interface and to the
>> clock controller specific MMIO at the same time for the same operation. I explained
>> that in the big discussion that Laura linked.
> 
> That's not what property description says. I discussed that part. Your
> description says - to aggregate votes.
> 

Yes. That is what the datasheets say, but read down there.

> Above you say that control is split between two different MMIO blocks.
> 

Also yes.

> Aggregating votes is exactly what we discussed last time and you should
> not use custom phandle for it.
> 

We discussed about aggregating votes, yes, in software - this instead is a
*broken* hardware that does the aggregation internally and does not require
nor want external drivers to do the aggregation.

> Maybe it is just the name, so avoid all the confusing "votes" if this is
> not voting system. If this is a voting system, then don't use custom
> phandles.

Being it fundamentally *broken*, this being a voting system is what the hardware
initially wanted to be - but effectively, since it requires YOU to:
  - Make sure that power supplies are turned on, if not, turn them on by "touching"
    HW registers (so, without any assistance from the voter MCU), if any;
  - Turn on parent clocks manually, if any, before using the "voter mcu" to try
    to ungate that clock; and
    - Enable the "FENC" manually, after the mcu says that the clock was ungated.

in the current state, it is just an hardware managed refcounting system and
nothing else, because the MCU seems to be unfinished, hence, again, b r o k e n.

Note that by "manually" I always mean "with direct writes to a clock controller's
registerS, and without any automation/assistance from the HWV MCU".

We're using the "hardware-voter" name because this is how MediaTek calls it in the
datasheets, and no it doesn't really *deserve* that name for what it is exactly in
MT8196 and MT6991.

And mind you - if using the "interconnect" property for this means that we have to
add an interconnect driver for it, no, we will not do that, as placing a software
vote that votes clocks in a a voter MCU that does exactly what the interconnect
driver would do - then requiring virtual/fake clocks - is not a good solution.

So, what should we do then?

Change it to "mediatek,clock-hw-refcounter", and adding a comment to the binding
saying that this is called "Hardware Voter (HWV)" in the datasheets?

Or is using the "interconnect" property without any driver in the interconnect API
actually legit? - Because to me it doesn't look like being legit (and if it is, it
shouldn't be, as I'm sure that everyone would expect an interconnect API driver
when encountering an "interconnect" property in DT), and if so, we should just add
a new "hw-interconnect" or "interconnect-hw" instead to not create confusion.

Regards,
Angelo

> 
> Best regards,
> Krzysztof




Return-Path: <netdev+bounces-211542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A728B1A01E
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66668174202
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB01F4617;
	Mon,  4 Aug 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFThwELH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD212EBE7;
	Mon,  4 Aug 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305309; cv=none; b=oUF0mEBp3m2bg2F8ij88vywFYLkzw7EjgFzY/ZhGwm/KW73iWpvGB/LKUnF6Nv5c0+ApB4yGP3bX/PVvWEbQ/t9G2SRGxuY/bJEgUB12p3eiWQekrDUJHwF8vvWhYWLMJDZkVQ/o7V5ZxdcsV07xTo3Kng1SBwE80sUBbQnB4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305309; c=relaxed/simple;
	bh=7Vi2uJ7wlOkjGx9qtfXpPL/qV6tJLMJ0r02efBl/RdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyzeHuiuVNzZVfnumTOBo4fn26VZG+RIO/RM8NqdXjiSMdeTms3y4yHoqszC2Yj+p21RgyoAFxYZe/fRZe24tUa29L+u0xp9+eIEYAACHxD2QuTMyDD3NUhU81vv3G/MHrMqePUoMb1b8lkrARirYb4XBJE8Dz3VXCHoEC5qW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFThwELH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C058AC4CEE7;
	Mon,  4 Aug 2025 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754305309;
	bh=7Vi2uJ7wlOkjGx9qtfXpPL/qV6tJLMJ0r02efBl/RdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KFThwELH3T5ifPqtFbwqhyae5Q/2x1er0BGr0D97vm6NzpiJ/WdvYnIbiERaeBpEq
	 9m4sl65ewl3Cpi3Dp0GrZlh6VEpjuV413JWUh39a5hPxgTsvSenPC9pQSS7jJdCzCD
	 6KK/axvlSZzLtSBqsEvwVLoj8K/j1kW6HI0docMW3YcuwEEcQLJYpo83qPQu/sO1XI
	 p68FfKqFr/Dlopctgu28HrZ5EHdC2SXYhnV7AiyDjWPL6W+Jlcc+gyNZ2zSpOTEvzz
	 T5OUWeom4/ztyiSmX+SLsEynwPySjovcM1bpL4Eh5RMatBoE3g5pgshLnS8NZGdhtl
	 LSkFYkBTgGugQ==
Message-ID: <e9ee33b0-d6b0-4641-aeeb-9803b4d1658a@kernel.org>
Date: Mon, 4 Aug 2025 13:01:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/27] dt-bindings: clock: mediatek: Describe MT8196
 clock controllers
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Laura Nao <laura.nao@collabora.com>, wenst@chromium.org
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <1db77784-a59a-49bd-89b5-9e81e6d3bafc@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/08/2025 11:27, AngeloGioacchino Del Regno wrote:
> Il 04/08/25 11:16, Krzysztof Kozlowski ha scritto:
>> On 04/08/2025 10:35, Laura Nao wrote:
>>> Hi,
>>>
>>> On 8/3/25 10:17, Krzysztof Kozlowski wrote:
>>>> On 01/08/2025 15:57, Rob Herring wrote:
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  '#clock-cells':
>>>>>> +    const: 1
>>>>>> +
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
>>>>> I thought this was going away based on v2 discussion?
>>>>
>>>> Yes, I asked to drop it and do not include it in v3. There was also
>>>> discussion clarifying review.
>>>>
>>>> I am really surprised that review meant nothing and code is still the same.
>>>>
>>>
>>> This has been re-submitted as-is, following the outcome of the discussion
>>> here: https://lore.kernel.org/all/242bf682-cf8f-4469-8a0b-9ec982095f04@collabora.com/
>>>
>>> We haven't found a viable alternative to the current approach so far, and
>>> the thread outlines why other options don’t apply. I'm happy to continue
>>> the discussion there if anyone has further suggestions or ideas on how
>>> to address this.
>>>
>>
>> And where is any of that resolution/new facts in the commit msg? You
>> must clearly reflect long discussions like that in the commit msg.
> 
> On that, I agree. That's a miss.
> 
>>
>> There was no objection from Chen to use clocks or power domains as I
>> requested.
> 
> Sorry Krzysztof, but now I really think that you don't understand the basics of
> MediaTek SoCs and how they're split in hardware - and I'm sorry again, but to me
> it really looks like that you're not even trying to understand it.

There is no DTS here. No diagrams or some simplified drawings to help me
understand.

> 
>> The objection was about DUPLICATING interfaces or nodes.
> 
> I don't see that duplication. The interface to each clock controller for each
> of the hardware subdomains of each controller is scattered all around the (broken
> by hardware and by concept, if you missed that in the discussion) HW Voter MMIO.
> 
> There are multiple clock controllers in the hardware.
> Each of those has its own interface to the HWV.
> 
> And there are some that require you to write to both its HWV interface and to the
> clock controller specific MMIO at the same time for the same operation. I explained
> that in the big discussion that Laura linked.

That's not what property description says. I discussed that part. Your
description says - to aggregate votes.

Above you say that control is split between two different MMIO blocks.

Aggregating votes is exactly what we discussed last time and you should
not use custom phandle for it.

Maybe it is just the name, so avoid all the confusing "votes" if this is
not voting system. If this is a voting system, then don't use custom
phandles.

Best regards,
Krzysztof


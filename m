Return-Path: <netdev+bounces-211597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79217B1A513
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D63B3186
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E5271450;
	Mon,  4 Aug 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZuhHqwjq"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE8E571;
	Mon,  4 Aug 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318162; cv=none; b=Zjpwfhmdd7jTpHFUz9yIXiNU5quUXFDjtbnVSAmxfmvoTHvf1PlchS60pPFyVmXKou9QKsrkq4sjcV8EbWGqU+Jnjhx7Y2foNOu8HxugSroiFeY+5yPDMMHQfVNNynFdZ0kX+5kWD5VPlxszLmzm8EXPtxQM+NEK3r2U78Vbq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318162; c=relaxed/simple;
	bh=sWaXa9Y+pMSXtZBUh/MPyteQ3dMc1Cweu4GCjbTzfro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qpi7D/WTDYnDrZfMR2hZCt1jdbb2N8Oeb51bUP1LdaSyp8nngmwWzrRt7ziXz5IrY8rCiB58c/bBrpnyWaYOUwTfJ5k3+freXKrGbo2wgdRH/6bBB/+qHk8tiwoIRk+HsLiZGp04hyt6Nq/evMurbTf4LCk/uQB/lvNjijsSiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZuhHqwjq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754318158;
	bh=sWaXa9Y+pMSXtZBUh/MPyteQ3dMc1Cweu4GCjbTzfro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZuhHqwjq+73WlntaHabAZHUCB+U/ijomZ3hYfYsyyoFIhD8clx+ycmXKN2gwQpMae
	 CbcYXeBNKXVXbufjrpWLQCcdwwh1/GZTy4TX7lbQ27ycPgZZyWAxvhIferpVfh8mcj
	 bkOyCOTbih0d8JB5iwVMRimtvLnB2vmikTx4GDlOOJtWjw6zFpESeZnpcc9kpO6pVX
	 cy8jd/MoEXJTu1qXnUlRQIr1ZFDl54Goa61QK1E6Y/hmttwde0tiCxfheKpKb+02fP
	 Rzu7OMcrWdYFbr6iAjyTv99vJoRnnxQlpMkjZp7CY0ORe4BxSUD/9wPOzpO+lE0zs6
	 fV4ZRwQqMGXtw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F3FFB17E0DD0;
	Mon,  4 Aug 2025 16:35:57 +0200 (CEST)
Message-ID: <4330785c-6564-4c66-b298-75655106e99f@collabora.com>
Date: Mon, 4 Aug 2025 16:35:57 +0200
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
 <00a12553-b248-4193-8017-22fea07ee196@collabora.com>
 <2555e9fe-3bc0-4f89-9d0b-2f7f946632e7@kernel.org>
 <ed0884fc-e43a-4f5b-8701-3645c406b37d@kernel.org>
 <3a499702-ba75-4d8a-b38d-222a62bffb34@collabora.com>
 <0fe4165d-f198-42cc-9c2f-f1e51bd96716@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <0fe4165d-f198-42cc-9c2f-f1e51bd96716@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/08/25 16:33, Krzysztof Kozlowski ha scritto:
> On 04/08/2025 16:31, AngeloGioacchino Del Regno wrote:
>> Il 04/08/25 16:19, Krzysztof Kozlowski ha scritto:
>>> On 04/08/2025 15:58, Krzysztof Kozlowski wrote:
>>>>>
>>>>> So, what should we do then?
>>>>>
>>>>> Change it to "mediatek,clock-hw-refcounter", and adding a comment to the binding
>>>>> saying that this is called "Hardware Voter (HWV)" in the datasheets?
>>>>>
>>>>> Or is using the "interconnect" property without any driver in the interconnect API
>>>>> actually legit? - Because to me it doesn't look like being legit (and if it is, it
>>>>> shouldn't be, as I'm sure that everyone would expect an interconnect API driver
>>>>> when encountering an "interconnect" property in DT), and if so, we should just add
>>>>
>>>> Why you would not add any interconnect driver for interconnect API?
>>>> Look, the current phandle allows you to poke in some other MMIO space
>>>> for the purpose of enabling the clock FOO? So interconnect or power
>>>> domains or whatever allows you to have existing or new driver to receive
>>>> xlate() and, when requested resources associated with clock FOO.
>>>
>>> Something got here cut. Last sentence is supposed to be:
>>>
>>> "So interconnect or power
>>> domains or whatever allows you to have existing or new driver to receive
>>> xlate() and, when requested, toggle the resources associated with clock
>>> FOO."
>>>
>>>>
>>>> Instead of the FOO clock driver poking resources, you do
>>>> clk_prepare_enable() or pm_domain or icc_enable().
>>>
>>> I looked now at the driver and see your clock drivers poking via regmap
>>> to other MMIO. That's exactly usecase of syscon and exactly the pattern
>>> *we are usually discouraging*. It's limited, non-scalable and vendor-driven.
>>>
>>
>> If the HWV wasn't BROKEN, I'd be the first one to go for generic stuff, but
>> since it is what it is, adding bloat to generic, non vendor-driven APIs would
>> be bad.
>>
>>> If this was a power domain provider then:
>>> 1. Your clock drivers would only do runtime PM.
>>
>> The clock drivers would have to get a list of power domain that is *equal to*
>> (in their amount) the list of clocks.
>> But then those are not power domains, as those registers in the MCU are ONLY
>> ungating a clock and nothing else in the current state of the hardware.
>>
>>> 2. Your MCU would be the power domain controller doing whatever is
>>> necessary - toggling these set/clr bits - when given clock is enabled.
>>
>> That MCU does support power domain voting (for two power domains in the main
>> PD Controller, and for all power domains in the multimedia PD controller), and
>> this is something completely separated from the *clock* controllers.
>>
>> Just to make the picture complete for you: the power domains that this MCU can
>> manage are not in any way related to the clocks that it can manage. At all.
> 
> 
> OK, thanks for explanations. Please rephrase commit msg and property
> description in v4. I am fine in using "hardware voter" terminology in
> some places, so it will match datasheet, but I want to make it clear
> that it is not voting for resources how we usually understand it. It's
> just syscon stuff, poking in other system-like device registers because
> hardware is like that.
> 

I'm happy that we finally reached a conclusion that works for both of us, and
I am sorry that all this went on for weeks with (very) long discussions.

Thanks for that.

Regards,
Angelo

> 
> Best regards,
> Krzysztof




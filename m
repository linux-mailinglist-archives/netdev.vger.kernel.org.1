Return-Path: <netdev+bounces-211521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1480B19EC1
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF171788B4
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E524469A;
	Mon,  4 Aug 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SL5z7Hhr"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AC24337D;
	Mon,  4 Aug 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299682; cv=none; b=hJV7IpZIDf2rdeTJ9+3Dgw7p8alAL60OTR3Sg+heaQ+QCtoDz+Gb7+kxzag8UheIkquqeMcnd9MAQP3OTVRz8z9bYcb1qNa1Vuir0j+iQDNeSSXKeLImKSoNjXm/QpiR0OyeNkMSF/mjW9fIdkKFKHM/ZUYyxiIADhVd94Lwcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299682; c=relaxed/simple;
	bh=LH7EqOf3AoVilTrkyp113dp+uJr0ORzeMHBnEtkb4Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8e0j/Yws2brEOme4N7KiMdMYSFUoCFwvJiA/SDWu0Qg8eB1tNp3P18o+2TvmjbkXJST++1AB+9D+ZrzRSMb2pM9cDak5rsDSf/QyNbEEESR4r3cH273K++vH9KAOElbgNdgxIDPr18Abtgv4hQ0PnX/kwvUkjjh66BFZAyTZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SL5z7Hhr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754299678;
	bh=LH7EqOf3AoVilTrkyp113dp+uJr0ORzeMHBnEtkb4Fw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SL5z7HhrZCD+bHt6ys6TBTbVFUWFxEV5hkIFT1afE5vLWkcsGZfrwaSoNKmeP/Z0s
	 WVxm0wU/qm+3r1lr/SF9I5k9ZCsNBI9vnsICfAPNHjiJbLR19PHgzbe786qzU+y1Fq
	 yZ3fE6eQbBCOyNbJROfvLyTk6VNzvPuaiNaTX7K2MAYBx83M4qkipSvBwniPwV1zYI
	 a2PlrbQVA1TryfGxwW6edcgmnsYBwsX6Um2fSk4SQ3YK0PZWkbKigly99uIlu3x/w+
	 yd0KXLZlT29zX74Xzm3t4dyEWRx8fU7+eU/Uy7GTN17BxJrePPiwVoRA4SqGdgJjcV
	 8Ho6rf6+rUSaw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18F9617E0B8C;
	Mon,  4 Aug 2025 11:27:57 +0200 (CEST)
Message-ID: <1db77784-a59a-49bd-89b5-9e81e6d3bafc@collabora.com>
Date: Mon, 4 Aug 2025 11:27:56 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <373f44c3-8a6a-4d52-ba6b-4c9484e2eac1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/08/25 11:16, Krzysztof Kozlowski ha scritto:
> On 04/08/2025 10:35, Laura Nao wrote:
>> Hi,
>>
>> On 8/3/25 10:17, Krzysztof Kozlowski wrote:
>>> On 01/08/2025 15:57, Rob Herring wrote:
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  '#clock-cells':
>>>>> +    const: 1
>>>>> +
>>>>> +  '#reset-cells':
>>>>> +    const: 1
>>>>> +    description:
>>>>> +      Reset lines for PEXTP0/1 and UFS blocks.
>>>>> +
>>>>> +  mediatek,hardware-voter:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>> +    description:
>>>>> +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
>>>>> +      MCU manages clock and power domain control across the AP and other
>>>>> +      remote processors. By aggregating their votes, it ensures clocks are
>>>>> +      safely enabled/disabled and power domains are active before register
>>>>> +      access.
>>>>
>>>> I thought this was going away based on v2 discussion?
>>>
>>> Yes, I asked to drop it and do not include it in v3. There was also
>>> discussion clarifying review.
>>>
>>> I am really surprised that review meant nothing and code is still the same.
>>>
>>
>> This has been re-submitted as-is, following the outcome of the discussion
>> here: https://lore.kernel.org/all/242bf682-cf8f-4469-8a0b-9ec982095f04@collabora.com/
>>
>> We haven't found a viable alternative to the current approach so far, and
>> the thread outlines why other options don’t apply. I'm happy to continue
>> the discussion there if anyone has further suggestions or ideas on how
>> to address this.
>>
> 
> And where is any of that resolution/new facts in the commit msg? You
> must clearly reflect long discussions like that in the commit msg.

On that, I agree. That's a miss.

> 
> There was no objection from Chen to use clocks or power domains as I
> requested.

Sorry Krzysztof, but now I really think that you don't understand the basics of
MediaTek SoCs and how they're split in hardware - and I'm sorry again, but to me
it really looks like that you're not even trying to understand it.

> The objection was about DUPLICATING interfaces or nodes.

I don't see that duplication. The interface to each clock controller for each
of the hardware subdomains of each controller is scattered all around the (broken
by hardware and by concept, if you missed that in the discussion) HW Voter MMIO.

There are multiple clock controllers in the hardware.
Each of those has its own interface to the HWV.

And there are some that require you to write to both its HWV interface and to the
clock controller specific MMIO at the same time for the same operation. I explained
that in the big discussion that Laura linked.

> 
> And what was the resolution:
> 
> "Regarding that to be a single clock controller,"
> 
> So where is the clock controller? I still see HW voter!

"especially the mux-gate clocks can't really be put in one single clock controller
because to manage those we have to write to the HWV *and* to the clock controller
MMIO"

Clarifying that, "the clock controller" -> "each clock controller of each hardware
subdomain" (not a single clock controller, excuse my bad wording).

Regards,
Angelo


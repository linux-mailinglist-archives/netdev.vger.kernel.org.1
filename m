Return-Path: <netdev+bounces-201134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85803AE8321
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18D1176726
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C62609F1;
	Wed, 25 Jun 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GbOkb+N1"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8DC1B4248;
	Wed, 25 Jun 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855724; cv=none; b=pGPnKCF7sOfSfDrrbCVfxh5P/9430rQVoGJbwQ9gg/zLroi09b2MM7Ikuuliz4cgTfB/xrAYxKZZAr4j9ub7edTCpuZMJzzaoy/71io3OpnZUzkECg3hpOFBYM9AwZQJ08mCglYPVj6cMf+FEkKUhCsdgEqSbxoDrnxFsMICSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855724; c=relaxed/simple;
	bh=zcJsv7RSUd1k6hYpfDkJX66HKFLsw5n2ZnJr/lyGLII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hheKe8QArML1KVfhYzizDzN+ToWsN7GAjOXIyOVUzqWYi26znbcP8Y3EfkdwUiVD8BUz7GBuyoE7UFF8JFPO0c8RwzI0pWBv/KosRjF9vH7EslfKu0SBExv7WPsPOcHG8cTljPASF6vAjyl8cGgFv9y0Ss2pG5dBo/gjVAz1tug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GbOkb+N1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750855720;
	bh=zcJsv7RSUd1k6hYpfDkJX66HKFLsw5n2ZnJr/lyGLII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GbOkb+N11olTudUbTceHiGbgWU4ugpVPHk7DG2+rYuY7IuICJKjPrkBPEap98VRiv
	 zsJGbeCSJmqlpPRbcOAnfE3A3Pkh+9UHYt9IbrnJ6cBDCBSClzPQogeKNc8JK4vvsi
	 euonaTxwPuaiUnmvQps3qdIMG92qduqrXdomHSBWutJ/daCpA9rL40MV3xyX74LEGB
	 HphiH3w2tYtX4vbMqBnDUkSz7H1V+l4aKxHWRgYz3narHbTvBHfHHZHBKX121okKIu
	 6Ex3wjzr51kNQumXFsYj7w+k21B0w5I/apx4pGEsxICksnATjE7KzAk1NuwFaxRCq0
	 FOScaYRCp1++Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD92F17E0CE7;
	Wed, 25 Jun 2025 14:48:39 +0200 (CEST)
Message-ID: <ae478fd7-c627-433c-a614-b76dcd4164d2@collabora.com>
Date: Wed, 25 Jun 2025 14:48:39 +0200
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
 <86654ad1-a2ab-4add-b9de-4d56c67f377b@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <86654ad1-a2ab-4add-b9de-4d56c67f377b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/06/25 13:06, Krzysztof Kozlowski ha scritto:
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
> 
> BTW:
> 
> git grep mediatek,hardware-voter
> 0 results
> 
> so I do not accept explanation that you use it in different drivers. Now
> is the first time this is being upstream, so now is the time when this
> is shaped.

I was simply trying to explain how I'm using it in the current design and nothing
else; and I am happy to understand what other solution could there be for this and
if there's anything cleaner.

You see what I do, and I'm *sure* that you definitely know that my goal is *not* to
just tick yet another box, but to make things right, - and with the best possible
shape and, especially, community agreement.

Cheers,
Angelo




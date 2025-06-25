Return-Path: <netdev+bounces-201020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE26AE7E07
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9081890DA2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386172BE7AA;
	Wed, 25 Jun 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GBU4AKGc"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36F29A303;
	Wed, 25 Jun 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844744; cv=none; b=tO02ZQPHU+cK5fC6Mh1/ChdAsKTNjYL2TkYgR/kYEqt5gTo5o5Bv84addc+MBodO6Klz9nUDufRU1EQGYbnRWuWoKO9eFCJW5lAnli0hP+45qJ+RqML8isi9vMvFdYnHIOmAL9q+gh81l+71Zzo+nEO4521iQXqKaI+QJpZ3zIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844744; c=relaxed/simple;
	bh=WGq9BnLFRlvgaj6JRyQGZWMVZ81/AYyKEllbs2pFfUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5dYSXqItUODp679RtJR7X9+KO826PbgxDzbgp54STqNt7l0tYZeQgGaFrzL3VBW4RTsWSkq8VZ+GJzsHe/2otby6S1xgHro6WhgnApRimZwh+CiZqws1BKnR3aHRsGneFNMzDYOlhEc2zJ0sIWfuInJ1ksAAHEUeAqZxEE68KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GBU4AKGc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750844739;
	bh=WGq9BnLFRlvgaj6JRyQGZWMVZ81/AYyKEllbs2pFfUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GBU4AKGca8KnCekeyVnEecyJmPoVJ7wlpqhQnR8iWTyHHoOmXtft89FJs/f+zClQV
	 hbB+VfZY7un9VwtAeD07AeKh1UjGVKVG0FXBySpj02ixuj48s0NNREvPRmj0d9EPD7
	 hSIJOAuxT7B8J5+oGL74kB+VAGj6Ot/Aizw8daZNKJV66x8egWZH/vgxHYgxIcSZaa
	 WmI79YohY/fz4whCsSj0MdwFqEGHo978IvhMhR13I0Nov+bqXurBJuTpdWIgcPj42X
	 3v82NQL/5x4kqHRLDpAuyf0qYvJ43Ib9grHcg+NmAWGMum2+fmyXCcLkwX19utj+VX
	 As/O7jLCKPSbg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B9EBB17E0CE3;
	Wed, 25 Jun 2025 11:45:38 +0200 (CEST)
Message-ID: <9fc32523-5009-4f48-8d82-6c3fd285801d@collabora.com>
Date: Wed, 25 Jun 2025 11:45:38 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <0870a2ba-936b-4eb2-a570-f2c9dea471b8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/06/25 10:57, Krzysztof Kozlowski ha scritto:
> On 25/06/2025 10:20, AngeloGioacchino Del Regno wrote:
>> Il 24/06/25 18:02, Krzysztof Kozlowski ha scritto:
>>> On 24/06/2025 16:32, Laura Nao wrote:
>>>> +  '#reset-cells':
>>>> +    const: 1
>>>> +    description:
>>>> +      Reset lines for PEXTP0/1 and UFS blocks.
>>>> +
>>>> +  mediatek,hardware-voter:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description:
>>>> +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
>>>> +      MCU manages clock and power domain control across the AP and other
>>>> +      remote processors. By aggregating their votes, it ensures clocks are
>>>> +      safely enabled/disabled and power domains are active before register
>>>> +      access.
>>>
>>> Resource voting is not via any phandle, but either interconnects or
>>> required opps for power domain.
>>
>> Sorry, I'm not sure who is actually misunderstanding what, here... let me try to
>> explain the situation:
>>
>> This is effectively used as a syscon - as in, the clock controllers need to perform
>> MMIO R/W on both the clock controller itself *and* has to place a vote to the clock
>> controller specific HWV register.
> 
> syscon is not the interface to place a vote for clocks. "clocks"
> property is.
> 
>>
>> This is done for MUX-GATE and GATE clocks, other than for power domains.
>>
>> Note that the HWV system is inside of the power domains controller, and it's split
>> on a per hardware macro-block basis (as per usual MediaTek hardware layout...).
>>
>> The HWV, therefore, does *not* vote for clock *rates* (so, modeling OPPs would be
>> a software quirk, I think?), does *not* manage bandwidth (and interconnect is for
>> voting BW only?), and is just a "switch to flip".
> 
> That's still clocks. Gate is a clock.
> 
>>
>> Is this happening because the description has to be improved and creating some
>> misunderstanding, or is it because we are underestimating and/or ignoring something
>> here?
>>
> 
> Other vendors, at least qcom, represent it properly - clocks. Sometimes
> they mix up and represent it as power domains, but that's because
> downstream is a mess and because we actually (at upstream) don't really
> know what is inside there - is it a clock or power domain.
> 

....but the hardware voter cannot be represented as a clock, because you use it
for clocks *or* power domains (but at the same time, and of course in different
drivers, and in different *intertwined* registers).

So the hardware voter itself (and/or bits inside of its registers) cannot be
represented as a clock :\

In the context of clocks, it's used for clocks, (and not touching power domains at
all), but in the context of power domains it's used for power domains (and not
touching clocks at all).

I'm not sure what qcom does - your reply makes me think that they did it such that
the clocks part is in a MMIO and the power domains part is in a different MMIO,
without having clock/pd intertwined voting registers...

Still not sure what to do here, then...

Cheers,
Angelo


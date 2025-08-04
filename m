Return-Path: <netdev+bounces-211588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A069B1A446
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916AE1704F3
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95B26D4DA;
	Mon,  4 Aug 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="koaccehe"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAE1DED4A;
	Mon,  4 Aug 2025 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316955; cv=none; b=X8sXxz20v+ZEwtWuZ6nx7uI/f3rwVioK/m7rh5oEAdnmTrQJkobJT9G/curc58HOchenf5gBBFr7ZxOgrWpkoqqMyoIf+AEwBnKnDpLvc7jmZ3OgDf1TdyrFX3FsmZytDdfQR15RM9fCr3SRbzXqdHmxBJQaYZaSOUonIAy5g0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316955; c=relaxed/simple;
	bh=tRn0xbDxVMK94MG9Cb3SGKBbHQrrDqm+3NMj4MZj5s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfBsy9FbyNFRvKN+ZpJBndGyhvkjCiHeSetLO3eDn9uI+kpW/fFNkwL2114aHQf6cLOfdsz3FmYjusOrc4k5VKU2X5UeiPebLv4O4vEoODLPZZTASv9t6ylKcbt+rTID43uwO8ytyoQ+3dkcyevpToH0NL8AiouhnACZ0Vv7skE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=koaccehe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754316950;
	bh=tRn0xbDxVMK94MG9Cb3SGKBbHQrrDqm+3NMj4MZj5s0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=koaccehefL7o3Jn8URhyuqKY0Yragys0YLh5NB4horLo+SxjExon6RFZ1q1t1pilF
	 4WTuPyLeOEXOScf9tpixGCN6z++ZlIm3wYpA+LEiG2wI9ARNlb4hav9qlLlasrKN6N
	 HTWLiNK2qnnKzZ42dIXDvHy//VkIGaTuwnIPIID6YYlcfnVk1jowrpW/YgDYzUdi4f
	 DHcaKZ5fsGmsp+PSJeBXUY97RuH1U7X6GNxvt/YR8TNR3HnVk3om1Qu+qN/hW5uUMK
	 KzQ+JiPfAETH+1nvL5Yor2V/03DeynnvCjBlvjsJXTE84z5bBbIZC3TgybCpX3qEUB
	 p+KaONoIpFM7Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 02B6517E153A;
	Mon,  4 Aug 2025 16:15:49 +0200 (CEST)
Message-ID: <62edb8e3-aff6-4225-b520-f4b73aef145d@collabora.com>
Date: Mon, 4 Aug 2025 16:15:49 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2555e9fe-3bc0-4f89-9d0b-2f7f946632e7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/08/25 15:58, Krzysztof Kozlowski ha scritto:
> On 04/08/2025 15:27, AngeloGioacchino Del Regno wrote:
>>
>> We discussed about aggregating votes, yes, in software - this instead is a
>> *broken* hardware that does the aggregation internally and does not require
>> nor want external drivers to do the aggregation.
>>
>>> Maybe it is just the name, so avoid all the confusing "votes" if this is
>>> not voting system. If this is a voting system, then don't use custom
>>> phandles.
>>
>> Being it fundamentally *broken*, this being a voting system is what the hardware
>> initially wanted to be - but effectively, since it requires YOU to:
>>    - Make sure that power supplies are turned on, if not, turn them on by "touching"
>>      HW registers (so, without any assistance from the voter MCU), if any;
>>    - Turn on parent clocks manually, if any, before using the "voter mcu" to try
>>      to ungate that clock; and
>>      - Enable the "FENC" manually, after the mcu says that the clock was ungated.
> 
> 
> I understand that "YOU" as Linux driver, when you want to do something
> (e.g. toggle) a clock?

"you" == Linux driver, yes.

> If so this looks a lot like power domain, although with some differences.
> 

A power domain ungates power to something.

These are clocks, giving a (x) (M)Hz signal to something.

>>
>> in the current state, it is just an hardware managed refcounting system and
>> nothing else, because the MCU seems to be unfinished, hence, again, b r o k e n.
>>
>> Note that by "manually" I always mean "with direct writes to a clock controller's
>> registerS, and without any automation/assistance from the HWV MCU".
>>
>> We're using the "hardware-voter" name because this is how MediaTek calls it in the
>> datasheets, and no it doesn't really *deserve* that name for what it is exactly in
>> MT8196 and MT6991.
> 
> Please capture most/all of this in the property description, so it will
> be clear that we treat it as some sort of exception and other users of
> that property would need similar rationale.
> 
> I am asking for this because I do not want this to be re-used for any
> other work which would represent something like real voting for
> resources. I want it to be clear for whoever looks at it later during
> new SoC bringup.

Okay, now that sounds reasonable, and that sounds like a clear suggestion with
a clear action to take.

Perfect.

Laura, please do exactly that.

P.S.: I understand what you're trying to do here, and I agree; preventing stuff
like this for things that aren't as broken as this is completely right.

> 
> If you send the same code as v4, the same commit msg, just like Laura
> did twice in v2 and v3, I will just keep NAKing via mutt macro because
> it's a waste of my time.
> 

My time isn't infinite, either :-)

>>
>> And mind you - if using the "interconnect" property for this means that we have to
>> add an interconnect driver for it, no, we will not do that, as placing a software
> 
> Existing driver(s) can be as well interconnect providers. Same with
> power domains.
> 
> I do not talk here how you should implement this in the drivers.
> 
>> vote that votes clocks in a a voter MCU that does exactly what the interconnect
> 
> What is a "software vote"? How did you encode it in DT? Via that phandle?
> 
>> driver would do - then requiring virtual/fake clocks - is not a good solution.
> 
> We do not add "software votes" in DT as separate properties, because
> they are "software". So maybe that's another problem here...
> 

Indeed - the point is, the only way to make this *broken* thing to work with an
interconnect provider would be to place a software vote to place a vote in the HW
voter, which would be ugly and wrong.

But anyway, a solution was reached. Let's just stop and avoid useless discussions
about what X could be if hardware Y wasn't broken; that'd be just a waste of time.

Regards,
Angelo

>>
>> So, what should we do then?
>>
>> Change it to "mediatek,clock-hw-refcounter", and adding a comment to the binding
>> saying that this is called "Hardware Voter (HWV)" in the datasheets?
>>
>> Or is using the "interconnect" property without any driver in the interconnect API
>> actually legit? - Because to me it doesn't look like being legit (and if it is, it
>> shouldn't be, as I'm sure that everyone would expect an interconnect API driver
>> when encountering an "interconnect" property in DT), and if so, we should just add
> 
> Why you would not add any interconnect driver for interconnect API?
> Look, the current phandle allows you to poke in some other MMIO space
> for the purpose of enabling the clock FOO? So interconnect or power
> domains or whatever allows you to have existing or new driver to receive
> xlate() and, when requested resources associated with clock FOO.
> 
> Instead of the FOO clock driver poking resources, you do
> clk_prepare_enable() or pm_domain or icc_enable().
> 
> 
> 
> Best regards,
> Krzysztof




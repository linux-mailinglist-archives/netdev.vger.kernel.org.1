Return-Path: <netdev+bounces-211594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98BB1A4F1
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D8218A1E7E
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E41126E712;
	Mon,  4 Aug 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U1/KmwBS"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351711713;
	Mon,  4 Aug 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317871; cv=none; b=twsNDpPKAVK9N0Wcp5kT98c4V7m+a5tnxBdroq3Uges5x02Op8xGwdhsDj7AuCSd7FYRxG/oCyZL0FYI+p7iDEMkXIPEOQojM3bNjgtNyCMv9Dr3ZJPGnccC1a04H3y5+L1Wg8iuo3XLQ+jtnLpQtUeBBPUS8UzjzlyAEqMLiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317871; c=relaxed/simple;
	bh=4Ew1ywqUKPBO3FXPRYx2L2fqAw4faKlxhYE2ck+WihQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbIHpEVPj8KSBPhbbieXFJs4i7rdgqTD2D9PfP0WGuUENkDOH79wgglw97RbkKC2O6zFo+kvpC0m02yUSKnVsRKkWhP2CuTr+9MpUDD8nKLL0AfxoSkbCp7R/h9VMlyAz7jx4o/vaaXpPeslzJCYhuyJPsks3pCteGc8pxeus90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U1/KmwBS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754317866;
	bh=4Ew1ywqUKPBO3FXPRYx2L2fqAw4faKlxhYE2ck+WihQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U1/KmwBSdPRaTX6WxZkf4hn47f/lTLATOi+gjmN8tRShdeQG6k1GbH645vXQpUQ1r
	 F0O9OIFMeooX6WriLO7TGJ0Id/o7NYW3Nckzy9qFOMTKBVbUyhYrDvJLvPxlI/7SL1
	 g8kJz86jAvMVSaQXsNV4e3+Ypk9YAR4unNFP/0vR+0cgfJBYv1k0YhZen6NRqFnIQY
	 E1ujbFBjsob7s1cpBuEqgOQnf5nft3fiLvpj39ezlEKqbxzZLJsWPHeQRBwFDaRbt2
	 6ChluzgqH6pXw4UGNDH1TS61z3WMm6twxNOO9LbsJbn7BPPxRWt5IjjWotbSe7OLy0
	 0DcScdV7Pqr4w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A729517E0DD0;
	Mon,  4 Aug 2025 16:31:05 +0200 (CEST)
Message-ID: <3a499702-ba75-4d8a-b38d-222a62bffb34@collabora.com>
Date: Mon, 4 Aug 2025 16:31:05 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ed0884fc-e43a-4f5b-8701-3645c406b37d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/08/25 16:19, Krzysztof Kozlowski ha scritto:
> On 04/08/2025 15:58, Krzysztof Kozlowski wrote:
>>>
>>> So, what should we do then?
>>>
>>> Change it to "mediatek,clock-hw-refcounter", and adding a comment to the binding
>>> saying that this is called "Hardware Voter (HWV)" in the datasheets?
>>>
>>> Or is using the "interconnect" property without any driver in the interconnect API
>>> actually legit? - Because to me it doesn't look like being legit (and if it is, it
>>> shouldn't be, as I'm sure that everyone would expect an interconnect API driver
>>> when encountering an "interconnect" property in DT), and if so, we should just add
>>
>> Why you would not add any interconnect driver for interconnect API?
>> Look, the current phandle allows you to poke in some other MMIO space
>> for the purpose of enabling the clock FOO? So interconnect or power
>> domains or whatever allows you to have existing or new driver to receive
>> xlate() and, when requested resources associated with clock FOO.
> 
> Something got here cut. Last sentence is supposed to be:
> 
> "So interconnect or power
> domains or whatever allows you to have existing or new driver to receive
> xlate() and, when requested, toggle the resources associated with clock
> FOO."
> 
>>
>> Instead of the FOO clock driver poking resources, you do
>> clk_prepare_enable() or pm_domain or icc_enable().
> 
> I looked now at the driver and see your clock drivers poking via regmap
> to other MMIO. That's exactly usecase of syscon and exactly the pattern
> *we are usually discouraging*. It's limited, non-scalable and vendor-driven.
> 

If the HWV wasn't BROKEN, I'd be the first one to go for generic stuff, but
since it is what it is, adding bloat to generic, non vendor-driven APIs would
be bad.

> If this was a power domain provider then:
> 1. Your clock drivers would only do runtime PM.

The clock drivers would have to get a list of power domain that is *equal to*
(in their amount) the list of clocks.
But then those are not power domains, as those registers in the MCU are ONLY
ungating a clock and nothing else in the current state of the hardware.

> 2. Your MCU would be the power domain controller doing whatever is
> necessary - toggling these set/clr bits - when given clock is enabled.

That MCU does support power domain voting (for two power domains in the main
PD Controller, and for all power domains in the multimedia PD controller), and
this is something completely separated from the *clock* controllers.

Just to make the picture complete for you: the power domains that this MCU can
manage are not in any way related to the clocks that it can manage. At all.

> And it really looks like what you described...
> 
> 
> Best regards,
> Krzysztof



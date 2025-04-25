Return-Path: <netdev+bounces-185900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638EA9C076
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D3716BABE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE8233704;
	Fri, 25 Apr 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bny011mn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D08232395;
	Fri, 25 Apr 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568539; cv=none; b=F92CnwbR+y5DgwV6DQtcOyIAF9Dq/YTGcJUAebQc2F2wfmBiYWCZtdjW68LFz/G4yr1JaAuV/ZN2F3vksvzAkaNC+HWd9U2Bf9nxeG4ZNzRallStZu1G8DVwu+6DdWhdSLPBsbyEClKTI0GiDlz1gDmqtK16Q64xrEf4UT0I/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568539; c=relaxed/simple;
	bh=gtRsuvmEISKz28EyTTx8EH0Xr4h+sH+AR8WuiCfVNRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqI1HcoGVW0gpZbdO4S9uadeaQ7X9HMUkUL9SH0gWLZeZscCsPsA/MTdSCTQ/BKwFEOnxmmYEQT62BLtTtmoAxIVtPx+gF0ZnAtuLEeTLxTVOaRoBDb4rjNp9MKuSUdht3bG7eO7gOj2aRNjanvEgWSAHavIqz94X85FR/OwwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bny011mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC61C4CEE4;
	Fri, 25 Apr 2025 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568539;
	bh=gtRsuvmEISKz28EyTTx8EH0Xr4h+sH+AR8WuiCfVNRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bny011mnmcqkpjlJhSmVb7MhrUlgc7SqH/Yxq41eN/4DXdB8yNKni+99jmij1Rxdt
	 KEZ2u2JrCIxxlv6qgs2cm0r5q5oNB0JKhXDwCfDBIZzljR5pXI5qncvipZ2OqU8jAX
	 tequWuknHqsnGhuedOR1fC21GdhSaGACDN6lhEfXn+0laIy5dWv7wZCVgOlFYEPLhk
	 8dXkMhCoFtngJ9EDLKpuNB9J8ZBnTNsW/Jo66256OnT6QwytmO/ehTa63vbGWUXnZf
	 6VlMQ96C757YYziDKe66jimlrDB48ri8cBFlKUURYQafSoBv8KiR7F1sqC+kaqp0uD
	 Q3Hx6tMBs7ahg==
Message-ID: <fc450dca-a1ba-4b9f-befa-f9643d9b1b82@kernel.org>
Date: Fri, 25 Apr 2025 10:08:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v7 4/7] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250423072911.3513073-1-lukma@denx.de>
 <20250423072911.3513073-5-lukma@denx.de> <20250424181110.2734cd0b@kernel.org>
 <0bf77ef6-d884-44d2-8ecc-a530fee215d1@kernel.org>
 <20250425080556.138922a8@wsk>
 <a5f54d46-6829-4d60-b453-9ee92e6b568c@kernel.org>
 <20250425094907.27740d07@wsk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250425094907.27740d07@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2025 09:49, Lukasz Majewski wrote:
> Hi Krzysztof, Jakub
> 
>> On 25/04/2025 08:05, Lukasz Majewski wrote:
>>> Hi Krzysztof, Jakub,
>>>   
>>>> On 25/04/2025 03:11, Jakub Kicinski wrote:  
>>>>> On Wed, 23 Apr 2025 09:29:08 +0200 Lukasz Majewski wrote:    
>>>>>> This patch series provides support for More Than IP L2 switch
>>>>>> embedded in the imx287 SoC.
>>>>>>
>>>>>> This is a two port switch (placed between uDMA[01] and
>>>>>> MAC-NET[01]), which can be used for offloading the network
>>>>>> traffic.
>>>>>>
>>>>>> It can be used interchangeably with current FEC driver - to be
>>>>>> more specific: one can use either of it, depending on the
>>>>>> requirements.
>>>>>>
>>>>>> The biggest difference is the usage of DMA - when FEC is used,
>>>>>> separate DMAs are available for each ENET-MAC block.
>>>>>> However, with switch enabled - only the DMA0 is used to
>>>>>> send/receive data to/form switch (and then switch sends them to
>>>>>> respecitive ports).    
>>>>>
>>>>> Lots of sparse warnings and build issues here, at least on x86.
>>>>>
>>>>> Could you make sure it's clean with an allmodconfig config, 
>>>>> something like:
>>>>>
>>>>> make C=1 W=1 drivers/net/ethernet/freescale/mtipsw/     
>>>>
>>>> ... and W=1 with clang as well.
>>>>  
>>>
>>> The sparse warnings are because of struct switch_t casting and
>>> register  
>>
>> clang W=1 fails on errors, so it is not only sparse:
>>
>> error: cast to smaller integer type 'uint' (aka 'unsigned int') from
>> 'struct cbd_t *' [-Werror,-Wpointer-to-int-cast]
>>
>> You probably wanted there kenel_ulong_t.
> 
> This I did not catch earlier (probably because of my testing on
> imx287). Thanks for spotting it.
> 
>>
>>> access with this paradigm (as it is done with other drivers).  
>>
>> I don't understand. I see code like:
>>
>> 	struct switch_t *fecp = fep->hwp;
>>
>> But this is not a cast - the same types.
> 
> For example:
> 
> The warning:
> 
> mtipl2sw.c:208:30: warning: incorrect type in argument 1 (different
> address spaces) mtipl2sw.c:208:30:    expected void const volatile
> [noderef] __iomem *addr mtipl2sw.c:208:30:    got unsigned int *
> 
> corresponds to:
>  info->maclo = readl(&fecp->ESW_LREC0);   [*]
> 
> where:
> 
> struct switch_t {
>         u32 ESW_REVISION;
>         u32 ESW_SCRATCH;
> 	...
>         /*from 0x420-0x4FC*/
>         u32 esw_reserved9[57];
>         /*0xFC0DC500---0xFC0DC508*/
>         u32 ESW_LREC0;
>         u32 ESW_LREC1;
>         u32 ESW_LSR;
> };
> 
> 
> The 'u32' type seems to be valid here as this register is 32 bit wide.

It is not about size, but IOMEM annotation and pointer/non-pointer.


> 
> To fix the sparse warnings - I think that I will replace [*] with:
> 
> info->maclo = readl((u32 __iomem *)&fecp->ESW_LREC0);

I don't understand why are you reading address of ESW_LREC0. This is
MMIO, right? So you are supposes to read base + offset (where base is a
proper iomem pointer).


Best regards,
Krzysztof


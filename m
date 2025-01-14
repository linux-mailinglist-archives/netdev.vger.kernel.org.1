Return-Path: <netdev+bounces-158050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EECA10418
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECCE1670D6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE15229639;
	Tue, 14 Jan 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jwbL0GKC"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E843229612
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850603; cv=none; b=UrJH2kroKsfOJT3W2REHR1b53jYLicW5sV0sbG0zFa7oxequCIoG5Z09eldZRjfZOk1ZdfnBbFTGBCk9V+zIBpDLrrV3bdMZtN62Zkihb/6sw+EgPmwX9mcLbY/34Nr6WlwKVlaUyYOW8TCSsHgD3tT7xiLf9ZKwOGHIhWQAAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850603; c=relaxed/simple;
	bh=JRmWpskUgFJC6TG3hbr+G20f5YLx+ZyrDyQJbdez9Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ulv+gHHsKrVN/EpZ7zxZio5l1P48etcpQimnNgm+QISNiDSIGfkPW5rQguHvXGDtoX+ITwiLbN3uljjSPQfMsZ2V68RxThhTU9NSlFTTVZRfHv65He9R1MiWAwNA45585ZNAWlovcvxKk6cKM5YbNpAkH9MSsU79EQXJC4E9qfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jwbL0GKC; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <52dab677-6ec9-4ae2-803f-1a2a34c32007@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736850599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GA/Tg/7baXnKm3SwQ55FP1056nxIRWPWVHxeGnzfrOw=;
	b=jwbL0GKCIehF3M3xckD3cBWjbhPRCEMzEavXLyL4y5L/V94tF6HT1FTrRQweF3EOUCan/A
	I0YTwI/haTiPydzelWmoiRk98CTdR5v6/A0FuXJWBHVFOuU12WncAKnqTr1P9VhNwz8t3r
	8yED/ivhpv/jPtwP6yHQnDJynDt7+jw=
Date: Tue, 14 Jan 2025 18:29:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: Paul Menzel <pmenzel@molgen.mpg.de>, Andrew Lunn <andrew@lunn.ch>
Cc: Joey Lu <a0987203069@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, netdev@vger.kernel.org,
 openbmc@lists.ozlabs.org, alexandre.torgue@foss.st.com,
 linux-kernel@vger.kernel.org, joabreu@synopsys.com, schung@nuvoton.com,
 peppe.cavallaro@st.com, yclu4@nuvoton.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250113055434.3377508-1-a0987203069@gmail.com>
 <20250113055434.3377508-4-a0987203069@gmail.com>
 <a30b338f-0a6f-47e7-922b-c637a6648a6d@molgen.mpg.de>
 <e7041d36-9bc7-482a-877d-6d8f549c0ada@lunn.ch>
 <d9fc5212-9710-449e-90b9-a195305d990f@molgen.mpg.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <d9fc5212-9710-449e-90b9-a195305d990f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/14 10:21, Paul Menzel 写道:
> Dear Andrew,
> 
> 
> Thank you for your quick reply.
> 
> 
> Am 14.01.25 um 21:16 schrieb Andrew Lunn:
>>>> +#define NVT_MISCR_RMII          BIT(0)
>>>> +
>>>> +/* 2000ps is mapped to 0x0 ~ 0xF */
>>>
>>> Excuse my ignorance: What is ps?
>>
>> picoseconds. An RGMII link needs a 2ns delay between the clock line
>> and the data lines. Some MACs allow you to tune the delay they can
>> insert, in this case in steps of 2ns / 16.
> 
> Thank you for the clarification. Maybe it’s my English, but I didn’t 
> deduce this from how the comment is worded. I do not have a better idea 
> either.

Hmmm, how about:

2000 ps is xxxx

I checked the kernel code and it looks like
folks usually put a space between the number
and the unit.

I looked into the rules of a bunch of publishers
again. It seems like there's a rule about putting
a space between a number and a unit, but when the
unit is a symbol, that's an exception:

space:

10 kg
10 ℃
10 h

no space:

22°36′48″N, 114°10′10″E


Thanks,
Yanteng


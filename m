Return-Path: <netdev+bounces-201068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4653CAE7F16
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F18189A494
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF729ACCB;
	Wed, 25 Jun 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gvfZ7xuy"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4129B220
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847056; cv=none; b=Yb8I7XlqBBta+eNmn1090Z+veTeTVII4TK9ZyfgvMfrjCjL+xrH9PTsBTw0ihJ6C7pomCbajIfFtf7kQznqVjRIUqp45JInZWw8DUK2mHtEUX7xZb2Pw9ZV8PJdC86coWtVnBqg65nsiEQ1XcEshS+XBujkHAVRd2EAdKjG3kCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847056; c=relaxed/simple;
	bh=N4ODkP2aCpb56KY1y5IRz3vLuysm4l9hlbfwa6uIkN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4e7jvZFQApbAHA4eUrRErEtTstcByzPb37LIoFvhqQlA+CHr3Nwn7Lt+r696tOtVrUO7kqDOOBBBGkeeBiIuzqha6VkTOtGDGRMJhO+5KBs6OHzSOXvbGYMeSysSKJoA5khpIkVj8G297XUH4DfiRon7jEfuHW+uSnjK8JqbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gvfZ7xuy; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2e330e5-82b8-4840-8506-b6bc2a58eda6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750847051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAz+93ZNhtCA9RuyrxciFUpZ+O91RX5qDUexSuei1O0=;
	b=gvfZ7xuymaWbuZiDvDe4ZcLeFj85FuVOp8bt9Y9gtXJZMgW+AQ2Kw3/87nrg0/2IUuIcp0
	Rheo7B93txiJiK6kSrdmwLRYqo43On5FEdLpboRitWhslb9PAMoScF2ycrdQDZ3Xykh1Ro
	f4NDD8HG+0jtjlXexBAqGoQr2y5BqB8=
Date: Wed, 25 Jun 2025 11:24:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next, 04/10] bng_en: Add initial interaction with firmware
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com,
 Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-5-vikas.gupta@broadcom.com>
 <4bf20b00-19bd-48f3-9d0c-3c8bde56ec47@linux.dev>
 <CAHLZf_u2e7Cm8-hkAy-bfcQ6QThwanYAFuRemi-FcNgh+rVprg@mail.gmail.com>
 <8d7d7d5b-c4f2-4063-81d6-8d17ec729c2c@linux.dev>
 <CAHLZf_svEKdeQPpvXrKGt-uKXQ0Zo-d+E3UvGYzH9h6fXudpVA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAHLZf_svEKdeQPpvXrKGt-uKXQ0Zo-d+E3UvGYzH9h6fXudpVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/06/2025 10:29, Vikas Gupta wrote:
> Hi Vadim,
> 
>>>>> +     req->year = cpu_to_le16(1900 + tm.tm_year);
>>>>> +     req->month = 1 + tm.tm_mon;
>>>>> +     req->day = tm.tm_mday;
>>>>> +     req->hour = tm.tm_hour;
>>>>> +     req->minute = tm.tm_min;
>>>>> +     req->second = tm.tm_sec;
>>>>> +     return hwrm_req_send(bd, req);
>>>>> +}
>>>>
>>>> This whole function looks like copy-paste from bnxt, did you consider
>>>> merging these parts?
>>>
>>> Both the bnxt and bnge drivers follow the same protocol to send the
>>> requests to  the firmware,
>>> so some functions may appear similar. However, we do not plan to share
>>> the code, as certain
>>>    fundamental data structures will differ.
>>
>> But at the same time some data structures are completely the same. Why
>> do you think code duplication will work better on long run?
> 
> In the long run, maintaining this driver for future hardware is more practical
> for us than integrating code into the BNXT driver.

I got it, my point was not in integrating it into BNXT, I totally agree
that it's more practical to have separate drivers for different
generations.

> Nevertheless, we are making a concerted effort to minimize duplication
> wherever feasible.
> So currently, we share the HSI (bnxt_hsi.h) as the driver to firmware
> protocol remains largely unchanged.
> While data structures are currently identical, but not all, we
> recognize this is due to the fundamental
> architectural similarities between the new and previous chip generations.
> Newer chip features will definitely change the data structures and
> related implementations.
> 
> Does this clarify your concern?

I was thinking of maybe creating a library with shared functions. But if
you say that data structures will change, I'm ok to have them
separately. Just be sure not to keep hacks for the really old HW.

Thanks,
Vadim

> 
> Thanks,
> Vikas



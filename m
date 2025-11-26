Return-Path: <netdev+bounces-241729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73781C87CF0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B50BD354A31
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7E22A4E8;
	Wed, 26 Nov 2025 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dw7qPRLn"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5391EE7DC
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764123424; cv=none; b=GF3A/H+1yJ79T6EU2KXh9JWLPQMq/DLGcu8LFL53jJ3RtWk15KyTAKR8fIJ1AA905tykOjQR2n852bkAXPWJNWJXex6s6I6Ql4cF7yjw8omipCqpTgJTpK/G2stSrr1tdze1+TKKdo0/N2m9t3Vnw7i8/DXxb/llXmjtwBzVW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764123424; c=relaxed/simple;
	bh=/tWrx/MnY6AKJaE4q79i4KUVbwYHDBE7SXmRCrj0fEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTK6EfyLVbshqxvkPwkZNd5wXVTdXwE0o003oL1vfwtCF/7X/C9HXEkU6DqIhEF8sZR3etw+2Sla9YW+ENsRFtNdzhckfobPRlwo0hg8fpf8DLjxTjHlPDRdneNdbbT+hpQQs7hq9Ww/jzbMTKJMuG/n8z23R+tpTPuDr5SlVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dw7qPRLn; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f9b3183-1aa1-4506-b4dc-3297a8f19928@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764123410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6HUMNDryA4piZEYrC2X4LuouZsF+ougkDJiYFbCSE4=;
	b=Dw7qPRLnoxTYwoymMqE+eRf1F2npYEEQUu73jGaYqyeUsdMq+gAbTKtCx742eULS6wXhcs
	Dh/PGQGMjoUZTpDYsjZYn98XeME9Jagx8vlRxr25xPeBkql3uKIftRfHnfl5f1JHPZ0QkL
	XIQ5CtqattPI9OgLb/2llxIXfAYyX54=
Date: Wed, 26 Nov 2025 10:16:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] page_pool: Add page_pool_release_stalled
 tracepoint
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Leon Huang Fu <leon.huangfu@shopee.com>
References: <20251125082207.356075-1-leon.hwang@linux.dev>
 <20251125112304.493ea1ee@gandalf.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20251125112304.493ea1ee@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 26/11/25 00:23, Steven Rostedt wrote:
> On Tue, 25 Nov 2025 16:22:07 +0800
> Leon Hwang <leon.hwang@linux.dev> wrote:
> 
>> +TRACE_EVENT(page_pool_release_stalled,
>> +
>> +	TP_PROTO(const struct page_pool *pool, int inflight, int sec),
>> +
>> +	TP_ARGS(pool, inflight, sec),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(const struct page_pool *, pool)
>> +		__field(int,			  inflight)
>> +		__field(int,			  sec)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->pool		= pool;
>> +		__entry->inflight	= inflight;
>> +		__entry->sec		= sec;
>> +	),
>> +
>> +	TP_printk("page_pool=%p id=%d inflight=%d sec=%d",
>> +		  __entry->pool, __entry->pool->user.id, __entry->inflight, __entry->sec)
> 
> You can't do: __entry->pool->user.id
> 
> The TP_fast_assign() is executed when the tracepoint is triggered. The
> TP_printk() is executed when the trace is read. That can happen seconds,
> minutes, hours, days, even months after the pool was assigned.
> 
> That __entry->pool can very well be freed a long time ago.
> 
> If you need the id, you need to record it in the TP_fast_assign():
> 
> 	__entry->id		= pool->user.id
> 
> and print that.
> 
> -- Steve
> 

Hi Steve,

Thanks for the review.

Yes, the id is needed here (similar to what we emit in pr_warn()), so
I'll follow your suggestion and record it explicitly in TP_fast_assign():

	__entry->id		= pool->user.id;

And then update the print format to:

	TP_printk("page_pool=%p id=%d inflight=%d sec=%d",
		  __entry->pool, __entry->id,
		  __entry->inflight, __entry->sec)

Thanks,
Leon


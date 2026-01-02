Return-Path: <netdev+bounces-246603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B20CEEED5
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 16:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E6C3045CC4
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176229A30E;
	Fri,  2 Jan 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjKtRe1d"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848B264619
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767369289; cv=none; b=tkIrecJJykYViz0JcYke2gjqpRSH5rr3j8J0WPq2A85TyhUG2VpJXFnFA3dmwzuEDBasuzoZF1MuXuMncSHVyDIPI/+/1iEu5i5mw8e8k2hjGkutaZ3gynKeypv/NaiICTJVlbYZSm0d4y+FFX12ymHrLLFtOQ33tcQ5JPP6u44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767369289; c=relaxed/simple;
	bh=AYNhkdmP1tJtXgCNHGe2xmAp1DrgVNe0CaWaSNBP0gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXf/bvcltvnMMet+G9p/fthbNQKa72xbXyjU5O8HXoepHFGvGqgT/Pi54wh+UFOsk0FqsMMWY0jzjlCgO+Nzc9xXq2N9Oid3CuzHD2XC/+PsM2OuKExOVEq4HrZI4wnMKsk2MQl0w4YdscGuSuqxorEaFSoCbY8KIdt9n4ZMqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjKtRe1d; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a8dcd09-fc28-4fbc-b8f5-a4f89d05a30a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767369275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ey84i6E6qnGgfsFMzS37RovpPPEFB2/BWeJmlqvfIJ4=;
	b=UjKtRe1dXL1CqhW2V4fM9Y6NwlE7pjwzey3eb9pown9nrD92SQRdmO8JZEBc8RzDqowKYy
	3WNlZU5q18f/XtFJmobpwmdeS0CBCLqjsnnturR2VQ3a2kQ7soK3dqJRR05MfPydPajyBi
	7UEAQ7Fx8i+0g16h9Eg3bMBabDH6Vvc=
Date: Fri, 2 Jan 2026 23:54:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] page_pool: Add page_pool_release_stalled
 tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Leon Huang Fu <leon.huangfu@shopee.com>
References: <20260102061718.210248-1-leon.hwang@linux.dev>
 <20260102104504.7f593441@gandalf.local.home>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260102104504.7f593441@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/2 23:45, Steven Rostedt wrote:
> On Fri,  2 Jan 2026 14:17:18 +0800
> Leon Hwang <leon.hwang@linux.dev> wrote:
> 
>> diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
>> index 31825ed30032..c34de6a5ae80 100644
>> --- a/include/trace/events/page_pool.h
>> +++ b/include/trace/events/page_pool.h
>> @@ -113,6 +113,30 @@ TRACE_EVENT(page_pool_update_nid,
>>  		  __entry->pool, __entry->pool_nid, __entry->new_nid)
>>  );
>>  
>> +TRACE_EVENT(page_pool_release_stalled,
>> +
>> +	TP_PROTO(const struct page_pool *pool, int inflight, int sec),
>> +
>> +	TP_ARGS(pool, inflight, sec),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(const struct page_pool *, pool)
>> +		__field(u32,			  id)
>> +		__field(int,			  inflight)
>> +		__field(int,			  sec)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->pool		= pool;
>> +		__entry->id		= pool->user.id;
>> +		__entry->inflight	= inflight;
>> +		__entry->sec		= sec;
>> +	),
>> +
>> +	TP_printk("page_pool=%p id=%d inflight=%d sec=%d",
>> +		  __entry->pool, __entry->id, __entry->inflight, __entry->sec)
>> +);
>> +
>>  #endif /* _TRACE_PAGE_POOL_H */
> 
> From a tracing POV, I see nothing wrong with this.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Hi Steve,

Thanks for the review!

I realized the id should be printed with '%u', so I've sent out v3 [1]
with that adjustment.

Links:
[1]
https://lore.kernel.org/netdev/20260102071745.291969-1-leon.hwang@linux.dev/

Thanks,
Leon



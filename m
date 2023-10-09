Return-Path: <netdev+bounces-39018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3797BD765
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B87281594
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC587168CE;
	Mon,  9 Oct 2023 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bG99yCTa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211E28ED
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 09:43:59 +0000 (UTC)
Received: from out-197.mta1.migadu.com (out-197.mta1.migadu.com [IPv6:2001:41d0:203:375::c5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCFF94
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 02:43:57 -0700 (PDT)
Message-ID: <68eb65c5-1870-0776-0878-694a8b002a6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696844635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0YOF8WiqWV3qWEelhaf9YObeiYly4thXLasaoZJfXw=;
	b=bG99yCTavxE57bN/sitJRBv3pvuXgFF9RvNFfRAPaLA/yw7LIq18IbInFcZFQahAQDzbrG
	YgvZMtphcWgi9sGRwruSxGXFM+LmJ86HtdVKsvysqZ+OcE7hl+tnmhZ1Sj7OAQv3ooAkqC
	ZxCWXIA1dcG1z4QhUKfmSa6R6xxV+UY=
Date: Mon, 9 Oct 2023 17:43:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, dennis@kernel.org,
 tj@kernel.org, cl@linux.com, mark.rutland@arm.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
 <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev>
 <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
 <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev>
 <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
 <4a747fda-2bb9-4231-66d6-31306184eec2@linux.dev>
 <814b5598-5284-9558-8f56-12a6f7a67187@linux.dev>
 <CANn89iJCTgWTu0mzwj-8_-HiWm4uErY=VASDHoYaod9Nq-ayPA@mail.gmail.com>
 <508b33f7-3dc0-4536-21f6-4a5e7ade2b5c@linux.dev>
 <CANn89i+r-pQGpen1mUhybmj+6ybhxSsuoaB07NFzOWyHUMFDNw@mail.gmail.com>
 <296ca17d-cff0-2d19-f620-eedab004ddde@linux.dev>
 <CANn89iL=W3fyuH_KawfhKvLyw2Cw=qhHbEZtbKgQEYhHJChy3Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <CANn89iL=W3fyuH_KawfhKvLyw2Cw=qhHbEZtbKgQEYhHJChy3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/10/9 17:30, Eric Dumazet wrote:
> On Mon, Oct 9, 2023 at 10:36 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>
>> On 2023/10/9 16:20, Eric Dumazet wrote:
>>> On Mon, Oct 9, 2023 at 10:14 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>> On 2023/10/9 15:53, Eric Dumazet wrote:
>>>>> On Mon, Oct 9, 2023 at 5:07 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>>
>>>>>> 'this_cpu_read + this_cpu_write' and 'pr_info + this_cpu_inc' will make
>>>>>> the trace work well.
>>>>>>
>>>>>> They all have 'pop' instructions in them. This may be the key to making
>>>>>> the trace work well.
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> I need your help on percpu and ftrace.
>>>>>>
>>>>> I do not think you made sure netdev_core_stats_inc() was never inlined.
>>>>>
>>>>> Adding more code in it is simply changing how the compiler decides to
>>>>> inline or not.
>>>> Yes, you are right. It needs to add the 'noinline' prefix. The
>>>> disassembly code will have 'pop'
>>>>
>>>> instruction.
>>>>
>>> The function was fine, you do not need anything like push or pop.
>>>
>>> The only needed stuff was the call __fentry__.
>>>
>>> The fact that the function was inlined for some invocations was the
>>> issue, because the trace point
>>> is only planted in the out of line function.
>>
>> But somehow the following code isn't inline? They didn't need to add the
>> 'noinline' prefix.
>>
>> +               field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
>> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
>>
>> Or
>> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;
>>
> I think you are very confused.
>
> You only want to trace netdev_core_stats_inc() entry point, not
> arbitrary pieces of it.


Yes, I will trace netdev_core_stats_inc() entry point. I mean to replace

+                                       field = (__force unsigned long 
__percpu *)((__force void *)p + offset);
+                                       this_cpu_inc(*field);

with

+               field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
+               WRITE_ONCE(*field, READ_ONCE(*field) + 1);

Or
+               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;

The netdev_core_stats_inc() entry point will work fine even if it doesn't
have 'noinline' prefix.

I don't know why this code needs to add 'noinline' prefix.
+               field = (__force unsigned long __percpu *)((__force void *)p + offset);
+               this_cpu_inc(*field);



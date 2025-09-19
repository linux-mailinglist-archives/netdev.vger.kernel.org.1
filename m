Return-Path: <netdev+bounces-224657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5AFB8793F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 03:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B843A86F7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D31F5617;
	Fri, 19 Sep 2025 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pc/0dPRN"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D6139D
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244491; cv=none; b=PYsfbjKrOwVVPv5B99QiwSjWhISPggXaIemvSKZy/RyU0mUQMHvGhfnHRGzwmrNWWp1Q41hOCL7M6dsD5SAh7bkYvJiFXf0WHwMq4+se6qg+XPKXYvf2wc6KBSiizd4e4yG5TrqA8pn/dRDgmxokEJwcFigBMfg0TvA+9c0hbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244491; c=relaxed/simple;
	bh=3REChC30H/tJKm5GSSKKHX7NiCWcPqID61RUN9Mqync=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSNX5nvq7Pg08yt8BSW1IrbkRbpIIGQ1gyDvjrUvuZGqvfg0TMMLKKaf1K3rP9g6JEzY8mS4Qi+jmp+qqlpCkImVwVFk/6MDV1lQP58hxQxSHWOJYS1AmIa98mOxoNK7KjUVYvmUPpY0ONxeXJ2+koVO25GnCXzISEyqP3P3+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pc/0dPRN; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eacd9a90-8c80-4e23-a193-f09d96fe24ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758244487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUYCZw/D9zyAWKZiRBOKohQldV5eYFv5bjvyLYwjRq8=;
	b=pc/0dPRNBEj9Y27c7fy3OPa4emDUbHlKOAVH7YWRs+fP/IHxVdge4JpT+th9/pT59/5lsO
	hlxhqgv/u72dae63GLAPiKdRrrXRqaQShj//MG0i4w1ajw5ODgFHUgt/0JQSq7JfpJq3WC
	wnT6th6RpjonFhCHPiFBZJcE0NtoL6M=
Date: Thu, 18 Sep 2025 18:14:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 bpf-next/net 6/6] selftest: bpf: Add test for
 SK_MEMCG_EXCLUSIVE.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250917191417.1056739-1-kuniyu@google.com>
 <20250917191417.1056739-7-kuniyu@google.com>
 <a706bb87-46e1-4524-8d35-8f22569a73e7@linux.dev>
 <CAAVpQUCoMkkGrPfqiL4C_3i5EG_THaYb0gT+qF7jyxreBJTSZw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAAVpQUCoMkkGrPfqiL4C_3i5EG_THaYb0gT+qF7jyxreBJTSZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/17/25 6:17 PM, Kuniyuki Iwashima wrote:
>>> +
>>> +close:
>>> +     for (i = 0; i < ARRAY_SIZE(sk); i++)
>>> +             close(sk[i]);
>>> +
>>> +     if (test_case->type == SOCK_DGRAM) {
>>> +             /* UDP recv queue is destroyed after RCU grace period.
>>> +              * With one kern_sync_rcu(), memory_allocated[0] of the
>>> +              * isoalted case often matches with memory_allocated[1]
>>> +              * of the preceding non-exclusive case.
>>> +              */
>> I don't think I understand the double kern_sync_rcu() below.
> With one kern_sync_rcu(), when I added bpf_printk() for memory_allocated,
> I sometimes saw two consecutive non-zero values, meaning memory_allocated[0]
> still see the previous test case result (memory_allocated[1]).
> ASSERT_LE() succeeds as expected, but somewhat unintentionally.
> 
> bpf_trace_printk: memory_allocated: 0 <-- non exclusive case
> bpf_trace_printk: memory_allocated: 4160
> bpf_trace_printk: memory_allocated: 4160 <-- exclusive case's
> memory_allocated[0]
> bpf_trace_printk: memory_allocated: 0
> bpf_trace_printk: memory_allocated: 0
> bpf_trace_printk: memory_allocated: 0
> 
> One kern_sync_rcu() is enough to kick call_rcu() + sk_destruct() but
> does not guarantee that it completes, so if the queue length was too long,
> the memory_allocated does not go down fast enough.
> 
> But now I don't see the flakiness with NR_SEND 32, and one
> kern_sync_rcu() might be enough unless the env is too slow...?

Ah, got it. I put you in the wrong path. It needs rcu_barrier() instead.

Is recv() enough? May be just recv(MSG_DONTWAIT) to consume it only for UDP 
socket? that will slow down the udp test... only read 1 byte and the remaining 
can be MSG_TRUNC?

btw, does the test need 64 sockets? is it because of the per socket snd/rcvbuf 
limitation?

Another option is to trace SEC("fexit/__sk_destruct") to ensure all the cleanup 
is done but seems overkill if recv() can do.


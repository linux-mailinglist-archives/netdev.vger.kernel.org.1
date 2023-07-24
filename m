Return-Path: <netdev+bounces-20249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E900775EA3F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 05:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274671C20988
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 03:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0569EC9;
	Mon, 24 Jul 2023 03:47:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549BEC5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:47:13 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D5DB
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 20:47:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6726d5d92afso3170489b3a.1
        for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 20:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690170431; x=1690775231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NSxBI+jZ4lM78HRKxD8ibkmyQyG/FtRFP+HyoBnx5I=;
        b=PgEeS0qOI+pKcrpPsv7cx17Jlt7Uzht14nwBIdBKNMvY9lkPJv+0Kt98k1wsdnIzG9
         iSOI7qakWbJdPnM6TsHMhEEbpc1/VybplhTM0PsZyroqv8Kmm0p+by7fpC7oedDAGnFJ
         eCmTNVgTyCAu5MVVme1Ez5G8PIxUSZqLfqn3iEHdI5GWl+HVWWK3XgVHPwP99qeED/Nr
         54QvjkQaaJj8zr0ff8BGNk0KBQ5UUrnePYxFm4YzSF3r0O2Nq3CP3fITV8nYm1kwMXkc
         ro+uz9JlKWbIcp26gzgXJ+gw4DKpOys7OSBDl5v5JwqaBhyejNeuuwKnv1Em5AkWiAPb
         jwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690170431; x=1690775231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NSxBI+jZ4lM78HRKxD8ibkmyQyG/FtRFP+HyoBnx5I=;
        b=DOPAlEggHpc8Mm5v0M/0BxduQaNrXDLMUI7pCxI8RLJPDbmhWp97kcUdvgGPz1cIbC
         wBKS+hMk8r8JmbPsP4WQUA9IB4E9SkITE1LisPT0ly31ExjCyPFyKLrU06ZoqBKCaOoh
         jcYsYeoMhOyste5TfZj7xp8h7YJli8qqCOFwG3/NKLzPs0kZdXHcVUXGZxyuSRvPjZoH
         AyNyWKruOJNYPaXVioFRjYhfz2KEJbgeRxXzE8KMFTnjxtAX9Mp4Fd+vu4jkBpwli6BJ
         t1isXDv3++mMzgTHYE5qKkIl3FIguJLaYaLoXis4Qr9T8IbZe4uOb60kYn0GGLpAIHo8
         avEQ==
X-Gm-Message-State: ABy/qLbIy0D0mCZiLz5d84hRAiL91MKZVBbHDfRTfV2paq5cj1uMd7g6
	qUxQKuTG+V90XxsrmCQ/eMh/yw==
X-Google-Smtp-Source: APBJJlEyQhIh1pIemHqUgQdKJnZFXDHmNxVzskhvDJZSJRCsJIVIOay9LorLBuwXEjozyQKE9n+Xqg==
X-Received: by 2002:a17:90b:195:b0:268:f2e:b480 with SMTP id t21-20020a17090b019500b002680f2eb480mr3628698pjs.11.1690170431458;
        Sun, 23 Jul 2023 20:47:11 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11bb:1457:9302:1528:c8f4? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id om5-20020a17090b3a8500b002677739860fsm5583934pjb.34.2023.07.23.20.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 20:47:10 -0700 (PDT)
Message-ID: <58e75f44-16e3-a40a-4c8a-0f61bbf393f9@bytedance.com>
Date: Mon, 24 Jul 2023 11:47:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators
 of sockmem pressure
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, David Ahern <dsahern@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao
 <yuzhao@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yafang Shao <laoar.shao@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Breno Leitao <leitao@debian.org>, David Howells <dhowells@redhat.com>,
 Jason Xing <kernelxing@tencent.com>, Xin Long <lucien.xin@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <cgroups@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <ZLsg1wklldKkVI2Z@P9FQF9L96D.corp.robot.car>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZLsg1wklldKkVI2Z@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Roman, thanks for taking time to have a look!

On 7/22/23 8:20 AM, Roman Gushchin wrote:
> On Tue, Jul 11, 2023 at 08:41:43PM +0800, Abel Wu wrote:
>> Now there are two indicators of socket memory pressure sit inside
>> struct mem_cgroup, socket_pressure and tcpmem_pressure.
> 
> Hi Abel!
> 
>> When in legacy mode aka. cgroupv1, the socket memory is charged
>> into a separate counter memcg->tcpmem rather than ->memory, so
>> the reclaim pressure of the memcg has nothing to do with socket's
>> pressure at all.
> 
> But we still might set memcg->socket_pressure and propagate the pressure,
> right?

Yes, but the pressure comes from memcg->socket_pressure does not mean
pressure in socket memory in cgroupv1, which might lead to premature
reclamation or throttling on socket memory allocation. As the following
example shows:

			->memory	->tcpmem
	limit		10G		10G
	usage		9G		4G
	pressure	true		false

the memcg's memory limits are both set to 10G, and the ->memory part
is suffering from reclaim pressure while ->tcpmem still has much room
for use. I have no idea why should treat the ->tcpmem as under pressure
in this scenario, am I missed something?

> If you're changing this, you need to provide a bit more data on why it's
> a good idea. I'm not saying the current status is perfect, but I think we need
> a bit more justification for this change.
> 
>> While for default mode, the ->tcpmem is simply
>> not used.
>>
>> So {socket,tcpmem}_pressure are only used in default/legacy mode
>> respectively. This patch fixes the pieces of code that make mixed
>> use of both.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/linux/memcontrol.h | 4 ++--
>>   mm/vmpressure.c            | 8 ++++++++
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 5818af8eca5a..5860c7f316b9 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1727,8 +1727,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
>>   void mem_cgroup_sk_free(struct sock *sk);
>>   static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
>>   {
>> -	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
>> -		return true;
>> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>> +		return !!memcg->tcpmem_pressure;
> 
> So here you can have something like
>     if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>          do {
>              if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
>                    return true;
>          } while ((memcg = parent_mem_cgroup(memcg)));
>     } else {
> 	return !!READ_ONCE(memcg->socket_pressure);
>     }

Yes, this looks better.

> 
> And, please, add a bold comment here or nearby the socket_pressure definition
> that it has a different semantics in the legacy and default modes.

Agreed.

> 
> Overall I think it's a good idea to clean these things up and thank you
> for working on this. But I wonder if we can make the next step and leave only
> one mechanism for both cgroup v1 and v2 instead of having this weird setup
> where memcg->socket_pressure is set differently from different paths on cgroup
> v1 and v2.

There is some difficulty in unifying the mechanism for both cgroup
designs. Throttling socket memory allocation when memcg is under
pressure only makes sense when socket memory and other usages are
sharing the same limit, which is not true for cgroupv1. Thoughts?

Thanks & Best,
	Abel


Return-Path: <netdev+bounces-27552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D714E77C61C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E1C1C20C1C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDAB17F6;
	Tue, 15 Aug 2023 02:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B96622
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:53:45 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE4173D
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:53:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6874d1c8610so3230890b3a.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692068023; x=1692672823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8HyUjDBkW62Y7ia/YRzhrRt6SI0MoeiKF06ymvveI4=;
        b=e5H6YSxaquRTypkZyjRtJDCwTmj5Z8r9Hx5apY8RhyinYxtJgLPHfj1RJYFYO+7j7h
         /XDrG7/16OKncrgd4rQzDKiDxmTxML7eTcIcJlApNVK7VwSPMRia945Nj3UpFZFqLVxr
         c+TJdcrrYEsJ2D+NPAvrqWZ/lcET6O9a7jF5NDA3w5oNdN00BW0X7ksw3eGvMmN4iAVv
         IPJTW3vBweY463qXeEMbiUcYWz3Ge+Zn5GN9ZdDLS+iEAXkLnBKigA9mtVVe0iPmHT/9
         HIfoGsl7xLunxJrwgoVyzkqCS1QH7hmlNRPFsL1uZKuEccnQq4wlLjkrsukuqlh8NNH1
         rMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692068023; x=1692672823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8HyUjDBkW62Y7ia/YRzhrRt6SI0MoeiKF06ymvveI4=;
        b=HapBAL6vsxFLRM4MAaXbt+fLNSG5dQJqzNAh/q8P41P4It0TD5MlNbbdyD5wl5fh1E
         fYfiEvBgdcm26v/K/QAdrg7SncDjsxa4Uwrtak/EwSROTFvqhx34sTc2gjSAODc/m4IZ
         0DJzkEdN8GImDwLp5PZ55PDuIxCgnRIEKgydvQoBk/lZGiN+TjXrw9TEDqOXHuM7P0Zm
         hntB3dhfLiK3hbsi8abZPKBlIWPQpEhrwZUjBGyAuBNk5YHxZzYROMROY2Dsx+WH5svI
         8CKrmA6SrXEaIWuFE3/l5MCXkgucrmky5Ga8vsIq21jK1QvYojvWFifKj2pWSADIj01u
         wXzw==
X-Gm-Message-State: AOJu0YyU6pJKFY7HqN9QIQ5H0jOZaKq3v4pBsc0IT6S4Q7wDHVIBTXx4
	Skucq22KepQDlfpu67uOy30kNA==
X-Google-Smtp-Source: AGHT+IHjc044e6npnV/BiafJF0UU9FsLZmr9i/ZW8Kkux8QHJDLaNlnB4TRHzQQqdetV8IlA/XzFsw==
X-Received: by 2002:a05:6a00:13a8:b0:682:2e99:9de0 with SMTP id t40-20020a056a0013a800b006822e999de0mr11561476pfg.23.1692068023296;
        Mon, 14 Aug 2023 19:53:43 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11bb:1457:9302:1528:c8f4? ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id g4-20020aa78744000000b00686f9789064sm8835581pfo.12.2023.08.14.19.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 19:53:42 -0700 (PDT)
Message-ID: <ef6a383f-56b0-9ac5-b358-1a29cf595a24@bytedance.com>
Date: Tue, 15 Aug 2023 10:53:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: Re: [PATCH net-next v2] net-memcg: Fix scope of sockmem pressure
 indicators
To: Shakeel Butt <shakeelb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, David Ahern <dsahern@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao
 <yuzhao@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yafang Shao <laoar.shao@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Breno Leitao <leitao@debian.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 David Howells <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <cgroups@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <linux-mm@kvack.org>
References: <20230814070923.35769-1-wuyun.abel@bytedance.com>
 <CALvZod5C3yWdgWr83EAdVUCH5PEK8ew7Q+FOt_zGOFOE9HVyQQ@mail.gmail.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CALvZod5C3yWdgWr83EAdVUCH5PEK8ew7Q+FOt_zGOFOE9HVyQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/23 4:18 AM, Shakeel Butt wrote:
> On Mon, Aug 14, 2023 at 12:09 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Now there are two indicators of socket memory pressure sit inside
>> struct mem_cgroup, socket_pressure and tcpmem_pressure, indicating
>> memory reclaim pressure in memcg->memory and ->tcpmem respectively.
>>
>> When in legacy mode (cgroupv1), the socket memory is charged into
>> ->tcpmem which is independent of ->memory, so socket_pressure has
>> nothing to do with socket's pressure at all. Things could be worse
>> by taking socket_pressure into consideration in legacy mode, as a
>> pressure in ->memory can lead to premature reclamation/throttling
>> in socket.
>>
>> While for the default mode (cgroupv2), the socket memory is charged
>> into ->memory, and ->tcpmem/->tcpmem_pressure are simply not used.
>>
>> So {socket,tcpmem}_pressure are only used in default/legacy mode
>> respectively for indicating socket memory pressure. This patch fixes
>> the pieces of code that make mixed use of both.
>>
>> Fixes: 8e8ae645249b ("mm: memcontrol: hook up vmpressure to socket pressure")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> So, this is undoing the unintended exposure of v2 functionality for

Exactly.

> the v1. I wonder if someone might have started depending upon that
> behavior but I am more convinced that no one is using v1's tcpmem
> accounting due to performance impact. So, this looks good to me.

Agreed. The performance impact is not negligible. While not accounting
tcpmem is also undesired for Resource Manager to do provision properly.
So we have to migrate to cgroupv2, and now we encountered a new issue.
Some discussion with Roman can be found here:

https://lore.kernel.org/netdev/29de901f-ae4c-a900-a553-17ec4f096f0e@bytedance.com/

It would be great if you can shed some light on this!

> 
> Acked-by: Shakeel Butt <shakeelb@google.com>

Thanks!
	Abel

> 
> I do think we should start the deprecation process of v1's tcpmem accounting.


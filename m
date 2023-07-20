Return-Path: <netdev+bounces-19368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88C75A873
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE77281C5C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31288171D2;
	Thu, 20 Jul 2023 07:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D0A5E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:59:06 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D50E213C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:59:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e916b880so276794b3a.2
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689839944; x=1690444744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCBG10jWmv8n11PUl1At+mRhQs+STyCHC9Y8ykk98hs=;
        b=Nnu9yXWnT11QAdbQ9GUhYKZSFFcUk0bsZdtUNqUMHxBWMFa6402Ny2yH5iQxEZhGtt
         Kz3XRv01VgrqlGSpLQm7E8BKzJTbIbnZkymzLZbp9YmpoHsQYwRejn13SBbT7IrQTO6U
         SSKMw0RKNd+ruoF1X7gd4bGzDUdn3VZamns/FpVKcyZVE8bZfh3ZB7SkwGWidjmpWE2S
         z1eYV6E/QnugvkY/taUn0a53MkAB3OHG65tL3psRnBqx/L04+GCvHT8xrBnv01/ZpdL0
         kXwHSiBUs/WAYR8ArUnjYyaQ6W/MAMWTQXpvjgTEogO5unsJNpTbyHBzDOtgtGFpgt0g
         Sp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839944; x=1690444744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCBG10jWmv8n11PUl1At+mRhQs+STyCHC9Y8ykk98hs=;
        b=ZBzZpFzpdIHHEjPbpc7v+EQHwwylwzQNi1rRpelaVgr9lROJfFhbRw3WxbmjAKF4g5
         uoAU0jVfW8zdjkULrM0mJQKDHWwD/PNWrAcjsCHwIZW8OrgMh0qpZPyhb/hrMPcwgPvI
         GX5PxRlNGQz5s3ZF8Re+FQD3uFQN7i33Zbdxjj9SVK0t92mPO0mGM94+g26WTTWNTQoA
         TsFwouNtu3yLFzyCzmKEihLaK9g6r29xWbcNKYDzJcu08za8ky8ZpNImzJq/pgbIOwgO
         N2ESGeazr0UJm6AtNV1jRSNjzs6AASVjGGL29WmuNBJMTAhoAjg+vP3E7UJj80+xuUFd
         7rEw==
X-Gm-Message-State: ABy/qLbEJ6GTUM7WjGkFKS0ZFnUA5ZrAU0ApYllzhmV9apEororcEmQj
	cr1/J0VMQjOYgIrdWMDUFhEXDA==
X-Google-Smtp-Source: APBJJlGQceyOTHuEAgshImHxzNJeR5JGceBNvAodrsHOmgwDK+Re8De+gti6K7ICOvS0ObBFvVOw/A==
X-Received: by 2002:a05:6a20:72a4:b0:133:f5c1:57bb with SMTP id o36-20020a056a2072a400b00133f5c157bbmr17999503pzk.20.1689839943740;
        Thu, 20 Jul 2023 00:59:03 -0700 (PDT)
Received: from [10.4.72.29] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001b895a17429sm579947plg.280.2023.07.20.00.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 00:59:03 -0700 (PDT)
Message-ID: <d114834c-2336-673f-f200-87fc6efb411f@bytedance.com>
Date: Thu, 20 Jul 2023 15:58:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators of
 sockmem pressure
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, David Ahern <dsahern@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao
 <yuzhao@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yafang Shao <laoar.shao@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Breno Leitao <leitao@debian.org>, David Howells <dhowells@redhat.com>,
 Jason Xing <kernelxing@tencent.com>, Xin Long <lucien.xin@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <cgroups@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230711124157.97169-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Gentle ping :)

On 7/11/23 8:41 PM, Abel Wu wrote:
> Now there are two indicators of socket memory pressure sit inside
> struct mem_cgroup, socket_pressure and tcpmem_pressure.
> 
> When in legacy mode aka. cgroupv1, the socket memory is charged
> into a separate counter memcg->tcpmem rather than ->memory, so
> the reclaim pressure of the memcg has nothing to do with socket's
> pressure at all. While for default mode, the ->tcpmem is simply
> not used.
> 
> So {socket,tcpmem}_pressure are only used in default/legacy mode
> respectively. This patch fixes the pieces of code that make mixed
> use of both.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   include/linux/memcontrol.h | 4 ++--
>   mm/vmpressure.c            | 8 ++++++++
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 


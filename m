Return-Path: <netdev+bounces-31839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1473A790AD2
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 06:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F561C20750
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 04:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D99EC3;
	Sun,  3 Sep 2023 04:55:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA57F0
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 04:55:07 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E3DCD6
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 21:55:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso3193245ad.1
        for <netdev@vger.kernel.org>; Sat, 02 Sep 2023 21:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693716904; x=1694321704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+U5CPjOKyPGHDpwnXP0B3NDICrZc2hSQHMD9gvWWzQ=;
        b=KEpqyDuSD13aFfriIa6Gh0EZ18ZuWmrF41R2zOE8WBE+FTwcBfvFcb3FJQcm4wVknZ
         KYuAvyedxxv1z8wIF8CjSB7GCMTCuT9JCp0DGb2sahR+4hVi3VHaAOKM+YJ7HE2VWLuQ
         kp0yeab6pN8yej7irYjltklWWPRfKDWu7L2peIzP874AVo4+jxxsHL93wW1Z0A4+lJgi
         1MssAmhjlzmq4ZCDOe5yxBXC0LWF/JtW5SA4TVo/DFisna7MKywq/qSnlnHs9X1x/iJ7
         uh0gGJ9W2VpB+ZZnINIxSl5vdDHL4WQTXmNK74dtgy6IpipezGtbq00+zlV/3v9X1d4M
         hhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693716904; x=1694321704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+U5CPjOKyPGHDpwnXP0B3NDICrZc2hSQHMD9gvWWzQ=;
        b=JgL3fKSMnM91LNGMvSs0qOLrEKinbTjEXHzZQQSCvmmeyXEnKC9IO8Rm5tjrWbExMr
         vVXxB4KhcTAlYbKmwScH2PlBrfGXqMO9eug5hb5+zU9T5/yLi0x2zeQZUGBbpvTn00sG
         S2z0IqbeleLPBIzVNo1ZWau3XOp8zlxjO1l0gQ+D4hVz+WuyW3eyassDUV8SqdFskmBY
         iVmH//9bfbTsCbhPLBqMjcyxRsybSVQc6gM3L6ed0f9SEyqbZf+C1+Nmo86KyjJX5uxy
         ITHplgoMUImxGlqKEIG0+i2ZRQmxdBvBbC+DfI6Tqu6vY0boYPpXuJ0JOp9XHYRPcMHW
         yauA==
X-Gm-Message-State: AOJu0Yz0vlJKwOoxgnopQifcrbSLzS8vBR956lQfxII6W5rrjXYx4ZUv
	QlAUNgsaa3VZinkHuT2SwP22ag==
X-Google-Smtp-Source: AGHT+IEZm84G9mzAoT4L/Z2t61RZFgqR47NnzrcVfwzvXzIuo/vipgN26tmwI1A7WWb/kkbrm2Z/rg==
X-Received: by 2002:a17:902:ef93:b0:1c1:dbd6:9bf6 with SMTP id iz19-20020a170902ef9300b001c1dbd69bf6mr5878849plb.41.1693716904671;
        Sat, 02 Sep 2023 21:55:04 -0700 (PDT)
Received: from [10.254.83.51] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001bc2831e1a9sm5301651plb.90.2023.09.02.21.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 21:55:04 -0700 (PDT)
Message-ID: <229c6f8d-b89b-1b85-8408-089c4cdf32a9@bytedance.com>
Date: Sun, 3 Sep 2023 12:54:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: Re: [RFC PATCH net-next 3/3] sock: Throttle pressure-aware
 sockets under pressure
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeelb@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Yu Zhao <yuzhao@google.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yafang Shao <laoar.shao@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Breno Leitao <leitao@debian.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 David Howells <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
 <20230901062141.51972-4-wuyun.abel@bytedance.com>
 <20230901135932.GH140739@kernel.org>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230901135932.GH140739@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon, thanks for reviewing!

On 9/1/23 9:59 PM, Simon Horman wrote:
> On Fri, Sep 01, 2023 at 02:21:28PM +0800, Abel Wu wrote:
>> @@ -3087,8 +3100,20 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>>   	if (sk_has_memory_pressure(sk)) {
>>   		u64 alloc;
>>   
>> -		if (!sk_under_memory_pressure(sk))
>> +		/* Be more conservative if the socket's memcg (or its
>> +		 * parents) is under reclaim pressure, try to possibly
>> +		 * avoid further memstall.
>> +		 */
>> +		if (under_memcg_pressure)
>> +			goto suppress_allocation;
>> +
>> +		if (!sk_under_global_memory_pressure(sk))
>>   			return 1;
>> +
>> +		/* Trying to be fair among all the sockets of same
>> +		 * protocal under global memory pressure, by allowing
> 
> nit: checkpatch.pl --codespell says, protocal -> protocol

Will fix in next version.

Thanks,
	Abel

> 
>> +		 * the ones that under average usage to raise.
>> +		 */
>>   		alloc = sk_sockets_allocated_read_positive(sk);
>>   		if (sk_prot_mem_limits(sk, 2) > alloc *
>>   		    sk_mem_pages(sk->sk_wmem_queued +
>> -- 
>> 2.37.3
>>
>>


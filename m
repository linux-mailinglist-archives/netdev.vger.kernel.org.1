Return-Path: <netdev+bounces-218137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB170B3B403
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8595C3AC4BC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3112253EE;
	Fri, 29 Aug 2025 07:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F5823F40C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451614; cv=none; b=HpvCAw4D+/Wd9qjGU9Ak3oMxf41PDTMnS2TyXd5XDbEM30SC7d3G7gBDbfnIE/Kbrkjmk9U52wX+EKdQyVv8A6RonDI7cQZdbwcmRJg8AE8De3ont+lYOufALhK1F5w9gBjVHn4VqGcY0y2UVZuV0RLPBv+2p5yzYWBCnwlfGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451614; c=relaxed/simple;
	bh=cx/p7+6edwHOtFOqMWTLNF24wlA995ty4dPrzYhYrQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XxJ+xfAS1Dhh9jBgOarmugMFnIS82SPXgzmp7ta1jDkt1XldKiZScwZ5pGv2c20nibnb6wMIz256usI2iQpIfvMcaSvy+yWkKmUAKwyieCzijPLNxaqpacPS6W4ua8CMGkKo3mQOqFz0KNel8XAfYH2w9x8ecGpXOJZA0rFa4Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cCqGM0NX7ztTPS;
	Fri, 29 Aug 2025 15:12:27 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A66E18006C;
	Fri, 29 Aug 2025 15:13:24 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 15:13:23 +0800
Message-ID: <e0d352b7-ee11-4a3d-9e76-289cf90fa6c5@huawei.com>
Date: Fri, 29 Aug 2025 15:13:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/3] inet: ping: remove ping_hash()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20250828164149.3304323-1-edumazet@google.com>
 <20250828164149.3304323-3-edumazet@google.com>
 <df07de96-5b35-4e64-ae9d-41fcdb73d484@huawei.com>
 <CANn89iJvMWSuuPmYG2GojejXcx6uaHEGH5hq3TKRP0QUhK_OZA@mail.gmail.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <CANn89iJvMWSuuPmYG2GojejXcx6uaHEGH5hq3TKRP0QUhK_OZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/29 14:57, Eric Dumazet wrote:
> On Thu, Aug 28, 2025 at 11:47 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>> On 2025/8/29 0:41, Eric Dumazet wrote:
>>> There is no point in keeping ping_hash().
>>>
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Reviewed-by: David Ahern <dsahern@kernel.org>
>>> ---
>>>  net/ipv4/ping.c | 10 ----------
>>>  net/ipv6/ping.c |  1 -
>>>  2 files changed, 11 deletions(-)
>>>
>>> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
>>> index 74a0beddfcc41d8ba17792a11a9d027c9d590bac..75e1b0f5c697653e79166fde5f312f46b471344a 100644
>>> --- a/net/ipv4/ping.c
>>> +++ b/net/ipv4/ping.c
>>> @@ -67,7 +67,6 @@ static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
>>>       pr_debug("hash(%u) = %u\n", num, res);
>>>       return res;
>>>  }
>>> -EXPORT_SYMBOL_GPL(ping_hash);
>>
>> The declaration should also be removed
>>
>> include/net/ping.h:58:void ping_unhash(struct sock *sk);
> 
> Right, but you probably meant

Sure，I have a copy_paste mistake.
> 
> include/net/ping.h:57:int ping_hash(struct sock *sk);


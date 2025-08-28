Return-Path: <netdev+bounces-217607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239CB39412
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D781BA2856
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB82284B25;
	Thu, 28 Aug 2025 06:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2B27B344;
	Thu, 28 Aug 2025 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363457; cv=none; b=H/sjbbZ2WzVt0J2rUJxRVn0qN3grPdH97+2zNJHUaUdP9wWHvXPquX2kd64fQMO7xpRPlTMahY/vPYIrn4mDaNpnZ0EPms53/qvl5JYmAUJWha9UHgrbut5v0wqxTS/9kD57e4nnSIuR3s7jCepSTs92plb4gXZWCT5+ti7QXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363457; c=relaxed/simple;
	bh=8zZBLR8WpA2QUeNR1rr53cjyWEPuk80dOXfqigSquRg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ONgmDb0nA9A/FDXAw9s5YQTtdHsUZZOzRRwP7rZLw0ZVaf2SksuQHegs9j8t6r0xgwkw1Snx/ZvTAtMjeAHAoBbm22xubKds7MEssAyckXSosPuoa4ONS96Y6Y5HjJ3DJuHowqsAqPvphLRnTTb7MTTrfRQZ+WVq9SpK8HDNOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cCBjR2sG2z27jM8;
	Thu, 28 Aug 2025 14:45:15 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DD0618005F;
	Thu, 28 Aug 2025 14:44:08 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 14:44:07 +0800
Message-ID: <83aeba1c-27ff-4a92-b91e-5719be879e7a@huawei.com>
Date: Thu, 28 Aug 2025 14:44:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for
 cleanup
From: Yue Haibing <yuehaibing@huawei.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250827040027.1013335-1-yuehaibing@huawei.com>
 <ec71f1cd-89b9-4a18-bcc6-0bac6f6660d0@intel.com>
 <5b0d6d7c-b65e-4022-b028-05f45fe56bf9@huawei.com>
Content-Language: en-US
In-Reply-To: <5b0d6d7c-b65e-4022-b028-05f45fe56bf9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/28 14:13, Yue Haibing wrote:
> On 2025/8/27 22:45, Alexander Lobakin wrote:
>> From: Yue Haibing <yuehaibing@huawei.com>
>> Date: Wed, 27 Aug 2025 12:00:27 +0800
>>
>>> Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
>>> ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.
>>>
>>> No functional change intended.
>>
>> ...but bloat-o-meter stats would be nice to see here. I'm curious
>> whether the object code got any changes or the compilers still just
>> inline this function to both call sites.

On a x86_64, with allmodconfig:

./scripts/bloat-o-meter -c net/ipv6/sit.o net/ipv6/sit-after.o
add/remove: 2/0 grow/shrink: 1/1 up/down: 1770/-2152 (-382)
Function                                     old     new   delta
ipip6_tunnel_dst_find                          -    1697   +1697
__pfx_ipip6_tunnel_dst_find                    -      64     +64
ipip6_tunnel_xmit.isra.cold                   79      88      +9
ipip6_tunnel_xmit.isra                      9910    7758   -2152
Total: Before=70060, After=69678, chg -0.55%
add/remove: 2/2 grow/shrink: 0/1 up/down: 16/-72 (-56)
Data                                         old     new   delta
__UNIQUE_ID___addressable_init_module2092       -       8      +8
__UNIQUE_ID___addressable_cleanup_module2093       -       8      +8
__UNIQUE_ID___addressable_init_module2093       8       -      -8
__UNIQUE_ID___addressable_cleanup_module2094       8       -      -8
descriptor                                   112      56     -56
Total: Before=752, After=696, chg -7.45%
add/remove: 1/1 grow/shrink: 2/2 up/down: 55/-51 (4)
RO Data                                      old     new   delta
__UNIQUE_ID_modinfo2094                        -      43     +43
__UNIQUE_ID_modinfo2096                       12      20      +8
__func__                                      55      59      +4
__UNIQUE_ID_modinfo2097                       20      18      -2
__UNIQUE_ID_modinfo2098                       18       -     -18
__UNIQUE_ID_modinfo2095                       43      12     -31
Total: Before=1725, After=1729, chg +0.23%


> 
> On a x86_64, with allmodconfig:
> before:
>    text    data     bss     dec     hex filename
>   96973   14687     256  111916   1b52c net/ipv6/sit.o
> 
> after:
>    text    data     bss     dec     hex filename
>   96699   14599     256  111554   1b3c2 net/ipv6/sit.o
> 
> I will add this in v2.
> 
>>
>>>
>>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>>> ---
>>>  net/ipv6/sit.c | 93 +++++++++++++++++++++++---------------------------
>>>  1 file changed, 43 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
>>> index 12496ba1b7d4..bcd261ff985b 100644
>>> --- a/net/ipv6/sit.c
>>> +++ b/net/ipv6/sit.c
>>> @@ -848,6 +848,47 @@ static inline __be32 try_6rd(struct ip_tunnel *tunnel,
>>>  	return dst;
>>>  }
>>>  
>>> +static bool ipip6_tunnel_dst_find(struct sk_buff *skb, __be32 *dst,
>>> +				  bool is_isatap)
>>> +{
>>> +	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
>>> +	struct neighbour *neigh = NULL;
>>> +	const struct in6_addr *addr6;
>>> +	bool found = false;
>>> +	int addr_type;
>>> +
>>> +	if (skb_dst(skb))
>>> +		neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
>>> +
>>> +	if (!neigh) {
>>> +		net_dbg_ratelimited("nexthop == NULL\n");
>>> +		return found;
>>
>> Return false here right away.
>>
>>> +	}
>>> +
>>> +	addr6 = (const struct in6_addr *)&neigh->primary_key;
>>> +	addr_type = ipv6_addr_type(addr6);
>>> +
>>> +	if (is_isatap) {
>>> +		if ((addr_type & IPV6_ADDR_UNICAST) &&
>>> +		    ipv6_addr_is_isatap(addr6)) {
>>> +			*dst = addr6->s6_addr32[3];
>>> +			found = true;
>>> +		}
>>> +	} else {
>>> +		if (addr_type == IPV6_ADDR_ANY) {
>>> +			addr6 = &ipv6_hdr(skb)->daddr;
>>> +			addr_type = ipv6_addr_type(addr6);
>>> +		}
>>> +
>>> +		if ((addr_type & IPV6_ADDR_COMPATv4) != 0) {
>>> +			*dst = addr6->s6_addr32[3];
>>> +			found = true;
>>> +		}
>>> +	}
>>> +	neigh_release(neigh);
>>> +	return found;
>>
>> I'd put 2 additional newlines here:
>>
>> 	}
>>
>> 	neigh_release(neigh);
>>
>> 	return found;
>> }
>>
>> for readability purposes and also a NL before the final `return` is
>> usually mandatory.
> 
> OK， thanks.
>>
>> Thanks,
>> Olek
>>
> 
> 


Return-Path: <netdev+bounces-216945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E84DEB36496
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5F31BC7A2C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28E62AD04;
	Tue, 26 Aug 2025 13:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C683376BA;
	Tue, 26 Aug 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215171; cv=none; b=DY2EJgtWGt4paAdGTwK8huCtDky+ohewix3KB9OQzIssAoTBATO79XSr1vQCLYXrDsEGWy+2/TlmIHenGkTm0IefmIsOqMPpgPKVlwsW05olCJ9YoZ2GWjoqfym2Hs25/eIgN/tldYsLjH0G039lfAPgJlc4hFAzHS3n2jvGnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215171; c=relaxed/simple;
	bh=2P/jEUIrcly5M6ffvXr+n6/JwLUJRxYguv1L+Q/9jP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qOFiQUn78tQc3rpOhAe9KSDMS2T2UTaI/V2DUwg5usgZOsGwIS86WXsQAijCp1bfjRWmvSOnQ8j4fsi35a5lkF4JvTWd8tEi/xwfHIOLQ7NWVCVl1Xn/HI7Al1/q+jIkLEvxLdN/WytqjVlB7x2NQXTArl3ihLh8WvItIUeXULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cB7lQ0x1JzdcGS;
	Tue, 26 Aug 2025 21:28:18 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DAC1C18048F;
	Tue, 26 Aug 2025 21:32:43 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 21:32:42 +0800
Message-ID: <ab973374-88cd-4b06-986f-56393b32ce06@huawei.com>
Date: Tue, 26 Aug 2025 21:32:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: annotate data-races around
 devconf->rpl_seg_enabled
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250826025206.303325-1-yuehaibing@huawei.com>
 <CAAVpQUDA5gCi--n9N7PQZC3rDBxhZxMW8AUFoaGs+09oT6Vebg@mail.gmail.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <CAAVpQUDA5gCi--n9N7PQZC3rDBxhZxMW8AUFoaGs+09oT6Vebg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/26 11:17, Kuniyuki Iwashima wrote:
> On Mon, Aug 25, 2025 at 7:51 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>> devconf->rpl_seg_enabled can be changed concurrently from
>> /proc/sys/net/ipv6/conf, annotate lockless reads on it.
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  net/ipv6/exthdrs.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
>> index d1ef9644f826..a23eb8734e15 100644
>> --- a/net/ipv6/exthdrs.c
>> +++ b/net/ipv6/exthdrs.c
>> @@ -494,10 +494,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>>
>>         idev = __in6_dev_get(skb->dev);
>>
>> -       accept_rpl_seg = net->ipv6.devconf_all->rpl_seg_enabled;
>> -       if (accept_rpl_seg > idev->cnf.rpl_seg_enabled)
>> -               accept_rpl_seg = idev->cnf.rpl_seg_enabled;
>> -
>> +       accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
>> +                            READ_ONCE(idev->cnf.rpl_seg_enabled));
>>         if (!accept_rpl_seg) {
> 
> Orthogonal to this change, but rpl_seg_enabled is missing .extra1/2
> or this condition should be adjusted like other knobs that recognises
>  <0 as disabled, .e.g. keep_addr_on_down, etc.

Thanks, will add .extra1/2 check for this in v2.

> 
> 
>>                 kfree_skb(skb);
>>                 return -1;
>> --
>> 2.34.1
>>
> 


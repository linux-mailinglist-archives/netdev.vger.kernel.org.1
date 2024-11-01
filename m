Return-Path: <netdev+bounces-140959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F619B8DE4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2DF1F22E24
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C910115B111;
	Fri,  1 Nov 2024 09:31:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC015B971
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730453493; cv=none; b=UXq8Pta0P56I7X2y+fwma7Zh4Br/p0ukCXPwtviJKTDMuddjahutgmmEWkkV3N8Rbw8zrLhIyUNq9fkBC2m9ljz16e7d9KllHL7lCshFqtwG3+0frTkGN5E0B2yfcGloL3HUZ0W+SHr6VxNa/ZNyOPA02BYeWvgaxd/IpaZZtgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730453493; c=relaxed/simple;
	bh=V7vhY+bZ5LH62o5Xo6aKqkv2PBOz1KjfC9w9krZrc8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cgle5SoC+hrHXHfxc22KrZk43hWPSEuFmgNLxKRezgVgnYr3wzDqtVtwFDnFQ9eePIYVGomgx7YDzCHy+N+Fh2WqeFUb9L3xmgHaQd1DWVJKDHcS6yCrwnHg2Y40alqC2etjtQEspYdhK3/3ipuzK9VN+ndywyqIEmKklk9qnuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XfwYh0js8z2Fbny;
	Fri,  1 Nov 2024 17:29:44 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id AEEC114035F;
	Fri,  1 Nov 2024 17:31:18 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 17:31:17 +0800
Message-ID: <22c2a6ff-531f-4044-92b7-c9616642c733@huawei.com>
Date: Fri, 1 Nov 2024 17:31:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bcmasp: Add missing of_node_get() before
 of_find_node_by_name()
To: Andrew Lunn <andrew@lunn.ch>
CC: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <o.rempel@pengutronix.de>,
	<kory.maincent@bootlin.com>, <horms@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<chenjun102@huawei.com>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
 <20241024015909.58654-2-zhangzekun11@huawei.com>
 <d3c3c6b5-499a-4890-9829-ae39022fec87@lunn.ch>
 <9ed41df0-7d35-4f64-87d7-e0717d9c172b@huawei.com>
 <0c9ea6c2-535d-4ce8-aea1-7523b5304635@lunn.ch>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <0c9ea6c2-535d-4ce8-aea1-7523b5304635@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)



在 2024/10/25 21:14, Andrew Lunn 写道:
> On Fri, Oct 25, 2024 at 10:41:22AM +0800, zhangzekun (A) wrote:
>>
>>
>> 在 2024/10/24 19:56, Andrew Lunn 写道:
>>> On Thu, Oct 24, 2024 at 09:59:08AM +0800, Zhang Zekun wrote:
>>>> of_find_node_by_name() will decrease the refcount of the device_node.
>>>> So, get the device_node before passing to it.
>>>
>>> This seems like an odd design. Why does it decrement the reference
>>> count?
>>>
>>> Rather than adding missing of_node_get() everywhere, should we be
>>> thinking about the design and fixing it to be more logical?
>>>
>>> 	Andrew
>>
>> Hi, Andrew,
>>
>> of_find* API is used as a iterater of the for loop defined in
>> "include/linux/of.h", which is already wildly used. I think is reasonable to
>> put the previous node when implement a loop, besides, the functionality has
>> been documented before the definiton of of_find* APIs.
>> The logical change of these series of APIs would require a large number of
>> conversions in the driver subsys, and I don't think it it necessary.
> 
> Do you have a rough idea how many missing gets there are because of
> this poor design?
> 
> A quick back of the envelope analysis, which will be inaccurate...
> 
> $ grep -r of_find_node_by_name | wc
>       68     348    5154
> 
> Now, a lot of these pass NULL as the node pointer:
> 
> $ grep -r of_find_node_by_name | grep NULL | wc
>       47     232    3456
> 
> so there are only about 20 call sites which are interesting. Have you
> looked at them all?
> 
> What percentage of these are not in a loop and hence don't want the
> decrement?
> 
> What percentage are broken?
> 
> We have to assume a similar number of new instances will also be
> broken, so you have an endless job of fixing these new broken cases as
> they are added.
> 
> If you found that 15 of the 20 are broken, it makes little difference
> changing the call to one which is not broken by design. If it is only
> 5 from 20 which are broken, then yes, it might be considered pointless
> churn changing them all, and you have a little job for life...
> 
> 	Andrew

Hi, Andrew,

There are about 10/20 call sites might have this problem, spreading in 
six files. May be we can fix these problems instead of adding a new API?

Thanks,
Zekun


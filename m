Return-Path: <netdev+bounces-129643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4E985121
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 04:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67307B228CB
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57E148FE6;
	Wed, 25 Sep 2024 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rMPFKytj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB6130E58;
	Wed, 25 Sep 2024 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233056; cv=none; b=YDAMZMo2qSoqQAuHxq6oSP0m75/vU20JhoO2SaKZLsZM7EIwSzR77fRCIch/jSWUFaq2DcYd49F4dUqNEzkeq2pVTNQiIy/rtWQPNdwfBiA76ZfZOj5J0j6W9JDrypFvByH/zg1ttfM5pq3cHQjq5OWr+MfAkz9tmPfoOzLp81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233056; c=relaxed/simple;
	bh=R2RJ7l+Eb6FbAZJXjRsY8f+2nozGaTBMfNV+zXgvonc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0T9MgACXPmVUWMOpAl9LV7FYpWNQ9XuXYyGTo2i9Bcn4wHieHc8O4ncUlNn837WANgvPxTJkyGPSor/jtUmVuEi0mSGXNjWn8srg7DnMl83fjLWiyPmJx342vbDJTeq4uSAM3PqTy08ohPeEnldzec+47lUVkdvALSODZXtaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rMPFKytj; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727233050; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bQwYUC4FT+aFcJ4E0MXChh0bNog0WSgq5FbQ3SZqSFY=;
	b=rMPFKytj/HjSaYtQSo3Oj1x0Y2Dt19Rin/mmtq7EzXnF2aB3vZdyi41fOcoyXBlweWg1w1lVAVKAXbXgNjzKlEcdsOR0xSkAgJzznpCfEfF8xAt5MC53d3HBUL6vQaGu0cYG4zM/VrMSSGw871FGolg5+JfFRhw+sTXjs2vc38M=
Received: from 30.221.128.100(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFi20yv_1727233048)
          by smtp.aliyun-inc.com;
          Wed, 25 Sep 2024 10:57:29 +0800
Message-ID: <7fdfc76d-cf7d-47f3-afcf-c963c44f01b7@linux.alibaba.com>
Date: Wed, 25 Sep 2024 10:57:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 net-next 1/3] net/udp: Add a new struct for hash2
 slot
To: Gur Stavi <gur.stavi@huawei.com>
Cc: antony.antony@secunet.com, davem@davemloft.net, dsahern@kernel.org,
 dust.li@linux.alibaba.com, edumazet@google.com, fred.cc@alibaba-inc.com,
 jakub@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
 willemdebruijn.kernel@gmail.com, yubing.qiuyubing@alibaba-inc.com
References: <20240924110414.52618-2-lulie@linux.alibaba.com>
 <20240924125101.1688823-1-gur.stavi@huawei.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20240924125101.1688823-1-gur.stavi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/9/24 20:51, Gur Stavi wrote:
>> @@ -224,13 +224,12 @@ struct sock *__udp6_lib_lookup(const struct net *net,
>>   			       struct sk_buff *skb)
>>   {
>>   	unsigned short hnum = ntohs(dport);
>> -	unsigned int hash2, slot2;
>>   	struct udp_hslot *hslot2;
>>   	struct sock *result, *sk;
>> +	unsigned int hash2;
>>
>>   	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
>> -	slot2 = hash2 & udptable->mask;
>> -	hslot2 = &udptable->hash2[slot2];
>> +	hslot2 = udp_hashslot2(udptable, hash2);
>>
> 
> Why not minimize the code change by using udptable->hash2[slot2].hslot?
> Especially since later you do it in __udp6_lib_mcast_deliver.
> I think that many developers would find usage of C primitives more
> readable.

Yes I can use udptable->hash2[slot2].hslot. But I prefer the 
udp_hashslot2() helper, because I found I have to add ".hslot" at many 
places, while most of them look exactly what udp_hashslot2() does. I 
think replacing them may get the codes simpler and benefit future coding.

Some places like __udp6_lib_mcast_deliver() get hslot2 differently from 
udp_hashslot2(), so just appending ".hslot" to avoid functionality change.

Thanks.
-- 
Philo



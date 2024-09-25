Return-Path: <netdev+bounces-129641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DDE985108
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 04:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67B11F23FB4
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 02:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E8148FF0;
	Wed, 25 Sep 2024 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LFHeZ1im"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D98136664;
	Wed, 25 Sep 2024 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232198; cv=none; b=BYJExTvtmrXfgh4w1mJlVE1oGkl1QmT1zkFWcIMd3Fq2z3u9iwSNbL0jGCzqT15CRsJlYRNs6isvyrxyLM+jxhJ4YQqP73l+dQH1KTQfZ8v2aktQXvxw6IfPnb4IeykHpM3ZZK5pndKAdJJh2zX2+l+wCJ4q02EzkzmboFO02CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232198; c=relaxed/simple;
	bh=wVbtPoPDt22mMWLfs3oIxJaZ1qXbvANDx7EAhMds3po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbjvH+noJnyRl5dtyDk8qgIUUsgIO0OT+Y/44slq+G6hP5+prz2PCh3vGZrjUGFBctyfQscIMzkLfjWIe66AeDF9qiQHCH0wrsXeCnTf5ktATzwzok74EuFUAz3pM1lgQ57A4uAUmProBH4T4mSWVC5Je4RUQGA0JoUtYT/PRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LFHeZ1im; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727232193; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9vTeNwrPvHBGZWsAzy8amRKVHrtyN+XFrFTU7Gd8C3I=;
	b=LFHeZ1im4NGkk7uENe0oONbXEqoNQ5qlGDMgb7dxNaLJqq2i9Ok9GCCXyMLCqUyMNUQ3gB4PUkMVyD+qyxpZnlhpv4uC6cTYe99I1AH6YvVfaSw+pb+KuTjp7fep9fAyPbaN2x4uq2xdBmKErSXUJGH5XNtKFwmCOU0R+5KevzU=
Received: from 30.221.128.100(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFhyJqP_1727232190)
          by smtp.aliyun-inc.com;
          Wed, 25 Sep 2024 10:43:11 +0800
Message-ID: <6c50d750-5a7c-4ddb-9415-17d0a963dbc9@linux.alibaba.com>
Date: Wed, 25 Sep 2024 10:43:10 +0800
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
 <20240924123017.1688277-1-gur.stavi@huawei.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20240924123017.1688277-1-gur.stavi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/9/24 20:30, Gur Stavi wrote:
>> + *	@hslot:	basic hash slot
>> + *	@hash4_cnt: number of sockets in hslot4 of the same (local port, local address)
>> + */
>> +struct udp_hslot_main {
>> +	struct udp_hslot	hslot; /* must be the first member */
>> +	u32			hash4_cnt;
>> +} __aligned(2 * sizeof(long));
>> +#define UDP_HSLOT_MAIN(__hslot) ((struct udp_hslot_main *)(__hslot))
> 
> Wouldn't container_of be more suitable than brutal cast?

I think struct udp_hslot_main is like a subclass of struct udp_hslot, so 
casting is reasonable here.

> 
>> @@ -91,7 +110,7 @@ static inline struct udp_hslot *udp_hashslot(struct udp_table *table,
>>   static inline struct udp_hslot *udp_hashslot2(struct udp_table *table,
>>   					      unsigned int hash)
>>   {
>> -	return &table->hash2[hash & table->mask];
>> +	return (struct udp_hslot *)udp_hashslot2_main(table, hash);
> 
> Why cast and not use ->hslot. Preferably with a local variable?

Got it. Will fix.

> 
>> @@ -3438,16 +3436,17 @@ void __init udp_table_init(struct udp_table *table, const char *name)
>>   					      UDP_HTABLE_SIZE_MIN,
>>   					      UDP_HTABLE_SIZE_MAX);
>>
>> -	table->hash2 = table->hash + (table->mask + 1);
>> +	table->hash2 = UDP_HSLOT_MAIN(table->hash + (table->mask + 1));
> 
> Wouldn't it be simpler to just cast to void? It is pure pointer
> arithmetic where type checking is meaningless.
> (void *)(table->hash + (table->mask + 1))
> I realize now why UDP_HSLOT_MAIN couldn't use container_of but it
> just demonstrates how convoluted this is.

Will fix. I agree that (void *) is better here.

Thank you for your review, Gur.

-- 
Philo



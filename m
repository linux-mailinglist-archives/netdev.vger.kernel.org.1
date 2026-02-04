Return-Path: <netdev+bounces-256719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHNnOTNYg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:31:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69243E7205
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA053030B2B
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A10410D35;
	Wed,  4 Feb 2026 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="x8Hx6jhU"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE2283FD6;
	Wed,  4 Feb 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215164; cv=none; b=NJO5KLPXnq590NMdMsYYAWKNlPpyuZ/YbcAP5cCoKCKS7OgYn3mIoVmBx6vH2V6MmV6+ilEmmMQiwpLxNCHr2TDsjb5QNu4mWcW73d5lWa/VSBswuzug+ZWi/oGoqXDpNJ4Cjj+SK2QYtiuVlUCE5wcTDD4Qa1k1/9vpUnZsrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215164; c=relaxed/simple;
	bh=aO9C4enZgFwRjSDXJQT/T36xFU8GX2K4g6cPeT60mQs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ALzky7PW7QLMUDUPcqLdswmClM8h/lywSvNCQ34gHJUjnr8Oln4IRlCCtOaigOrAr09Tfojcs52YRWzRMmMQMi9b/Mo5p50Pl2Up0DHagy7tYeIUhMnvTdlLJy7cyCUbNu5T5/rdPt9nbpFfV/aO80xVUanI/LUHTzKpHaW+ShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=x8Hx6jhU; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vS0dTna8RwjEXu2oVjoPyGWZr5bJ1YMbsCQ7vRVTBJU=;
	b=x8Hx6jhUC3yub4BQW5KxkovnLNCYNME5g8gF0qSyswtLWd+snnpFRTn6QppYwHjfSxuYWlMqQ
	zDQmf0xhfRGhfNFz/VOwV2FwLdSJ1PrEplHAYPcUTRR2quz+rBW+ujM/ccgVfRIESfOmLgaAeuE
	Z+a3Y3TARDe3DSW8z0eQRu0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f5jFn14jCz1prLm;
	Wed,  4 Feb 2026 22:21:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E91BC40363;
	Wed,  4 Feb 2026 22:25:53 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 4 Feb 2026 22:25:53 +0800
Message-ID: <81f552d6-fc53-4aa0-8c7d-d098a3bb6f04@huawei.com>
Date: Wed, 4 Feb 2026 22:25:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: hns3: fix double free issue for tx spare buffer
To: Jacob Keller <jacob.e.keller@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20260202105837.1909444-1-shaojijie@huawei.com>
 <2b7049bd-1b85-4e6a-be3e-0f3efe3b809a@intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <2b7049bd-1b85-4e6a-be3e-0f3efe3b809a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256719-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69243E7205
X-Rspamd-Action: no action


on 2026/2/4 9:30, Jacob Keller wrote:
>
>
> On 2/2/2026 2:58 AM, Jijie Shao wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> The driver missed to clear ring->tx_spare to NULL when
>> fail to initialize tx spare buffer. And it will try to
>> free the tx spare buffer in hns3_fini_ring() if tx_spare
>> is not NULL. So it may cause double free issue.
>>
>> Fixes: 907676b130711 ("net: hns3: use tx bounce buffer for small 
>> packets")
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c 
>> b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> index 7a9573dcab74..e879b04e21b0 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> @@ -1048,13 +1048,13 @@ static void hns3_init_tx_spare_buffer(struct 
>> hns3_enet_ring *ring)
>>       int order;
>>         if (!alloc_size)
>> -        return;
>> +        goto not_init;
>>         order = get_order(alloc_size);
>>       if (order > MAX_PAGE_ORDER) {
>>           if (net_ratelimit())
>>               dev_warn(ring_to_dev(ring), "failed to allocate tx 
>> spare buffer, exceed to max order\n");
>> -        return;
>> +        goto not_init;
>>       }
>>         tx_spare = devm_kzalloc(ring_to_dev(ring), sizeof(*tx_spare),
>> @@ -1092,6 +1092,13 @@ static void hns3_init_tx_spare_buffer(struct 
>> hns3_enet_ring *ring)
>>       devm_kfree(ring_to_dev(ring), tx_spare);
>
>
>>   devm_kzalloc_error:
>>       ring->tqp->handle->kinfo.tx_spare_buf_size = 0;
>> +not_init:
>> +    /* When driver init or reset_init, the ring->tx_spare is always 
>> NULL;
>> +     * but when called from hns3_set_ringparam, it's usually not 
>> NULL, and
>> +     * will be restored if hns3_init_all_ring() failed. So it's safe 
>> to set
>> +     * ring->tx_spare to NULL here.
>> +     */
>> +    ring->tx_spare = NULL;
>
> This feels weird. If it was already NULL there's no reason to write a 
> NULL to it. And if it isn't NULL, we should have released and 
> overwritten it previously by whatever caller was going to free it, 
> otherwise you'd just have a different kind of memory leak...
>
> It looks like the only places that call devm_kfree on the tx_spare is 
> hns3_fini_ring. It sets the value to NULL after freeing it. I am not 
> following how it can ever be non-NULL where setting this to NULL and 
> overwriting it would not lead to a memory leak (aside from the fact 
> that this is devm memory and will be released on removing the device)
>
> Is it because the ring memory isn't zero-initialized?? But that 
> wouldn't be a double-free that would be a freeing a bad address...
>
> Hmm. You create a copy of the ring parameters in hns3_set_ringparam. 
> Then if that fails, you copy things back. Otherwise you release the 
> tmp_rings... but the new rings didn't get cleared memory.. So the 
> issue is that your ring structures effectively have garbage memory in 
> them when initialized in set_ringparam.
>
> You can't just check the old tx_spare and release it here because 
> doing so would corrupt the memory pointed by the temporary copy made 
> when changing ring paramters (as it would no longer be valid), and you 
> can't assume it was zero initialized because your new rings were built 
> in place on top of the old ring structures.
>
> Ok. The fix makes sense but it does take a bit to understand why. You 
> effectively have to treat the memory in tx_spare as "uninitialized 
> garbage".
>
> Other solutions would require more significant refactoring. You could 
> memset or otherwise zero out the ring array structures entirely when 
> allocating new rings in hns3_init_all_ring() for example. Not sure 
> that is any easier to follow, and its not my driver so:
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thank you for your careful review, I apologize for the trouble this patch has caused you.

We considered the logic to be quite complex, so we added comments in the code to explain it.
However, for reviewers who are not familiar with our driver, these comments might be a bit unclear.
I will add more detailed explanations in the commit message for v2.

Thanks,
Jijie Shao


>
>>   }
>>     /* Use hns3_tx_spare_space() to make sure there is enough buffer
>
>


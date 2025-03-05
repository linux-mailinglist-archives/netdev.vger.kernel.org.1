Return-Path: <netdev+bounces-172015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B0A4FE81
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8D81881B10
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BAA243955;
	Wed,  5 Mar 2025 12:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A77201270;
	Wed,  5 Mar 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177183; cv=none; b=pY+hor4Em5yMKTy1v4zR7hiqT57qBy/jIQcvrhuk0qg8PvbsC3vGcyQ1q7G7PvOWRfeSZypXlNPA78SBuyQ8lonbYkTgBwn0e95zOABlYJjEcvdwkbZo0a7CZXcnQHy0uQ58nuNtOgyt1WfYnAwLqk0poyZl5kcfns5Jt1DeDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177183; c=relaxed/simple;
	bh=vlhpyamIfu0B4jVYp73PoZHZAQox5ZrifYWqOBNLXog=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XIxLXgyXQTAhKYSHsGUs5gv3moGmAXLGkSXz/ZnwtmZNbDVg19NDLnN0NUYAh8PHquUjSUYFdhNs4JK0M8lQbG+J79QsLMpG0YahL6JIGBlUq2z8PQ1saWPoLYwyjl5uRs8UhrPxjNB1atj+qwSWkhJceiNdeDwTTl+hTK6a3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z7BNm3kTtz9w7R;
	Wed,  5 Mar 2025 20:16:24 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 85DB3140360;
	Wed,  5 Mar 2025 20:19:32 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Mar 2025 20:19:32 +0800
Message-ID: <04c85f03-d3b3-4299-90d8-1d8432925993@huawei.com>
Date: Wed, 5 Mar 2025 20:19:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 3/4] page_pool: support unlimited number of
 inflight pages
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, Yan
 Zhai <yan@cloudflare.com>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
 <20250226110340.2671366-4-linyunsheng@huawei.com>
 <d3c7d421-566f-4007-b272-650294edd019@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <d3c7d421-566f-4007-b272-650294edd019@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/4 17:25, Jesper Dangaard Brouer wrote:


>>   }
>> @@ -514,10 +518,42 @@ static struct page_pool_item *page_pool_fast_item_alloc(struct page_pool *pool)
>>       return llist_entry(first, struct page_pool_item, lentry);
>>   }
>>   +static struct page_pool_item *page_pool_slow_item_alloc(struct page_pool *pool)
>> +{
>> +    if (unlikely(!pool->slow_items.block ||
>> +             pool->slow_items.next_to_use >= ITEMS_PER_PAGE)) {
>> +        struct page_pool_item_block *block;
>> +        struct page *page;
>> +
>> +        page = alloc_pages_node(pool->p.nid, GFP_ATOMIC | __GFP_NOWARN |
>> +                    __GFP_ZERO, 0);
>> +        if (!page) {
>> +            alloc_stat_inc(pool, item_slow_failed);
>> +            return NULL;
>> +        }
> 
> I'm missing a counter that I can use to monitor the rate of page
> allocations for these "item" block's.
> In production want to have a metric that shows me a sudden influx of
> that cause code to hit this "item_slow_alloc" case (inflight_slow_alloc)

It seems the 'item_fast_empty' stat added in patch 2 is the metric you
mention above? as we use those slow_items sequentially, the pages allocated
for slow_items can be calculated by 'item_fast_empty' / ITEMS_PER_PAGE.

> 
> BTW should this be called "inflight_block" instead of "item_block"?
> 
> 
>> +
>> +        block = page_address(page);
>> +        block->pp = pool;
>> +        block->flags |= PAGE_POOL_SLOW_ITEM_BLOCK_BIT;
>> +        refcount_set(&block->ref, ITEMS_PER_PAGE);
>> +        pool->slow_items.block = block;
>> +        pool->slow_items.next_to_use = 0;
>> +
>> +        spin_lock_bh(&pool->item_lock);
>> +        list_add(&block->list, &pool->item_blocks);
>> +        spin_unlock_bh(&pool->item_lock);
>> +    }
>> +
>> +    return &pool->slow_items.block->items[pool->slow_items.next_to_use++];
>> +}

...

>>   +static void __page_pool_slow_item_free(struct page_pool *pool,
>> +                       struct page_pool_item_block *block)
>> +{
>> +    spin_lock_bh(&pool->item_lock);
>> +    list_del(&block->list);
>> +    spin_unlock_bh(&pool->item_lock);
>> +
>> +    put_page(virt_to_page(block));
> 
> Here again I'm missing a counter that I can use to monitor the rate of
> page free events.
> 
> In production I want a metric (e.g inflight_slow_free_block) that
> together with "item_slow_alloc" (perhaps named
> inflight_slow_alloc_block), show me if this code path is creating churn,
> that I can correlate/explain some other influx event on the system.
> 
> BTW subtracting these (alloc - free) counters gives us the memory used.

If I understand it correctly, the 'item_fast_empty' is something like
the 'alloc' mentioned above, let's discuss the 'free' below.

> 
>> +}
>> +

...

>>   }
>>   +static int page_pool_nl_fill_item_mem_info(struct page_pool *pool,
>> +                       struct sk_buff *rsp)
>> +{
>> +    struct page_pool_item_block *block;
>> +    size_t resident = 0, used = 0;
>> +    int err;
>> +
>> +    spin_lock_bh(&pool->item_lock);
>> +
>> +    list_for_each_entry(block, &pool->item_blocks, list) {
>> +        resident += PAGE_SIZE;
>> +
>> +        if (block->flags & PAGE_POOL_SLOW_ITEM_BLOCK_BIT)
>> +            used += (PAGE_SIZE - sizeof(struct page_pool_item) *
>> +                 refcount_read(&block->ref));
>> +        else
>> +            used += PAGE_SIZE;
>> +    }
>> +
>> +    spin_unlock_bh(&pool->item_lock);
> 
> Holding a BH spin_lock can easily create production issues.

The above is not only give us the total pages used for page_pool_item,
but also give us the fragmentation info for those pages too.
So it seems the BH spin_lock is needed if we want the fragmentation info?

And the 'free' memtioned above can be calculated by 'memory used' - 'alloc'.

> I worry how long time it will take to traverse these lists.

I wouldn't worry about that as it is not supposed to be a lot of pages
in those list, if it is, it seems it is something we should be fixing
by increasing the size of fast_item or by defragmenting the slow_item
pages.

> 
> We (Cc Yan) are currently hunting down a number of real production issue
> due to different cases of control-path code querying the kernel that
> takes a _bh lock to read data, hurting the data-path processing.

I am not sure if the above is the control-path here, I would rather
treat it as the debug-path?

> 
> If we had the stats counters, then this would be less work, right?

It depends on if we want the fragmentation info or not as mentioned
above.

> 
> 


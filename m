Return-Path: <netdev+bounces-192736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D839AC0F5B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03677B437F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E317828DB61;
	Thu, 22 May 2025 15:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33273239E85;
	Thu, 22 May 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926288; cv=none; b=EbaDBXaRZx3nYDVeFw9LCuArK0EHw1fQtSijEolMqI6IKcPWErD5lO+n325APEUo/n8LMsaVL1cUBzTV/8x0MRNsFsQonCRYiM3JFtwBIni6v/vpn2HgtE9O51dDbjD6rTPeIrF4QNocFcq3tZjyfsh2F1veVB4uyHr+fauJokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926288; c=relaxed/simple;
	bh=6T1ttKIMuKzvujI7awY82v5YEXc/9trQlGSmdF2HvQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z8Dv2NtokkAR82w5RHflHmoZ0p9cqpPD8Trup/lq0L8FLIUj3UqonFAlf+EXCXxUj3n6gnZvHnPBT0VA27sVsDVCZRXBGQr2bToN+2xlFho0N0djKqLr2CiT2cMowGWEBZiNVs3cdzLkcGnEeE4YDTmLKo9eehBfbxGACaqhby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4b3BP55nltz1d1DG;
	Thu, 22 May 2025 23:03:05 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 887BD1402EA;
	Thu, 22 May 2025 23:04:42 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 May 2025 23:04:42 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 May 2025 23:04:41 +0800
Message-ID: <76635aef-45e5-4464-908b-57ea0920b01b@huawei.com>
Date: Thu, 22 May 2025 23:04:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG Report] KASAN: slab-use-after-free in
 page_pool_recycle_in_ring
To: Mina Almasry <almasrymina@google.com>
CC: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
References: <20250513083123.3514193-1-dongchenchen2@huawei.com>
 <CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
 <34f06847-f0d8-4ff3-b8a1-0b1484e27ba8@huawei.com>
 <CAHS8izPh5Z-CAJpQzDjhLVN5ye=5i1zaDqb2xQOU3QP08f+Y0Q@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CAHS8izPh5Z-CAJpQzDjhLVN5ye=5i1zaDqb2xQOU3QP08f+Y0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On Tue, May 13, 2025 at 8:11 PM dongchenchen (A)
> <dongchenchen2@huawei.com> wrote:
>>
>>> On Tue, May 13, 2025 at 1:28 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
>>>> Hello,
>>>>
>>>> syzkaller found the UAF issue in page_pool_recycle_in_ring[1], which is
>>>> similar to syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com.
>>>>
>>>> root cause is as follow:
>>>>
>>>> page_pool_recycle_in_ring
>>>>     ptr_ring_produce
>>>>       spin_lock(&r->producer_lock);
>>>>       WRITE_ONCE(r->queue[r->producer++], ptr)
>>>>         //recycle last page to pool
>>>>                                   page_pool_release
>>>>                                     page_pool_scrub
>>>>                                       page_pool_empty_ring
>>>>                                         ptr_ring_consume
>>>>                                         page_pool_return_page //release all page
>>>>                                     __page_pool_destroy
>>>>                                        free_percpu(pool->recycle_stats);
>>>>                                        kfree(pool) //free
>>>>
>>>>        spin_unlock(&r->producer_lock); //pool->ring uaf read
>>>>     recycle_stat_inc(pool, ring);
>>>>
>>>> page_pool can be free while page pool recycle the last page in ring.
>>>> After adding a delay to the page_pool_recycle_in_ring(), syzlog[2] can
>>>> reproduce this issue with a high probability. Maybe we can fix it by
>>>> holding the user_cnt of the page pool during the page recycle process.
>>>>
>>>> Does anyone have a good idea to solve this problem?
>>>>
>>> Ugh. page_pool_release is not supposed to free the page_pool until all
>>> inflight pages have been returned. It detects that there are pending
>>> inflight pages by checking the atomic stats, but in this case it looks
>>> like we've raced checking the atomic stats with another cpu returning
>>> a netmem to the ptr ring (and it updates the stats _after_ it already
>>> returned to the ptr_ring).
>>>
>>> My guess here is that page_pool_scrub needs to acquire the
>>> r->producer_lock to make sure there are no other producers returning
>>> netmems to the ptr_ring while it's scrubbing them (and checking after
>>> to make sure there are no inflight netmems).
>>>
>>> Can you test this fix? It may need some massaging. I only checked it
>>> builds. I haven't thought through all the possible races yet:
>>>
>>> ```
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index 2b76848659418..8654608734773 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -1146,10 +1146,17 @@ static void page_pool_scrub(struct page_pool *pool)
>>>
>>>    static int page_pool_release(struct page_pool *pool)
>>>    {
>>> +       bool in_softirq;
>>>           int inflight;
>>>
>>> +
>>> +       /* Acquire producer lock to make sure we don't race with another thread
>>> +        * returning a netmem to the ptr_ring.
>>> +        */
>>> +       in_softirq = page_pool_producer_lock(pool);
>>>           page_pool_scrub(pool);
>>>           inflight = page_pool_inflight(pool, true);
>>> +       page_pool_producer_unlock(pool, in_softirq);
>>>           if (!inflight)
>>>                   __page_pool_destroy(pool);
>>> ```
>> Hi, Mina!
>>
>> I tested this patch and the problem still exists.
>> Although this patch ensures that lock access is safe, the page recycle
>> process
>> can access the page pool after unlock.
>>
> Sorry for the very late reply; got a bit busy with some work work.
>
> My initial analysis was wrong as the test shows with the candidate
> fix. I took another look, and here is what I can tell so far. The full
> syzbot report is here for reference:
>
> https://syzkaller.appspot.com/bug?extid=204a4382fcb3311f3858
>
> page_pool_release_retry is supposed to block freeing the page_pool
> until all netmems have been freed via page_pool_put_unrefed_netmem
> using the inflight logic. What is clear from the syzbot report is that
> this inflight logic didn't work properly, because the
> page_pool_put_unrefed_netmem call happened after
> page_pool_release_retry has allowed the page_pool to be freed
> (__page_pool_destroy has already been called).
>
> The inflight logic works by taking the diff between
> `pool->pages_state_release_cnt` and `pool->pages_state_hold_cnt`.
> pages_state_hold_cnt is incremented when the page_pool allocates a new
> page from the buddy allocator. pages_state_hold_cnt is incremented at
> the end of the page_pool_put_unrefed_netmem.
>
> We don't expect new pages to be allocated by the page_pool owner after
> page_pool_destroy has been called, so pages_state_hold_cnt is supposed
> to not move after page_pool_destroy is called I think.
> pages_state_release_cnt should be <= pages_state_hold_cnt at the time
> of page_pool_destroy is called. Then when all the inflight netmems
> have been freed via page_pool_put_unrefed_netmem,
> pool->pages_state_release_cnt should be == to
> pool->pages_state_hold_cnt, and the page_pool should be allowed to be
> freed.
>
> Clearly this is not working, but I can't tell why. I also notice the
> syzbot report is from the bpf/test_run.c, but I don't think we have
> reports from prod, so it may be a test issue. Some possibilities:
>
> 1. Maybe the test is calling a page_pool allocation like
> page_pool_dev_alloc_pages in parallel with page_pool_destroy. That may
> increment pages_state_hold_cnt unexpectedly?
>
> 2.  Maybe one of the pages_state_*_cnt overflowed or something?
>
> 3. Memory corruption?
>
> I'm afraid I'm not sure. Possibly littering the code with warnings for
> unexpected cases would give some insight. For example, I think this
> would catch case #1:
>
> ```
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 4011eb305cee..9fa70c60f9b5 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -536,6 +536,9 @@ static struct page
> *__page_pool_alloc_page_order(struct page_pool *pool,
>          alloc_stat_inc(pool, slow_high_order);
>          page_pool_set_pp_info(pool, page_to_netmem(page));
>
> +       /* Warn if we're allocating a page on a destroyed page_pool */
> +       DEBUG_NET_WARN_ON(pool->destroy_cnt);
> +
>          /* Track how many pages are held 'in-flight' */
>          pool->pages_state_hold_cnt++;
>          trace_page_pool_state_hold(pool, page_to_netmem(page),
> @@ -582,6 +585,8 @@ static noinline netmem_ref
> __page_pool_alloc_pages_slow(struct page_pool *pool,
>                  page_pool_set_pp_info(pool, netmem);
>                  pool->alloc.cache[pool->alloc.count++] = netmem;
>                  /* Track how many pages are held 'in-flight' */
> +               /* Warn if we're allocating a page on a destroyed page_pool */
> +               DEBUG_NET_WARN_ON(pool->destroy_cnt);
>                  pool->pages_state_hold_cnt++;
>                  trace_page_pool_state_hold(pool, netmem,
>                                             pool->pages_state_hold_cnt);
> @@ -1271,6 +1276,8 @@ void net_mp_niov_set_page_pool(struct page_pool
> *pool, struct net_iov *niov)
>
>          page_pool_set_pp_info(pool, netmem);
>
> +       /* Warn if we're allocating a page on a destroyed page_pool */
> +       DEBUG_NET_WARN_ON(pool->destroy_cnt);
>          pool->pages_state_hold_cnt++;
>          trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
> ```
>
> If you have steps to repro this, maybe post them and I'll try to take
> a look when I get a chance if you can't root cause this further.
HI, Mina
Thank you for your rigorous analysis of the problem.
We can use the config and log in syzkaller to reproduce the problem.
Enable CONFIG_PAGE_POOL_STATS and add delay to
page_pool_recycle_in_ring() can make it easier to reproduce the problem.

static noinline bool page_pool_recycle_in_ring(struct page_pool *pool, 
netmem_ref netmem)
{
         int ret;
         /* BH protection not needed if current is softirq */
@@ -715,6 +719,8 @@ static bool page_pool_recycle_in_ring(struct 
page_pool *pool, netmem_ref netmem)
                 ret = ptr_ring_produce_bh(&pool->ring, (__force void 
*)netmem);

         if (!ret) {
+               mdelay(2500);
                 recycle_stat_inc(pool, ring);
                 return true;
         }
> --
> Thanks,
> Mina


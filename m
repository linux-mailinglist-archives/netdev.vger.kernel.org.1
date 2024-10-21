Return-Path: <netdev+bounces-137401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E89A603B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB2A287121
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1491E201D;
	Mon, 21 Oct 2024 09:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4631E1A33;
	Mon, 21 Oct 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503382; cv=none; b=hdjMYaAyecrymb8c5XdZ0g5ApABjxpc31Mu8o2uThGOJxqKWpGJ3AyjGpp31Co81PFHdHatDiJ3FSubCGsNtvMM9uumuiQFEwYGxkAklqu1xqcJky8iwo+YOrf3sJcmZh/C/XKJyWujmEmad2TBBAKuFEEDdbxLX/E7/8VNDjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503382; c=relaxed/simple;
	bh=3QOK3FoGMVlLE3F7suimpJKsWNhVhCDUbbenGFL4/Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aJf3mAm8yIvNklaZtp7/ccAw+T7p7jKpZREnYGdq0YWxJnHaPJ76rE7is/zL7wzCKHNjlb39ye4pbEfkNh6n5QPqZGhry/VOt/buIXxoJN340ZXJoPBFDX9pVwHfQdhPF3pXKS5bPkXtA9lBIxssJujgRNceCM62aDxmOygMLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XX9CM6bZMz20qbV;
	Mon, 21 Oct 2024 17:35:27 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 716661401F1;
	Mon, 21 Oct 2024 17:36:17 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 17:36:17 +0800
Message-ID: <a18b54d5-648a-4369-893c-2c4f2c68e1c4@huawei.com>
Date: Mon, 21 Oct 2024 17:36:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 10/14] mm: page_frag: introduce
 prepare/probe/commit API
To: Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng Lin
	<yunshenglin0825@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <20241018105351.1960345-11-linyunsheng@huawei.com>
 <CAKgT0UcrbmhJCm4=30Y12ZX9bWD_ChTn5vqHxKdTrGBP-FLk5w@mail.gmail.com>
 <a6703e66-a8bc-43c9-a2b9-08f2a849c4ff@gmail.com>
 <CAKgT0UdawPJgh-J266cpRqNvCHFT=X=OM3CVBorBT0mTEGVpeg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UdawPJgh-J266cpRqNvCHFT=X=OM3CVBorBT0mTEGVpeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/21 0:04, Alexander Duyck wrote:
> On Sat, Oct 19, 2024 at 1:33 AM Yunsheng Lin <yunshenglin0825@gmail.com> wrote:
>>
>> On 10/19/2024 2:03 AM, Alexander Duyck wrote:
>>
>>>
>>> Not a huge fan of introducing a ton of new API calls and then having
>>> to have them all applied at once in the follow-on patches. Ideally the
>>> functions and the header documentation for them would be introduced in
>>> the same patch as well as examples on how it would be used.
>>>
>>> I really think we should break these up as some are used in one case,
>>> and others in another and it is a pain to have a pile of abstractions
>>> that are all using these functions in different ways.
>>
>> I am guessing this patch may be split into three parts to make it more
>> reviewable and easier to discuss here:
>> 1. Prepare & commit related API, which is still the large one.
>> 2. Probe API related API.
> 
> In my mind the first two listed here are much more related to each
> other than this abort api.
> 
>> 3. Abort API.
> 
> I wonder if we couldn't look at introducing this first as it is
> actually closer to the existing API in terms of how you might use it.
> The only spot of commonality I can think of in terms of all these is
> that we would need to be able to verify the VA, offset, and size. I
> partly wonder if for our page frag API we couldn't get away with
> passing a virtual address instead of a page for the page frag. It
> would save us having to do the virt_to_page or page_to_virt when
> trying to verify a commit or a revert.

Perhaps break this patch into the more patches as the order like below?
mm: page_frag: introduce page_frag_alloc_abort() API
mm: page_frag: introduce refill prepare & commit API
mm: page_frag: introduce alloc_refill prepare & commit API
mm: page_frag: introduce probe related API

> 
> 
>> And it is worthing mentioning that even if this patch is split into more
>> patches, it seems impossible to break patch 12 up as almost everything
>> related to changing "page_frag" to "page_frag_cache" need to be one
>> patch to avoid compile error.
> 
> That is partly true. One issue is that there are more changes there
> than just changing out the page APIs. It seems like you went in
> performing optimizations as soon as you were changing out the page
> allocation method used. For example one thing that jumps out at me was
> the removal of linear_to_page and its replacement with
> spd_fill_linear_page which seems to take on other pieces of the
> function as well as you made it a return path of its own when that
> section wasn't previously.

The reason for the new spd_fill_linear_page() is that the reference
counting in spd_fill_page() is not longer reusable for new API, which
uses page_frag_commit() and page_frag_commit_noref(), instead of using
get_page() in spd_fill_page().

> 
> Ideally changing out the APIs used should be more about doing just
> that and avoiding additional optimization or deviations from the
> original coded path if possible.

Yes, we can always do better, I am just not sure if it is worthing it.

> 
>>>
>>>> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
>>>> +                                        unsigned int fragsz)
>>>> +{
>>>> +       VM_BUG_ON(fragsz > nc->offset);
>>>> +
>>>> +       nc->pagecnt_bias++;
>>>> +       nc->offset -= fragsz;
>>>> +}
>>>> +
>>>
>>> We should probably have the same checks here you had on the earlier
>>> commit. We should not be allowing blind changes. If we are using the
>>> commit or abort interfaces we should be verifying a page frag with
>>> them to verify that the request to modify this is legitimate.
>>
>> As an example in 'Preparation & committing API' section of patch 13, the
>> abort API is used to abort the operation of page_frag_alloc_*() related
>> API, so 'page_frag' is not available for doing those checking like the
>> commit API. For some case without the needing of complicated prepare &
>> commit API like tun_build_skb(), the abort API can be used to abort the
>> operation of page_frag_alloc_*() related API when bpf_prog_run_xdp()
>> returns XDP_DROP knowing that no one else is taking extra reference to
>> the just allocated fragment.
>>
>> +Allocation & freeing API
>> +------------------------
>> +
>> +.. code-block:: c
>> +
>> +    void *va;
>> +
>> +    va = page_frag_alloc_align(nc, size, gfp, align);
>> +    if (!va)
>> +        goto do_error;
>> +
>> +    err = do_something(va, size);
>> +    if (err) {
>> +        page_frag_alloc_abort(nc, size);
>> +        goto do_error;
>> +    }
>> +
>> +    ...
>> +
>> +    page_frag_free(va);
>>
>>
>> If there is a need to abort the commit API operation, we probably call
>> it something like page_frag_commit_abort()?
> 
> I would argue that using an abort API in such a case is likely not
> valid then. What we most likely need to be doing is passing the va as
> a part of the abort request. With that we should be able to work our
> way backwards to get back to verifying the fragment came from the
> correct page before we allow stuffing it back on the page.

How about something like below mentioned in the previous comment:
page_frag_alloc_abort(nc, va, size);

> 
>>>
>>>>   void page_frag_free(void *addr);
>>>>
>>>>   #endif
>>>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>>>> index f55d34cf7d43..5ea4b663ab8e 100644
>>>> --- a/mm/page_frag_cache.c
>>>> +++ b/mm/page_frag_cache.c
>>>> @@ -112,6 +112,27 @@ unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
>>>>   }
>>>>   EXPORT_SYMBOL(__page_frag_cache_commit_noref);
>>>>
>>>> +void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
>>>> +                                          unsigned int fragsz,
>>>> +                                          struct page_frag *pfrag,
>>>> +                                          unsigned int align_mask)
>>>> +{
>>>> +       unsigned long encoded_page = nc->encoded_page;
>>>> +       unsigned int size, offset;
>>>> +
>>>> +       size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
>>>> +       offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>>>> +       if (unlikely(!encoded_page || offset + fragsz > size))
>>>> +               return NULL;
>>>> +
>>>> +       pfrag->page = encoded_page_decode_page(encoded_page);
>>>> +       pfrag->size = size - offset;
>>>> +       pfrag->offset = offset;
>>>> +
>>>> +       return encoded_page_decode_virt(encoded_page) + offset;
>>>> +}
>>>> +EXPORT_SYMBOL(__page_frag_alloc_refill_probe_align);
>>>> +
>>>
>>> If I am not mistaken this would be the equivalent of allocating a size
>>> 0 fragment right? The only difference is that you are copying out the
>>> "remaining" size, but we could get that from the offset if we knew the
>>> size couldn't we? Would it maybe make sense to look at limiting this
>>> to PAGE_SIZE instead of passing the size of the actual fragment?
>>
>> I am not sure if I understand what does "limiting this to PAGE_SIZE"
>> mean here.
> 
> Right now you are returning pfrag->size = size - offset. I am
> wondering if we should be returning something more like "pfrag->size =
> PAGE_SIZE - (offset % PAGE_SIZE)".

Doesn't doing above defeat the purpose of the 'performant' part mentioned
in the commit log? With above, I would say the new page_frag API is not
providing the expected semantic of skb_page_frag_refill() as the caller
can use up the whole order-3 page by accessing pfrag->size directly.

"There are many use cases that need minimum memory in order
for forward progress, but more performant if more memory is
available"

> 
>> I probably should mention the usecase of probe API here. For the usecase
>> of mptcp_sendmsg(), the minimum size of a fragment can be smaller when
>> the new fragment can be coalesced to previous fragment as there is an
>> extra memory needed for some header if the fragment can not be coalesced
>> to previous fragment. The probe API is mainly used to see if there is
>> any memory left in the 'page_frag_cache' that can be coalesced to
>> previous fragment.
> 
> What is the fragment size we are talking about? In my example above we

I am talking about the minimum fragment size required by the caller, if
there is more space, the caller can decide how much it will use by using
the commit API passing the 'used_sz' parameter.

We only need to limit the caller not to pass a fragsz larger than
PAGE_SIZE when calling a prepare API, but not when calling commit API.

> would basically be looking at rounding the page off to the nearest
> PAGE_SIZE block before we would have to repeat the call to grab the
> next PAGE_SIZE block. Since the request size for the page frag alloc
> API is supposed to be limited to 4K or less it would make sense to
> limit the probe API similarly.
It is partly true for prepare/commit API, as it is true for prepare API,
but not true for commit API.


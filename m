Return-Path: <netdev+bounces-137398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320BA9A601E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B293B28F7A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B51E3771;
	Mon, 21 Oct 2024 09:32:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B511E376B;
	Mon, 21 Oct 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503166; cv=none; b=MJ8tSAJFf88srdNoEuErvHzv1GhbgN01CcFRSlL9kJ4xaCwhFmyE6yOUhH0fVheTfPw/BKpcnD6kjUBmEy9qkG0WG00hpqrqIcaBI+TXJNb5BS7h4tGlbvZIiagNggDUswOObLy1GECdoSKnAegY4eKJqAVq/8NrAhPSlXKB7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503166; c=relaxed/simple;
	bh=eIUXnt/ABmUvP35d3vsYEMPzCW8J7Xh+nToDlaB4hK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UxTpUholZvo/pdFwROE7m9YX0+r7wR2B0E3oNxt+D86sMqiSafraynwuBeXhplpnKhjvZ+4xtL8ctd3d/ODvZIugun3jjeK1Xv2EPcCa/2Xzgvuct7ELuZ9rM9CDw7M3S4P/5Ez1mHiPiWVrSVRpBPbTNQgleXo+kUN1aeWCYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XX96L50bSzyTNV;
	Mon, 21 Oct 2024 17:31:06 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F327F1800DB;
	Mon, 21 Oct 2024 17:32:35 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 17:32:35 +0800
Message-ID: <6f9840b3-66c4-485e-b6bb-baeaa641e720@huawei.com>
Date: Mon, 21 Oct 2024 17:32:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 13/14] mm: page_frag: update documentation
 for page_frag
To: Bagas Sanjaya <bagasdotme@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <20241018105351.1960345-14-linyunsheng@huawei.com>
 <ZxTVRRecKRpna6Aj@archie.me>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <ZxTVRRecKRpna6Aj@archie.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/20 18:02, Bagas Sanjaya wrote:

Thanks, will try my best to not miss any 'alloc' typo for doc patch
next version:(

> On Fri, Oct 18, 2024 at 06:53:50PM +0800, Yunsheng Lin wrote:
>> diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
>> index 503ca6cdb804..7fd9398aca4e 100644
>> --- a/Documentation/mm/page_frags.rst
>> +++ b/Documentation/mm/page_frags.rst
>> @@ -1,3 +1,5 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>>  ==============
>>  Page fragments
>>  ==============
>> @@ -40,4 +42,176 @@ page via a single call.  The advantage to doing this is that it allows for
>>  cleaning up the multiple references that were added to a page in order to
>>  avoid calling get_page per allocation.
>>  
>> -Alexander Duyck, Nov 29, 2016.
>> +
>> +Architecture overview
>> +=====================
>> +
>> +.. code-block:: none
>> +
>> +                      +----------------------+
>> +                      | page_frag API caller |
>> +                      +----------------------+
>> +                                  |
>> +                                  |
>> +                                  v
>> +    +------------------------------------------------------------------+
>> +    |                   request page fragment                          |
>> +    +------------------------------------------------------------------+
>> +             |                                 |                     |
>> +             |                                 |                     |
>> +             |                          Cache not enough             |
>> +             |                                 |                     |
>> +             |                         +-----------------+           |
>> +             |                         | reuse old cache |--Usable-->|
>> +             |                         +-----------------+           |
>> +             |                                 |                     |
>> +             |                             Not usable                |
>> +             |                                 |                     |
>> +             |                                 v                     |
>> +        Cache empty                   +-----------------+            |
>> +             |                        | drain old cache |            |
>> +             |                        +-----------------+            |
>> +             |                                 |                     |
>> +             v_________________________________v                     |
>> +                              |                                      |
>> +                              |                                      |
>> +             _________________v_______________                       |
>> +            |                                 |              Cache is enough
>> +            |                                 |                      |
>> + PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE         |                      |
>> +            |                                 |                      |
>> +            |               PAGE_SIZE >= PAGE_FRAG_CACHE_MAX_SIZE    |
>> +            v                                 |                      |
>> +    +----------------------------------+      |                      |
>> +    | refill cache with order > 0 page |      |                      |
>> +    +----------------------------------+      |                      |
>> +      |                    |                  |                      |
>> +      |                    |                  |                      |
>> +      |              Refill failed            |                      |
>> +      |                    |                  |                      |
>> +      |                    v                  v                      |
>> +      |      +------------------------------------+                  |
>> +      |      |   refill cache with order 0 page   |                  |
>> +      |      +----------------------------------=-+                  |
>> +      |                       |                                      |
>> + Refill succeed               |                                      |
>> +      |                 Refill succeed                               |
>> +      |                       |                                      |
>> +      v                       v                                      v
>> +    +------------------------------------------------------------------+
>> +    |             allocate fragment from cache                         |
>> +    +------------------------------------------------------------------+
>> +
>> +API interface
>> +=============
>> +As the design and implementation of page_frag API implies, the allocation side
>> +does not allow concurrent calling. Instead it is assumed that the caller must
>> +ensure there is not concurrent alloc calling to the same page_frag_cache
>> +instance by using its own lock or rely on some lockless guarantee like NAPI
>> +softirq.
>> +
>> +Depending on different aligning requirement, the page_frag API caller may call
>> +page_frag_*_align*() to ensure the returned virtual address or offset of the
>> +page is aligned according to the 'align/alignment' parameter. Note the size of
>> +the allocated fragment is not aligned, the caller needs to provide an aligned
>> +fragsz if there is an alignment requirement for the size of the fragment.
>> +
>> +Depending on different use cases, callers expecting to deal with va, page or
>> +both va and page for them may call page_frag_alloc, page_frag_refill, or
>> +page_frag_alloc_refill API accordingly.
>> +
>> +There is also a use case that needs minimum memory in order for forward progress,
>> +but more performant if more memory is available. Using page_frag_*_prepare() and
>> +page_frag_commit*() related API, the caller requests the minimum memory it needs
>> +and the prepare API will return the maximum size of the fragment returned. The
>> +caller needs to either call the commit API to report how much memory it actually
>> +uses, or not do so if deciding to not use any memory.
>> +
>> +.. kernel-doc:: include/linux/page_frag_cache.h
>> +   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
>> +		  __page_frag_alloc_align page_frag_alloc_align page_frag_alloc
>> +		 __page_frag_refill_align page_frag_refill_align
>> +		 page_frag_refill __page_frag_refill_prepare_align
>> +		 page_frag_refill_prepare_align page_frag_refill_prepare
>> +		 __page_frag_alloc_refill_prepare_align
>> +		 page_frag_alloc_refill_prepare_align
>> +		 page_frag_alloc_refill_prepare page_frag_alloc_refill_probe
>> +		 page_frag_refill_probe page_frag_commit
>> +		 page_frag_commit_noref page_frag_alloc_abort
>> +
>> +.. kernel-doc:: mm/page_frag_cache.c
>> +   :identifiers: page_frag_cache_drain page_frag_free
>> +		 __page_frag_alloc_refill_probe_align
>> +
>> +Coding examples
>> +===============
>> +
>> +Initialization and draining API
>> +-------------------------------
>> +
>> +.. code-block:: c
>> +
>> +   page_frag_cache_init(nc);
>> +   ...
>> +   page_frag_cache_drain(nc);
>> +
>> +
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
>> +        page_frag_abort(nc, size);
>> +        goto do_error;
>> +    }
>> +
>> +    ...
>> +
>> +    page_frag_free(va);
>> +
>> +
>> +Preparation & committing API
>> +----------------------------
>> +
>> +.. code-block:: c
>> +
>> +    struct page_frag page_frag, *pfrag;
>> +    bool merge = true;
>> +    void *va;
>> +
>> +    pfrag = &page_frag;
>> +    va = page_frag_alloc_refill_prepare(nc, 32U, pfrag, GFP_KERNEL);
>> +    if (!va)
>> +        goto wait_for_space;
>> +
>> +    copy = min_t(unsigned int, copy, pfrag->size);
>> +    if (!skb_can_coalesce(skb, i, pfrag->page, pfrag->offset)) {
>> +        if (i >= max_skb_frags)
>> +            goto new_segment;
>> +
>> +        merge = false;
>> +    }
>> +
>> +    copy = mem_schedule(copy);
>> +    if (!copy)
>> +        goto wait_for_space;
>> +
>> +    err = copy_from_iter_full_nocache(va, copy, iter);
>> +    if (err)
>> +        goto do_error;
>> +
>> +    if (merge) {
>> +        skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
>> +        page_frag_commit_noref(nc, pfrag, copy);
>> +    } else {
>> +        skb_fill_page_desc(skb, i, pfrag->page, pfrag->offset, copy);
>> +        page_frag_commit(nc, pfrag, copy);
>> +    }
> 
> Looks good.
> 
>> +/**
>> + * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
>> + * @nc: page_frag cache from which to check
>> + *
>> + * Used to check if the current page in page_frag cache is allocated from the
> "Check if ..."
>> + * pfmemalloc reserves. It has the same calling context expectation as the
>> + * allocation API.
>> + *
>> + * Return:
>> + * true if the current page in page_frag cache is allocated from the pfmemalloc
>> + * reserves, otherwise return false.
>> + */
>> <snipped>...
>> +/**
>> + * page_frag_alloc() - Allocate a page fragment.
>> + * @nc: page_frag cache from which to allocate
>> + * @fragsz: the requested fragment size
>> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
>> + *
>> + * Alloc a page fragment from page_frag cache.
> "Allocate a page fragment ..."
>> + *
>> + * Return:
>> + * virtual address of the page fragment, otherwise return NULL.
>> + */
>>  static inline void *page_frag_alloc(struct page_frag_cache *nc,
>> <snipped>...
>> +/**
>> + * __page_frag_refill_prepare_align() - Prepare refilling a page_frag with
>> + * aligning requirement.
>> + * @nc: page_frag cache from which to refill
>> + * @fragsz: the requested fragment size
>> + * @pfrag: the page_frag to be refilled.
>> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
>> + * @align_mask: the requested aligning requirement for the fragment
>> + *
>> + * Prepare refill a page_frag from page_frag cache with aligning requirement.
> "Prepare refilling ..."
>> + *
>> + * Return:
>> + * True if prepare refilling succeeds, otherwise return false.
>> + */
>> <snipped>...
>> +/**
>> + * __page_frag_alloc_refill_probe_align() - Probe allocing a fragment and
>> + * refilling a page_frag with aligning requirement.
>> + * @nc: page_frag cache from which to allocate and refill
>> + * @fragsz: the requested fragment size
>> + * @pfrag: the page_frag to be refilled.
>> + * @align_mask: the requested aligning requirement for the fragment.
>> + *
>> + * Probe allocing a fragment and refilling a page_frag from page_frag cache with
> "Probe allocating..."
>> + * aligning requirement.
>> + *
>> + * Return:
>> + * virtual address of the page fragment, otherwise return NULL.
>> + */
> 
> Thanks.
> 


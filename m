Return-Path: <netdev+bounces-94741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305BA8C0893
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2CAB21E75
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 00:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A33398E;
	Thu,  9 May 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U0t0scC6"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3310A1F;
	Thu,  9 May 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215503; cv=none; b=vEgIwTag0eEjQD9uX2smw72NckdefHI623t01TgyT6dXXa/Faxty2vxS++DQWsKU/8jFCrht7TXrvXZZTF27+6zPbiXG/SjxW/Mdp5PaGchyGfAyfToqGPYMxtNG9Tzq60E1ZntTb8ucS3Boz74atq0hfKCPG3g4IpryzLMRau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215503; c=relaxed/simple;
	bh=WVHtNljGpj4u18niXFyP3IP1K5P1hjMmkE4XUd2J5+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxKkroX1tuPZKrisqmUdXtjV0koh8oscdSnh2UHZAleJQ9c03NisSCj1tY1K4LvAH0fh3c4Mv6zOuMBNrYu09bo2s/vKa0heIBXUp6NacH13WMbDmL9GKcDRLN3CLmamUGJad1CnwRATozsnBsqMH1+FJuOxGohJeWWmJIBwZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U0t0scC6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=p4w5MoMB38DN/Tg8kqUxVog4ZJJdmPG/YvyxaE2aVjE=; b=U0t0scC6BqoggumMzzzpHfKbAC
	l5flUebn83u9hy3Shi9Zqbfw6GKJcYJHRPpvAcmvz2ylLgsYeaiE9++trYywOSQtiDpbRcCdmSfSD
	kuNRn2zV9xQdJtgIMK8Uf6Tgahd2Pvesnubpx9s27aygt14bWnKnr2Mw5f9XRIk6oLa+XA2DoO1t0
	LkNNsOK8dJFe5zdE8QcB/z9o4t9gXeCQ5WSTPbVRmuX39RFNttxi1eOrLc/YcaFg77Mqhme53y9zI
	9q0GUTsoEhGA/e7WhM3YqLKN70q/Gaz7wY/aYogTDOvbZI1W7fidgvDSGlCYk7A7ySDbk5HmM8k7+
	o15H3z5A==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4rtz-0000000HQZY-1MJO;
	Thu, 09 May 2024 00:44:51 +0000
Message-ID: <0ac5219b-b756-4a8d-ba31-21601eb1e7f4@infradead.org>
Date: Wed, 8 May 2024 17:44:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/13] mm: page_frag: update documentation for
 page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20240508133408.54708-1-linyunsheng@huawei.com>
 <20240508133408.54708-13-linyunsheng@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240508133408.54708-13-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/8/24 6:34 AM, Yunsheng Lin wrote:
> Update documentation about design, implementation and API usages
> for page_frag.
> 
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  Documentation/mm/page_frags.rst | 156 +++++++++++++++++++++++++++++++-
>  include/linux/page_frag_cache.h |  96 ++++++++++++++++++++
>  mm/page_frag_cache.c            |  65 ++++++++++++-
>  3 files changed, 314 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
> index 503ca6cdb804..9c25c0fd81f0 100644
> --- a/Documentation/mm/page_frags.rst
> +++ b/Documentation/mm/page_frags.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ==============
>  Page fragments
>  ==============
> @@ -40,4 +42,156 @@ page via a single call.  The advantage to doing this is that it allows for
>  cleaning up the multiple references that were added to a page in order to
>  avoid calling get_page per allocation.
>  
> -Alexander Duyck, Nov 29, 2016.
> +
> +Architecture overview
> +=====================
> +
> +.. code-block:: none
> +
> +                +----------------------+
> +                | page_frag API caller |
> +                +----------------------+
> +                            ^
> +                            |
> +                            |
> +                            |
> +                            v
> +    +------------------------------------------------+
> +    |             request page fragment              |
> +    +------------------------------------------------+
> +        ^                      ^                   ^
> +        |                      | Cache not enough  |
> +        | Cache empty          v                   |
> +        |             +-----------------+          |
> +        |             | drain old cache |          |
> +        |             +-----------------+          |
> +        |                      ^                   |
> +        |                      |                   |
> +        v                      v                   |
> +    +----------------------------------+           |
> +    |  refill cache with order 3 page  |           |
> +    +----------------------------------+           |
> +     ^                  ^                          |
> +     |                  |                          |
> +     |                  | Refill failed            |
> +     |                  |                          | Cache is enough
> +     |                  |                          |
> +     |                  v                          |
> +     |    +----------------------------------+     |
> +     |    |  refill cache with order 0 page  |     |
> +     |    +----------------------------------+     |
> +     |                       ^                     |
> +     | Refill succeed        |                     |
> +     |                       | Refill succeed      |
> +     |                       |                     |
> +     v                       v                     v
> +    +------------------------------------------------+
> +    |         allocate fragment from cache           |
> +    +------------------------------------------------+
> +
> +API interface
> +=============
> +As the design and implementation of page_frag API implies, the allocation side
> +does not allow concurrent calling. Instead it is assumed that the caller must
> +ensure there is not concurrent alloc calling to the same page_frag_cache
> +instance by using its own lock or rely on some lockless guarantee like NAPI
> +softirq.
> +
> +Depending on different aligning requirement, the page_frag API caller may call
> +page_frag_alloc*_align*() to ensure the returned virtual address or offset of
> +the page is aligned according to the 'align/alignment' parameter. Note the size
> +of the allocated fragment is not aligned, the caller need to provide a aligned

                                                        needs to provide an aligned

> +fragsz if there is a alignment requirement for the size of the fragment.

                      an alignment

> +
> +Depending on different use cases, callers expecting to deal with va, page or
> +both va and page for them may call page_frag_alloc_va*, page_frag_alloc_pg*,
> +or page_frag_alloc* API accordingly.
> +
> +There is also a use case that need minimum memory in order for forward

                                 needs

> +progressing, but more performant if more memory is available. Using

   progress,

> +page_frag_alloc_prepare() and page_frag_alloc_commit() related API, the caller
> +requests the minimum memory it need and the prepare API will return the maximum

                                  needs

> +size of the fragment returned, the caller needs to either call the commit API to

                        returned. The caller

> +report how much memory it actually uses, or not do so if deciding to not use any
> +memory.
> +
> +.. kernel-doc:: include/linux/page_frag_cache.h
> +   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
> +                 page_frag_cache_page_offset page_frag_alloc_va
> +                 page_frag_alloc_va_align page_frag_alloc_va_prepare_align
> +                 page_frag_alloc_probe page_frag_alloc_commit
> +                 page_frag_alloc_commit_noref
> +
> +.. kernel-doc:: mm/page_frag_cache.c
> +   :identifiers: __page_frag_alloc_va_align page_frag_alloc_va_prepare
> +		 page_frag_alloc_pg_prepare page_frag_alloc_prepare
> +		 page_frag_cache_drain page_frag_free_va
> +
> +Coding examples
> +===============
> +
> +Init & Drain API
> +----------------
> +
> +.. code-block:: c
> +
> +   page_frag_cache_init(pfrag);
> +   ...
> +   page_frag_cache_drain(pfrag);
> +
> +
> +Alloc & Free API
> +----------------
> +
> +.. code-block:: c
> +
> +    void *va;
> +
> +    va = page_frag_alloc_va_align(pfrag, size, gfp, align);
> +    if (!va)
> +        goto do_error;
> +
> +    err = do_something(va, size);
> +    if (err) {
> +        page_frag_free_va(va);
> +        goto do_error;
> +    }
> +
> +Prepare & Commit API
> +--------------------
> +
> +.. code-block:: c
> +
> +    unsigned int offset, size;
> +    bool merge = true;
> +    struct page *page;
> +    void *va;
> +
> +    size = 32U;
> +    page = page_frag_alloc_prepare(pfrag, &offset, &size, &va);
> +    if (!page)
> +        goto wait_for_space;
> +
> +    copy = min_t(int, copy, size);

declare copy?

> +    if (!skb_can_coalesce(skb, i, page, offset)) {
> +        if (i >= max_skb_frags)
> +            goto new_segment;
> +
> +        merge = false;
> +    }
> +
> +    copy = mem_schedule(copy);
> +    if (!copy)
> +        goto wait_for_space;
> +
> +    err = copy_from_iter_full_nocache(va, copy, iter);
> +    if (err)
> +        goto do_error;
> +
> +    if (merge) {
> +        skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
> +        page_frag_alloc_commit_noref(pfrag, offset, copy);
> +    } else {
> +        skb_fill_page_desc(skb, i, page, offset, copy);
> +        page_frag_alloc_commit(pfrag, offset, copy);
> +    }
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
> index 30893638155b..8925397262a1 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -61,11 +61,28 @@ struct page_frag_cache {
>  #endif
>  };
>  
> +/**
> + * page_frag_cache_init() - Init page_frag cache.
> + * @nc: page_frag cache from which to init
> + *
> + * Inline helper to init the page_frag cache.
> + */
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
>  	memset(nc, 0, sizeof(*nc));
>  }
>  
> +/**
> + * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
> + * @nc: page_frag cache from which to check
> + *
> + * Used to check if the current page in page_frag cache is pfmemalloc'ed.
> + * It has the same calling context expection as the alloc API.
> + *
> + * Return:
> + * Return true if the current page in page_frag cache is pfmemalloc'ed,

Drop the (second) word "Return"...

> + * otherwise return false.
> + */
>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>  {
>  	return encoded_page_pfmemalloc(nc->encoded_va);
> @@ -92,6 +109,19 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>  				 unsigned int fragsz, gfp_t gfp_mask,
>  				 unsigned int align_mask);
>  
> +/**
> + * page_frag_alloc_va_align() - Alloc a page fragment with aligning requirement.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled

                                                      needs

> + * @align: the requested aligning requirement for 'va'

                 or                                  @va

> + *
> + * WARN_ON_ONCE() checking for 'align' before allocing a page fragment from
> + * page_frag cache with aligning requirement for 'va'.

                    or                              @va.

> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.

Drop the second "Return".

> + */
>  static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
>  					     unsigned int fragsz,
>  					     gfp_t gfp_mask, unsigned int align)
> @@ -100,11 +130,32 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
>  }
>  
> +/**
> + * page_frag_cache_page_offset() - Return the current page fragment's offset.
> + * @nc: page_frag cache from which to check
> + *
> + * The API is only used in net/sched/em_meta.c for historical reason, do not use

                                                                 reasons; do not use

> + * it for new caller unless there is a strong reason.

                 callers

> + *
> + * Return:
> + * Return the offset of the current page fragment in the page_frag cache.

Drop second "Return".

> + */
>  static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
>  {
>  	return __page_frag_cache_page_offset(nc->encoded_va, nc->remaining);
>  }
>  
> +/**
> + * page_frag_alloc_va() - Alloc a page fragment.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled

                                                      needs

> + *
> + * Get a page fragment from page_frag cache.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.

Drop second "Return".

> + */
>  static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
>  				       unsigned int fragsz, gfp_t gfp_mask)
>  {
> @@ -114,6 +165,21 @@ static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
>  void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned int *fragsz,
>  				 gfp_t gfp);
>  
> +/**
> + * page_frag_alloc_va_prepare_align() - Prepare allocing a page fragment with
> + * aligning requirement.
> + * @nc: page_frag cache from which to prepare
> + * @fragsz: in as the requested size, out as the available size
> + * @gfp: the allocation gfp to use when cache need to be refilled

                                                 needs

> + * @align: the requested aligning requirement for 'va'

                                       or            @va

> + *
> + * WARN_ON_ONCE() checking for 'align' before preparing an aligned page fragment
> + * with minimum size of ‘fragsz’, 'fragsz' is also used to report the maximum

                           'fragsz'. 'fragsz' is
(don't use fancy single quote marks above)

> + * size of the page fragment the caller can use.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.

Drop second "Return".

> + */
>  static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
>  						     unsigned int *fragsz,
>  						     gfp_t gfp,
> @@ -148,6 +214,19 @@ static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache
>  	return encoded_va;
>  }
>  
> +/**
> + * page_frag_alloc_probe - Probe the avaiable page fragment.

                                        available

> + * @nc: page_frag cache from which to probe
> + * @offset: out as the offset of the page fragment
> + * @fragsz: in as the requested size, out as the available size
> + * @va: out as the virtual address of the returned page fragment
> + *
> + * Probe the current available memory to caller without doing cache refilling.
> + * If the cache is empty, return NULL.
> + *
> + * Return:
> + * Return the page fragment, otherwise return NULL.

Drop the second "Return".

> + */
>  #define page_frag_alloc_probe(nc, offset, fragsz, va)			\
>  ({									\
>  	struct encoded_va *__encoded_va;				\
> @@ -162,6 +241,13 @@ static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache
>  	__page;								\
>  })
>  
> +/**
> + * page_frag_alloc_commit - Commit allocing a page fragment.
> + * @nc: page_frag cache from which to commit
> + * @fragsz: size of the page fragment has been used
> + *
> + * Commit the alloc preparing by passing the actual used size.
> + */
>  static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
>  					  unsigned int fragsz)
>  {
> @@ -170,6 +256,16 @@ static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
>  	nc->remaining -= fragsz;
>  }
>  
> +/**
> + * page_frag_alloc_commit_noref - Commit allocing a page fragment without taking
> + * page refcount.
> + * @nc: page_frag cache from which to commit
> + * @fragsz: size of the page fragment has been used
> + *
> + * Commit the alloc preparing by passing the actual used size, but not taking
> + * page refcount. Mostly used for fragmemt coaleasing case when the current

                                     fragment coalescing

> + * fragmemt can share the same refcount with previous fragmemt.

      fragment                                           fragment.

> + */
>  static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
>  						unsigned int fragsz)
>  {
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index eb8bf59b26bb..85e23d5cbdcc 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -89,6 +89,18 @@ static struct page *page_frag_cache_refill(struct page_frag_cache *nc,
>  	return __page_frag_cache_refill(nc, gfp_mask);
>  }
>  
> +/**
> + * page_frag_alloc_va_prepare() - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @fragsz: in as the requested size, out as the available size
> + * @gfp: the allocation gfp to use when cache need to be refilled

                                                 needs

> + *
> + * Prepare a page fragment with minimum size of ‘fragsz’, 'fragsz' is also used

                                                   'fragsz'. 'fragsz'
(don't use fancy single quote marks)

> + * to report the maximum size of the page fragment the caller can use.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.

Drop second "Return".

> + */
>  void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
>  				 unsigned int *fragsz, gfp_t gfp)
>  {
> @@ -111,6 +123,19 @@ void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
>  }
>  EXPORT_SYMBOL(page_frag_alloc_va_prepare);
>  
> +/**
> + * page_frag_alloc_pg_prepare - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @offset: out as the offset of the page fragment
> + * @fragsz: in as the requested size, out as the available size
> + * @gfp: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare a page fragment with minimum size of ‘fragsz’, 'fragsz' is also used

                                                   'fragsz'. 'fragsz'
(don't use fancy single quote marks)

> + * to report the maximum size of the page fragment the caller can use.
> + *
> + * Return:
> + * Return the page fragment, otherwise return NULL.

Drop second "Return".

> + */
>  struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
>  					unsigned int *offset,
>  					unsigned int *fragsz, gfp_t gfp)
> @@ -141,6 +166,21 @@ struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
>  }
>  EXPORT_SYMBOL(page_frag_alloc_pg_prepare);
>  
> +/**
> + * page_frag_alloc_prepare - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @offset: out as the offset of the page fragment
> + * @fragsz: in as the requested size, out as the available size
> + * @va: out as the virtual address of the returned page fragment
> + * @gfp: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare a page fragment with minimum size of ‘fragsz’, 'fragsz' is also used

                                                   'fragsz'. 'fragsz'
(don't use fancy single quote marks)

You could also (in several places) refer to the variables as
                                                    @fragsz. @fragsz

> + * to report the maximum size of the page fragment. Return both 'page' and 'va'
> + * of the fragment to the caller.
> + *
> + * Return:
> + * Return the page fragment, otherwise return NULL.

Drop second "Return". But the paragraph above says that both @page and @va
are returned. How is that done?

> + */
>  struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
>  				     unsigned int *offset,
>  				     unsigned int *fragsz,
> @@ -173,6 +213,10 @@ struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
>  }
>  EXPORT_SYMBOL(page_frag_alloc_prepare);
>  
> +/**
> + * page_frag_cache_drain - Drain the current page from page_frag cache.
> + * @nc: page_frag cache from which to drain
> + */
>  void page_frag_cache_drain(struct page_frag_cache *nc)
>  {
>  	if (!nc->encoded_va)
> @@ -193,6 +237,19 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
>  }
>  EXPORT_SYMBOL(__page_frag_cache_drain);
>  
> +/**
> + * __page_frag_alloc_va_align() - Alloc a page fragment with aligning
> + * requirement.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + * @align_mask: the requested aligning requirement for the 'va'
> + *
> + * Get a page fragment from page_frag cache with aligning requirement.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.

Drop the second "Return".

> + */
>  void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>  				 unsigned int fragsz, gfp_t gfp_mask,
>  				 unsigned int align_mask)
> @@ -263,8 +320,12 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>  }
>  EXPORT_SYMBOL(__page_frag_alloc_va_align);
>  
> -/*
> - * Frees a page fragment allocated out of either a compound or order 0 page.
> +/**
> + * page_frag_free_va - Free a page fragment.
> + * @addr: va of page fragment to be freed
> + *
> + * Free a page fragment allocated out of either a compound or order 0 page by
> + * virtual address.
>   */
>  void page_frag_free_va(void *addr)
>  {


thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html


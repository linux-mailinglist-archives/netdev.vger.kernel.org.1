Return-Path: <netdev+bounces-95000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6828C134B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A374E281FC1
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314288F44;
	Thu,  9 May 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itWjunuv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009426FB0;
	Thu,  9 May 2024 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273890; cv=none; b=grZkM31Uvc7HQOQcMiNiieZSvrLSeWI1SvwKEXtqfUu1RcbxbkkcESndgjijEExg49dEvf3/TRhNCjrjINt0HZgiS72HaqmCiuLBBA4jHjZQ0fhWQXjAB1hes4W71OHHDUf4PvuDrk3WV6GowTNqxz4tp0/zvua3Muu1MrIffK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273890; c=relaxed/simple;
	bh=Rv252xbtK7kqw+580zaOJQJK+pd6z69TPTUWEDC6nyM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZyLgzhiGbU2LzUmVuo66PtpCAs8BVkY0uyetWzuG/7Ga8F6dI2J6zApFgvDi1kTXJAegAzUk73I2QREDoqnxlbhBSvbqcukPJ/iNlb4WjjtjMHfbcqf94AhEQ8cm9xAkJVQVmeFF549Be4bY+Stb8IxHC3bgHt8t4kQgPuLfPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itWjunuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634FEC116B1;
	Thu,  9 May 2024 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715273889;
	bh=Rv252xbtK7kqw+580zaOJQJK+pd6z69TPTUWEDC6nyM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=itWjunuvy+dTZ+EsBfr1IqpAG1KcaAzX0rJXlkbUu9lRhUc+WvAlHORJtkkUPZ3jZ
	 S90VqQzlFYWiHkGkTDZvWrIwBsV9FTIVSgOYiFs8spI+0WGrbGoCNm6R9xLwDloGqX
	 SPS97+jnlPPw/eJ8jSUdXZxd5vNU+dnYJEQQWWyl2Bj3hl6KVAm/zqt9y7X2Pa4TIK
	 n64Vp5ws8SuWMDxoJpRo5G06pmzCeP7QotCHNxAFHmpMwO6E+VnZuFVqtxgnzcW7W6
	 FAAgWwwAorCP5U+5fdHhVmJzMVA3q8btwmLZEE/TkhfCfIcSGqxmPJWqxwgtOuP95D
	 s80BrgVZnDjSw==
Date: Thu, 9 May 2024 09:58:08 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Alexander Duyck <alexander.duyck@gmail.com>, 
    Jonathan Corbet <corbet@lwn.net>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 12/13] mm: page_frag: update documentation
 for page_frag
In-Reply-To: <20240508133408.54708-13-linyunsheng@huawei.com>
Message-ID: <2dc46fd0-fe7a-436a-5238-ff6b3f69e1a8@kernel.org>
References: <20240508133408.54708-1-linyunsheng@huawei.com> <20240508133408.54708-13-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed

On Wed, 8 May 2024, Yunsheng Lin wrote:

> Update documentation about design, implementation and API usages
> for page_frag.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> Documentation/mm/page_frags.rst | 156 +++++++++++++++++++++++++++++++-
> include/linux/page_frag_cache.h |  96 ++++++++++++++++++++
> mm/page_frag_cache.c            |  65 ++++++++++++-
> 3 files changed, 314 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
> index 503ca6cdb804..9c25c0fd81f0 100644
> --- a/Documentation/mm/page_frags.rst
> +++ b/Documentation/mm/page_frags.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> ==============
> Page fragments
> ==============
> @@ -40,4 +42,156 @@ page via a single call.  The advantage to doing this is that it allows for
> cleaning up the multiple references that were added to a page in order to
> avoid calling get_page per allocation.
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
> +fragsz if there is a alignment requirement for the size of the fragment.
> +
> +Depending on different use cases, callers expecting to deal with va, page or
> +both va and page for them may call page_frag_alloc_va*, page_frag_alloc_pg*,
> +or page_frag_alloc* API accordingly.
> +
> +There is also a use case that need minimum memory in order for forward
> +progressing, but more performant if more memory is available. Using
> +page_frag_alloc_prepare() and page_frag_alloc_commit() related API, the caller
> +requests the minimum memory it need and the prepare API will return the maximum
> +size of the fragment returned, the caller needs to either call the commit API to
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
> #endif
> };
>
> +/**
> + * page_frag_cache_init() - Init page_frag cache.
> + * @nc: page_frag cache from which to init
> + *
> + * Inline helper to init the page_frag cache.
> + */
> static inline void page_frag_cache_init(struct page_frag_cache *nc)
> {
> 	memset(nc, 0, sizeof(*nc));
> }
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
> + * otherwise return false.
> + */
> static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
> {
> 	return encoded_page_pfmemalloc(nc->encoded_va);
> @@ -92,6 +109,19 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
> 				 unsigned int fragsz, gfp_t gfp_mask,
> 				 unsigned int align_mask);
>
> +/**
> + * page_frag_alloc_va_align() - Alloc a page fragment with aligning requirement.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + * @align: the requested aligning requirement for 'va'
> + *
> + * WARN_ON_ONCE() checking for 'align' before allocing a page fragment from
> + * page_frag cache with aligning requirement for 'va'.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
> static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
> 					     unsigned int fragsz,
> 					     gfp_t gfp_mask, unsigned int align)
> @@ -100,11 +130,32 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
> 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
> }
>
> +/**
> + * page_frag_cache_page_offset() - Return the current page fragment's offset.
> + * @nc: page_frag cache from which to check
> + *
> + * The API is only used in net/sched/em_meta.c for historical reason, do not use
> + * it for new caller unless there is a strong reason.
> + *
> + * Return:
> + * Return the offset of the current page fragment in the page_frag cache.
> + */
> static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
> {
> 	return __page_frag_cache_page_offset(nc->encoded_va, nc->remaining);
> }
>
> +/**
> + * page_frag_alloc_va() - Alloc a page fragment.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + *
> + * Get a page fragment from page_frag cache.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
> static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
> 				       unsigned int fragsz, gfp_t gfp_mask)
> {
> @@ -114,6 +165,21 @@ static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
> void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned int *fragsz,
> 				 gfp_t gfp);
>
> +/**
> + * page_frag_alloc_va_prepare_align() - Prepare allocing a page fragment with
> + * aligning requirement.
> + * @nc: page_frag cache from which to prepare
> + * @fragsz: in as the requested size, out as the available size
> + * @gfp: the allocation gfp to use when cache need to be refilled
> + * @align: the requested aligning requirement for 'va'
> + *
> + * WARN_ON_ONCE() checking for 'align' before preparing an aligned page fragment
> + * with minimum size of ???fragsz???, 'fragsz' is also used to report the maximum
> + * size of the page fragment the caller can use.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
> static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
> 						     unsigned int *fragsz,
> 						     gfp_t gfp,
> @@ -148,6 +214,19 @@ static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache
> 	return encoded_va;
> }
>
> +/**
> + * page_frag_alloc_probe - Probe the avaiable page fragment.
> + * @nc: page_frag cache from which to probe
> + * @offset: out as the offset of the page fragment
> + * @fragsz: in as the requested size, out as the available size

Hi Yunsheng -

fragsz is never used as an input in this function. I think it would be 
good to make the code consistent with this documentation by checking that 
*fragsz <= (nc)->remaining

> + * @va: out as the virtual address of the returned page fragment
> + *
> + * Probe the current available memory to caller without doing cache refilling.
> + * If the cache is empty, return NULL.

Instead of this line, is it more accurate to say "if no space is available 
in the page_frag cache, return NULL" ?

I also suggest adding some documentation here like:

"If the requested space is available, up to fragsz bytes may be added to 
the fragment using page_frag_alloc_commit()".

> + *
> + * Return:
> + * Return the page fragment, otherwise return NULL.
> + */
> #define page_frag_alloc_probe(nc, offset, fragsz, va)			\
> ({									\
> 	struct encoded_va *__encoded_va;				\
> @@ -162,6 +241,13 @@ static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache
> 	__page;								\
> })
>
> +/**
> + * page_frag_alloc_commit - Commit allocing a page fragment.
> + * @nc: page_frag cache from which to commit
> + * @fragsz: size of the page fragment has been used
> + *
> + * Commit the alloc preparing by passing the actual used size.

Rephrasing suggestion:

"Commit the actual used size for the allocation that was either prepared 
or probed"


Thanks,

Mat

> + */
> static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
> 					  unsigned int fragsz)
> {
> @@ -170,6 +256,16 @@ static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
> 	nc->remaining -= fragsz;
> }
>
> +/**
> + * page_frag_alloc_commit_noref - Commit allocing a page fragment without taking
> + * page refcount.
> + * @nc: page_frag cache from which to commit
> + * @fragsz: size of the page fragment has been used
> + *
> + * Commit the alloc preparing by passing the actual used size, but not taking
> + * page refcount. Mostly used for fragmemt coaleasing case when the current
> + * fragmemt can share the same refcount with previous fragmemt.
> + */
> static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
> 						unsigned int fragsz)
> {
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index eb8bf59b26bb..85e23d5cbdcc 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -89,6 +89,18 @@ static struct page *page_frag_cache_refill(struct page_frag_cache *nc,
> 	return __page_frag_cache_refill(nc, gfp_mask);
> }
>
> +/**
> + * page_frag_alloc_va_prepare() - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @fragsz: in as the requested size, out as the available size
> + * @gfp: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare a page fragment with minimum size of ???fragsz???, 'fragsz' is also used
> + * to report the maximum size of the page fragment the caller can use.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
> void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
> 				 unsigned int *fragsz, gfp_t gfp)
> {
> @@ -111,6 +123,19 @@ void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
> }
> EXPORT_SYMBOL(page_frag_alloc_va_prepare);
>
> +/**
> + * page_frag_alloc_pg_prepare - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @offset: out as the offset of the page fragment
> + * @fragsz: in as the requested size, out as the available size
> + * @gfp: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare a page fragment with minimum size of ???fragsz???, 'fragsz' is also used
> + * to report the maximum size of the page fragment the caller can use.
> + *
> + * Return:
> + * Return the page fragment, otherwise return NULL.
> + */
> struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
> 					unsigned int *offset,
> 					unsigned int *fragsz, gfp_t gfp)
> @@ -141,6 +166,21 @@ struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
> }
> EXPORT_SYMBOL(page_frag_alloc_pg_prepare);
>
> +/**
> + * page_frag_alloc_prepare - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @offset: out as the offset of the page fragment
> + * @fragsz: in as the requested size, out as the available size
> + * @va: out as the virtual address of the returned page fragment
> + * @gfp: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare a page fragment with minimum size of ???fragsz???, 'fragsz' is also used
> + * to report the maximum size of the page fragment. Return both 'page' and 'va'
> + * of the fragment to the caller.
> + *
> + * Return:
> + * Return the page fragment, otherwise return NULL.
> + */
> struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
> 				     unsigned int *offset,
> 				     unsigned int *fragsz,
> @@ -173,6 +213,10 @@ struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
> }
> EXPORT_SYMBOL(page_frag_alloc_prepare);
>
> +/**
> + * page_frag_cache_drain - Drain the current page from page_frag cache.
> + * @nc: page_frag cache from which to drain
> + */
> void page_frag_cache_drain(struct page_frag_cache *nc)
> {
> 	if (!nc->encoded_va)
> @@ -193,6 +237,19 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
> }
> EXPORT_SYMBOL(__page_frag_cache_drain);
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
> + */
> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
> 				 unsigned int fragsz, gfp_t gfp_mask,
> 				 unsigned int align_mask)
> @@ -263,8 +320,12 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
> }
> EXPORT_SYMBOL(__page_frag_alloc_va_align);
>
> -/*
> - * Frees a page fragment allocated out of either a compound or order 0 page.
> +/**
> + * page_frag_free_va - Free a page fragment.
> + * @addr: va of page fragment to be freed
> + *
> + * Free a page fragment allocated out of either a compound or order 0 page by
> + * virtual address.
>  */
> void page_frag_free_va(void *addr)
> {
> -- 
> 2.33.0
>
>
>


Return-Path: <netdev+bounces-33895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4F7A093D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC96D1C20844
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1FF21351;
	Thu, 14 Sep 2023 15:17:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4339C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:17:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E3AA1FD0
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694704635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBHXLcuV4EPqLOuVGuSZ2vgBmxBMgNfH5q8svpMWRW4=;
	b=UBWoeL3/NlEnHu9PXV10oocxlTtTJpsgDq/V48FOTUyMjSWZZipL6j+uBUdyusGvq105w8
	DYPu+MFPlqx/lO3P0MOWBlu3G1KmX+D9ryAaObjZFIS6boOOn0EbNO25yTb3uRPN79DdIn
	QxPcXWUFqIEFQqV7MSGjUfmlKc24WvI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-s7h072Q4NNasoV7Y8CZ6rQ-1; Thu, 14 Sep 2023 11:17:14 -0400
X-MC-Unique: s7h072Q4NNasoV7Y8CZ6rQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2be48142a6cso2647331fa.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704632; x=1695309432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBHXLcuV4EPqLOuVGuSZ2vgBmxBMgNfH5q8svpMWRW4=;
        b=MrRqnAHK70VZZKvsVXyQDq5He7aV9kyxJVMncBvEd+1cg5sgr5mqJAObwnQpHKWo0c
         nyFcwKTOwSELUe86/HIgEiwgo7UJGuooJa3vMk+tut1lwWwX4BrG5cP4w8FpbkmjRizc
         kysvZlNJQ8/x2MmZlphjcS0x5EOCDhWRQghf6zKs2tJducIqruOWNEegtgQGDMyCX/Pe
         OzttGd/0fyF20CUXbB29uy73gFTE2fW3auDj5QI23J/xwtU4KgGjN5fnu3Qu18T+ThMP
         6dB32aQpWRORyyLNFB6ujAOezUVQRIQWQkz1rZdyUzEhEmBqbftCERt7XWlfiF5wzPTg
         6C4A==
X-Gm-Message-State: AOJu0YzkpUxbLbRhlDQmAmyMOyy9OKbulrRnIWF9fR2uZa+qTVxcDeWj
	IuupIvW3x7DMQxQkR8q0rL3haQVAi7SpPcba+LFd3Wfc0ICSGr6Cq8m6pp27XN4/00DJ1N1YM0V
	hpTG0lOAvEWUvYSZj
X-Received: by 2002:ac2:488d:0:b0:502:d7fe:46f0 with SMTP id x13-20020ac2488d000000b00502d7fe46f0mr4370582lfc.0.1694704632710;
        Thu, 14 Sep 2023 08:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsU0DDT6yb3BujGwrIOC4cHfjRDtzTfEejwVQRucm650X7K6Lu5bFm3ku0G5LtBzXT6cTgCA==
X-Received: by 2002:ac2:488d:0:b0:502:d7fe:46f0 with SMTP id x13-20020ac2488d000000b00502d7fe46f0mr4370560lfc.0.1694704632270;
        Thu, 14 Sep 2023 08:17:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-187.dyn.eolo.it. [146.241.242.187])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7cd4a000000b0052333d7e320sm1033353edw.27.2023.09.14.08.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:17:11 -0700 (PDT)
Message-ID: <9e53ca46be34f3c393861b7a645bb25f0b03f1d2.camel@redhat.com>
Subject: Re: [PATCH net-next v8 2/6] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
From: Paolo Abeni <pabeni@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Bianconi
 <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang
 Chen <liangchen.linux@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>
Date: Thu, 14 Sep 2023 17:17:10 +0200
In-Reply-To: <20230912083126.65484-3-linyunsheng@huawei.com>
References: <20230912083126.65484-1-linyunsheng@huawei.com>
	 <20230912083126.65484-3-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 16:31 +0800, Yunsheng Lin wrote:
> Currently when page_pool_create() is called with
> PP_FLAG_PAGE_FRAG flag, page_pool_alloc_pages() is only
> allowed to be called under the below constraints:
> 1. page_pool_fragment_page() need to be called to setup
>    page->pp_frag_count immediately.
> 2. page_pool_defrag_page() often need to be called to drain
>    the page->pp_frag_count when there is no more user will
>    be holding on to that page.
>=20
> Those constraints exist in order to support a page to be
> split into multi frags.
>=20
> And those constraints have some overhead because of the
> cache line dirtying/bouncing and atomic update.
>=20
> Those constraints are unavoidable for case when we need a
> page to be split into more than one frag, but there is also
> case that we want to avoid the above constraints and their
> overhead when a page can't be split as it can only hold a big
> frag as requested by user, depending on different use cases:
> use case 1: allocate page without page splitting.
> use case 2: allocate page with page splitting.
> use case 3: allocate page with or without page splitting
>             depending on the frag size.
>=20
> Currently page pool only provide page_pool_alloc_pages() and
> page_pool_alloc_frag() API to enable the 1 & 2 separately,
> so we can not use a combination of 1 & 2 to enable 3, it is
> not possible yet because of the per page_pool flag
> PP_FLAG_PAGE_FRAG.
>=20
> So in order to allow allocating unsplit page without the
> overhead of split page while still allow allocating split
> page we need to remove the per page_pool flag in
> page_pool_is_last_frag(), as best as I can think of, it seems
> there are two methods as below:
> 1. Add per page flag/bit to indicate a page is split or
>    not, which means we might need to update that flag/bit
>    everytime the page is recycled, dirtying the cache line
>    of 'struct page' for use case 1.
> 2. Unify the page->pp_frag_count handling for both split and
>    unsplit page by assuming all pages in the page pool is split
>    into a big frag initially.
>=20
> As page pool already supports use case 1 without dirtying the
> cache line of 'struct page' whenever a page is recyclable, we
> need to support the above use case 3 with minimal overhead,
> especially not adding any noticeable overhead for use case 1,
> and we are already doing an optimization by not updating
> pp_frag_count in page_pool_defrag_page() for the last frag
> user, this patch chooses to unify the pp_frag_count handling
> to support the above use case 3.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/helpers.h | 48 ++++++++++++++++++++++++---------
>  net/core/page_pool.c            | 10 ++++++-
>  2 files changed, 44 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index 8e1c85de4995..0ec81b91bed8 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -115,28 +115,50 @@ static inline long page_pool_defrag_page(struct pag=
e *page, long nr)
>  	long ret;
> =20
>  	/* If nr =3D=3D pp_frag_count then we have cleared all remaining
> -	 * references to the page. No need to actually overwrite it, instead
> -	 * we can leave this to be overwritten by the calling function.
> +	 * references to the page:
> +	 * 1. 'n =3D=3D 1': no need to actually overwrite it.
> +	 * 2. 'n !=3D 1': overwrite it with one, which is the rare case
> +	 *              for frag draining.
>  	 *
> -	 * The main advantage to doing this is that an atomic_read is
> -	 * generally a much cheaper operation than an atomic update,
> -	 * especially when dealing with a page that may be partitioned
> -	 * into only 2 or 3 pieces.
> +	 * The main advantage to doing this is that not only we avoid a
> +	 * atomic update, as an atomic_read is generally a much cheaper
> +	 * operation than an atomic update, especially when dealing with
> +	 * a page that may be partitioned into only 2 or 3 pieces; but
> +	 * also unify the frag and non-frag handling by ensuring all
> +	 * pages have been split into one big frag initially, and only
> +	 * overwrite it when the page is split into more than one frag.
>  	 */
> -	if (atomic_long_read(&page->pp_frag_count) =3D=3D nr)
> +	if (atomic_long_read(&page->pp_frag_count) =3D=3D nr) {
> +		/* As we have ensured nr is always one for constant case
> +		 * using the BUILD_BUG_ON(), only need to handle the
> +		 * non-constant case here for frag count draining, which
> +		 * is a rare case.
> +		 */
> +		BUILD_BUG_ON(__builtin_constant_p(nr) && nr !=3D 1);
> +		if (!__builtin_constant_p(nr))
> +			atomic_long_set(&page->pp_frag_count, 1);
> +
>  		return 0;
> +	}
> =20
>  	ret =3D atomic_long_sub_return(nr, &page->pp_frag_count);
>  	WARN_ON(ret < 0);
> +
> +	/* We are the last user here too, reset frag count back to 1 to
> +	 * ensure all pages have been split into one big frag initially,
> +	 * this should be the rare case when the last two frag users call
> +	 * page_pool_defrag_page() currently.
> +	 */
> +	if (unlikely(!ret))
> +		atomic_long_set(&page->pp_frag_count, 1);
> +
>  	return ret;
>  }
> =20
> -static inline bool page_pool_is_last_frag(struct page_pool *pool,
> -					  struct page *page)
> +static inline bool page_pool_is_last_frag(struct page *page)
>  {
> -	/* If fragments aren't enabled or count is 0 we were the last user */
> -	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
> -	       (page_pool_defrag_page(page, 1) =3D=3D 0);
> +	/* If page_pool_defrag_page() returns 0, we were the last user */
> +	return page_pool_defrag_page(page, 1) =3D=3D 0;
>  }
> =20
>  /**
> @@ -161,7 +183,7 @@ static inline void page_pool_put_page(struct page_poo=
l *pool,
>  	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
>  	 */
>  #ifdef CONFIG_PAGE_POOL
> -	if (!page_pool_is_last_frag(pool, page))
> +	if (!page_pool_is_last_frag(page))
>  		return;
> =20
>  	page_pool_put_defragged_page(pool, page, dma_sync_size, allow_direct);
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 8a9868ea5067..403b6df2e144 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -376,6 +376,14 @@ static void page_pool_set_pp_info(struct page_pool *=
pool,
>  {
>  	page->pp =3D pool;
>  	page->pp_magic |=3D PP_SIGNATURE;
> +
> +	/* Ensuring all pages have been split into one big frag initially:
> +	 * page_pool_set_pp_info() is only called once for every page when it
> +	 * is allocated from the page allocator and page_pool_fragment_page()
> +	 * is dirtying the same cache line as the page->pp_magic above, so
> +	 * the overhead is negligible.
> +	 */
> +	page_pool_fragment_page(page, 1);
>  	if (pool->p.init_callback)
>  		pool->p.init_callback(page, pool->p.init_arg);
>  }

I think it would be nice backing the above claim with some benchmarks.
(possibly even just a micro-benchmark around the relevant APIs)
and include such info into the changelog message.

Cheers,

Paolo



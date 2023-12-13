Return-Path: <netdev+bounces-56689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A38107E3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1121C20AA2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AFEA5E;
	Wed, 13 Dec 2023 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIZ/UNyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F8CBE
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 17:53:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so14786165a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 17:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702432431; x=1703037231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okDeu+9sBNlATlj4ezj6Nv77l0bOiqekSRhSNc931I0=;
        b=xIZ/UNygxLbAdcessEGXR+W/Gr8sD9wnmVrUwjZZcy4RCj4JYMCqPLMq0IbSY6WGB0
         dmyQssKlNbTG7/R6NJbobEE/0idePk7p/Te1Hws7IJu+U8KgKLEElZqy8I0Ybcl5M8gS
         uOAbLFpAFqKxfZr3iI+pn5G8DCQVp8VGC0PinxA5VIXhmIuQKrD8YZZbIOprrlVfvWp8
         JRLWCtd5Pzc8oDpmSKjQCkr3pr3yIbNj/fou2ham3IlQUnYMNg9WXYv0IUb4IOS3Xfxd
         IIdRm11h0vO8hlbm1toX1YZJvyGTYs3e9gyrAsGmlyQqpoVFXUS+w3aWzEc3QFn6vmUj
         8chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702432431; x=1703037231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okDeu+9sBNlATlj4ezj6Nv77l0bOiqekSRhSNc931I0=;
        b=e4M/62dt9IeW0pSgjgsMUmH02F/OdvrH+XEAP+tC4ybDceFDd0BT3S4StwAEq1SYBd
         jUGBOPahTwuUhUv95xg1fMRlfCEXh4M+Whx4oS/5ScJBHum3VYXg7IfrhqJi8qMwEWT6
         F7WiSUMR3QWOvW5nziFDURpTTNsfO3Dcjv9jj3wd0tVq8ubLJnUdCMAcTE8DYv2EMb6/
         h4boY40G/Nve++k9g+yISL8NSevDmUkhXUEDlFJd6BIhFQpIfgsDJVDvDJ4K7ExWLlSs
         lrsVa85IxsehfY6fa0sml6RLP3Ykf+yh7rDXO+7WWk0W/FVesvNPWDK5i0mJqRdbFyXz
         4sYQ==
X-Gm-Message-State: AOJu0YxoxEo+Oe8uJASQzI1PZSrbPnymoakfCURkssJdLxZx4ZBoHtJD
	r8BUZ8EYxng4idU6YsrhQx1g7E/HXizk34nNltFHsA==
X-Google-Smtp-Source: AGHT+IEKq3x4/aMef9HYZeYqqyDGhVxO/He9KC+A3NqC2s8OxrpouNu45KiJzrfPWPbzpwW0Ty+go+m4t30AhCGdNUc=
X-Received: by 2002:a17:906:3084:b0:a1c:7fdd:3a04 with SMTP id
 4-20020a170906308400b00a1c7fdd3a04mr7167895ejv.46.1702432430613; Tue, 12 Dec
 2023 17:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212044614.42733-1-liangchen.linux@gmail.com> <20231212044614.42733-2-liangchen.linux@gmail.com>
In-Reply-To: <20231212044614.42733-2-liangchen.linux@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 17:53:38 -0800
Message-ID: <CAHS8izNuqn9Hn5yvB_4uJ0XJ7n5LK9fBSPakhNGn7uoHZRKXEg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/4] page_pool: transition to reference count
 management after page draining
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 8:46=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> To support multiple users referencing the same fragment,
> 'pp_frag_count' is renamed to 'pp_ref_count', transitioning pp pages
> from fragment management to reference count management after draining
> based on the suggestion from [1].
>
> The idea is that the concept of fragmenting exists before the page is
> drained, and all related functions retain their current names.
> However, once the page is drained, its management shifts to being
> governed by 'pp_ref_count'. Therefore, all functions associated with
> that lifecycle stage of a pp page are renamed.
>
> [1]
> http://lore.kernel.org/netdev/f71d9448-70c8-8793-dc9a-0eb48a570300@huawei=
.com
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
>  include/linux/mm_types.h                      |  2 +-
>  include/net/page_pool/helpers.h               | 60 +++++++++++--------
>  include/net/page_pool/types.h                 |  6 +-
>  net/core/page_pool.c                          | 12 ++--
>  5 files changed, 46 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index 8d9743a5e42c..98d33ac7ec64 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -298,8 +298,8 @@ static void mlx5e_page_release_fragmented(struct mlx5=
e_rq *rq,
>         u16 drain_count =3D MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
>         struct page *page =3D frag_page->page;
>
> -       if (page_pool_defrag_page(page, drain_count) =3D=3D 0)
> -               page_pool_put_defragged_page(rq->page_pool, page, -1, tru=
e);
> +       if (page_pool_unref_page(page, drain_count) =3D=3D 0)
> +               page_pool_put_unrefed_page(rq->page_pool, page, -1, true)=
;
>  }
>
>  static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 957ce38768b2..64e4572ef06d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -125,7 +125,7 @@ struct page {
>                         struct page_pool *pp;
>                         unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
> -                       atomic_long_t pp_frag_count;
> +                       atomic_long_t pp_ref_count;
>                 };
>                 struct {        /* Tail pages of compound page */
>                         unsigned long compound_head;    /* Bit zero is se=
t */
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index 4ebd544ae977..d0c5e7e6857a 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -29,7 +29,7 @@
>   * page allocated from page pool. Page splitting enables memory saving a=
nd thus
>   * avoids TLB/cache miss for data access, but there also is some cost to
>   * implement page splitting, mainly some cache line dirtying/bouncing fo=
r
> - * 'struct page' and atomic operation for page->pp_frag_count.
> + * 'struct page' and atomic operation for page->pp_ref_count.
>   *
>   * The API keeps track of in-flight pages, in order to let API users kno=
w when
>   * it is safe to free a page_pool object, the API users must call
> @@ -214,69 +214,77 @@ inline enum dma_data_direction page_pool_get_dma_di=
r(struct page_pool *pool)
>         return pool->p.dma_dir;
>  }
>
> -/* pp_frag_count represents the number of writers who can update the pag=
e
> - * either by updating skb->data or via DMA mappings for the device.
> - * We can't rely on the page refcnt for that as we don't know who might =
be
> - * holding page references and we can't reliably destroy or sync DMA map=
pings
> - * of the fragments.
> +/**
> + * page_pool_fragment_page() - split a fresh page into fragments
> + * @page:      page to split
> + * @nr:                references to set
> + *
> + * pp_ref_count represents the number of outstanding references to the p=
age,
> + * which will be freed using page_pool APIs (rather than page allocator =
APIs
> + * like put_page()). Such references are usually held by page_pool-aware
> + * objects like skbs marked for page pool recycling.
>   *
> - * When pp_frag_count reaches 0 we can either recycle the page if the pa=
ge
> - * refcnt is 1 or return it back to the memory allocator and destroy any
> - * mappings we have.
> + * This helper allows the caller to take (set) multiple references to a
> + * freshly allocated page. The page must be freshly allocated (have a
> + * pp_ref_count of 1). This is commonly done by drivers and
> + * "fragment allocators" to save atomic operations - either when they kn=
ow
> + * upfront how many references they will need; or to take MAX references=
 and
> + * return the unused ones with a single atomic dec(), instead of perform=
ing
> + * multiple atomic inc() operations.
>   */
>  static inline void page_pool_fragment_page(struct page *page, long nr)
>  {
> -       atomic_long_set(&page->pp_frag_count, nr);
> +       atomic_long_set(&page->pp_ref_count, nr);
>  }
>
> -static inline long page_pool_defrag_page(struct page *page, long nr)
> +static inline long page_pool_unref_page(struct page *page, long nr)
>  {
>         long ret;
>
> -       /* If nr =3D=3D pp_frag_count then we have cleared all remaining
> +       /* If nr =3D=3D pp_ref_count then we have cleared all remaining
>          * references to the page:
>          * 1. 'n =3D=3D 1': no need to actually overwrite it.
>          * 2. 'n !=3D 1': overwrite it with one, which is the rare case
> -        *              for pp_frag_count draining.
> +        *              for pp_ref_count draining.
>          *
>          * The main advantage to doing this is that not only we avoid a a=
tomic
>          * update, as an atomic_read is generally a much cheaper operatio=
n than
>          * an atomic update, especially when dealing with a page that may=
 be
> -        * partitioned into only 2 or 3 pieces; but also unify the pp_fra=
g_count
> +        * referenced by only 2 or 3 users; but also unify the pp_ref_cou=
nt
>          * handling by ensuring all pages have partitioned into only 1 pi=
ece
>          * initially, and only overwrite it when the page is partitioned =
into
>          * more than one piece.
>          */
> -       if (atomic_long_read(&page->pp_frag_count) =3D=3D nr) {
> +       if (atomic_long_read(&page->pp_ref_count) =3D=3D nr) {
>                 /* As we have ensured nr is always one for constant case =
using
>                  * the BUILD_BUG_ON(), only need to handle the non-consta=
nt case
> -                * here for pp_frag_count draining, which is a rare case.
> +                * here for pp_ref_count draining, which is a rare case.
>                  */
>                 BUILD_BUG_ON(__builtin_constant_p(nr) && nr !=3D 1);
>                 if (!__builtin_constant_p(nr))
> -                       atomic_long_set(&page->pp_frag_count, 1);
> +                       atomic_long_set(&page->pp_ref_count, 1);
>
>                 return 0;
>         }
>
> -       ret =3D atomic_long_sub_return(nr, &page->pp_frag_count);
> +       ret =3D atomic_long_sub_return(nr, &page->pp_ref_count);
>         WARN_ON(ret < 0);
>
> -       /* We are the last user here too, reset pp_frag_count back to 1 t=
o
> +       /* We are the last user here too, reset pp_ref_count back to 1 to
>          * ensure all pages have been partitioned into 1 piece initially,
>          * this should be the rare case when the last two fragment users =
call
> -        * page_pool_defrag_page() currently.
> +        * page_pool_unref_page() currently.
>          */
>         if (unlikely(!ret))
> -               atomic_long_set(&page->pp_frag_count, 1);
> +               atomic_long_set(&page->pp_ref_count, 1);
>
>         return ret;
>  }
>
> -static inline bool page_pool_is_last_frag(struct page *page)
> +static inline bool page_pool_is_last_ref(struct page *page)
>  {
> -       /* If page_pool_defrag_page() returns 0, we were the last user */
> -       return page_pool_defrag_page(page, 1) =3D=3D 0;
> +       /* If page_pool_unref_page() returns 0, we were the last user */
> +       return page_pool_unref_page(page, 1) =3D=3D 0;
>  }
>
>  /**
> @@ -301,10 +309,10 @@ static inline void page_pool_put_page(struct page_p=
ool *pool,
>          * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
>          */
>  #ifdef CONFIG_PAGE_POOL
> -       if (!page_pool_is_last_frag(page))
> +       if (!page_pool_is_last_ref(page))
>                 return;
>
> -       page_pool_put_defragged_page(pool, page, dma_sync_size, allow_dir=
ect);
> +       page_pool_put_unrefed_page(pool, page, dma_sync_size, allow_direc=
t);
>  #endif
>  }
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index e1bb92c192de..6a5323619f6e 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -224,9 +224,9 @@ static inline void page_pool_put_page_bulk(struct pag=
e_pool *pool, void **data,
>  }
>  #endif
>
> -void page_pool_put_defragged_page(struct page_pool *pool, struct page *p=
age,
> -                                 unsigned int dma_sync_size,
> -                                 bool allow_direct);
> +void page_pool_put_unrefed_page(struct page_pool *pool, struct page *pag=
e,
> +                               unsigned int dma_sync_size,
> +                               bool allow_direct);
>
>  static inline bool is_page_pool_compiled_in(void)
>  {
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index df2a06d7da52..106220b1f89c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -650,8 +650,8 @@ __page_pool_put_page(struct page_pool *pool, struct p=
age *page,
>         return NULL;
>  }
>
> -void page_pool_put_defragged_page(struct page_pool *pool, struct page *p=
age,
> -                                 unsigned int dma_sync_size, bool allow_=
direct)
> +void page_pool_put_unrefed_page(struct page_pool *pool, struct page *pag=
e,
> +                               unsigned int dma_sync_size, bool allow_di=
rect)
>  {
>         page =3D __page_pool_put_page(pool, page, dma_sync_size, allow_di=
rect);
>         if (page && !page_pool_recycle_in_ring(pool, page)) {
> @@ -660,7 +660,7 @@ void page_pool_put_defragged_page(struct page_pool *p=
ool, struct page *page,
>                 page_pool_return_page(pool, page);
>         }
>  }
> -EXPORT_SYMBOL(page_pool_put_defragged_page);
> +EXPORT_SYMBOL(page_pool_put_unrefed_page);
>
>  /**
>   * page_pool_put_page_bulk() - release references on multiple pages
> @@ -687,7 +687,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, =
void **data,
>                 struct page *page =3D virt_to_head_page(data[i]);
>
>                 /* It is not the last user for the page frag case */
> -               if (!page_pool_is_last_frag(page))
> +               if (!page_pool_is_last_ref(page))
>                         continue;
>
>                 page =3D __page_pool_put_page(pool, page, -1, false);
> @@ -729,7 +729,7 @@ static struct page *page_pool_drain_frag(struct page_=
pool *pool,
>         long drain_count =3D BIAS_MAX - pool->frag_users;
>
>         /* Some user is still using the page frag */
> -       if (likely(page_pool_defrag_page(page, drain_count)))
> +       if (likely(page_pool_unref_page(page, drain_count)))
>                 return NULL;
>
>         if (page_ref_count(page) =3D=3D 1 && !page_is_pfmemalloc(page)) {
> @@ -750,7 +750,7 @@ static void page_pool_free_frag(struct page_pool *poo=
l)
>
>         pool->frag_page =3D NULL;
>
> -       if (!page || page_pool_defrag_page(page, drain_count))
> +       if (!page || page_pool_unref_page(page, drain_count))
>                 return;
>
>         page_pool_return_page(pool, page);
> --
> 2.31.1
>
>


--=20
Thanks,
Mina


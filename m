Return-Path: <netdev+bounces-16132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117574B77E
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4DC281897
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45B174FB;
	Fri,  7 Jul 2023 19:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEB174C4
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:51:05 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE419A5
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:51:03 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-440ac4b44a8so956058137.3
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688759463; x=1691351463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6B0lFu+I8+BEBhYYNJkyo9zfH4e8i60t8kDTiJbC10=;
        b=fz8/UafbjqyK2VFC7luNlOm7v4Xq+VrS+zeTweoUbGuUeWyfTv44kEA9haQrSwq4w1
         XpLYb6MtGUV5F8/I0FuM7Dr4E1Hj7i6LLJxfi2ujfGbSzalwwIHVd4bTyu2aQaPgZc6x
         b5daRMtJq4lwAzMckTsK3nbzQhU2VG4OJp0jz8+KixcRLiliMtOMHfmMUx6lKGC+d0Oy
         Jn3C0owlKzRXzJXrjAG8BYHIr6siSrXTGuVSmarVAoAuBqy214MiwHT/EXVEGhuqkLkv
         eVARMHX2FH6+gtO8YwQBg4zGrZsus64/+2nUFQAFX2KGmjrZxqwd9i2qZmGD0/NxD9Qr
         rXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688759463; x=1691351463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6B0lFu+I8+BEBhYYNJkyo9zfH4e8i60t8kDTiJbC10=;
        b=IPrY3QFBqin80JtD/t1F5pNtI902tTfy9MX8WYcVtK7UmrAWhUpjc/vNV+Pcm0MA6s
         8K0wYW/qJSxyXNj5+4Pmnh3OiHccKAat+Rb0X8ywWMN6lkJlG/Epz8nj1VXKM67zLVL+
         /r1PoacMJFQ5jEw7RXktEfhX/o7JSUUCn6BElhg1+ttBgzHhnc1JspzBU3/5Ow7z8TKZ
         I3hswdYhoPgiT/F5LLxjm4Ro3E8/ZwAIwoeteHmVMh0nzX+LlSlBiF+u0KseZQ3oy0/z
         qhAjHlTpirGd1K8bl33TXKurRh3HIauGdF4HDQPXpuyPOMAIBlRa8uKzoi1oNB0NkSiC
         wK6w==
X-Gm-Message-State: ABy/qLZKgu5Dk82WOT2XSlVAHAXmbGgz5BxZfqhrT++UnsIhI73zV0R1
	hRzBnSDrCvW0NAqhyC8g43kvuuuxPWOO/h3m3EhVew==
X-Google-Smtp-Source: APBJJlFv4OIzypJQ14RCykHySJSpn4+UQRAWa1hRsIvce/2W2v0FDRh5ZZgPBDKTcNK9G7mRW0VclOjxMXfq+W1RRa0=
X-Received: by 2002:a05:6102:300b:b0:443:92a5:f454 with SMTP id
 s11-20020a056102300b00b0044392a5f454mr4341501vsa.26.1688759462865; Fri, 07
 Jul 2023 12:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707183935.997267-1-kuba@kernel.org> <20230707183935.997267-7-kuba@kernel.org>
In-Reply-To: <20230707183935.997267-7-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 7 Jul 2023 12:50:51 -0700
Message-ID: <CAHS8izM+o3m_h1SU8D-1XmDVsfqTwWmpcPpsp2Xh-0vVdOo=ew@mail.gmail.com>
Subject: Re: [RFC 06/12] net: page_pool: create hooks for custom page providers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	edumazet@google.com, dsahern@gmail.com, michael.chan@broadcom.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 11:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The page providers which try to reuse the same pages will
> need to hold onto the ref, even if page gets released from
> the pool - as in releasing the page from the pp just transfers
> the "ownership" reference from pp to the provider, and provider
> will wait for other references to be gone before feeding this
> page back into the pool.
>
> The rest if pretty obvious.
>
> Add a test provider which should behave identically to
> a normal page pool.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool.h | 20 +++++++++++
>  net/core/page_pool.c    | 80 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 97 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index b082c9118f05..5859ab838ed2 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -77,6 +77,7 @@ struct page_pool_params {
>         int             nid;  /* Numa node id to allocate from pages from=
 */
>         struct device   *dev; /* device, for DMA pre-mapping purposes */
>         struct napi_struct *napi; /* Sole consumer of pages, otherwise NU=
LL */
> +       u8              memory_provider; /* haaacks! should be user-facin=
g */
>         enum dma_data_direction dma_dir; /* DMA mapping direction */
>         unsigned int    max_len; /* max DMA sync memory size */
>         unsigned int    offset;  /* DMA addr offset */
> @@ -147,6 +148,22 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *=
data, void *stats)
>
>  #endif
>
> +struct mem_provider;
> +
> +enum pp_memory_provider_type {
> +       __PP_MP_NONE, /* Use system allocator directly */
> +       PP_MP_BASIC, /* Test purposes only, Hacky McHackface */
> +};
> +
> +struct pp_memory_provider_ops {
> +       int (*init)(struct page_pool *pool);
> +       void (*destroy)(struct page_pool *pool);
> +       struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
> +       bool (*release_page)(struct page_pool *pool, struct page *page);
> +};
> +
> +extern const struct pp_memory_provider_ops basic_ops;
> +
>  struct page_pool {
>         struct page_pool_params p;
>
> @@ -194,6 +211,9 @@ struct page_pool {
>          */
>         struct ptr_ring ring;
>
> +       const struct pp_memory_provider_ops *mp_ops;
> +       void *mp_priv;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         /* recycle stats are per-cpu to avoid locking */
>         struct page_pool_recycle_stats __percpu *recycle_stats;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 09f8c34ad4a7..e886a439f9bb 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -23,6 +23,8 @@
>
>  #include <trace/events/page_pool.h>
>
> +static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
>
> @@ -161,6 +163,7 @@ static int page_pool_init(struct page_pool *pool,
>                           const struct page_pool_params *params)
>  {
>         unsigned int ring_qsize =3D 1024; /* Default */
> +       int err;
>
>         memcpy(&pool->p, params, sizeof(pool->p));
>
> @@ -218,10 +221,36 @@ static int page_pool_init(struct page_pool *pool,
>         /* Driver calling page_pool_create() also call page_pool_destroy(=
) */
>         refcount_set(&pool->user_cnt, 1);
>
> +       switch (pool->p.memory_provider) {
> +       case __PP_MP_NONE:
> +               break;
> +       case PP_MP_BASIC:
> +               pool->mp_ops =3D &basic_ops;
> +               break;
> +       default:
> +               err =3D -EINVAL;
> +               goto free_ptr_ring;
> +       }
> +
> +       if (pool->mp_ops) {
> +               err =3D pool->mp_ops->init(pool);
> +               if (err) {
> +                       pr_warn("%s() mem-provider init failed %d\n",
> +                               __func__, err);
> +                       goto free_ptr_ring;
> +               }
> +
> +               static_branch_inc(&page_pool_mem_providers);
> +       }
> +
>         if (pool->p.flags & PP_FLAG_DMA_MAP)
>                 get_device(pool->p.dev);
>
>         return 0;
> +
> +free_ptr_ring:
> +       ptr_ring_cleanup(&pool->ring, NULL);
> +       return err;
>  }
>
>  struct page_pool *page_pool_create(const struct page_pool_params *params=
)
> @@ -463,7 +492,10 @@ struct page *page_pool_alloc_pages(struct page_pool =
*pool, gfp_t gfp)
>                 return page;
>
>         /* Slow-path: cache empty, do real allocation */
> -       page =3D __page_pool_alloc_pages_slow(pool, gfp);
> +       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_=
ops)
> +               page =3D pool->mp_ops->alloc_pages(pool, gfp);
> +       else
> +               page =3D __page_pool_alloc_pages_slow(pool, gfp);
>         return page;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_pages);
> @@ -515,8 +547,13 @@ void __page_pool_release_page_dma(struct page_pool *=
pool, struct page *page)
>  void page_pool_return_page(struct page_pool *pool, struct page *page)
>  {
>         int count;
> +       bool put;
>
> -       __page_pool_release_page_dma(pool, page);
> +       put =3D true;
> +       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_=
ops)
> +               put =3D pool->mp_ops->release_page(pool, page);
> +       else
> +               __page_pool_release_page_dma(pool, page);
>
>         page_pool_clear_pp_info(page);
>
> @@ -526,7 +563,8 @@ void page_pool_return_page(struct page_pool *pool, st=
ruct page *page)
>         count =3D atomic_inc_return_relaxed(&pool->pages_state_release_cn=
t);
>         trace_page_pool_state_release(pool, page, count);
>
> -       put_page(page);
> +       if (put)
> +               put_page(page);

+1 to giving memory providers the option to replace put_page() with a
custom release function. In your original proposal, the put_page() was
intact, and I thought it was some requirement from you that pages must
be freed with put_page(). I made my code with/around that, but I think
it's nice to give future memory providers the option to replace this.

>         /* An optimization would be to call __free_pages(page, pool->p.or=
der)
>          * knowing page is not part of page-cache (thus avoiding a
>          * __page_cache_release() call).
> @@ -779,6 +817,11 @@ static void page_pool_free(struct page_pool *pool)
>         if (pool->disconnect)
>                 pool->disconnect(pool);
>
> +       if (pool->mp_ops) {
> +               pool->mp_ops->destroy(pool);
> +               static_branch_dec(&page_pool_mem_providers);
> +       }
> +
>         ptr_ring_cleanup(&pool->ring, NULL);
>
>         if (pool->p.flags & PP_FLAG_DMA_MAP)
> @@ -952,3 +995,34 @@ bool page_pool_return_skb_page(struct page *page, bo=
ol napi_safe)
>         return true;
>  }
>  EXPORT_SYMBOL(page_pool_return_skb_page);
> +
> +/***********************
> + *  Mem provider hack  *
> + ***********************/
> +
> +static int mp_basic_init(struct page_pool *pool)
> +{
> +       return 0;
> +}
> +
> +static void mp_basic_destroy(struct page_pool *pool)
> +{
> +}
> +
> +static struct page *mp_basic_alloc_pages(struct page_pool *pool, gfp_t g=
fp)
> +{
> +       return __page_pool_alloc_pages_slow(pool, gfp);
> +}
> +
> +static bool mp_basic_release(struct page_pool *pool, struct page *page)
> +{
> +       __page_pool_release_page_dma(pool, page);
> +       return true;
> +}
> +
> +const struct pp_memory_provider_ops basic_ops =3D {
> +       .init                   =3D mp_basic_init,
> +       .destroy                =3D mp_basic_destroy,
> +       .alloc_pages            =3D mp_basic_alloc_pages,
> +       .release_page           =3D mp_basic_release,
> +};
> --
> 2.41.0
>


--=20
Thanks,
Mina


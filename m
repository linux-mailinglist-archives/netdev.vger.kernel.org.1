Return-Path: <netdev+bounces-20375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D1675F36C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1D01C20B93
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA3D6ABA;
	Mon, 24 Jul 2023 10:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA5125AC
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:36:26 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C6E1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:36:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977e0fbd742so677637266b.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690194981; x=1690799781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t37qj44IfJRFzMeZmWHLWUgt1Pyq0ja8fDgODh/CLE4=;
        b=CLI6dZELWpH+vCkrm8MOABUcyuTLO8ZP7ZP6BluTQzVrDydEHzoYcqUaPnNsCU8EjF
         594/jNmhvs+26sbFpaK+Dc2wLCsg4+u6n/jMdy2jHSu/yEF5DaDiUqws2C0uXSdrva67
         iD/PW9vWcgDpt2HVIMazdLbU7qdVLqBbi/13PYPoUScow1w/+aKteiG/90eXWLGdC39f
         RFBd9oI6mTsyE/vPdDSPaEwtEkSiv76Gjk/ASMS5W0fXL0BXTDFFtBGHHM+7ZQpWH4yc
         x08S92+ms3Xh+ejXthIYbU5PX4eUt0nkzM3B4bOiKXNjqItTGz7Y8mmAzHBsLDkPZUbx
         P2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690194981; x=1690799781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t37qj44IfJRFzMeZmWHLWUgt1Pyq0ja8fDgODh/CLE4=;
        b=ScjzaEPZyjW+LzGyFjb/FrorxgHXqxOKjWq18M9xLGLJgWMoJLljV0A49Po3zzm+MJ
         MKS5m0mS+43TrUsSi4DDavll2WK9GG7xF27G4F+Xeu1PH0SVSyL91CyCn21eAXKVJmAO
         6zmoUWiJw9+gnByGJQp7hdtRadaNhCn6I+QD3bbTfR5ezQ+/SMumWHreDp0U5ZxW/jet
         Vgc3WDffvVsixDpBh5XZPyHtXmJ2B3PgOt2JlpvxHCaJXQ7PGJFe8G17K5hJ55iB1QOK
         KDTf4+nVGCsVi7HA6NIn0LWMG0xLaiq+BAt9NJKvVCcS+HbGWrio8jWM+SLS0YvceG45
         OT8g==
X-Gm-Message-State: ABy/qLYlA7KYJq7eoSRzoqvC0g+YSKSc/TzV++YtgxeB4I/1U79YZHaz
	wUYMZ+e3i5CV6Eaumtgur+Am/w==
X-Google-Smtp-Source: APBJJlFgv6lmwWNbbQEZ1kqMDi60UI0SGYSwRS7hT0OCZYiaX/owgiMQ27VeCgxBxZo2cVAWRIIr1Q==
X-Received: by 2002:a17:906:7691:b0:991:c566:979 with SMTP id o17-20020a170906769100b00991c5660979mr8266006ejm.36.1690194981347;
        Mon, 24 Jul 2023 03:36:21 -0700 (PDT)
Received: from hera (ppp046103056065.access.hol.gr. [46.103.56.65])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906080c00b009927d4d7a6dsm6477014ejd.192.2023.07.24.03.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:36:21 -0700 (PDT)
Date: Mon, 24 Jul 2023 13:36:18 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, hawk@kernel.org
Subject: Re: [PATCH net-next 3/4] net: page_pool: hide
 page_pool_release_page()
Message-ID: <ZL5UIsXuFMNc7lKa@hera>
References: <20230720010409.1967072-1-kuba@kernel.org>
 <20230720010409.1967072-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720010409.1967072-4-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

Apologies for being late, I was on vacation and will now slowly go through
the pile of patches

On Wed, Jul 19, 2023 at 06:04:08PM -0700, Jakub Kicinski wrote:
> There seems to be no user calling page_pool_release_page()
> for legit reasons, all the users simply haven't been converted
> to skb-based recycling, yet. Previous changes converted them.
> Update the docs, and unexport the function.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> ---
>  Documentation/networking/page_pool.rst | 11 ++++-------
>  include/net/page_pool.h                | 10 ++--------
>  net/core/page_pool.c                   |  3 +--
>  3 files changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
> index 873efd97f822..0aa850cf4447 100644
> --- a/Documentation/networking/page_pool.rst
> +++ b/Documentation/networking/page_pool.rst
> @@ -13,9 +13,9 @@ replacing dev_alloc_pages().
>
>  API keeps track of in-flight pages, in order to let API user know
>  when it is safe to free a page_pool object.  Thus, API users
> -must run page_pool_release_page() when a page is leaving the page_pool or
> -call page_pool_put_page() where appropriate in order to maintain correct
> -accounting.
> +must call page_pool_put_page() to free the page, or attach
> +the page to a page_pool-aware objects like skbs marked with
> +skb_mark_for_recycle().
>
>  API user must call page_pool_put_page() once on a page, as it
>  will either recycle the page, or in case of refcnt > 1, it will
> @@ -87,9 +87,6 @@ a page will cause no race conditions is enough.
>    must guarantee safe context (e.g NAPI), since it will recycle the page
>    directly into the pool fast cache.
>
> -* page_pool_release_page(): Unmap the page (if mapped) and account for it on
> -  in-flight counters.
> -
>  * page_pool_dev_alloc_pages(): Get a page from the page allocator or page_pool
>    caches.
>
> @@ -194,7 +191,7 @@ NAPI poller
>              if XDP_DROP:
>                  page_pool_recycle_direct(page_pool, page);
>          } else (packet_is_skb) {
> -            page_pool_release_page(page_pool, page);
> +            skb_mark_for_recycle(skb);
>              new_page = page_pool_dev_alloc_pages(page_pool);
>          }
>      }
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 126f9e294389..f1d5cc1fa13b 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -18,9 +18,8 @@
>   *
>   * API keeps track of in-flight pages, in-order to let API user know
>   * when it is safe to dealloactor page_pool object.  Thus, API users
> - * must make sure to call page_pool_release_page() when a page is
> - * "leaving" the page_pool.  Or call page_pool_put_page() where
> - * appropiate.  For maintaining correct accounting.
> + * must call page_pool_put_page() where appropriate and only attach
> + * the page to a page_pool-aware objects, like skbs marked for recycling.
>   *
>   * API user must only call page_pool_put_page() once on a page, as it
>   * will either recycle the page, or in case of elevated refcnt, it
> @@ -251,7 +250,6 @@ void page_pool_unlink_napi(struct page_pool *pool);
>  void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
>  			   struct xdp_mem_info *mem);
> -void page_pool_release_page(struct page_pool *pool, struct page *page);
>  void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>  			     int count);
>  #else
> @@ -268,10 +266,6 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
>  					 struct xdp_mem_info *mem)
>  {
>  }
> -static inline void page_pool_release_page(struct page_pool *pool,
> -					  struct page *page)
> -{
> -}
>
>  static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>  					   int count)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a3e12a61d456..2c7cf5f2bcb8 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -492,7 +492,7 @@ static s32 page_pool_inflight(struct page_pool *pool)
>   * a regular page (that will eventually be returned to the normal
>   * page-allocator via put_page).
>   */
> -void page_pool_release_page(struct page_pool *pool, struct page *page)
> +static void page_pool_release_page(struct page_pool *pool, struct page *page)
>  {
>  	dma_addr_t dma;
>  	int count;
> @@ -519,7 +519,6 @@ void page_pool_release_page(struct page_pool *pool, struct page *page)
>  	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
>  	trace_page_pool_state_release(pool, page, count);
>  }
> -EXPORT_SYMBOL(page_pool_release_page);
>
>  /* Return a page to the page allocator, cleaning up our state */
>  static void page_pool_return_page(struct page_pool *pool, struct page *page)
> --
> 2.41.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>



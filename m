Return-Path: <netdev+bounces-46768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F37E64FE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD1C1C2082C
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D091E10790;
	Thu,  9 Nov 2023 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUS4/fnO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BA10780
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:14:01 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895492D4D
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 00:14:00 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507f1c29f25so711167e87.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 00:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699517639; x=1700122439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G17FVc9ZIs9MsADgRcHfDSaNMtMlfNOczgj7HTnDgTw=;
        b=hUS4/fnODHvCt4LC+GZCb0i/pICkzBjhFF09qZdsU/D+b7hAlPxpmxaiWozCRJvg0Z
         lROtONTbDdHZnsbXXzvqI1wjG7pYhPWtmJjnPcX6/Q8VeUGCDwGMrMTz6LqCtzNc2D7v
         39mGJFf98xcHuYU/Cvg/Cn7gzDU8k6Vd6bVMVZMbOIeXYXX/YXHl70wqPAAI/KQ2rLLP
         9h9+guwzUli81KiziKvIOdU4aSDYJ30RYWwuy5GZqnN6B/TSNKmq8ZjAw7TpapC+d/yz
         31s9QSYRPtOxWmwQSPL/O5h0H6GgwaPFawI9mEzLQycie98wEEl0QW3+OGfTTW799DHb
         cRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699517639; x=1700122439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G17FVc9ZIs9MsADgRcHfDSaNMtMlfNOczgj7HTnDgTw=;
        b=dcbAi9YRAMp8BqqO+V+kaMdsbR2c/Z9F36nLYGVhSIa6DdciNKevGtNgSast18nQ6Q
         yhmkEtYegpyHbTOOiAYX+9uhKEG+bkgD/PjkUz5dRynK8BooSm14vYSJT11SxmUTW7Tf
         ibb2I53oW9aCz4RxaheMKdVfzzAHt2LZ8Xc+1kLCrrUzjD+cxakGKgscYF1SiwkH1sIm
         SgAz756AJ4lF8OSEjVRVWq0mHjw7jydb7nQ9BoIqvkBz8AeoVRaX7LSAaGD5imsSH0Lx
         U1BRMksEcTc/yFUTUfcmQDxfW118JrOk3Yrl/6k6/i1HFSgbNw55wPpEowYbkheu0OGO
         KX1A==
X-Gm-Message-State: AOJu0YzR5uTO3NTqK9zxDKuegRyXidkezqty3wyUnNurMuXHeeZegE7d
	O0+98LjSLV4K74WFxRN6yhHXEBtYSFiUvW0Xp2RU/Q==
X-Google-Smtp-Source: AGHT+IH2r9WNnRLnV5uGU3d5Llux4hoXQYUMNaE4Hjf1i4MbmVDWuTW9k0oJXF1ZB7Hr/UFPd9TcZFYsRREBNgCBRVE=
X-Received: by 2002:ac2:5e6c:0:b0:509:1033:c544 with SMTP id
 a12-20020ac25e6c000000b005091033c544mr683089lfr.50.1699517638598; Thu, 09 Nov
 2023 00:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-2-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-2-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 10:13:22 +0200
Message-ID: <CAC_iWjKk4FPF4Pf-Lz15NrR9yWvrOehgFeSB+Wi6UzYDh8r=wQ@mail.gmail.com>
Subject: Re: [PATCH net-next 01/15] net: page_pool: split the page_pool_params
 into fast and slow
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Oct 2023 at 19:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
> struct page_pool is rather performance critical and we use
> 16B of the first cache line to store 2 pointers used only
> by test code. Future patches will add more informational
> (non-fast path) attributes.
>
> It's convenient for the user of the API to not have to worry
> which fields are fast and which are slow path. Use struct
> groups to split the params into the two categories internally.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool/types.h | 31 +++++++++++++++++++------------
>  net/core/page_pool.c          |  7 ++++---
>  2 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 6fc5134095ed..23950fcc4eca 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -54,18 +54,22 @@ struct pp_alloc_cache {
>   * @offset:    DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
>   */
>  struct page_pool_params {
> -       unsigned int    flags;
> -       unsigned int    order;
> -       unsigned int    pool_size;
> -       int             nid;
> -       struct device   *dev;
> -       struct napi_struct *napi;
> -       enum dma_data_direction dma_dir;
> -       unsigned int    max_len;
> -       unsigned int    offset;
> +       struct_group_tagged(page_pool_params_fast, fast,
> +               unsigned int    flags;
> +               unsigned int    order;
> +               unsigned int    pool_size;
> +               int             nid;
> +               struct device   *dev;
> +               struct napi_struct *napi;
> +               enum dma_data_direction dma_dir;
> +               unsigned int    max_len;
> +               unsigned int    offset;
> +       );
> +       struct_group_tagged(page_pool_params_slow, slow,
>  /* private: used by test code only */
> -       void (*init_callback)(struct page *page, void *arg);
> -       void *init_arg;
> +               void (*init_callback)(struct page *page, void *arg);
> +               void *init_arg;
> +       );
>  };
>
>  #ifdef CONFIG_PAGE_POOL_STATS
> @@ -119,7 +123,7 @@ struct page_pool_stats {
>  #endif
>
>  struct page_pool {
> -       struct page_pool_params p;
> +       struct page_pool_params_fast p;
>
>         long frag_users;
>         struct page *frag_page;
> @@ -178,6 +182,9 @@ struct page_pool {
>         refcount_t user_cnt;
>
>         u64 destroy_cnt;
> +
> +       /* Slow/Control-path information follows */
> +       struct page_pool_params_slow slow;
>  };
>
>  struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 5e409b98aba0..5cae413de7cc 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -173,7 +173,8 @@ static int page_pool_init(struct page_pool *pool,
>  {
>         unsigned int ring_qsize = 1024; /* Default */
>
> -       memcpy(&pool->p, params, sizeof(pool->p));
> +       memcpy(&pool->p, &params->fast, sizeof(pool->p));
> +       memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
>
>         /* Validate only known flags were used */
>         if (pool->p.flags & ~(PP_FLAG_ALL))
> @@ -384,8 +385,8 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>          * the overhead is negligible.
>          */
>         page_pool_fragment_page(page, 1);
> -       if (pool->p.init_callback)
> -               pool->p.init_callback(page, pool->p.init_arg);
> +       if (pool->slow.init_callback)
> +               pool->slow.init_callback(page, pool->slow.init_arg);
>  }
>
>  static void page_pool_clear_pp_info(struct page *page)
> --
> 2.41.0
>

Had time for a close look, feel free to replace my ack with
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


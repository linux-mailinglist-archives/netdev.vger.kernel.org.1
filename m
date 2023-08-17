Return-Path: <netdev+bounces-28375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B019777F393
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B49B281E5A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA4125DE;
	Thu, 17 Aug 2023 09:36:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F17F9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:36:38 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AAD271B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:36:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so119349281fa.3
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692264996; x=1692869796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CgMIogxFJdbbje1Wj9BdW12n1FzF0IOzLniM/oBp9EU=;
        b=dD4wOjB5zC4k9hXz3xiwunA1xddKOFycT9lAuXrV7KG7hiFIQYJY4qhqXT717x+Am2
         Dqme1g19mUPis9Qnqa9sPrITb4NGfWNkYQGZd/BhQ103uGhXb+2ZpQ4crieYfhECt2Ku
         3UJ8P8p+SZkekorj7Qz34IpwyjuPUQQkQKEjLHq6DEZSKcT4jR5uZhgwMbIRqiJLRJT0
         PZne8aqIBdOI57ve1cWPAo86FKCfsWrlUvESGLIL3N0qW7tNpEPRWRo4c5UbpzsmRrHi
         tI722JfVQboGiwoC3IRrIbCASJdB5bmRxC53yIMLuU+TWhGXgGR29o2L4kdDDAUDFgQ6
         nDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264996; x=1692869796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgMIogxFJdbbje1Wj9BdW12n1FzF0IOzLniM/oBp9EU=;
        b=e8UIqOAFAZspFop6Hp8HJgVtcn8HHVFuIvzndr3QprZY/ucA3tZ86MptwkK+jajqKN
         hQuPy61CJvA1ZgE/q7u9uUmL04Z10v/DOK7Dm+KY1Na2ZMjYhjChLMeq5UNKS/rcuZtM
         z7BrUQpTDZZF53tJmCQyNE6lOU8QTd3xvME7X90awMqcXLvWb6wEO0ihc1TtI60SDMra
         gzRdEDh0L0HGygf6ErPCnwewM9eMET2O807bgVSckLksCDdMkRtAM9SMosEY/hMCJaN6
         0pbvrFS3HT/sg7SDb/ypEaekApLjTtncLIeumzKAFJx5eRMOuHEcoMwZJSLn+1nbU9ax
         7HdQ==
X-Gm-Message-State: AOJu0YwUCHvHHPOn61ljGV/OgtK1cZwUZuSjlXPWlzHt5+snFGGYPFY5
	Qex+U84BU3HrZEGUl9FIsMBbCC7z/vdGdhnqMwL3KQ==
X-Google-Smtp-Source: AGHT+IHjE1WJQTgAxJw0FhMpGaphRG3tPiudL3hjcJNynUaPI4UQvOaeIoFtNmDPmXVygr5q1s+GzhlvQ6RFscLY1MM=
X-Received: by 2002:a19:520b:0:b0:4fe:82a7:814f with SMTP id
 m11-20020a19520b000000b004fe82a7814fmr3287395lfb.37.1692264995894; Thu, 17
 Aug 2023 02:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816234303.3786178-1-kuba@kernel.org> <20230816234303.3786178-2-kuba@kernel.org>
In-Reply-To: <20230816234303.3786178-2-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 12:35:59 +0300
Message-ID: <CAC_iWjJ6t5fhGyKXuGH+RrLJuLKyfuvGWXSQ3PpK2X=T4z3T_w@mail.gmail.com>
Subject: Re: [RFC net-next 01/13] net: page_pool: split the page_pool_params
 into fast and slow
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, aleksander.lobakin@intel.com, 
	linyunsheng@huawei.com, almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

On Thu, 17 Aug 2023 at 02:43, Jakub Kicinski <kuba@kernel.org> wrote:
>
> struct page_pool is rather performance critical and we use
> 16B of the first cache line to store 2 pointers used only
> by test code. Future patches will add more informational
> (non-fast path) attributes.
>
> It's convenient for the user of the API to not have to worry
> which fields are fast and which are slow path. Use struct
> groups to split the params into the two categories internally.

LGTM and valuable, since we've been struggling to explain where new
variables should be placed, in order to affect the cache line
placement as little as possible.

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>




>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool/types.h | 31 +++++++++++++++++++------------
>  net/core/page_pool.c          |  7 ++++---
>  2 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 887e7946a597..1c16b95de62f 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -56,18 +56,22 @@ struct pp_alloc_cache {
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
> @@ -121,7 +125,7 @@ struct page_pool_stats {
>  #endif
>
>  struct page_pool {
> -       struct page_pool_params p;
> +       struct page_pool_params_fast p;
>
>         long frag_users;
>         struct page *frag_page;
> @@ -180,6 +184,9 @@ struct page_pool {
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
> index 77cb75e63aca..ffe7782d7fc0 100644
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
> @@ -372,8 +373,8 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>  {
>         page->pp = pool;
>         page->pp_magic |= PP_SIGNATURE;
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


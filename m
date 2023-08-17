Return-Path: <netdev+bounces-28609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65E777FFE1
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19111281F37
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591F1B7DD;
	Thu, 17 Aug 2023 21:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986DA1ADDD
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:06 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC1EE55
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:05 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-44ae69a6b20so74792137.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692307744; x=1692912544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/7KVx6j9tOY/PWtqHRDoRDRy9SbozVCIo14PeHDhfY=;
        b=O0uhai6EOU5yyndF8EyMAwMAnmBkBsInCrVQwOCPK3hoxUX5ehj3dG9ipi1qcvX5ZH
         sXg65Daqx3W1eGgCQMgQsQjQxQLnoqGUHsLYeRhQEyzLFL5x/H8WYQ/7aYzvoytuAUxt
         2gB39vvdIuk4yHHdtU4BOacVO5xV8ULVFZmBbsFUxl7zoYEV+BVSog4RyyAGBFX91axA
         WhF2vlMfTlIoYU3EwUdI27vvM5aO8kRSwGYixlwQeZN8mttM98FEYPCWMF/3VhJip27M
         A02QoCZV+7j35Bi9mwdwGq4NfwA8FniZCmyh5gLs2woT9Z8SXPU5xPq0CBtxYX7GPNu9
         v0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307744; x=1692912544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/7KVx6j9tOY/PWtqHRDoRDRy9SbozVCIo14PeHDhfY=;
        b=Lu/C2wlwqYwOrmSw1IpAzLbnTa67hN0SCJwjs545qKipOOqvvfAkIykgv0qDF7NyN1
         kaemDfNoNivEMUB7O6uXWDh2YgRabEOB/dmgheCZkh9hX5m3PffGjv2FD3oQljqmhxaT
         U27lkaAiaSTBo6E9o005cAZUqMKxSrB0LJX0eojdLoZ491B0N7/cSOq7t9NNSIg/Mo05
         Uuf5JL+1plqSo6jBjTD/sumlYHLJYdhQ3dxFeTN0nsAKggm6VQZDG+gIk2kFpOmH5wZ9
         Q9JtSi2LiB7DypRqhOjjPAZlfhLQipVXhwuRqMU74MyMMBwSBq3fMaFr48OAP7UCEr3I
         Bu+Q==
X-Gm-Message-State: AOJu0YxWLcxQbrOKy57AlnE/XWsZZtVCrjPS5OJaWLzCpLUaCXOPPpAg
	nZcFXH4caifigd/nv/da9a4+b7O72CxMVOYFpK1EVA==
X-Google-Smtp-Source: AGHT+IFpOa4o6dpUful0VmuGJCgYS3gtkCS5WM21TaRPH8vm+ZI8g08j3DXB+UXEMgsNYc/K1M1y9ZrKuefG3zpkSSM=
X-Received: by 2002:a67:bc0e:0:b0:443:3d62:77a with SMTP id
 t14-20020a67bc0e000000b004433d62077amr1291531vsn.1.1692307744165; Thu, 17 Aug
 2023 14:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816234303.3786178-1-kuba@kernel.org> <20230816234303.3786178-2-kuba@kernel.org>
In-Reply-To: <20230816234303.3786178-2-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 17 Aug 2023 14:28:53 -0700
Message-ID: <CAHS8izO_qC+3froE=HyxMmd4LubZuC_h-LJtF=ygD8DCvTXMWQ@mail.gmail.com>
Subject: Re: [RFC net-next 01/13] net: page_pool: split the page_pool_params
 into fast and slow
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	aleksander.lobakin@intel.com, linyunsheng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 4:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
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
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  include/net/page_pool/types.h | 31 +++++++++++++++++++------------
>  net/core/page_pool.c          |  7 ++++---
>  2 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
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
>         unsigned int ring_qsize =3D 1024; /* Default */
>
> -       memcpy(&pool->p, params, sizeof(pool->p));
> +       memcpy(&pool->p, &params->fast, sizeof(pool->p));
> +       memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
>
>         /* Validate only known flags were used */
>         if (pool->p.flags & ~(PP_FLAG_ALL))
> @@ -372,8 +373,8 @@ static void page_pool_set_pp_info(struct page_pool *p=
ool,
>  {
>         page->pp =3D pool;
>         page->pp_magic |=3D PP_SIGNATURE;
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


--=20
Thanks,
Mina


Return-Path: <netdev+bounces-28376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AA77F39C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14635281E68
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81912B64;
	Thu, 17 Aug 2023 09:38:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAD9125B9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:38:51 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC79271F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:38:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so12118978e87.3
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692265128; x=1692869928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5QnDMkzddTDF/tdm3zgyPHjuyLvf5GNxM4/yiGQH9NA=;
        b=M2q+DD22/EeCiRhlgu/a6ch/3ZIPd9INW6HjXPEuSzrQQwEqKIOdZ5nxdeLi6aLu3b
         /Rd/p6WBHlFm2Y6bVYuH94J709RHN5xLzhYCL8hU7QesJ4cLHi12a/rvp0a8qrwfqHW9
         PTLxGrsYSCAgTx4rOXhttfzN6RkJWtYtkiul/Z3OaQm4In4phejWGJdEn4deJudnmhb8
         D0AN1+7BNB8oH5stW+M9/CIrqEx31c8UGfWSAyPtzzJHhw/wwZa7yWCPquAV5JmG/F7r
         /7QbP1MOhOf6A/XwM10go8S+IQHnsrv76IE6lScpkO632gkxMovBnvhWjB6ETxgLo5JA
         wL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692265128; x=1692869928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QnDMkzddTDF/tdm3zgyPHjuyLvf5GNxM4/yiGQH9NA=;
        b=csEcqR8VU4ivktwJ3qWJCJ6RprYZDtUVBEyLIvY7yux3mtICktGDOF4TkeADYkz5pB
         +PauiUleq0R/9XApIH9wCXHyqzH7+X8xNM3tZV63ngXNmDPcgeeIAMihnZmG8SRx0TKN
         aBWPD84A3boyeIV/ZTE/XLLv0fZT4/c7JKgjNMbWPRAw5VdbigKfwrAV73znpm/Y1hhG
         nkd9WOrQQA7kZGinv+Krw3lDnYIBnAZommw/MB+Grjph9nT5w9Ast9WlfKQH18n6tVj4
         klew5J6Pr3DHMgzbZ9zHpY0DENUtKqJUj6F6Xmc60+l/LXwxyjO9a3kYJCQfY7PWPc8t
         VNCw==
X-Gm-Message-State: AOJu0YyiVTowJW900+QpRv6nRoEKpX1WY/tZQ4GaCR909P09Xlm62swr
	lYOCalqkh3uYeyhS7jEUgTyvfUMP9yQzCU15ksginA==
X-Google-Smtp-Source: AGHT+IFbj+hPr6iBI8Xa0HQ/2QSHftKJhAvy/bOP4Rs38Lf4gbJoAhULoC6IkaQd0PP761l9ffqG+qcQQkyydW8H79E=
X-Received: by 2002:a05:6512:1cf:b0:4ff:8983:db4e with SMTP id
 f15-20020a05651201cf00b004ff8983db4emr3508726lfp.26.1692265128567; Thu, 17
 Aug 2023 02:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816234303.3786178-1-kuba@kernel.org> <20230816234303.3786178-3-kuba@kernel.org>
In-Reply-To: <20230816234303.3786178-3-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 12:38:12 +0300
Message-ID: <CAC_iWjLUvqcJoBUTyRYhQE+V2MHrScj6-yBmYMVBQ_Pqo9eRYA@mail.gmail.com>
Subject: Re: [RFC net-next 02/13] net: page_pool: avoid touching slow on the fastpath
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, aleksander.lobakin@intel.com, 
	linyunsheng@huawei.com, almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 17 Aug 2023 at 02:43, Jakub Kicinski <kuba@kernel.org> wrote:
>
> To fully benefit from previous commit add one byte of state
> in the first cache line recording if we need to look at
> the slow part.
>
> The packing isn't all that impressive right now, we create
> a 7B hole. I'm expecting Olek's rework will reshuffle this,
> anyway.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool/types.h | 2 ++
>  net/core/page_pool.c          | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 1c16b95de62f..1ac7ce25fbd4 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -127,6 +127,8 @@ struct page_pool_stats {
>  struct page_pool {
>         struct page_pool_params_fast p;
>
> +       bool has_init_callback;
> +
>         long frag_users;
>         struct page *frag_page;
>         unsigned int frag_offset;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index ffe7782d7fc0..2c14445a353a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -216,6 +216,8 @@ static int page_pool_init(struct page_pool *pool,
>             pool->p.flags & PP_FLAG_PAGE_FRAG)
>                 return -EINVAL;
>
> +       pool->has_init_callback = !!pool->slow.init_callback;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>         if (!pool->recycle_stats)
> @@ -373,7 +375,7 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>  {
>         page->pp = pool;
>         page->pp_magic |= PP_SIGNATURE;
> -       if (pool->slow.init_callback)
> +       if (pool->has_init_callback)
>                 pool->slow.init_callback(page, pool->slow.init_arg);
>  }
>
> --
> 2.41.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


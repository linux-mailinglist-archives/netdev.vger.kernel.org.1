Return-Path: <netdev+bounces-57803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20D8142EB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 08:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE8E1C224C6
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B445E10A0E;
	Fri, 15 Dec 2023 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AokBiNJi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79F19446
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc3facf0c0so3225871fa.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 23:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702626219; x=1703231019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6CU2aBIsn4uLVHIUeTfbp05eiVPkokyoGdlPhM/bWCM=;
        b=AokBiNJiyPvZZYHu7gH7tre8199C/1US8hWkzYuCbcx4fAbYv0VZxOq2M1OjYuNeLi
         H0vSL4zhtRF0zqMLOqHLZer2sCd7ZqL+M+aMjkoWiu5AWXbkbgJpWjUYEKu/4ZEM3L2d
         sKRV4ThQjdp77oBgZp4K7ahkDnMl3kWhZLxOzECO4sVu54+ImnZcgeXSxubscHVnK1bR
         AG0KTxMQCsLRxlkUEd2Ud1USRpotb+KSLvdmq0bxsnzzN9xbXsxkc7zvdwbE4V65K74J
         SVtR6lPnEQaap7T6XPzcBnWyytssM5RBEtSlHuQhS9RCr4DXczqrbXR7IsLZpwIx56Fx
         a7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702626219; x=1703231019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CU2aBIsn4uLVHIUeTfbp05eiVPkokyoGdlPhM/bWCM=;
        b=nOqCutN/x3mxrdsvoi+r78GFpy8HjJrTMszsHb4BMG7Ez93uRz/N92iB88Ye5Z0fE0
         UjUxRRDXu9hkjK3+jWXxIiVNOnnkM88pGf9GxNVkhVOzZ82n/4G2gfkIfwFH5zIW+xMY
         rr78/IC9JhRPf4xJ0oEv7rfiCzAnwkpx7S1fNSa5rMIxl5hKc2DmOfFEYJmIsRk2vN4f
         MN/VM9Rqc5cLIXAuSW25btUO2NXSSr4ULwYCCGU+3bdNHjpmWwbjC1t17NWhmrhjtLBp
         5WR+TdERg/orbTgEuf2J41fZ8OAw6Whml72kM/2rN11vArmRm+6m6nvfhvPp5F78GANr
         vCdg==
X-Gm-Message-State: AOJu0YyX/UGrw/wb6vwUJghywSuotZoX/tJhp1+5vZ3NN8FnXxJMCA/K
	NHnpG1wOTEPHM8k7cdKjjCs+ENy9iyA8S5zmTfL90h1mM4lsC7+YWMo=
X-Google-Smtp-Source: AGHT+IFoL7u9z0Lc9WuuCSh08T4stA/DbiwJaOgeTvrpfjkv4Y6ZwzQiD4LmdYl97Ol9//U110N44Oh2EJg3Pu7/U2U=
X-Received: by 2002:a05:651c:20a:b0:2cc:4bb5:6b12 with SMTP id
 y10-20020a05651c020a00b002cc4bb56b12mr371694ljn.20.1702626219157; Thu, 14 Dec
 2023 23:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Dec 2023 09:43:03 +0200
Message-ID: <CAC_iWjLYu7En7-2sVAxFtNwhvqhrRPqJmbPR_C-YL5wD2Cfe6w@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: Rename frag_users to frag_cnt
To: netdev@vger.kernel.org
Cc: linyunsheng@huawei.com, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Dec 2023 at 09:31, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Since [0] got merged, it's clear that 'pp_ref_count' is used to track
> the number of users for each page. On struct_page though we have
> a member called 'frag_users'. Despite of what the name suggests this is
> not the number of users. It instead represents the number of fragments of
> the current page. When we have a single page this is set to one.

Replying to myself here, but this is a typo. On single pages, we set
pp_ref_count to one, not this.

>  When we
> split the page this is set to the actual number of frags and later used
> in page_pool_drain_frag() to infer the real number of users.
>
> So let's rename it to something that matches the description above
>
> [0]
> Link: https://lore.kernel.org/netdev/20231212044614.42733-2-liangchen.linux@gmail.com/
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  include/net/page_pool.h | 2 +-
>  net/core/page_pool.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 813c93499f20..957cd84bb3f4 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -158,7 +158,7 @@ struct page_pool {
>         u32 pages_state_hold_cnt;
>         unsigned int frag_offset;
>         struct page *frag_page;
> -       long frag_users;
> +       long frag_cnt;
>
>  #ifdef CONFIG_PAGE_POOL_STATS
>         /* these stats are incremented while in softirq context */
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 9b203d8660e4..19a56a52ac8f 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -659,7 +659,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
>  static struct page *page_pool_drain_frag(struct page_pool *pool,
>                                          struct page *page)
>  {
> -       long drain_count = BIAS_MAX - pool->frag_users;
> +       long drain_count = BIAS_MAX - pool->frag_cnt;
>
>         /* Some user is still using the page frag */
>         if (likely(page_pool_defrag_page(page, drain_count)))
> @@ -678,7 +678,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
>
>  static void page_pool_free_frag(struct page_pool *pool)
>  {
> -       long drain_count = BIAS_MAX - pool->frag_users;
> +       long drain_count = BIAS_MAX - pool->frag_cnt;
>         struct page *page = pool->frag_page;
>
>         pool->frag_page = NULL;
> @@ -721,14 +721,14 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
>                 pool->frag_page = page;
>
>  frag_reset:
> -               pool->frag_users = 1;
> +               pool->frag_cnt = 1;
>                 *offset = 0;
>                 pool->frag_offset = size;
>                 page_pool_fragment_page(page, BIAS_MAX);
>                 return page;
>         }
>
> -       pool->frag_users++;
> +       pool->frag_cnt++;
>         pool->frag_offset = *offset + size;
>         alloc_stat_inc(pool, fast);
>         return page;
> --
> 2.37.2
>


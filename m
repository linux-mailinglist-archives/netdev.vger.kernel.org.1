Return-Path: <netdev+bounces-29268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD17825AC
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A4A280F43
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6506C3D6D;
	Mon, 21 Aug 2023 08:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C7185B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 08:39:24 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78ADF2
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:39:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so4752481e87.1
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692607149; x=1693211949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCAks9RwozvRJpX+QX0ILjL7a4y4gtGfSt+E1DcOdRA=;
        b=TswRyY7az3TMHUPsPfN3K8mRhp5AupbNizwslgQ9BjmYhg3U1fXkPSyPGboy1hRx5L
         aVI2RuPLg/VNtz8DUMGPFbxAfsR6AyznkuGteIo7Ke7jFXIL9T89B+QSjwBKojSl+LiN
         zcropkbeVIwis3XNbSmBrpGyTILzzZ3CRMJhkYYRQpSRhPo9NtX11NWLXv0Rtyht6VWQ
         dpKYSPtHPK7cuIUhYIpv1w47xhZAXCsA/3VwnrHsCYRPldnpij6MgAbIPmJVwAYV2RUt
         5wJRRSFyJt/bC4piANNswOkBGhcn3CC577NP9Q/U8rdcMGKoXgYqA7yyosLscZOD2Mgi
         ju7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692607149; x=1693211949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCAks9RwozvRJpX+QX0ILjL7a4y4gtGfSt+E1DcOdRA=;
        b=Dvb/gm4SvNPYEQmz9S0lW7hcz8C4Lc2swkmjecf4W/lMgXy3KN+PJxVkXZ/K76xt/r
         e2CSGyA13Vziu3jt66xi3xwBXcW9+RnoKXU12W3DkglXxx0Xz7sv64D6mQ/6ba3iLiGn
         1hL6inqMbSyFEYMnLYm6I2xFSWnUKWlkoinQXtCfxpUAIvd5oC2Ip35+76mGG9wMTs+W
         M8QydgWKXjEeARX0j0aAUXqz0+8JFi9dltZgnD3fNhUblnnN+mbXvEMxhNsFEdkWLE0L
         wtUZNqx5znEfDW9u/VJkK99+ztccI0+LaOIvkJBYYxe5IyFngVB5t30BZsn9GbhcrXjU
         /OQQ==
X-Gm-Message-State: AOJu0Yzt+1s3ph623YlmbZb8KzjsEkOMjwPg4uDfEUPR7Zil13Bu8SfV
	LBQh1933sU8cR6h5vqdy3vUuPNikhs3GYF8OW3NSDA==
X-Google-Smtp-Source: AGHT+IFT8Gpe8aC0gV08a4N0ZFmjyC8jiHHEkt6AWLAhMSdtMGkNUN0OaSNUAsvEZpIKsY+hAiy8NVA6Mw6qleHN1LM=
X-Received: by 2002:ac2:4ad1:0:b0:500:7f51:d129 with SMTP id
 m17-20020ac24ad1000000b005007f51d129mr1570409lfp.34.1692607148905; Mon, 21
 Aug 2023 01:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org> <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org> <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org>
In-Reply-To: <20230818145145.4b357c89@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Aug 2023 11:38:32 +0300
Message-ID: <CAC_iWjKp_NKofQQTSgA810+bOt84Hgbm3YV=X=JWH9t=DHuzqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, 
	Liang Chen <liangchen.linux@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

resending for the mailing list apologies for the noise.


On Sat, 19 Aug 2023 at 00:51, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 18 Aug 2023 09:12:09 +0300 Ilias Apalodimas wrote:
> > > Right, IIUC we don't have enough space to fit dma_addr_t and the
> > > refcount, but if we store the dma addr on a shifted u32 instead
> > > of using dma_addr_t explicitly - the refcount should fit?
> >
> > struct page looks like this:
> >
> > unsigned long dma_addr;
> > union {
> >       unsigned long dma_addr_upper;
> >       atomic_long_t pp_frag_count;
> > };
>
> I could be completely misunderstanding the problem.

You aren't!

> Let me show you the diff of what I was thinking more or less.
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5e74ce4a28cd..58ffa8dc745f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -126,11 +126,6 @@ struct page {
>                         unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
>                         union {
> -                               /**
> -                                * dma_addr_upper: might require a 64-bit
> -                                * value on 32-bit architectures.
> -                                */
> -                               unsigned long dma_addr_upper;
>                                 /**
>                                  * For frag page support, not supported in
>                                  * 32-bit architectures with 64-bit DMA.
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 94231533a369..6f87a0fa2178 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -212,16 +212,24 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>         dma_addr_t ret = page->dma_addr;
>
>         if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -               ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> +               ret <<= PAGE_SHIFT;
>
>         return ret;
>  }
>
> -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>  {
> +       bool failed = false;
> +
>         page->dma_addr = addr;
> -       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -               page->dma_addr_upper = upper_32_bits(addr);
> +       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> +               page->dma_addr >>= PAGE_SHIFT;
> +               /* We assume page alignment to shave off bottom bits,
> +                * if this "compression" doesn't work we need to drop.
> +                */
> +               failed = addr != page->dma_addr << PAGE_SHIFT;
> +       }
> +       return failed;
>  }
>
>  static inline bool page_pool_put(struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..9ea42e242a89 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
>                  */
>         }
>
> -       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> -           pool->p.flags & PP_FLAG_PAGE_FRAG)
> -               return -EINVAL;
> -
>  #ifdef CONFIG_PAGE_POOL_STATS
>         pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>         if (!pool->recycle_stats)
> @@ -359,12 +355,19 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>         if (dma_mapping_error(pool->p.dev, dma))
>                 return false;
>
> -       page_pool_set_dma_addr(page, dma);
> +       if (page_pool_set_dma_addr(page, dma))
> +               goto unmap_failed;
>
>         if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>                 page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>
>         return true;
> +
> +unmap_failed:
> +       dma_unmap_page_attrs(pool->p.dev, dma,
> +                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> +       return false;
>  }

That seems reasonable and would work for pages > 4k as well. But is
16TB enough?  I am more familiar with embedded than large servers,
which do tend to scale that high.

Regards
/Ilias
>
>  static void page_pool_set_pp_info(struct page_pool *pool,


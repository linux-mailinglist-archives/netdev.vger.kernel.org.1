Return-Path: <netdev+bounces-34016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E537A18D4
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C731C20C25
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4ED515;
	Fri, 15 Sep 2023 08:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE693D304
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:29:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF2602D66
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694766526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcGHkHEkl2F+HrrCmBnGlpMxClskGfx3G9ZgUgAvCEo=;
	b=gMsh9PsPTyJNpLOrgiEIB1qo+ORoNB/fRLqizbIudCxGzPgkEBqH0Y7Xs1CU2vxxm5OWxz
	O+LhvtpctjPFn5yzJ7Hxh6EIoaMdIkBkbsyqX+qoxDzDLrkADdPfjp3ggKDkDP3uQeLIlO
	UUGnUJ62nyW2NF0YbA8ADYT1Bt9LshM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-EVtrkpTSNyK_utnp8RYIqw-1; Fri, 15 Sep 2023 04:28:44 -0400
X-MC-Unique: EVtrkpTSNyK_utnp8RYIqw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bceb2b3024so23314431fa.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 01:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694766523; x=1695371323;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcGHkHEkl2F+HrrCmBnGlpMxClskGfx3G9ZgUgAvCEo=;
        b=f1/mc1x5RVaDaMVi0Un+8tTJVoAIuKBRxl6X5aG/NaN/LuasmmpkU3+EjsRalUrjeB
         WbkQgET8Hdzh9abSfHWhD18NG6WEycmuRdCPWTu4EcGKyVw/1520+mhdG/AwiR87xfee
         vbnEeN23mv6NyWTmvQKUIS8KsvEyvIOTgCbi/VRPaOLX2y7fTBxKmh1Kv0Sk3TVZlYpA
         vgVu0SekwtQHnTo4EOgCaFjnMxClRwK1M4C2QJEj9hXlBbSYa/i/vehMhuSJAjMacIic
         BKKW2TMa+S0lER4lK/Dofb4HdooxmJgkdhEu/vmdvu62Gr0mRuxuNrEMlld5OO7aBQU3
         4hUQ==
X-Gm-Message-State: AOJu0Yw9HDdCv78EdF2F5Ow/LBmzxl+Ie6B46yf2D6qRxVeClHcIgzJj
	Ywv5xK43onmSQKPprTbkXo9qJFgJGknu34ksQmuEGhxeM5vpj5u3UyIXncgReiWiBmcQtkVmq/S
	EykN1G1+azQPMMHQl
X-Received: by 2002:ac2:5e68:0:b0:502:a56b:65f7 with SMTP id a8-20020ac25e68000000b00502a56b65f7mr809373lfr.16.1694766522966;
        Fri, 15 Sep 2023 01:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXe9WijGF+xd6sNUS8Btxyd7ZjXZH/hd49roTE/EzbjLuB9jzTKiTfy80O32sXsGz2tMVrcw==
X-Received: by 2002:ac2:5e68:0:b0:502:a56b:65f7 with SMTP id a8-20020ac25e68000000b00502a56b65f7mr809354lfr.16.1694766522621;
        Fri, 15 Sep 2023 01:28:42 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id c27-20020ac244bb000000b004f86d3e52c0sm557925lfm.4.2023.09.15.01.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 01:28:41 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <84282e55-519c-0e17-30c5-b6de54d1001c@redhat.com>
Date: Fri, 15 Sep 2023 10:28:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Liang Chen <liangchen.linux@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Linux-MM <linux-mm@kvack.org>,
 Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH net-next v8 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
References: <20230912083126.65484-1-linyunsheng@huawei.com>
 <20230912083126.65484-2-linyunsheng@huawei.com>
Content-Language: en-US
In-Reply-To: <20230912083126.65484-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Lin,

This looks reasonable, but given you are changing struct-page
(include/linux/mm_types.h) we need to MM-list <linux-mm@kvack.org>.
Also Cc Wilcox.

I think it was Ilias and Duyck that validated the assumptions, last time
this patch was discussed. Thus I want to see their review before this is
applied.

-Jesper

On 12/09/2023 10.31, Yunsheng Lin wrote:
> Currently page_pool_alloc_frag() is not supported in 32-bit
> arch with 64-bit DMA because of the overlap issue between
> pp_frag_count and dma_addr_upper in 'struct page' for those
> arches, which seems to be quite common, see [1], which means
> driver may need to handle it when using frag API.
> 
> It is assumed that the combination of the above arch with an
> address space >16TB does not exist, as all those arches have
> 64b equivalent, it seems logical to use the 64b version for a
> system with a large address space. It is also assumed that dma
> address is page aligned when we are dma mapping a page aliged
> buffer, see [2].
> 
> That means we're storing 12 bits of 0 at the lower end for a
> dma address, we can reuse those bits for the above arches to
> support 32b+12b, which is 16TB of memory.
> 
> If we make a wrong assumption, a warning is emitted so that
> user can report to us.
> 
> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/
> 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>   include/linux/mm_types.h        | 13 +------------
>   include/net/page_pool/helpers.h | 20 ++++++++++++++------
>   net/core/page_pool.c            | 14 +++++++++-----
>   3 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 36c5b43999e6..74b49c4c7a52 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -125,18 +125,7 @@ struct page {
>   			struct page_pool *pp;
>   			unsigned long _pp_mapping_pad;
>   			unsigned long dma_addr;
> -			union {
> -				/**
> -				 * dma_addr_upper: might require a 64-bit
> -				 * value on 32-bit architectures.
> -				 */
> -				unsigned long dma_addr_upper;
> -				/**
> -				 * For frag page support, not supported in
> -				 * 32-bit architectures with 64-bit DMA.
> -				 */
> -				atomic_long_t pp_frag_count;
> -			};
> +			atomic_long_t pp_frag_count;
>   		};
>   		struct {	/* Tail pages of compound page */
>   			unsigned long compound_head;	/* Bit zero is set */
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 94231533a369..8e1c85de4995 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -197,7 +197,7 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>   	page_pool_put_full_page(pool, page, true);
>   }
>   
> -#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
> +#define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
>   		(sizeof(dma_addr_t) > sizeof(unsigned long))
>   
>   /**
> @@ -211,17 +211,25 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>   {
>   	dma_addr_t ret = page->dma_addr;
>   
> -	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -		ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> +	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
> +		ret <<= PAGE_SHIFT;
>   
>   	return ret;
>   }
>   
> -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>   {
> +	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> +		page->dma_addr = addr >> PAGE_SHIFT;
> +
> +		/* We assume page alignment to shave off bottom bits,
> +		 * if this "compression" doesn't work we need to drop.
> +		 */
> +		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
> +	}
> +
>   	page->dma_addr = addr;
> -	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -		page->dma_addr_upper = upper_32_bits(addr);
> +	return false;
>   }
>   
>   static inline bool page_pool_put(struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..8a9868ea5067 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
>   		 */
>   	}
>   
> -	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> -	    pool->p.flags & PP_FLAG_PAGE_FRAG)
> -		return -EINVAL;
> -
>   #ifdef CONFIG_PAGE_POOL_STATS
>   	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>   	if (!pool->recycle_stats)
> @@ -359,12 +355,20 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>   	if (dma_mapping_error(pool->p.dev, dma))
>   		return false;
>   
> -	page_pool_set_dma_addr(page, dma);
> +	if (page_pool_set_dma_addr(page, dma))
> +		goto unmap_failed;
>   
>   	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>   		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>   
>   	return true;
> +
> +unmap_failed:
> +	WARN_ON_ONCE("unexpected DMA address, please report to netdev@");
> +	dma_unmap_page_attrs(pool->p.dev, dma,
> +			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> +	return false;
>   }
>   
>   static void page_pool_set_pp_info(struct page_pool *pool,



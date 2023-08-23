Return-Path: <netdev+bounces-29985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBF7856D9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D392812F7
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E4DBA51;
	Wed, 23 Aug 2023 11:36:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B88BA34
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:36:56 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3222FE69
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:36:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so7121524e87.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692790602; x=1693395402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bO5yoG8NWJVUJXrrv+VTCswhooMZ4oFHxOIUIKgCKUg=;
        b=GOAyOQt9lyITaTfUVg7AM0qeC/DedKZ9GOiBTUKLsfCa8NKi9vS9OqmsX68VibR1My
         zZAibhl/45Z3qTv6JCpPzde5v10ZWsN/s0GUvpm91Q+lM5qRzo0oHKwukp3Z/8VriYgW
         3HGPJiu9ZgGB0InZLPWcjVtvh0BiUOcPkVHftXWdZoBcInfmgTbagwec3ekGZhAeDX2Y
         +qCgkfV3wjuydqPI0O+ls+joZVvtrHFx7HnAINLQ2yeMkggxHurIElRKfVUyU2tyIyNk
         56lQndNzis4E5Nhjq5PWBcEeV0DWSdlCAIqhmKfcB7lH5wy4qHPZt6l02KzAJCS1s/T5
         gO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790602; x=1693395402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO5yoG8NWJVUJXrrv+VTCswhooMZ4oFHxOIUIKgCKUg=;
        b=mAnhWdkoinVDjIAr0f/3I5xOsmLDMsrdz1hnssCdd42RBM88Ef+Xtt85o/AeX9n3u9
         1oPMBfpEruk2Pa6XyQdaUHP2z9hiPWj+VIuf8wTLXbHisCtF2wNXfPxSeYxmt1KlzeMg
         JcuRf3jZRPj4j30Jc46HSj5RTBr2XLkWpWUQJCKqNYJU3WjLzB/zbhI5tjaPYH0AAR9D
         C8P9LlnD/X9cds6mAfCvKnKrYnlQwLHv8e2cLRh9egqBeindW/BCKUQHoZAswc5/4JdK
         lDSvD7xuODxPTCy8ZkrOfiCgRMNFNRfGFFUjAhNBvYfmytANqOX1ykO/0TKZbMZaLUBp
         uqLA==
X-Gm-Message-State: AOJu0Yz33kbb57HDHjyXkBrUuN/tYVdoJJvX6W5jOzbJ5o/2V87TQ67F
	SDwSvVkIRrR92YID7lAlhGtghrOoqCcXtt1SVL2gPQ==
X-Google-Smtp-Source: AGHT+IGyM9h4r2ILmvOlw+auuoX+bz+gdAPvwR27b7LNUuA8jVwUu4+lbNnRIK8W9nzZfoflSXePhHDEa463/JEH0oI=
X-Received: by 2002:ac2:5605:0:b0:500:9214:b308 with SMTP id
 v5-20020ac25605000000b005009214b308mr2162555lfd.65.1692790602350; Wed, 23 Aug
 2023 04:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823094757.gxvCEOBi@linutronix.de>
In-Reply-To: <20230823094757.gxvCEOBi@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 23 Aug 2023 14:36:06 +0300
Message-ID: <CAC_iWjJmoqsC6w=9cjr5v9o+43=2t4LKeZCrEP83PBb7nRS6zw@mail.gmail.com>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Geetha sowjanya <gakula@marvell.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hariprasad <hkelam@marvell.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sebastian,

Thanks for the report.


On Wed, 23 Aug 2023 at 12:48, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Hi,
>
> I've been looking at the page_pool locking.

Apologies for any traumas we caused with that code :)


>
> page_pool_alloc_frag() -> page_pool_alloc_pages() ->
> __page_pool_get_cached():
>
> There core of the allocation is:
> |         /* Caller MUST guarantee safe non-concurrent access, e.g. softirq */
> |         if (likely(pool->alloc.count)) {
> |                 /* Fast-path */
> |                 page = pool->alloc.cache[--pool->alloc.count];
>
> The access to the `cache' array and the `count' variable is not locked.
> This is fine as long as there only one consumer per pool. In my
> understanding the intention is to have one page_pool per NAPI callback
> to ensure this.
>
> The pool can be filled in the same context (within allocation if the
> pool is empty). There is also page_pool_recycle_in_cache() which fills
> the pool from within skb free, for instance:
>  napi_consume_skb() -> skb_release_all() -> skb_release_data() ->
>  napi_frag_unref() -> page_pool_return_skb_page().
>
> The last one has the following check here:
> |         napi = READ_ONCE(pp->p.napi);
> |         allow_direct = napi_safe && napi &&
> |                 READ_ONCE(napi->list_owner) == smp_processor_id();
>
> This eventually ends in page_pool_recycle_in_cache() where it adds the
> page to the cache buffer if the check above is true (and BH is disabled).
>
> napi->list_owner is set once NAPI is scheduled until the poll callback
> completed. It is safe to add items to list because only one of the two
> can run on a single CPU and the completion of them ensured by having BH
> disabled the whole time.
>
> This breaks in octeontx2 where a worker is used to fill the buffer:
>   otx2_pool_refill_task() -> otx2_alloc_rbuf() -> __otx2_alloc_rbuf() ->
>   otx2_alloc_pool_buf() -> page_pool_alloc_frag().
>
> BH is disabled but the add of a page can still happen while NAPI
> callback runs on a remote CPU and so corrupting the index/ array.
>
> API wise I would suggest to
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7ff80b80a6f9f..b50e219470a36 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -612,7 +612,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>                         page_pool_dma_sync_for_device(pool, page,
>                                                       dma_sync_size);
>
> -               if (allow_direct && in_softirq() &&
> +               if (allow_direct && in_serving_softirq() &&
>                     page_pool_recycle_in_cache(page, pool))
>                         return NULL;
>

FWIW we used to have that check.
commit 542bcea4be866b ("net: page_pool: use in_softirq() instead")
changed that, so maybe we should revert that overall?

> because the intention (as I understand it) is to be invoked from within
> the NAPI callback (while softirq is served) and not if BH is just
> disabled due to a lock or so.
>
> It would also make sense to a add WARN_ON_ONCE(!in_serving_softirq()) to
> page_pool_alloc_pages() to spot usage outside of softirq. But this will
> trigger in every driver since the same function is used in the open
> callback to initially setup the HW.

What about adding a check in the cached allocation path in order to
skip the initial page allocation?

Thanks
/Ilias
>
> Sebastian


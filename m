Return-Path: <netdev+bounces-21191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD7C762C0F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366741C20C92
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370A846C;
	Wed, 26 Jul 2023 06:56:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28570846B
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:56:49 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2B026B6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:56:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so10064074e87.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690354605; x=1690959405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8dNXCLuuED/A16qvM4h7Um33uxblgFXGdDRt9okSqQ4=;
        b=i2j4s0/16fhQRBMGBacAh7lsBmDbPPq5jH5kIrHdtdCvdSZVrCTVekoi91uW3JNOkv
         ZRb0Rnf1k1aBmLYXnLzDqZEHbTYdlq1+5tkKNL7oUqj0tA9iVUuASTfccZ9Iql3kj6RR
         SDhvRiTtBwRl2cNpx6fXL7XP8+4lMQFnVfQzLBXPX6avx5UxdSzoUgiZqT0gIt8jyh1D
         1LeJd/J5L45Nu9Jd6ELGvkzm8GQ5Rf8oXdNSA5sXptWjGBzRDIDBiHascTDaI0V1Oh3r
         3ODrVqQ+J07J2bvqXmR1nosaXowVAr4nlrW6GVhjbILfoi4V0xGtQrkODFh3xz7GvL5V
         nL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354605; x=1690959405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dNXCLuuED/A16qvM4h7Um33uxblgFXGdDRt9okSqQ4=;
        b=k6g6rZsqbNu1tshcX5ptjJkSE98JjkEhowcShouQAxTyGjuoKmFdSnatqGNVsG2/Wy
         3a3KadJSypytOe92EVD+A5EwRLRd6jeg1i7uMrImoSUkLXD9o34Pi872inUWEGFSZnCM
         31xJRAmyvrh87pOPneTRzolpvpCWOeVXrjRljQ8O9zAt665BrCI+Tz4H9ynCDZ6W0kKw
         3WrqnZxAQO6Aend2HmAZcCn21O1zraxEp3fzi4hUcL1OOpmybUa+SmYquImag+CCX4Ye
         w3uAB125Tq8XYkqpT+0NHoS3+YWvMNQP1Ahg+X0P8bVOrcUz5VrBiEAyYfUpQ7Iq59yo
         p+kA==
X-Gm-Message-State: ABy/qLaob9OONtgNZB49FkFqpRzVN/FM5mlBFoIkjpZzvbJYeSRmCQ8W
	2xnui1IACRZccITSaXQ4XSIGNZ/uipSOWGdMX/hSLA==
X-Google-Smtp-Source: APBJJlH7d0ByQkHhPZAiILcb3LWseT5Eusr91gQbVauREViMSto6FyDEjBZ77tkCGfZeMjf3+xbzktkDaWn+EKz5gX4=
X-Received: by 2002:a19:5003:0:b0:4fd:fabf:b923 with SMTP id
 e3-20020a195003000000b004fdfabfb923mr764284lfb.14.1690354605309; Tue, 25 Jul
 2023 23:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707183935.997267-1-kuba@kernel.org> <20230707183935.997267-9-kuba@kernel.org>
 <f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com>
In-Reply-To: <f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Jul 2023 09:56:09 +0300
Message-ID: <CAC_iWjJdRqdOvxLB2gwkNHWLGL4e4dkcJ5A1=K2SeJ-9cjS8SQ@mail.gmail.com>
Subject: Re: [RFC 08/12] eth: bnxt: let the page pool manage the DMA mapping
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, brouer@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, edumazet@google.com, 
	dsahern@gmail.com, michael.chan@broadcom.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[...]

> > -     *mapping = dma_map_page_attrs(dev, page, 0, PAGE_SIZE, bp->rx_dir,
> > -                                   DMA_ATTR_WEAK_ORDERING);
> > -     if (dma_mapping_error(dev, *mapping)) {
> > -             page_pool_recycle_direct(rxr->page_pool, page);
> > -             return NULL;
> > -     }
> > +     *mapping = page_pool_get_dma_addr(page);
> > +     dma_sync_single_for_device(dev, *mapping, PAGE_SIZE, DMA_BIDIRECTIONAL);
> > +
>
> You can keep this as-is, but I just wanted mention that page_pool
> supports doing the "dma_sync_for_device" via PP_FLAG_DMA_SYNC_DEV.
> Thus, removing more lines from driver code.

+1 to that.  Also, the direction is stored in pp->dma_dir, so it
should automatically do the right thing.

Regards
/Ilias

>
> >       return page;
> >   }
> >
> > @@ -951,6 +948,7 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
> >                                             unsigned int offset_and_len)
> >   {
> >       unsigned int len = offset_and_len & 0xffff;
> > +     struct device *dev = &bp->pdev->dev;
> >       struct page *page = data;
> >       u16 prod = rxr->rx_prod;
> >       struct sk_buff *skb;
> > @@ -962,8 +960,7 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
> >               return NULL;
> >       }
> >       dma_addr -= bp->rx_dma_offset;
> > -     dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
> > -                          DMA_ATTR_WEAK_ORDERING);
> > +     dma_sync_single_for_cpu(dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> >       skb = build_skb(page_address(page), PAGE_SIZE);
> >       if (!skb) {
> >               page_pool_recycle_direct(rxr->page_pool, page);
> > @@ -984,6 +981,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
> >   {
> >       unsigned int payload = offset_and_len >> 16;
> >       unsigned int len = offset_and_len & 0xffff;
> > +     struct device *dev = &bp->pdev->dev;
> >       skb_frag_t *frag;
> >       struct page *page = data;
> >       u16 prod = rxr->rx_prod;
> > @@ -996,8 +994,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
> >               return NULL;
> >       }
> >       dma_addr -= bp->rx_dma_offset;
> > -     dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
> > -                          DMA_ATTR_WEAK_ORDERING);
> > +     dma_sync_single_for_cpu(dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> >
> >       if (unlikely(!payload))
> >               payload = eth_get_headlen(bp->dev, data_ptr, len);
> > @@ -2943,9 +2940,6 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
> >               rx_buf->data = NULL;
> >               if (BNXT_RX_PAGE_MODE(bp)) {
> >                       mapping -= bp->rx_dma_offset;
> > -                     dma_unmap_page_attrs(&pdev->dev, mapping, PAGE_SIZE,
> > -                                          bp->rx_dir,
> > -                                          DMA_ATTR_WEAK_ORDERING);
> >                       page_pool_recycle_direct(rxr->page_pool, data);
> >               } else {
> >                       dma_unmap_single_attrs(&pdev->dev, mapping,
> > @@ -2967,9 +2961,6 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
> >                       continue;
> >
> >               if (BNXT_RX_PAGE_MODE(bp)) {
> > -                     dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
> > -                                          BNXT_RX_PAGE_SIZE, bp->rx_dir,
> > -                                          DMA_ATTR_WEAK_ORDERING);
> >                       rx_agg_buf->page = NULL;
> >                       __clear_bit(i, rxr->rx_agg_bmap);
> >
> > @@ -3208,6 +3199,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
> >   {
> >       struct page_pool_params pp = { 0 };
> >
> > +     pp.flags = PP_FLAG_DMA_MAP;
> >       pp.pool_size = bp->rx_ring_size;
> >       pp.nid = dev_to_node(&bp->pdev->dev);
> >       pp.napi = &rxr->bnapi->napi;
>


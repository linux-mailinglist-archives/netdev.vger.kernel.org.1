Return-Path: <netdev+bounces-16428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB174D310
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 12:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31B71C2042F
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684D101FE;
	Mon, 10 Jul 2023 10:13:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A882101F3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 10:13:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA487FA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688983954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XimhFg6rcc2I5TvsesuZSKC9L6Ln1GggFWxQ20V0eNk=;
	b=LF2aXRoTI+M/kuPPlo+L8MmrCIVp0KpcPVzzEgCkF7NWOpdNoIUUUiLW9zaSHKkk8mnyzZ
	zlaMCdHGRxKjonH9npB/QDW8WdPAR3xdaAYNM4TfStQ5K4h3i8qqjzRVHKpgln3w9PR84C
	//X2GJ63pWwIEV+/s0pMb5I1sSbjvys=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-FeryloQNO5SsKwydzqZsdQ-1; Mon, 10 Jul 2023 06:12:33 -0400
X-MC-Unique: FeryloQNO5SsKwydzqZsdQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-97542592eb9so251648966b.2
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 03:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688983952; x=1691575952;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XimhFg6rcc2I5TvsesuZSKC9L6Ln1GggFWxQ20V0eNk=;
        b=WvTrR3RTsKBA9YWyRN28vOo6xKHpfXlnVSmFyv3k33u6iBttChzTTaQYYrlAGAtbQB
         eT4rAZMAYPWz/L52veCL+OI7/Rt1AipjzjVG7gO2vFANYmVgdx6LebBzfaaXekTVBm8N
         R9DCYKFfKC6Nc5EV2GKn5HLaXGGQ1uCUfpmKrQtzk+N0eCaps59GBSiNvBk6glUTSu8z
         LNOt3V5Y6MtuDfjsz8S2FsomxAbcuGl/yjuiz0W/+n2NxbrbSlij/98Pd/pKsLdJXPX7
         ssi1QXmjKWqYxKaeHGB83tbg6k/mBZoMShSAUnIDZ4zGjma5YnMhOaZqBt3ShZ5x5o3F
         9VqA==
X-Gm-Message-State: ABy/qLYtzRQPXMJCy8ZyPspWesLOQ6Cg/Lt8Wbpi/cM3Tz9SdOYKGfBK
	3+IdEGcrIyPgkpci0RO0OXnGdH4FRfJyCaHS4KiiJ87euSk6+01kBcOtKFK6JZj1m4COdigeCYc
	AQc+yhXRLs1WDui1U
X-Received: by 2002:a17:906:4bd2:b0:993:336d:bc0c with SMTP id x18-20020a1709064bd200b00993336dbc0cmr12556758ejv.34.1688983952390;
        Mon, 10 Jul 2023 03:12:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHT7apu5lZK9knYitLNERBYCAspxrU+zPoOpW930Un18nML9eeC+loNe9Fpqk1CbTP3VJKlWA==
X-Received: by 2002:a17:906:4bd2:b0:993:336d:bc0c with SMTP id x18-20020a1709064bd200b00993336dbc0cmr12556736ejv.34.1688983952073;
        Mon, 10 Jul 2023 03:12:32 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id rn6-20020a170906d92600b00993470682e5sm5891261ejb.32.2023.07.10.03.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:12:31 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com>
Date: Mon, 10 Jul 2023 12:12:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, edumazet@google.com, dsahern@gmail.com,
 michael.chan@broadcom.com, willemb@google.com
Subject: Re: [RFC 08/12] eth: bnxt: let the page pool manage the DMA mapping
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20230707183935.997267-1-kuba@kernel.org>
 <20230707183935.997267-9-kuba@kernel.org>
In-Reply-To: <20230707183935.997267-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 07/07/2023 20.39, Jakub Kicinski wrote:
> Use the page pool's ability to maintain DMA mappings for us.
> This avoid re-mapping recycled pages.
> 

For DMA using IOMMU mappings, using page_pool like this patch solves the
main bottleneck.  Thus, I suspect this patch will give the biggest
performance boost on it's own.

As you have already discovered, the next bottleneck then becomes the
IOMMU's address resolution, which the IOTLB (I/O Translation Lookaside
Buffer) hardware helps speed up.

There are a number of techniques for reducing IOTLB misses.
I recommend reading:
  IOMMU: Strategies for Mitigating the IOTLB Bottleneck
  - https://inria.hal.science/inria-00493752/document


> Note that pages in the pool are always mapped DMA_BIDIRECTIONAL,
> so we should use that instead of looking at bp->rx_dir.
> 
> The syncing is probably wrong, TBH, I haven't studied the page
> pool rules, they always confused me. But for a hack, who cares,
> x86 :D
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 ++++++++---------------
>   1 file changed, 8 insertions(+), 16 deletions(-)

Love seeing these stats, where page_pool reduce lines in drivers.

> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index e5b54e6025be..6512514cd498 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -706,12 +706,9 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
>   	if (!page)
>   		return NULL;
>   
> -	*mapping = dma_map_page_attrs(dev, page, 0, PAGE_SIZE, bp->rx_dir,
> -				      DMA_ATTR_WEAK_ORDERING);
> -	if (dma_mapping_error(dev, *mapping)) {
> -		page_pool_recycle_direct(rxr->page_pool, page);
> -		return NULL;
> -	}
> +	*mapping = page_pool_get_dma_addr(page);
> +	dma_sync_single_for_device(dev, *mapping, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +

You can keep this as-is, but I just wanted mention that page_pool
supports doing the "dma_sync_for_device" via PP_FLAG_DMA_SYNC_DEV.
Thus, removing more lines from driver code.

>   	return page;
>   }
>   
> @@ -951,6 +948,7 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
>   					      unsigned int offset_and_len)
>   {
>   	unsigned int len = offset_and_len & 0xffff;
> +	struct device *dev = &bp->pdev->dev;
>   	struct page *page = data;
>   	u16 prod = rxr->rx_prod;
>   	struct sk_buff *skb;
> @@ -962,8 +960,7 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
>   		return NULL;
>   	}
>   	dma_addr -= bp->rx_dma_offset;
> -	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
> -			     DMA_ATTR_WEAK_ORDERING);
> +	dma_sync_single_for_cpu(dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
>   	skb = build_skb(page_address(page), PAGE_SIZE);
>   	if (!skb) {
>   		page_pool_recycle_direct(rxr->page_pool, page);
> @@ -984,6 +981,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
>   {
>   	unsigned int payload = offset_and_len >> 16;
>   	unsigned int len = offset_and_len & 0xffff;
> +	struct device *dev = &bp->pdev->dev;
>   	skb_frag_t *frag;
>   	struct page *page = data;
>   	u16 prod = rxr->rx_prod;
> @@ -996,8 +994,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
>   		return NULL;
>   	}
>   	dma_addr -= bp->rx_dma_offset;
> -	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
> -			     DMA_ATTR_WEAK_ORDERING);
> +	dma_sync_single_for_cpu(dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
>   
>   	if (unlikely(!payload))
>   		payload = eth_get_headlen(bp->dev, data_ptr, len);
> @@ -2943,9 +2940,6 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
>   		rx_buf->data = NULL;
>   		if (BNXT_RX_PAGE_MODE(bp)) {
>   			mapping -= bp->rx_dma_offset;
> -			dma_unmap_page_attrs(&pdev->dev, mapping, PAGE_SIZE,
> -					     bp->rx_dir,
> -					     DMA_ATTR_WEAK_ORDERING);
>   			page_pool_recycle_direct(rxr->page_pool, data);
>   		} else {
>   			dma_unmap_single_attrs(&pdev->dev, mapping,
> @@ -2967,9 +2961,6 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
>   			continue;
>   
>   		if (BNXT_RX_PAGE_MODE(bp)) {
> -			dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
> -					     BNXT_RX_PAGE_SIZE, bp->rx_dir,
> -					     DMA_ATTR_WEAK_ORDERING);
>   			rx_agg_buf->page = NULL;
>   			__clear_bit(i, rxr->rx_agg_bmap);
>   
> @@ -3208,6 +3199,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>   {
>   	struct page_pool_params pp = { 0 };
>   
> +	pp.flags = PP_FLAG_DMA_MAP;
>   	pp.pool_size = bp->rx_ring_size;
>   	pp.nid = dev_to_node(&bp->pdev->dev);
>   	pp.napi = &rxr->bnapi->napi;



Return-Path: <netdev+bounces-30301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B610C786D51
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEE31C20DA4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D46CA7E;
	Thu, 24 Aug 2023 11:02:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B94A933
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:02:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413519A2
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692874905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WrWsrLG6AaEOOJ9A9ov3qY439ojh9QoBEVAKqojw0Y=;
	b=hjeIRNIHvE0HLk+blrQwnWbMT4kAI6cT5fyBtn0/EHbgoG/tGgEVqm2Oxwi3iOw5T/cpft
	XYFCqHGMSdQAatX/tlPME3iEbWHjPkkwyqaRjSLuaz+EyeqES9Ek63Qs44z6BNCqljspxj
	vs4+Xc9Czsjn8x/cSRmfuHES9Q+Wn90=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-tdD5M1VaM_ua2k_-12EgOA-1; Thu, 24 Aug 2023 07:01:44 -0400
X-MC-Unique: tdD5M1VaM_ua2k_-12EgOA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe52cd62aaso7778594e87.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874902; x=1693479702;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WrWsrLG6AaEOOJ9A9ov3qY439ojh9QoBEVAKqojw0Y=;
        b=N5dSYmn16z1BqSERTY5HgYPH1k/KeMMM41evgQuJK68GGCOa1sb2254ZT29n3A4jI8
         /HEP9cXyBOhZLU8xjCM+Ugy/wstuqTTZDEITvi3MeGrLZbWvLOG7iYwOGLjLYCeROPaj
         U3jhtxLnJaZ9ZW97+91gkk1Wf7a4VZgHs9MdPV9rVsnE8pfungg+LVgBML/wO79KBNwO
         TKK57xzG/vhp2tlhm4aYCZPhhbgwm1fS7VmnQRxfCQxSX2+pq7Rds7H23B5xqyX5b6ZO
         MOi0SxKX1TDwtKwRf+/yPIfZQzcoj9APfEeSbEsN6n/ZYt4gPAg2HRgT161lTXvhmSko
         WVZQ==
X-Gm-Message-State: AOJu0Yyfz0Dddp0lrNGrrx8+4zlCQR5fwzHKx9Gj2OLlWnw2hEB/b7cW
	9R+cy2fcSkNVZV4ioZiSWmus8jBymA86UXsQtl2cph4z1DPdRM3y4usstygEyUPqMLsGlGHyVFC
	BJ/glivxw5euLNCTS
X-Received: by 2002:a05:6512:689:b0:4fd:d64f:c0a6 with SMTP id t9-20020a056512068900b004fdd64fc0a6mr13373790lfe.48.1692874902596;
        Thu, 24 Aug 2023 04:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/8JSIpvwRmqUiTu7BKn1NEXo81ltu5VANojRzPX7O9gRwpDR1OYO6jocVlLCUqX3t2VYMrg==
X-Received: by 2002:a05:6512:689:b0:4fd:d64f:c0a6 with SMTP id t9-20020a056512068900b004fdd64fc0a6mr13373761lfe.48.1692874902091;
        Thu, 24 Aug 2023 04:01:42 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id d6-20020a05640208c600b0052a3ad836basm1995473edz.41.2023.08.24.04.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 04:01:41 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <131877ae-cb72-1bc2-350d-8a21c3b4e27a@redhat.com>
Date: Thu, 24 Aug 2023 13:01:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
 linyunsheng@huawei.com, Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3 net] octeontx2-pf: fix page_pool creation fail for
 rings > 32k
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230824030301.2525375-1-rkannoth@marvell.com>
In-Reply-To: <20230824030301.2525375-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 24/08/2023 05.03, Ratheesh Kannoth wrote:
> octeontx2 driver calls page_pool_create() during driver probe()
> and fails if queue size > 32k. Page pool infra uses these buffers
> as shock absorbers for burst traffic. These pages are pinned down
> over time as working sets varies, due to the recycling nature
> of page pool, given page pool (currently) don't have a shrinker
> mechanism, the pages remain pinned down in ptr_ring.
> Instead of clamping page_pool size to 32k at
> most, limit it even more to 2k to avoid wasting memory.
> 
> This have been tested on octeontx2 CN10KA hardware.
> TCP and UDP tests using iperf shows no performance regressions.
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---

Again

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> ChangeLogs:
> 
> v2->v3: Fix macro aligment and header file changes suggested by
> 	Alexander Lobakin
> v1->v2: Commit message changes and typo fixes
> v0->v1: Commit message changes.
> ---
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h   | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 77c8f650f7ac..3e1c70c74622 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1432,7 +1432,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>   	}
>   
>   	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
> -	pp_params.pool_size = numptrs;
> +	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
>   	pp_params.nid = NUMA_NO_NODE;
>   	pp_params.dev = pfvf->dev;
>   	pp_params.dma_dir = DMA_FROM_DEVICE;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> index b5d689eeff80..9e3bfbe5c480 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> @@ -23,6 +23,8 @@
>   #define	OTX2_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN)
>   #define	OTX2_MIN_MTU		60
>   
> +#define OTX2_PAGE_POOL_SZ	2048
> +
>   #define OTX2_MAX_GSO_SEGS	255
>   #define OTX2_MAX_FRAGS_IN_SQE	9
>   



Return-Path: <netdev+bounces-37587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E317B62B5
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DFD661C20840
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533CDD2EB;
	Tue,  3 Oct 2023 07:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060AECA7B
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 07:46:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459090
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696319162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=badhJh7j9vTt4lYRj3w4dzKDnX5l9fCk+488RmtlxLs=;
	b=i3BPWSR0EZVzk69Xi2Qt7MwyNY7AGGPZvevn2TWiLcMpggFGxo8jDjowDQoXnxmGYdNxzJ
	yOrwSSVAfF89TqoNObiZ7TsElEOtmqHcTX4leJEnmVtcpw2JHRbHMep1oWLE2wrY8aJXZt
	vC+pRYGIXmIObXtAx7bXoI1fUlPqMco=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-d0LyL8VDO2-guzPVkD0NYw-1; Tue, 03 Oct 2023 03:46:01 -0400
X-MC-Unique: d0LyL8VDO2-guzPVkD0NYw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9adcb9ecc16so10492566b.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 00:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696319160; x=1696923960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=badhJh7j9vTt4lYRj3w4dzKDnX5l9fCk+488RmtlxLs=;
        b=t3gCGlb6D6o7D58J2jY54eA3FRItqTFTlPKziHUQB8K2BCtenskca/QFFnSNRrUZkn
         dEdCQs7i2xaEOZLLh/iQuaveQiCbCpu9yNn3vC3pyHn1xFirY/t37QqeWs5aDn6sNAMb
         9Q0gzgQoGyJw/jvQLbZZ2cYBbEqj+eUlBW7oJwBZvjDpL4gTCkvDuBFE8EkJmeayaXDL
         JRw5Aul6tdIOrbJPoBdVHCiSM2IQAb7tiqOgUvd9TlJzYwd691FyGdAaNEDR9Cavv07j
         dxFrH0X5195Qa2q7wYmW+sqjUXtpkHE6U2phxDyaJFPvRu9P2v8XeaWkhuApWKjzLM4P
         MmlQ==
X-Gm-Message-State: AOJu0YzxuzloJc9roaT0zbUx/CKL8akK5iVnl8HPBRXEn98xxPY+XdZ8
	cnj+sybX7kl0zjhc5e/E5oZjA/J6a9/Ui6N/2FGTPZ54V0zGqT9I/d08p6cj7r9NqB+ljWqsJTr
	bkMN4gOIAWQusFNXW
X-Received: by 2002:a17:906:19b:b0:9ae:6da8:181c with SMTP id 27-20020a170906019b00b009ae6da8181cmr12064771ejb.7.1696319159814;
        Tue, 03 Oct 2023 00:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWzeUW1QUpPdAL7ev6RQA1+N2TB0hOVem0AAU3/MPZFHW0EnnDEy+RK9wC9vjYR/dvQPeDRw==
X-Received: by 2002:a17:906:19b:b0:9ae:6da8:181c with SMTP id 27-20020a170906019b00b009ae6da8181cmr12064749ejb.7.1696319159406;
        Tue, 03 Oct 2023 00:45:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709067ad300b009a193a5acffsm592740ejo.121.2023.10.03.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:45:58 -0700 (PDT)
Message-ID: <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
From: Paolo Abeni <pabeni@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Bianconi
 <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang
 Chen <liangchen.linux@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Guillaume Tucker
 <guillaume.tucker@collabora.com>, Matthew Wilcox <willy@infradead.org>,
 Linux-MM <linux-mm@kvack.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>
Date: Tue, 03 Oct 2023 09:45:56 +0200
In-Reply-To: <20230922091138.18014-2-linyunsheng@huawei.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
	 <20230922091138.18014-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-09-22 at 17:11 +0800, Yunsheng Lin wrote:
> Currently page_pool_alloc_frag() is not supported in 32-bit
> arch with 64-bit DMA because of the overlap issue between
> pp_frag_count and dma_addr_upper in 'struct page' for those
> arches, which seems to be quite common, see [1], which means
> driver may need to handle it when using fragment API.
>=20
> It is assumed that the combination of the above arch with an
> address space >16TB does not exist, as all those arches have
> 64b equivalent, it seems logical to use the 64b version for a
> system with a large address space. It is also assumed that dma
> address is page aligned when we are dma mapping a page aligned
> buffer, see [2].
>=20
> That means we're storing 12 bits of 0 at the lower end for a
> dma address, we can reuse those bits for the above arches to
> support 32b+12b, which is 16TB of memory.
>=20
> If we make a wrong assumption, a warning is emitted so that
> user can report to us.
>=20
> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.=
com/
> 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Guillaume Tucker <guillaume.tucker@collabora.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Linux-MM <linux-mm@kvack.org>
> ---
>  include/linux/mm_types.h        | 13 +------------
>  include/net/page_pool/helpers.h | 20 ++++++++++++++------
>  net/core/page_pool.c            | 14 +++++++++-----
>  3 files changed, 24 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 36c5b43999e6..74b49c4c7a52 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -125,18 +125,7 @@ struct page {
>  			struct page_pool *pp;
>  			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
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
>  		};
>  		struct {	/* Tail pages of compound page */
>  			unsigned long compound_head;	/* Bit zero is set */

As noted by Jesper, since this is touching the super-critcal struct
page, an explicit ack from the mm people is required.

@Matthew: could you please have a look?

I think it would be nice also an explicit ack from Jesper and/or Ilias.

Cheers,

Paolo



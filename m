Return-Path: <netdev+bounces-17140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF0750890
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5181C21134
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA67200B5;
	Wed, 12 Jul 2023 12:43:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414061F942
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:43:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704F1727
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689165817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+p4zijdnnotGwm7Q3HCqnAFmmDPWVa3aWA6W3Ys2rs=;
	b=jK7cd3VImMgJgmMuZ4PbXQNfJbXnqga2T7sv/qQvDMaQYTyucRpCxhaOXRgEN77SJxJiYk
	nY5RFVoKfb7cSqr60UUfgcznH7jTX7/f25zDQVToByy+SVVaW953V6PbG06DbR1mQny1cB
	bDcMYG0L7D1NgWjUNhu7rnDKBA5rC0M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-Mgmql7iwO6OKGWv6IFdKhQ-1; Wed, 12 Jul 2023 08:43:36 -0400
X-MC-Unique: Mgmql7iwO6OKGWv6IFdKhQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993d5006993so345885766b.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 05:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165814; x=1691757814;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+p4zijdnnotGwm7Q3HCqnAFmmDPWVa3aWA6W3Ys2rs=;
        b=La3Sck1Xo8VpKsiUcqhLv+027/sx8mYW2aPr85luvXdrJv2iYEuSx9TB9npnNPm/OW
         qYst4rFXgJiBtkU9eMbLFKNinTItTUSm3amOVOmtI3nIaQ3TCohxnkRF+AmEe8ZL/iyv
         8I1eMD+zLYw8HtfgwwId9WLH+cUBMXLAldAAApqC6mFo6PZTnueI+KSRd0iFUdsJYNvb
         i4Fl8tNUtfUhWClKfaNjbd6JRw8m2W+ftV9Sn/qZ3Qu8/tL/yaB9+5nrOyXYV7FLt8Fj
         ehWep3TDtZqmxY+0uMnkQ11EuM1lYFnOPPRNkoqVUOd4iwZGZWjDTeuyWBub18/733XK
         B2Hg==
X-Gm-Message-State: ABy/qLbMdT//Pwfzn3AKV2LtNjPG1zNCPpKM67MxNR/4YAYiWkNECYn9
	HbYcm19CpueBonowYxBQKNxrjZBvIB3o2ybeVsYlWVFVhWI2oWgCn/Gv1/YorSSBtVvO2Pzw4/v
	cFPzmyvlHPErMq5Ji
X-Received: by 2002:a17:906:1046:b0:993:d5bd:a763 with SMTP id j6-20020a170906104600b00993d5bda763mr15227962ejj.20.1689165814376;
        Wed, 12 Jul 2023 05:43:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+ewEF2yQ9ZvTxJZTtpXPYDFVylDkyburs1+7cuHfVNzohEahoExX12dJoXjqPdsrewP0z6A==
X-Received: by 2002:a17:906:1046:b0:993:d5bd:a763 with SMTP id j6-20020a170906104600b00993d5bda763mr15227940ejj.20.1689165814103;
        Wed, 12 Jul 2023 05:43:34 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090680d200b00992d70cc8acsm2488027ejx.112.2023.07.12.05.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:43:33 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <8b50a49e-5df8-dccd-154e-4423f0e8eda5@redhat.com>
Date: Wed, 12 Jul 2023 14:43:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, netdev@vger.kernel.org, almasrymina@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, edumazet@google.com,
 dsahern@gmail.com, michael.chan@broadcom.com, willemb@google.com
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230707183935.997267-1-kuba@kernel.org>
 <1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
 <20230711170838.08adef4c@kernel.org>
 <edf4f724-0c0e-c6ae-ffcb-ec1336448e59@huawei.com>
In-Reply-To: <edf4f724-0c0e-c6ae-ffcb-ec1336448e59@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12/07/2023 13.47, Yunsheng Lin wrote:
> On 2023/7/12 8:08, Jakub Kicinski wrote:
>> On Tue, 11 Jul 2023 17:49:19 +0200 Jesper Dangaard Brouer wrote:
>>> I see you have discovered that the next bottleneck are the IOTLB misses.
>>> One of the techniques for reducing IOTLB misses is using huge pages.
>>> Called "super-pages" in article (below), and they report that this trick
>>> doesn't work on AMD (Pacifica arch).
>>>
>>> I think you have convinced me that the pp_provider idea makes sense for
>>> *this* use-case, because it feels like natural to extend PP with
>>> mitigations for IOTLB misses. (But I'm not 100% sure it fits Mina's
>>> use-case).
>>
>> We're on the same page then (no pun intended).
>>
>>> What is your page refcnt strategy for these huge-pages. I assume this
>>> rely on PP frags-scheme, e.g. using page->pp_frag_count.
>>> Is this correctly understood?
>>
>> Oh, I split the page into individual 4k pages after DMA mapping.
>> There's no need for the host memory to be a huge page. I mean,
>> the actual kernel identity mapping is a huge page AFAIU, and the
>> struct pages are allocated, anyway. We just need it to be a huge
>> page at DMA mapping time.
>>
>> So the pages from the huge page provider only differ from normal
>> alloc_page() pages by the fact that they are a part of a 1G DMA
>> mapping.

So, Jakub you are saying the PP refcnt's are still done "as usual" on 
individual pages.

> 
> If it is about DMA mapping, is it possible to use dma_map_sg()
> to enable a big continuous dma map for a lot of discontinuous
> 4k pages to avoid allocating big huge page?
> 
> As the comment:
> "The scatter gather list elements are merged together (if possible)
> and tagged with the appropriate dma address and length."
> 
> https://elixir.free-electrons.com/linux/v4.16.18/source/arch/arm/mm/dma-mapping.c#L1805
> 

This is interesting for two reasons.

(1) if this DMA merging helps IOTLB misses (?)

(2) PP could use dma_map_sg() to amortize dma_map call cost.

For case (2) __page_pool_alloc_pages_slow() already does bulk allocation
of pages (alloc_pages_bulk_array_node()), and then loops over the pages
to DMA map them individually.  It seems like an obvious win to use
dma_map_sg() here?

--Jesper





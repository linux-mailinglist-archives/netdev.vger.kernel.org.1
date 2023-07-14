Return-Path: <netdev+bounces-18013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD27542A7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9B31C21617
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E3154A0;
	Fri, 14 Jul 2023 18:37:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4013715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 18:37:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A26C6
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689359864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlt/C80WJuZUiszaR3tLxgEwAcnLKDklXFhvNucHvpc=;
	b=e49QXlrMb0tfoxyEnpH4oPJJ5ym2S8cCq8vnTfjr65YH/Mx27wxACXmxvWpoVoggi65mkI
	85S4GdF5SZ2rsSqcUwC1bje1IlrrCw2Q4tWw6lq4DCKRDy8IwcSWyPtiXZrswROG41X1Or
	k/ZYRJ7P7u2+0Jf0YNKswmryLPoO7/w=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-WwsHmPIqPfSWhXs28UuRFQ-1; Fri, 14 Jul 2023 14:37:43 -0400
X-MC-Unique: WwsHmPIqPfSWhXs28UuRFQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b708d79112so21884231fa.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 11:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359862; x=1691951862;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlt/C80WJuZUiszaR3tLxgEwAcnLKDklXFhvNucHvpc=;
        b=Xlwz5I0szdOUuob5NYsaBCrcB7fVu6qlUqAja5V0zcot1rk5ZSrvvjLLbxmfU5V8zu
         MNlbkUNscfyuxfuhVuibkWbOQLXEquXKnPkidi1aZeLQXqxYeQ6ZhCteXu9ulCR85hTf
         k8/kf7y5ygR/olv8j2QSQ+HlRpMrpMFgzlKSt2sL4XV3chZ3VP967qRWXiwZIbqRY38g
         ISYUE//KOwFepJdF5Jqp97b9tF0VerZG5PhgpOUmPVLRK0ioGWITbo3hUIg7HqPNyLsY
         Q2Fu4LliE15ZY/EHTpEFZWsV0VmcFq1kuxyUh4r18Ogn/Ucv+V6gT1wcOr8OLWLHDnY2
         gYDQ==
X-Gm-Message-State: ABy/qLYGXkyB2irUlXLKI3CfyWKEwlMLN1swOYM3sSttNyPdy4VWKx8P
	HBKriAZ0QtSpQVVidUpNdTRb5FH9dcgPTeusp0vZSLC5F+kjaETBCS3uetr8ztYaJpsops4tl5g
	DKqrrsxSYfZSWTT3T
X-Received: by 2002:a2e:9053:0:b0:2b5:9e51:2912 with SMTP id n19-20020a2e9053000000b002b59e512912mr4824482ljg.24.1689359861978;
        Fri, 14 Jul 2023 11:37:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG0DcrmoWUD7erkzbvOJvy1v8KA2m34srzCw022IBv7s40Nq/DYobabu5nOWd5bEX1/OOSj6A==
X-Received: by 2002:a2e:9053:0:b0:2b5:9e51:2912 with SMTP id n19-20020a2e9053000000b002b59e512912mr4824471ljg.24.1689359861658;
        Fri, 14 Jul 2023 11:37:41 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906038800b009893650453fsm5726448eja.173.2023.07.14.11.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:37:41 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <ac97825d-6a27-f121-4cee-9d2ee0934ce6@redhat.com>
Date: Fri, 14 Jul 2023 20:37:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/7] net: page_pool: place frag_* fields
 in one cacheline
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-3-aleksander.lobakin@intel.com>
In-Reply-To: <20230714170853.866018-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 14/07/2023 19.08, Alexander Lobakin wrote:
> On x86_64, frag_* fields of struct page_pool are scattered across two
> cachelines despite the summary size of 24 bytes. The last field,
> ::frag_users, is pushed out to the next one, sharing it with
> ::alloc_stats.
> All three fields are used in pretty much the same places. There are some
> holes and cold members to move around. Move frag_* one block up, placing
> them right after &page_pool_params perfectly at the beginning of CL2.
> This doesn't do any meaningful to the second block, as those are some
> destroy-path cold structures, and doesn't do anything to ::alloc_stats,
> which still starts at 200-byte offset, 8 bytes after CL3 (still fitting
> into 1 cacheline).
> On my setup, this yields 1-2% of Mpps when using PP frags actively.
> When it comes to 32-bit architectures with 32-byte CL: &page_pool_params
> plus ::pad is 44 bytes, the block taken care of is 16 bytes within one
> CL, so there should be at least no regressions from the actual change.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   include/net/page_pool.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 829dc1f8ba6b..212d72b5cfec 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -130,16 +130,16 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
>   struct page_pool {
>   	struct page_pool_params p;
>   
> +	long frag_users;
> +	struct page *frag_page;
> +	unsigned int frag_offset;
> +	u32 pages_state_hold_cnt;

I think this is okay, but I want to highlight that:
  - pages_state_hold_cnt and pages_state_release_cnt
need to be kept on separate cache-lines.


> +
>   	struct delayed_work release_dw;
>   	void (*disconnect)(void *);
>   	unsigned long defer_start;
>   	unsigned long defer_warn;
>   
> -	u32 pages_state_hold_cnt;
> -	unsigned int frag_offset;
> -	struct page *frag_page;
> -	long frag_users;
> -
>   #ifdef CONFIG_PAGE_POOL_STATS
>   	/* these stats are incremented while in softirq context */
>   	struct page_pool_alloc_stats alloc_stats;



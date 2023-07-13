Return-Path: <netdev+bounces-17501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD2751D09
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74422814F1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D8100A7;
	Thu, 13 Jul 2023 09:20:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC8FC1F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:20:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A6CF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689240012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zRCAMOHy+zk6cYyrxsKq7F0seQMRfEJ6HjinaFbLQU=;
	b=MggO1UJgk94WqDWniwhzA8to1n2E6fAB+m2ABe9WIoM4PSCb37KCmtu932olWPW4ForUCk
	ymed9udsp/l4OO6AKVjsqXIxjhT+8l7VXjtCTfVJXEvHzYhOmgO3sNDWKxz4hm+3sjZ3FG
	HvUGIYqW4xFL0QaCFei2mFjVbaQb0KA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-BDaFooctPli5o4cnbcOjEA-1; Thu, 13 Jul 2023 05:20:10 -0400
X-MC-Unique: BDaFooctPli5o4cnbcOjEA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51df80f3afeso331116a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240009; x=1691832009;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zRCAMOHy+zk6cYyrxsKq7F0seQMRfEJ6HjinaFbLQU=;
        b=EFjWwJS8wF9ClIDoFLvCMKCrWxACplTmsm9SwdVrktSzCTOP0357iLyhOFecy5/dR5
         RcOb9p/aopOusiaa4KiL/e8+5TkXVxvmOOqS0oCqOFj1kGcSFiCLM7G8BF6nDxyxcm6t
         o//IqT0y+rku2eSbOcUQfM3hheET9omPNKIIZNeaxrjkvXWrTLpvBgkDkbO1Oy7bHgsW
         gOP7Gr3ECCm494/+TKbqL+fScK4J6qx1lkMdaQQWSzc/srOj1YQxNxbvXKGW6xsq9AYI
         iqlhuelSM14F/LiZJkxrqWy2rVo6Zl7HG020op+/WunMOJ/GcXBxsCgi/n1pqA1WhyIE
         ML1A==
X-Gm-Message-State: ABy/qLb4MnMT2Wi8lI/F6AZw0TViDUkGBuSHkJk0SFaUIFBnrlxl1Zzi
	7T/UAhMFDdoRd6eio0NPwjz2vG4ng+IM97Rj0a6+LRGwRIhDtghrwJ4Bz533YTtsrgXiapFSxse
	+97GCVsH6MG2QmxDZ
X-Received: by 2002:aa7:c553:0:b0:51d:fa4e:49bb with SMTP id s19-20020aa7c553000000b0051dfa4e49bbmr1249433edr.7.1689240009044;
        Thu, 13 Jul 2023 02:20:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGs3DOEOi+UoA5PqEiGd8/cqwH8rDF07UJ6dbXSFDCXMv7RoPn/XVRBdyjGRDKYme3Ol3hzA==
X-Received: by 2002:aa7:c553:0:b0:51d:fa4e:49bb with SMTP id s19-20020aa7c553000000b0051dfa4e49bbmr1249422edr.7.1689240008718;
        Thu, 13 Jul 2023 02:20:08 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id e3-20020a50ec83000000b0051e0ea53eaasm3988818edr.97.2023.07.13.02.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:20:08 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
Date: Thu, 13 Jul 2023 11:20:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, "maxtram95@gmail.com" <maxtram95@gmail.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
 "kheib@redhat.com" <kheib@redhat.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "mkabat@redhat.com" <mkabat@redhat.com>, "atzin@redhat.com"
 <atzin@redhat.com>, "fmaurer@redhat.com" <fmaurer@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "jbenc@redhat.com" <jbenc@redhat.com>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>,
 "jbrouer@redhat.com" <jbrouer@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "saeed@kernel.org" <saeed@kernel.org>,
 "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
In-Reply-To: <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Dragos,

Below you promised to work on a fix for XDP redirect memory leak...
What is the status?

On 23/05/2023 18.35, Dragos Tatulea wrote:
> 
> On Tue, 2023-05-23 at 17:55 +0200, Jesper Dangaard Brouer wrote:
>>
>> When the mlx5 driver runs an XDP program doing XDP_REDIRECT, then memory
>> is getting leaked. Other XDP actions, like XDP_DROP, XDP_PASS and XDP_TX
>> works correctly. I tested both redirecting back out same mlx5 device and
>> cpumap redirect (with XDP_PASS), which both cause leaking.
>>
>> After removing the XDP prog, which also cause the page_pool to be
>> released by mlx5, then the leaks are visible via the page_pool periodic
>> inflight reports. I have this bpftrace[1] tool that I also use to detect
>> the problem faster (not waiting 60 sec for a report).
>>
>>    [1]
>> https://github.com/xdp-project/xdp-project/blob/master/areas/mem/bpftrace/page_pool_track_shutdown01.bt
>>
>> I've been debugging and reading through the code for a couple of days,
>> but I've not found the root-cause, yet. I would appreciate new ideas
>> where to look and fresh eyes on the issue.
>>
>>
>> To Lin, it looks like mlx5 uses PP_FLAG_PAGE_FRAG, and my current
>> suspicion is that mlx5 driver doesn't fully release the bias count (hint
>> see MLX5E_PAGECNT_BIAS_MAX).
>>
> 
> Thanks for the report Jesper. Incidentally I've just picked up this issue today
> as well.
> 
> On XDP redirect and tx, the page is set to skip the bias counter release with
> the expectation that page_pool_put_defragged_page will be called from [1]. But,
> as I found out now, during XDP redirect only one fragment of the page is
> released in xdp core [2]. This is where the leak is coming from.
> 
> We'll provide a fix soon.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c#n665
> 
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/core/xdp.c#n390
> 
> Thanks,
> Dragos
> 
> 



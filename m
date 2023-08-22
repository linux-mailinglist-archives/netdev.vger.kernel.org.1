Return-Path: <netdev+bounces-29630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121C784187
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480EA281062
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6291C9E2;
	Tue, 22 Aug 2023 13:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A47F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:05:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F94CDD
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692709551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7FAYdoJwloLrv0UGWz5p4dSAOg5t5Yw2PfUQOXhwCU=;
	b=Hxv92FxjrLVASy4agzebWpN0fcNQ4KMFn8B7e2ESBD9R8zp5e1AiYE3g5t4fMFbdJ9RmHE
	178ayEEWzhmgA8iD+5w34S1kffCCckd6Ei+CAAt07NoccgQddoD0FKWvyMWVXQkdnDkMAS
	/Zpv0A3uHE+Cxjyj8NMRI52XKXR7hFM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-gi1LhVfjOm2p9KCPikQFug-1; Tue, 22 Aug 2023 09:05:50 -0400
X-MC-Unique: gi1LhVfjOm2p9KCPikQFug-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bba9a3d63fso45077101fa.0
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 06:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692709548; x=1693314348;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7FAYdoJwloLrv0UGWz5p4dSAOg5t5Yw2PfUQOXhwCU=;
        b=VNF1ToNbp9LcAB8gaLJ87igrE6DjeEBHIyADk8ID2RJf2mCsGTnEloKUdwtLCcaMgx
         oLms4+KPksy8Z6JHexFI9f5HwF5Q8vM8D3emIqr9aEG7B6dV/vwpIScKZEd3YaUF4z6y
         QZRz1iqHjgAW4jPN734xwwTud8YYTIz/WH37Eq1WiXgP131fpFczYPCN+7H6W1fezbF3
         /OEw9VoTKrxeKoDnmD6tdrFkN5MrCp3OeTh18lUCY8J1H8RK5RQFcrbxwDlydqir0VrW
         5/ZoXz8p9alaXMOmZA0ynbmvdVyR4m71IyqdKLKjVBQYSNmFy+pVBh3+mtDRhAllSDwN
         o1Kw==
X-Gm-Message-State: AOJu0YwekCGqB4mj0PuZEBCpjiEztU56XmUvfk3xTVoB2R4HttQuHVCq
	pXb4yGQQIa0mxF7KtSjMOLtAH7B+zphEiQ7gePETnwixjF2jX42knMxJ16exkWHoNdKOAB5S07h
	ALjbrtOOOwJvtbces
X-Received: by 2002:a2e:9dcd:0:b0:2b6:e105:6174 with SMTP id x13-20020a2e9dcd000000b002b6e1056174mr7134457ljj.47.1692709548645;
        Tue, 22 Aug 2023 06:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN/2HdvHP/tbRs13x2YKwx3LDsEjKHDcO/3micVZQ4thN1wkq5rYdyuRU4M1SJnlVojS4sWA==
X-Received: by 2002:a2e:9dcd:0:b0:2b6:e105:6174 with SMTP id x13-20020a2e9dcd000000b002b6e1056174mr7134433ljj.47.1692709548169;
        Tue, 22 Aug 2023 06:05:48 -0700 (PDT)
Received: from [192.168.42.222] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id l20-20020a17090615d400b009930308425csm8138891ejd.31.2023.08.22.06.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 06:05:47 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <ef4ca8d3-3127-f6dd-032a-e04d367fd49c@redhat.com>
Date: Tue, 22 Aug 2023 15:05:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, ilias.apalodimas@linaro.org, daniel@iogearbox.net,
 ast@kernel.org, netdev@vger.kernel.org,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Stanislav Fomichev <sdf@google.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [RFC PATCH net-next v3 0/2] net: veth: Optimizing page pool usage
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>,
 Liang Chen <liangchen.linux@gmail.com>, hawk@kernel.org, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20230816123029.20339-1-liangchen.linux@gmail.com>
 <05eec0a4-f8f8-ef68-3cf2-66b9109843b9@redhat.com>
 <a7e72202-0fa1-633e-1564-132a1984aba1@redhat.com>
 <a4e49ab5-fdc5-971a-47e6-30c002ad513f@huawei.com>
In-Reply-To: <a4e49ab5-fdc5-971a-47e6-30c002ad513f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 22/08/2023 14.24, Yunsheng Lin wrote:
> On 2023/8/22 5:54, Jesper Dangaard Brouer wrote:
>> On 21/08/2023 16.21, Jesper Dangaard Brouer wrote:
>>>
>>> On 16/08/2023 14.30, Liang Chen wrote:
>>>> Page pool is supported for veth, but at the moment pages are not properly
>>>> recyled for XDP_TX and XDP_REDIRECT. That prevents veth xdp from fully
>>>> leveraging the advantages of the page pool. So this RFC patchset is mainly
>>>> to make recycling work for those cases. With that in place, it can be
>>>> further optimized by utilizing the napi skb cache. Detailed figures are
>>>> presented in each commit message, and together they demonstrate a quite
>>>> noticeable improvement.
>>>>
>>>
>>> I'm digging into this code path today.
>>>
>>> I'm trying to extend this and find a way to support SKBs that used
>>> kmalloc (skb->head_frag=0), such that we can remove the
>>> skb_head_is_locked() check in veth_convert_skb_to_xdp_buff(), which will
>>> allow more SKBs to avoid realloc.  As long as they have enough headroom,
>>> which we can dynamically control for netdev TX-packets by adjusting
>>> netdev->needed_headroom, e.g. when loading an XDP prog.
>>>
>>> I noticed netif_receive_generic_xdp() and bpf_prog_run_generic_xdp() can
>>> handle SKB kmalloc (skb->head_frag=0).  Going though the code, I don't
>>> think it is a bug that generic-XDP allows this.
> 
> Is it possible to relaxe other checking too, and implement something like
> pskb_expand_head() in xdp core if xdp core need to modify the data?
> 

Yes, I definitely hope (and plan) to relax other checks.

The XDP_PACKET_HEADROOM (256 bytes) check have IMHO become obsolete and
wrong, as many drivers today use headroom 192 bytes for XDP (which we
allowed).  Thus, there is not reason for veth to insist on this
XDP_PACKET_HEADROOM limit.  Today XDP can handle variable headroom (due
to these drivers).


> 
>>>
>>> Deep into this rabbit hole, I start to question our approach.
>>>    - Perhaps the veth XDP approach for SKBs is wrong?
>>>
>>> The root-cause of this issue is that veth_xdp_rcv_skb() code path (that
>>> handle SKBs) is calling XDP-native function "xdp_do_redirect()". I
>>> question, why isn't it using "xdp_do_generic_redirect()"?
>>> (I will jump into this rabbit hole now...)
> 
> Is there any reason why xdp_do_redirect() can not handle the slab-allocated
> data? Can we change the xdp_do_redirect() to handle slab-allocated
> data, so that it can benefit other case beside veth too?
> 

I started coding up this, but realized that it was a wrong approach.

The xdp_do_redirect() call is for native-XDP with a proper xdp_buff.
When dealing with SKBs we pretend is a xdp_buff, we have the API
xdp_do_generic_redirect().  IMHO it is wrong to "steal" the packet-data
from an SKB and in-order to use the native-XDP API xdp_do_redirect().
In the use-cases I see, often the next layer will allocate a new SKB and
attach the stolen packet-data , which is pure-waste as
xdp_do_generic_redirect() keeps the SKB intact, so no new SKB allocs.

--Jesper





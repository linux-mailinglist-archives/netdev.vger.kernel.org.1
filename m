Return-Path: <netdev+bounces-29452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2A783506
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA198280E25
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9780134B7;
	Mon, 21 Aug 2023 21:54:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E317ABD
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 21:54:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F7912C
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692654879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ooCbAjtdo9/Ih4UjNr8Yz1H0RJtwGg8vTdvDwXkFis=;
	b=IvVOwG38db8EpGfdMYVM7gmi4MImlBo97/PRYYETz1xm4vozunhslemFdODBg4i2oxTl19
	w3nTu+NW21wzKIbrGc/xsFEh9/fRu3VhDXwujYUJCCPwB1MsbIqzKK/vDBkmjH6FDvjcMF
	jUawCnpXi3S2bogtowbAdSLDsEtvS/I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-go8KAn7dNlyWmxL7Y54lTA-1; Mon, 21 Aug 2023 17:54:37 -0400
X-MC-Unique: go8KAn7dNlyWmxL7Y54lTA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5219ceead33so2437486a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654876; x=1693259676;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ooCbAjtdo9/Ih4UjNr8Yz1H0RJtwGg8vTdvDwXkFis=;
        b=Szo6NL6OYwKScNMfhZ6uvF1RjDu5CSoN5b647prFUjz+TokXXU2y2yb3eJzP1B8KHA
         EkvTeDvHVuoqFTdi7f7ArG17BarVSLvcGt37ScwXax2JVYHYPOEiAgOgq9kovxDBnfM2
         5d+iscpKX9L+Mo0OXpH83acONVxOFGpimRac2c8HZ8+7VWOOs0zg/4RxUWOJYHhULSzC
         2qJCY1VvZ//hQTTEP02D74HeGi+l2tjBOpV3pQHd/mBN+43C1z41R07rzRLRygM0l7PC
         WGKN43YdSK1DFAaHKgZqvuYfbf1e0Q2ju/CrOCWjfIKbNUnpSvj687Z4qkw69dKqpjio
         EVSQ==
X-Gm-Message-State: AOJu0YwfFjwa7b1rRYJcQyAGvSJlUWOybV7QJOWqNfChlzN6u6HdqAJb
	e2AasN+Fksa2uo+WLOMsSaCDco6JwpUiRtC6kq+H3TO6PhgUf6iqWbdne+YZq2g1Q9f65DW9sTs
	xP34cKqQ0HhVMMfdq
X-Received: by 2002:a17:907:2c57:b0:99d:bcc6:12f with SMTP id hf23-20020a1709072c5700b0099dbcc6012fmr5828893ejc.48.1692654876513;
        Mon, 21 Aug 2023 14:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1xxmlnwX5M/ylcgRJkZ4UuSNtakNDHkWjbBTTa2sWxfXpkIeCDm+U7lBO2AJXb8KkMDa6w==
X-Received: by 2002:a17:907:2c57:b0:99d:bcc6:12f with SMTP id hf23-20020a1709072c5700b0099dbcc6012fmr5828887ejc.48.1692654876254;
        Mon, 21 Aug 2023 14:54:36 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id lz16-20020a170906fb1000b0099297782aa9sm7018761ejb.49.2023.08.21.14.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 14:54:35 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a7e72202-0fa1-633e-1564-132a1984aba1@redhat.com>
Date: Mon, 21 Aug 2023 23:54:34 +0200
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
To: Liang Chen <liangchen.linux@gmail.com>, hawk@kernel.org,
 horms@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linyunsheng@huawei.com
References: <20230816123029.20339-1-liangchen.linux@gmail.com>
 <05eec0a4-f8f8-ef68-3cf2-66b9109843b9@redhat.com>
In-Reply-To: <05eec0a4-f8f8-ef68-3cf2-66b9109843b9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21/08/2023 16.21, Jesper Dangaard Brouer wrote:
> 
> On 16/08/2023 14.30, Liang Chen wrote:
>> Page pool is supported for veth, but at the moment pages are not properly
>> recyled for XDP_TX and XDP_REDIRECT. That prevents veth xdp from fully
>> leveraging the advantages of the page pool. So this RFC patchset is 
>> mainly
>> to make recycling work for those cases. With that in place, it can be
>> further optimized by utilizing the napi skb cache. Detailed figures are
>> presented in each commit message, and together they demonstrate a quite
>> noticeable improvement.
>>
> 
> I'm digging into this code path today.
> 
> I'm trying to extend this and find a way to support SKBs that used
> kmalloc (skb->head_frag=0), such that we can remove the
> skb_head_is_locked() check in veth_convert_skb_to_xdp_buff(), which will
> allow more SKBs to avoid realloc.  As long as they have enough headroom,
> which we can dynamically control for netdev TX-packets by adjusting
> netdev->needed_headroom, e.g. when loading an XDP prog.
> 
> I noticed netif_receive_generic_xdp() and bpf_prog_run_generic_xdp() can
> handle SKB kmalloc (skb->head_frag=0).  Going though the code, I don't
> think it is a bug that generic-XDP allows this.
> 
> Deep into this rabbit hole, I start to question our approach.
>   - Perhaps the veth XDP approach for SKBs is wrong?
> 
> The root-cause of this issue is that veth_xdp_rcv_skb() code path (that
> handle SKBs) is calling XDP-native function "xdp_do_redirect()". I
> question, why isn't it using "xdp_do_generic_redirect()"?
> (I will jump into this rabbit hole now...)

It works, implemented using xdp_do_generic_redirect() and lifted
skb_head_is_locked check in veth_convert_skb_to_xdp_buff(), plus adjust
xsk_build_skb() to alloc enough headroom.

The results[1] are good approx 26% faster[1] compared to Maryam's
veth-benchmark[3] results[2].

--Jesper

[1] 
https://github.com/xdp-project/xdp-project/blob/veth-benchmark02/areas/core/veth_benchmark04.org#implemented-use-generic-xdp-redirect

[2] 
https://github.com/xdp-project/xdp-project/blob/veth-benchmark02/areas/core/veth_benchmark03.org#benchmark01-with-xdp-redirect-loaded-on-host-veth

[3] https://github.com/maryamtahhan/veth-benchmark/



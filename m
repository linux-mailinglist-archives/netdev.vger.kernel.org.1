Return-Path: <netdev+bounces-29343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CDA782B99
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2FF1C20927
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335C79C2;
	Mon, 21 Aug 2023 14:22:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075295258
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:22:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D440F12B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692627720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/670X0jaiD6dl8tqvFRYHujg0yyiRDcztdkh+O4EF+w=;
	b=ApJsChC4pzmEMoDKMiNmrTCrXvoKX8gtpUqrXt6F86VKQBM4jQBeRuOt7bnr33dRrwsenZ
	Yjg2weBvQH+P+2jCEjZHUHryGEyo1jkaE4CGHEd3db4vHc9ItnqQt2ROq4EKAiFdmwWedB
	A/bUXLdFXSVydoRjm+M4d9Sd7xUcORw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-ry3DF-WOM-KxSRztGUnIYg-1; Mon, 21 Aug 2023 10:21:59 -0400
X-MC-Unique: ry3DF-WOM-KxSRztGUnIYg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3198430f945so2106842f8f.2
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627718; x=1693232518;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/670X0jaiD6dl8tqvFRYHujg0yyiRDcztdkh+O4EF+w=;
        b=KxM+gqjhJKQA8Ty3LgXbBYM2DCWPds4t1uVCYioDOhrSP2lhX4fAj3mAVmmKSo8e0M
         UEZo0YfDmeOA/0K95z6ztdrLo1wZubWWAkMjy5W0Mp0R/lvZwsGgZpMVnzkzfzHvyjbx
         iotnavHZHRCpQlgpLKjAX77asBO/lTYYjvHuLxpR89a/agetJ0fUa6l8TR8u4bt8aTCu
         qY1nPmDNp2alcJaodt/1af66glshrshUIKsh6SoXmRUbHTa4W2nzQDH1Pq9RkfRS3q0k
         ywpPGTTSuGOTUFhZ4gcyxEy1uJyLbyREfi+sWwPnLQHU6rIzehLZZk8DnuRp/iKYjTmF
         NTbA==
X-Gm-Message-State: AOJu0YziiDnIOJaAHIPAe6gjxeJojK2bRb1p1POeZ1EZ+E6W0WHOLLbS
	XOQidn3Q9xGSuYoH7iflPIAMHVSAi8I/HE/r8p4HL+09q+bFuquQhcI9bn90CornaqrDBrgeJFD
	YAy9VmOfhF2BCv96t
X-Received: by 2002:a5d:4d8d:0:b0:31a:ea86:cbb8 with SMTP id b13-20020a5d4d8d000000b0031aea86cbb8mr5964445wru.2.1692627717937;
        Mon, 21 Aug 2023 07:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT1XFSYQoKt9ryXh/TJ/NjegtAFkX8tRyJKTrJFVkjGdtjkc3T6jjWtGkIr6gDJFRT8FESkw==
X-Received: by 2002:a5d:4d8d:0:b0:31a:ea86:cbb8 with SMTP id b13-20020a5d4d8d000000b0031aea86cbb8mr5964432wru.2.1692627717637;
        Mon, 21 Aug 2023 07:21:57 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id k3-20020aa7c383000000b0052563bff34bsm6004840edq.63.2023.08.21.07.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 07:21:57 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <05eec0a4-f8f8-ef68-3cf2-66b9109843b9@redhat.com>
Date: Mon, 21 Aug 2023 16:21:55 +0200
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
 Stanislav Fomichev <sdf@google.com>
Subject: Re: [RFC PATCH net-next v3 0/2] net: veth: Optimizing page pool usage
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>, hawk@kernel.org,
 horms@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linyunsheng@huawei.com
References: <20230816123029.20339-1-liangchen.linux@gmail.com>
In-Reply-To: <20230816123029.20339-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 16/08/2023 14.30, Liang Chen wrote:
> Page pool is supported for veth, but at the moment pages are not properly
> recyled for XDP_TX and XDP_REDIRECT. That prevents veth xdp from fully
> leveraging the advantages of the page pool. So this RFC patchset is mainly
> to make recycling work for those cases. With that in place, it can be
> further optimized by utilizing the napi skb cache. Detailed figures are
> presented in each commit message, and together they demonstrate a quite
> noticeable improvement.
> 

I'm digging into this code path today.

I'm trying to extend this and find a way to support SKBs that used
kmalloc (skb->head_frag=0), such that we can remove the
skb_head_is_locked() check in veth_convert_skb_to_xdp_buff(), which will
allow more SKBs to avoid realloc.  As long as they have enough headroom,
which we can dynamically control for netdev TX-packets by adjusting
netdev->needed_headroom, e.g. when loading an XDP prog.

I noticed netif_receive_generic_xdp() and bpf_prog_run_generic_xdp() can
handle SKB kmalloc (skb->head_frag=0).  Going though the code, I don't
think it is a bug that generic-XDP allows this.

Deep into this rabbit hole, I start to question our approach.
  - Perhaps the veth XDP approach for SKBs is wrong?

The root-cause of this issue is that veth_xdp_rcv_skb() code path (that
handle SKBs) is calling XDP-native function "xdp_do_redirect()". I
question, why isn't it using "xdp_do_generic_redirect()"?
(I will jump into this rabbit hole now...)

--Jesper

> Changes from v2:
> - refactor the code to make it more readable
> - make use of the napi skb cache for further optimization
> - take the Page pool creation error handling patch out for separate
>    submission
> 
> Liang Chen (2):
>    net: veth: Improving page pool recycling
>    net: veth: Optimizing skb reuse in NAPI Context
> 
>   drivers/net/veth.c | 66 ++++++++++++++++++++++++++++++++++++++++------
>   net/core/skbuff.c  |  1 +
>   2 files changed, 59 insertions(+), 8 deletions(-)
> 



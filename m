Return-Path: <netdev+bounces-22244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92242766B01
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7D01C20ACC
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F9111B8;
	Fri, 28 Jul 2023 10:49:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041111199
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:49:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0713C2A
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690541340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lqrPNW1JcTrEMqTKKWb+4YowGOk52AI3HlI/QjBaCY=;
	b=WhnBguLd9N7HOJXDhBsClUb5QBUJMlBD6ncLNfilwNPs2UtXfP72OWQhxqinip8NwqCNcf
	kUA/HQbVW4qYVMa0QDmwoSKXUwu26ECWWi6Wxxdr5GA8ymExJh1miVAv7zIwTVWHnMeNtn
	WPaTmm4dJrRm3Jokkff+Px7HRBmT4Po=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-KLJMwIP6N0SCx2QEBAaKzg-1; Fri, 28 Jul 2023 06:48:58 -0400
X-MC-Unique: KLJMwIP6N0SCx2QEBAaKzg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb9364b320so1867053e87.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690541337; x=1691146137;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lqrPNW1JcTrEMqTKKWb+4YowGOk52AI3HlI/QjBaCY=;
        b=jEEa81GNjkPjPGlrPUOPCZP6wjvchvO1ovO/BGKPy87A8NqgO6u3BjOQj4NIvbkJF9
         JoTtIKTo5txhAPa/jhd1KZW1OuwquIpzgYmVRBV+GU5s7ZKVSl7zmPU2SkuOLVs8Mvhn
         r8C+i06xVAVPoCFLzyM4ESbkhOh+S35cV7AW57p/d/UA+g34wsn/7de8expA4GEbiNZD
         6OGtThyML0513TERTlygYf0EoCt0hapXuTI/9TvxKHlrQlzf4gANnqBp9hJGOFXN2Lto
         d0FEqG0W/veYxt0NsFENPd1NJZyZDDAyEJ9K3+vCloYFJmVedVqkFLRdgRwLexyea1q0
         kLdQ==
X-Gm-Message-State: ABy/qLa0ItChZY8F5jOQnNsN/JLSNqtFDx8rU0zrzma+eZ2wYYP4iSvG
	SIGMSDolbz3LeaWNdgxmX0Zcubo5p1Dhnwb/o8CT57px9BxuFq+pcL3w7O16UtipPzh/JuMyN4v
	qq/mfOj0o0+klOaD3lMGvTidZ
X-Received: by 2002:a05:6512:6c4:b0:4fd:c83b:a093 with SMTP id u4-20020a05651206c400b004fdc83ba093mr1636643lff.1.1690541337183;
        Fri, 28 Jul 2023 03:48:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFFosXPUMnl49nBR3Ba3aPS0Wzfh9EXsE9WmbJpvenVnkXB4yojtLQ3jzp6gHKi8umEQ4cShQ==
X-Received: by 2002:a05:6512:6c4:b0:4fd:c83b:a093 with SMTP id u4-20020a05651206c400b004fdc83ba093mr1636631lff.1.1690541336861;
        Fri, 28 Jul 2023 03:48:56 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709065acc00b00997e52cb30bsm1903281ejs.121.2023.07.28.03.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:48:56 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <hawk@kernel.org>
Message-ID: <7212d85c-2eaa-2b07-3b81-a481b59d5d7c@redhat.com>
Date: Fri, 28 Jul 2023 12:48:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 houtao1@huawei.com
Subject: Re: [PATCH bpf-next 2/2] bpf, devmap: Remove unused dtab field from
 bpf_dtab_netdev
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
References: <20230728014942.892272-1-houtao@huaweicloud.com>
 <20230728014942.892272-3-houtao@huaweicloud.com>
In-Reply-To: <20230728014942.892272-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 28/07/2023 03.49, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Commit 96360004b862 ("xdp: Make devmap flush_list common for all map
> instances") removes the use of bpf_dtab_netdev::dtab in bq_enqueue(),
> so just remove dtab from bpf_dtab_netdev.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> ---
>   kernel/bpf/devmap.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 49cc0b5671c6..4d42f6ed6c11 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -65,7 +65,6 @@ struct xdp_dev_bulk_queue {
>   struct bpf_dtab_netdev {
>   	struct net_device *dev; /* must be first member, due to tracepoint */
>   	struct hlist_node index_hlist;
> -	struct bpf_dtab *dtab;
>   	struct bpf_prog *xdp_prog;
>   	struct rcu_head rcu;
>   	unsigned int idx;
> @@ -874,7 +873,6 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
>   	}
>   
>   	dev->idx = idx;
> -	dev->dtab = dtab;
>   	if (prog) {
>   		dev->xdp_prog = prog;
>   		dev->val.bpf_prog.id = prog->aux->id;



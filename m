Return-Path: <netdev+bounces-16871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1BD74F1EE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DF91C20F24
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602119BB5;
	Tue, 11 Jul 2023 14:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636D19BAC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:22:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF31734
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689085308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBoxNuRKO8Odbj9dJum9thOQusIAmG6oQ4aiWp/kYHY=;
	b=cZBdRbCca/3SoVY9DvcuEhHoPftjCh5HchDsKQkTTd1FBZyMlodQFdxRETA2H9cY9R+216
	XlzbewjxCvpuPjILvl+BIkq/kFkJ1vaCxFW/19BrjXVjQvJHI051q+ZflQFnJgopxgzKQ2
	qyeVENvQ9/8z/vs2BptibKVnYNfTGjY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-o4s1k00aNjOjOD5SNCPJzA-1; Tue, 11 Jul 2023 10:21:44 -0400
X-MC-Unique: o4s1k00aNjOjOD5SNCPJzA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51e0fc38f16so3870710a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085303; x=1691677303;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBoxNuRKO8Odbj9dJum9thOQusIAmG6oQ4aiWp/kYHY=;
        b=Gy1oD/s30RiO4Z4B0Wayy7n6CqV+/Ju4RcR33w+xkYd4mvcOcsL4bi5DsCfc51eB+K
         GWWx9gMJEif3yrqxgnon3oElsYB7QOmbfF+U21eKCZObh0FvjVQrcv73fg27I3CB1xvX
         KYX+ARFHG/2D0W6rfDj34if0GVF9yj9EyXWcGoKlg8AFGOga0efZ19OBmpcuR1bisa+P
         VTbQzVeAgP4XzbGAnWJURVIchK5d1FXHJF4yqe/234xT4nEESw93TgJXI8a9H48sHLeB
         5nRenvRFP09T5fgF8uwLAFR8l6z/7xYPk/XJTPIZ+tw7RcpgtmHGU2UxMBrOZQbo1fWZ
         1NCA==
X-Gm-Message-State: ABy/qLaW5gtx7hv7jbLNjJAsO8y7ZUupgF0qqGDLGU5c1DoecAdRqiL3
	ziwUZixYh68XhMAJu0wQ+ATmLjcOY9RE9HyJEv6NusM0Wj/V9F9fW5h/FiC04GmuFlbzxhWMgVz
	tZ4TvTHurOcydtIdK
X-Received: by 2002:a05:6402:5170:b0:51d:e20c:59e4 with SMTP id d16-20020a056402517000b0051de20c59e4mr15160877ede.29.1689085303773;
        Tue, 11 Jul 2023 07:21:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHQzjFQLgODxnlwxJH2X5hdNDnii+BX1zti/bW0srr3Gg9oD8DJpENBl8r9f/T+qWzknzkv2Q==
X-Received: by 2002:a05:6402:5170:b0:51d:e20c:59e4 with SMTP id d16-20020a056402517000b0051de20c59e4mr15160856ede.29.1689085303439;
        Tue, 11 Jul 2023 07:21:43 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id by26-20020a0564021b1a00b0050488d1d376sm1356785edb.0.2023.07.11.07.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:21:42 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a05a4ac2-40c8-da67-6727-b9844930386e@redhat.com>
Date: Tue, 11 Jul 2023 16:21:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] xdp: use trusted arguments in XDP hints kfuncs
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org,
 Stanislav Fomichev <sdf@google.com>
References: <20230711105930.29170-1-larysa.zaremba@intel.com>
In-Reply-To: <20230711105930.29170-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 11/07/2023 12.59, Larysa Zaremba wrote:
> Currently, verifier does not reject XDP programs that pass NULL pointer to
> hints functions. At the same time, this case is not handled in any driver
> implementation (including veth). For example, changing
> 
> bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
> 
> to
> 
> bpf_xdp_metadata_rx_timestamp(ctx, NULL);
> 
> in xdp_metadata test successfully crashes the system.
> 
> Add KF_TRUSTED_ARGS flag to hints kfunc definitions, so driver code
> does not have to worry about getting invalid pointers.
> 

Looks good to me, assuming this means verifier will reject BPF-prog's 
supplying NULL.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> Fixes: 3d76a4d3d4e5 ("bpf: XDP metadata RX kfuncs")
> Reported-by: Stanislav Fomichev <sdf@google.com>
> Closes: https://lore.kernel.org/bpf/ZKWo0BbpLfkZHbyE@google.com/
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>   net/core/xdp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 41e5ca8643ec..8362130bf085 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>   __diag_pop();
>   
>   BTF_SET8_START(xdp_metadata_kfunc_ids)
> -#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
> +#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
>   XDP_METADATA_KFUNC_xxx
>   #undef XDP_METADATA_KFUNC
>   BTF_SET8_END(xdp_metadata_kfunc_ids)



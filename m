Return-Path: <netdev+bounces-13045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD42173A080
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFDC1C20382
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4711E50F;
	Thu, 22 Jun 2023 12:07:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E57A1B8FC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:07:19 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222C41728
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:07:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so8227792f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brouer-com.20221208.gappssmtp.com; s=20221208; t=1687435635; x=1690027635;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVyazHtH7BoefuXPN1dGTu12wq0pEkn36JrXNLI8VOI=;
        b=X902Lhkef7RPM2PUbK9gHThcFE+acILIHJaWObU2hhpalosEP/KroI1J+lVJ2BGdzJ
         k2oea91C+j6mZXF0Ye9hQ51Wh6+i1Vhxu78Hff64RACp0YdJsJ1VTl/qwBPh2j59xFiQ
         uODDTfTa9w6fcVK2Saj1Eh4pqOtVkQ4QUXIX6bsx768mrx5Oz/d1WjmKzA2PKXafe2CF
         eX5mpi6HjKSmfFVZYz4VynMAmb+FZ9qk6ZOjwnujfOmyMvgTdCeraiWF9GWNTiDwHXwj
         JYQyfS34FYc2VxzOj3CjDz0ovJH/VD5q5UgZT37hkyg2AXvHb6dEA2yKW/qxvZ6Q6pny
         w/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435635; x=1690027635;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVyazHtH7BoefuXPN1dGTu12wq0pEkn36JrXNLI8VOI=;
        b=gXgBQZQMoS0mPW8EDPu5BQnNCQoa2LBN1+awmwsAecLzujTgqYXnYsaLKUKvxEK9Bb
         ccffZuqDFPJDlZGc+YXGkG1QWlM/zCd50xPdfJC/fZ2QYXIn4cjx+VOiVG+WiYAAE5Ry
         YBzwrk1br/ZivET2mz7qhZTpp24Q4oBi4g0j8Ms6qVgZh2x7z73HkIVHBCq6bNWh/S86
         DHba7dSMDf9nB8Xs0R6//4u7SWXRJNlDMDKmibZQMy8g/7wB12dWE/AKRnFdq9QNdOuX
         yakSNJB/Nmjr7ZiL9TfnkuIFkflo/QlJKaPwJBlSrxRu1RWaQ5ZIU7zGk5054EmQ2aCR
         Hnlw==
X-Gm-Message-State: AC+VfDy7tTLWY0Gbqs5HYB6HwGNa/VtEbvXPXn2dBMxnuGcRq9KR8TL4
	ZxxSpqHpI2WQZy2TDg4y6LYa7Q==
X-Google-Smtp-Source: ACHHUZ7S1GQemJdnLFiYBFUZIUhH3h7YQa/BixRJmTXLb9eCH5SD3D9Nt03ZOYDxyMx5l21WvdeGgQ==
X-Received: by 2002:a5d:6987:0:b0:310:b979:d00f with SMTP id g7-20020a5d6987000000b00310b979d00fmr17521737wru.45.1687435635515;
        Thu, 22 Jun 2023 05:07:15 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b003111a9a8dbfsm6904351wrm.44.2023.06.22.05.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:07:15 -0700 (PDT)
Message-ID: <00c76c9d-cce8-f3a7-2eda-1c4cc6f36d93@brouer.com>
Date: Thu, 22 Jun 2023 14:07:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC bpf-next v2 05/11] bpf: Implement devtx timestamp kfunc
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-6-sdf@google.com>
From: "Jesper D. Brouer" <netdev@brouer.com>
In-Reply-To: <20230621170244.1283336-6-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21/06/2023 19.02, Stanislav Fomichev wrote:
> Two kfuncs, one per hook point:
> 
> 1. at submit time - bpf_devtx_sb_request_timestamp - to request HW
>     to put TX timestamp into TX completion descriptors
> 
> 2. at completion time - bpf_devtx_cp_timestamp - to read out
>     TX timestamp
> 
[...]
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 08fbd4622ccf..2fdb0731eb67 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
[...]
>   struct xdp_metadata_ops {
>   	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
>   	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
>   			       enum xdp_rss_hash_type *rss_type);
> +	int	(*xmo_sb_request_timestamp)(const struct devtx_frame *ctx);
> +	int	(*xmo_cp_timestamp)(const struct devtx_frame *ctx, u64 *timestamp);
>   };

The "sb" and "cp" abbreviations, what do they stand for?

--Jesper


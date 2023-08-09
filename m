Return-Path: <netdev+bounces-25729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8258F7754B5
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33384281A96
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6763DF;
	Wed,  9 Aug 2023 08:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9863C1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:03:17 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F45DF2
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:03:16 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso10692095e9.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 01:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568195; x=1692172995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zk90bIXL+yyvPk2okzm0tDjIZH3f7c861pF0b2flLdE=;
        b=NOGkHHOWkOn9opRPec/02K4X22gjDY6qfnhfDySa4erMRTkQkAuA+MjHdfNo9yJ2L3
         T+h0U9ro5VB3PcU7oyZbxrzoAC0yZIMdgYJN64HRPXigBqxysCl8wcF3GmNoHrvFouvQ
         44ZI8ZWbRzX9sKgKIwx/twm4BEKhYJfuYpKqrt3u9xgCIRKMXVo+wiQFMLmvBNDRnSQA
         MWMJHeydny490WTeqsR4aH7Bxix6tr8uVPn2VsmqLdWnAbm5zHHAN9W+CRMayVT37aQE
         wmSjEuSjYxMMjFW1Qi4kzQj3rm7exlJW1MP289qydB9G7+CgK4SSf28xyNguuFmT98kc
         Nl/w==
X-Gm-Message-State: AOJu0Yxcvo6SNuH60krPNomNz1GcJc9v61YfBO+qd4ZAOIkLP6h3ba5a
	JzfPRN/GNu46/0f5BSCGhoE=
X-Google-Smtp-Source: AGHT+IEMQHyxAFHpU7dAZZH278FaZvbsBd2+2urgwy5GgK3U2TTQvkV99io+fNVFL/vnz5azBLs3WQ==
X-Received: by 2002:a05:600c:a54:b0:3f7:fb5d:6e7a with SMTP id c20-20020a05600c0a5400b003f7fb5d6e7amr1677124wmq.0.1691568194861;
        Wed, 09 Aug 2023 01:03:14 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b003175f00e555sm15956798wrr.97.2023.08.09.01.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:03:14 -0700 (PDT)
Message-ID: <1f68b7ee-b559-177b-650a-a8683fb86768@grimberg.me>
Date: Wed, 9 Aug 2023 11:03:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 11/26] nvme-tcp: Add modparam to control the ULP
 offload enablement
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-12-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-12-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/12/23 19:14, Aurelien Aptel wrote:
> Add ulp_offload module parameter to the nvme-tcp module to control
> ULP offload at the NVMe-TCP layer.
> 
> Turn ULP offload off be default, regardless of the NIC driver support.
> 
> Overall, in order to enable ULP offload:
> - nvme-tcp ulp_offload modparam must be set to 1
> - netdev->ulp_ddp_caps.active must have ULP_DDP_C_NVME_TCP and/or
>    ULP_DDP_C_NVME_TCP_DDGST_RX capabilities flag set.
> 
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e68e5da3df76..e560bdf3a023 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -49,6 +49,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>   		 "nvme TLS handshake timeout in seconds (default 10)");
>   #endif
>   
> +#ifdef CONFIG_ULP_DDP
> +/* NVMeTCP direct data placement and data digest offload will not
> + * happen if this parameter false (default), regardless of what the
> + * underlying netdev capabilities are.
> + */
> +static bool ulp_offload;
> +module_param(ulp_offload, bool, 0644);
> +MODULE_PARM_DESC(ulp_offload, "Enable or disable NVMeTCP ULP support");

the name is strange.
maybe call it ddp_offload?
and in the description spell it as "direct data placement"

> +#endif
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -350,7 +360,7 @@ static bool nvme_tcp_ddp_query_limits(struct net_device *netdev,
>   static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   						struct nvme_tcp_queue *queue)
>   {
> -	if (!netdev || !queue)
> +	if (!ulp_offload || !netdev || !queue)
>   		return false;
>   
>   	/* If we cannot query the netdev limitations, do not offload */

This patch should be folded to the control path. No reason for it to
stand on its own I think.


Return-Path: <netdev+bounces-51634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD17FB82D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512D4B20C16
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C0AD511;
	Tue, 28 Nov 2023 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB38A270D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:40:14 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-407acb21f27so6039635e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168013; x=1701772813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjJxS7p9+IiDxE6FTR+YE31h+D0ZFJ7s2N4nV3VgPJA=;
        b=sIIVEBOBjecxEpe6D4XY/Adz4sHYD9oyk/pLB9K6poFnh8vpxwzV7Sois4e//BhHXC
         im1vzIfJ3xjrPCJiz75xvC1obDg0pskfVM5+fLxJRDl0k6mKnsGxUP3+aaJiTOkEMoyz
         eaSP/3jgsbiMB7NZbubZdkOSt4+eFe5RUIf9TGtwR1jyFQAV1E6Aa8MzXA9KxY8ABRV8
         FIvF3Z/u/sBa2JAE5jPtHXn6Owm7zDhI+zy3Nk/uTvorePaH6bG1nuwTiRCqRugQ6G3o
         89SSKTfyQZqF3e6LxmIrnlUxsoB7rDu3ur0xPfEgRSOkR/4HtHrN57hI8N6LicfBs2MT
         5KcQ==
X-Gm-Message-State: AOJu0Yw/uFmYvHxcz0u6zdIVq5y6N/GV5StZznMLDqp2k7sIEIxhqm93
	icDirVK+QzXoCA75awxHclz+kRkLxn0=
X-Google-Smtp-Source: AGHT+IG1SegaRk+FvFxzQk6OH1r5/1kqkxH9cQpJkjhv34SFVg1FDEkwJzI7ieHTPkIjT3+f6SDL0Q==
X-Received: by 2002:a05:600c:3b0c:b0:40b:2708:2a52 with SMTP id m12-20020a05600c3b0c00b0040b27082a52mr10198925wms.1.1701168013235;
        Tue, 28 Nov 2023 02:40:13 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id jg28-20020a05600ca01c00b004063cd8105csm17665570wmb.22.2023.11.28.02.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:40:12 -0800 (PST)
Message-ID: <84efdc69-364f-43fc-9c7a-0fbcab47571b@grimberg.me>
Date: Tue, 28 Nov 2023 12:40:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-7-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231122134833.20825-7-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +static void nvme_tcp_complete_request(struct request *rq,
> +				      __le16 status,
> +				      union nvme_result result,
> +				      __u16 command_id)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (req->offloaded) {
> +		req->ddp_status = status;

unless this is really a ddp_status, don't name it as such. afiact
it is the nvme status, so lets stay consistent with the naming.

btw, for making the code simpler we can promote the request
status/result capture out of CONFIG_ULP_DDP to the general logic
and then I think the code will look slightly simpler.

This will be consistent with what we do in nvme-rdma and PI.

> +		req->result = result;
> +		nvme_tcp_teardown_ddp(req->queue, rq);
> +		return;
> +	}
> +#endif
> +
> +	if (!nvme_try_complete_req(rq, status, result))
> +		nvme_complete_rq(rq);
> +}
> +
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> @@ -772,10 +865,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
>   		req->status = cqe->status;
>   
> -	if (!nvme_try_complete_req(rq, req->status, cqe->result))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, req->status, cqe->result,
> +				  cqe->command_id);
>   	queue->nr_cqe++;
> -
>   	return 0;
>   }
>   
> @@ -973,10 +1065,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   {
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   	union nvme_result res = {};
>   
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
> +				  pdu->command_id);
>   }
>   
>   static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> @@ -1283,6 +1378,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	else
>   		msg.msg_flags |= MSG_EOR;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
> +

We keep coming back to this. Why isn't setup done at setup time?


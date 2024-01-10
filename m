Return-Path: <netdev+bounces-62924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D09829E22
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D5C282D85
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFD04C3C3;
	Wed, 10 Jan 2024 16:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2D4B5DE
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33678b10a6eso440208f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 08:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704902515; x=1705507315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1vOkHNh98Rjr6tnyhGCdvbi+xua5GJGrn0Z4bVNhlU=;
        b=uWR0gWRDAjKNTEmkcLAVs02zUAqnO/obm2uLMU8rnNM/eJB+4MZrbW/i8yl6PVd8Nk
         Z95Jru6pvvQ0PZIsJTuBYJO3+9Z5HqEbMXZGVF4/aw9gQc//2JZcburyAPes5dJryfL1
         kGbT9Yo9Mi+Nc1yop8Q7itaDJyqxy/JrWT6LSdpZtlPZQsIwv6wlWRGm6SRgssh9P0Vd
         e4RIoHEnrkHYPAHyTL3XFVOqtLllSH8T3DjeDNQH39fK+0SqxkUjCnJC1qyrxCx+sBsR
         F4tW4fCT6Q6y0gniBQi4L5iQ0vrjCwpcjn/SLxKclu5+wWIsEatWZr8M4FzfPDiKn1vC
         k+4g==
X-Gm-Message-State: AOJu0YxGpURd4QWeBNPm483obvWj1Zyu2ql8+86f16T9QE4qN1RSC9t8
	sF5kkt2PH2OX9/apSlektjM=
X-Google-Smtp-Source: AGHT+IEFa0ye+uF7IJgam5SCh2K9DoNA+o3Nj2eQ/iN4V29rQmqUmFOvWhNwPe8zmm5j+ni4ndayrA==
X-Received: by 2002:a5d:46c9:0:b0:337:39c6:a911 with SMTP id g9-20020a5d46c9000000b0033739c6a911mr1445386wrs.2.1704902515420;
        Wed, 10 Jan 2024 08:01:55 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600004d000b003367ff4aadasm5212422wri.31.2024.01.10.08.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:01:55 -0800 (PST)
Message-ID: <f9e315d1-5876-49da-870b-a073c911df28@grimberg.me>
Date: Wed, 10 Jan 2024 18:01:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 08/20] nvme-tcp: Deal with netdevice DOWN events
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-9-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231221213358.105704-9-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/21/23 23:33, Aurelien Aptel wrote:
> From: Or Gerlitz <ogerlitz@nvidia.com>
> 
> For ddp setup/teardown and resync, the offloading logic
> uses HW resources at the NIC driver such as SQ and CQ.
> 
> These resources are destroyed when the netdevice does down
> and hence we must stop using them before the NIC driver
> destroys them.
> 
> Use netdevice notifier for that matter -- offloaded connections
> are stopped before the stack continues to call the NIC driver
> close ndo.
> 
> We use the existing recovery flow which has the advantage
> of resuming the offload once the connection is re-set.
> 
> This also buys us proper handling for the UNREGISTER event
> b/c our offloading starts in the UP state, and down is always
> there between up to unregister.
> 
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 6eed24b5f90c..00cb1c8404c4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -235,6 +235,7 @@ struct nvme_tcp_ctrl {
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
>   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> +static struct notifier_block nvme_tcp_netdevice_nb;
>   static struct workqueue_struct *nvme_tcp_wq;
>   static const struct blk_mq_ops nvme_tcp_mq_ops;
>   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> @@ -3193,6 +3194,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   	return ERR_PTR(ret);
>   }
>   
> +static int nvme_tcp_netdev_event(struct notifier_block *this,
> +				 unsigned long event, void *ptr)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct nvme_tcp_ctrl *ctrl;
> +
> +	switch (event) {
> +	case NETDEV_GOING_DOWN:
> +		mutex_lock(&nvme_tcp_ctrl_mutex);
> +		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
> +			if (ndev == ctrl->ddp_netdev)
> +				nvme_tcp_error_recovery(&ctrl->ctrl);
> +		}
> +		mutex_unlock(&nvme_tcp_ctrl_mutex);
> +		flush_workqueue(nvme_reset_wq);
> +		/*
> +		 * The associated controllers teardown has completed,
> +		 * ddp contexts were also torn down so we should be
> +		 * safe to continue...
> +		 */
> +	}

Will this handler ever react to another type of event? because
if not, maybe its better to just have:

	if (event != NETDEV_GOING_DOWN)
		return NOTIFY_DONE;

	...

> +#endif
> +	return NOTIFY_DONE;
> +}
> +
>   static struct nvmf_transport_ops nvme_tcp_transport = {
>   	.name		= "tcp",
>   	.module		= THIS_MODULE,
> @@ -3208,6 +3235,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   
>   static int __init nvme_tcp_init_module(void)
>   {
> +	int ret;
> +
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
> @@ -3222,8 +3251,19 @@ static int __init nvme_tcp_init_module(void)
>   	if (!nvme_tcp_wq)
>   		return -ENOMEM;
>   
> +	nvme_tcp_netdevice_nb.notifier_call = nvme_tcp_netdev_event;
> +	ret = register_netdevice_notifier(&nvme_tcp_netdevice_nb);
> +	if (ret) {
> +		pr_err("failed to register netdev notifier\n");
> +		goto out_free_workqueue;
> +	}
> +
>   	nvmf_register_transport(&nvme_tcp_transport);
>   	return 0;
> +
> +out_free_workqueue:
> +	destroy_workqueue(nvme_tcp_wq);
> +	return ret;
>   }
>   
>   static void __exit nvme_tcp_cleanup_module(void)
> @@ -3231,6 +3271,7 @@ static void __exit nvme_tcp_cleanup_module(void)
>   	struct nvme_tcp_ctrl *ctrl;
>   
>   	nvmf_unregister_transport(&nvme_tcp_transport);
> +	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
>   
>   	mutex_lock(&nvme_tcp_ctrl_mutex);
>   	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)


Return-Path: <netdev+bounces-25728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A406677549B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE55281A83
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BF963CF;
	Wed,  9 Aug 2023 08:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19416654
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:00:24 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC8C1736
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:00:23 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99c3ca08c09so197183966b.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 01:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568022; x=1692172822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3sy719J1OdKMCl1tpcdWo2P4o7Y0NWOiudBzFSrvUs=;
        b=aO1IHpBO6CbNkgw5e8VDS/LLEj/3hbKKwPEVUibQA47HBfbBYvJ6wnvUcfkgqlPgt0
         e13tGyDpH4lHtWu9+j8+26oYIPuWBjQLrMfHsW6/LdycJi7sX4SLx/qZ+YYL0sgcVNuc
         9LmquG03BBITnXayhmBLeG0P3y12E39Az6E36aNHcg/ewRvS26yI1G+hvIF9gwy7FkCm
         jnyGJliWuO+AFhpmkvtaywn5k7fJJHpPOXF/FjJKhp4Lo8pZ7cCJyfpYUJOM45oOfY7Z
         GVnUIsrHnM0ajXN7wWzeKT7PeTIR1yl3EqD3YEwBWEGjQPCt43MK3cfY0cVS/+nLY/6X
         exZw==
X-Gm-Message-State: AOJu0YyLjo5G4cmxSa2PkVNZUSif5jV2OOH0jqhv87OsuPH5P2X+wUf8
	qo/eM0bVCIJ7FGrHf4bIxHQ=
X-Google-Smtp-Source: AGHT+IG00dZk5hezrxoS1oGLommC7BmAfwLMSx7C11sYJ98hNFag2T//DFpR2NTawUYpowPgfJ7oWw==
X-Received: by 2002:a17:906:2096:b0:99c:d995:22e8 with SMTP id 22-20020a170906209600b0099cd99522e8mr1229614ejq.7.1691568022095;
        Wed, 09 Aug 2023 01:00:22 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bh10-20020a170906a0ca00b0099bd86f9248sm7606086ejb.63.2023.08.09.01.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:00:21 -0700 (PDT)
Message-ID: <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
Date: Wed, 9 Aug 2023 11:00:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-11-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-11-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/12/23 19:14, Aurelien Aptel wrote:
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
> ---
>   drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index df58668cbad6..e68e5da3df76 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -221,6 +221,7 @@ struct nvme_tcp_ctrl {
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
>   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> +static struct notifier_block nvme_tcp_netdevice_nb;
>   static struct workqueue_struct *nvme_tcp_wq;
>   static const struct blk_mq_ops nvme_tcp_mq_ops;
>   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> @@ -3234,6 +3235,30 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   	return ERR_PTR(ret);
>   }
>   
> +static int nvme_tcp_netdev_event(struct notifier_block *this,
> +				 unsigned long event, void *ptr)
> +{
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct nvme_tcp_ctrl *ctrl;
> +
> +	switch (event) {
> +	case NETDEV_GOING_DOWN:
> +		mutex_lock(&nvme_tcp_ctrl_mutex);
> +		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
> +			if (ndev == ctrl->offloading_netdev)
> +				nvme_tcp_error_recovery(&ctrl->ctrl);
> +		}
> +		mutex_unlock(&nvme_tcp_ctrl_mutex);
> +		flush_workqueue(nvme_reset_wq);

In what context is this called? because every time we flush a workqueue,
lockdep finds another reason to complain about something...

Otherwise looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


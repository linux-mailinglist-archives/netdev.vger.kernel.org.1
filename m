Return-Path: <netdev+bounces-78296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA7874A51
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C524628402F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08658286B;
	Thu,  7 Mar 2024 09:06:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660B1C2A3
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802372; cv=none; b=gjgL/cGMfOoeYYkfDyg6DOBG3sfNYCtgwCCSr8Rt4aoNlxB8xvzhKpMyx4poSPeB3l1Q7V1R70je6uBAyDlrUPt56QncoXvldXIte3DKKfv0CJW4a0tXYlS7cw3rqT/1EX5Dqkkja2kz7hxtjTFYCTZEs9Zq7CEmfkCNn/aXfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802372; c=relaxed/simple;
	bh=yUew/qb4mUig4oj3boqDdf61ioiXV/OMzK65Gg6d5uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LL7zJIG+wCS+BamYWLFNVTNq5iK586vU7Mk1l5/EG8q/zQNwZAJ4Muxmel3Bs0nUc9yDfB6/5/gPBjAAmy2OUUQNg4VTJmW9ovh4nPPCcPTCFBGjUAHYVuS9E+I7wyMmiukIHa2GQq0LiqxKq4IVFcomHs4rM38BiY9AosJF94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412db7067d6so199565e9.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802368; x=1710407168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgYfVgOpRakmgUe9/iU4ILHam4T4hPedg6c4zAI4xok=;
        b=Mgv8BECA6TaoFivgh7cY2Qh3ojQpTODwkS/iWjgW+Q0HODHaf3qAPJ93kqhl2IYn7U
         tiTbTOPblQ9CIfP60nVK1FBfMUchXcDKcUI0P3OziN+/ULlXj11JOrGoJL6EKM1zWSet
         gTt+ZtvyBpQ7hOpiRBfgSM9vBgFeAAEUWuDNg/xwKWsziYyuIrnAx6+LprFNdgPQSuzh
         50mpf4yOS0c36vrfDyqxf7BYwt+FFqFGr/C/M65QICbHL7L1XD2yHLZX0LeCci7BEjTD
         2fbtHf6uIAVmWpquLUaonwQYUOXnIMLR4SxakKyp67PSeKjDOo65OFTyymiAgDq7c9oH
         UqPw==
X-Forwarded-Encrypted: i=1; AJvYcCWKjSVtT7qzanKSzWJWnDzdkvBPWpHOsk9D2dccYbBqIB7wIJotW7W7Szctj0u0t+/Mqgs7PLwgvtsH3YCoWR394Jvyx7h7
X-Gm-Message-State: AOJu0Yy0pZs2wy95WRU5tXXunLgQpbdmRMcicZXMwOiqTJEF1Wtpbym2
	EDZ9FOVqP9WH9Vzqgw18+b+JA3CoTPjKre+/LZMjd4MJVZ89ibys
X-Google-Smtp-Source: AGHT+IFtJqLvalk9v/pTaHywkcMmtVbpUnBLl0Ku69akFKD0SmUZDejD8BhBEHkPoMAXfynt5O+qAA==
X-Received: by 2002:a05:600c:1d0f:b0:412:f82b:9cb8 with SMTP id l15-20020a05600c1d0f00b00412f82b9cb8mr968091wms.4.1709802367973;
        Thu, 07 Mar 2024 01:06:07 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id hn37-20020a05600ca3a500b00412f478a90bsm1897096wmb.48.2024.03.07.01.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:06:07 -0800 (PST)
Message-ID: <7a2c3491-bd2a-4104-8371-f5b98bbd7355@grimberg.me>
Date: Thu, 7 Mar 2024 11:06:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 brauner@kernel.org
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240228125733.299384-6-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240228125733.299384-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/2024 14:57, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
>
> This commit introduces direct data placement offload to NVME
> TCP. There is a context per queue, which is established after the
> handshake using the sk_add/del NDOs.
>
> Additionally, a resynchronization routine is used to assist
> hardware recovery from TCP OOO, and continue the offload.
> Resynchronization operates as follows:
>
> 1. TCP OOO causes the NIC HW to stop the offload
>
> 2. NIC HW identifies a PDU header at some TCP sequence number,
> and asks NVMe-TCP to confirm it.
> This request is delivered from the NIC driver to NVMe-TCP by first
> finding the socket for the packet that triggered the request, and
> then finding the nvme_tcp_queue that is used by this routine.
> Finally, the request is recorded in the nvme_tcp_queue.
>
> 3. When NVMe-TCP observes the requested TCP sequence, it will compare
> it with the PDU header TCP sequence, and report the result to the
> NIC driver (resync), which will update the HW, and resume offload
> when all is successful.
>
> Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
> for queue of size N) where the linux nvme driver uses part of the 16
> bit CCID for generation counter. To address that, we use the existing
> quirk in the nvme layer when the HW driver advertises if the device is
> not supports the full 16 bit CCID range.
>
> Furthermore, we let the offloading driver advertise what is the max hw
> sectors/segments via ulp_ddp_limits.
>
> A follow-up patch introduces the data-path changes required for this
> offload.
>
> Socket operations need a netdev reference. This reference is
> dropped on NETDEV_GOING_DOWN events to allow the device to go down in
> a follow-up patch.
>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 265 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 252 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a6d596e05602..86a9ad9f679b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -21,6 +21,10 @@
>   #include <net/busy_poll.h>
>   #include <trace/events/sock.h>
>   
> +#ifdef CONFIG_ULP_DDP
> +#include <net/ulp_ddp.h>
> +#endif
> +
>   #include "nvme.h"
>   #include "fabrics.h"
>   
> @@ -46,6 +50,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>   		 "nvme TLS handshake timeout in seconds (default 10)");
>   #endif
>   
> +#ifdef CONFIG_ULP_DDP
> +/* NVMeTCP direct data placement and data digest offload will not
> + * happen if this parameter false (default), regardless of what the
> + * underlying netdev capabilities are.
> + */
> +static bool ddp_offload;
> +module_param(ddp_offload, bool, 0644);
> +MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
> +#endif
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -119,6 +133,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFF_DDP	= 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -146,6 +161,18 @@ struct nvme_tcp_queue {
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
>   
> +#ifdef CONFIG_ULP_DDP
> +	/*
> +	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
> +	 * an additional flag in the lower 32 bits) that the HW send to
> +	 * the SW, for the SW to verify.
> +	 * - The 32 high bits store the seq number
> +	 * - The 32 low bits are used as a flag to know if a request
> +	 *   is pending (ULP_DDP_RESYNC_PENDING).
> +	 */
> +	atomic64_t		resync_tcp_seq;
> +#endif
> +
>   	/* send state */
>   	struct nvme_tcp_request *request;
>   
> @@ -186,6 +213,13 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +
> +	struct net_device	*ddp_netdev;
> +	netdevice_tracker	netdev_tracker;
> +	u32			ddp_threshold;
> +#ifdef CONFIG_ULP_DDP
> +	struct ulp_ddp_limits	ddp_limits;
> +#endif
>   };
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
> @@ -297,6 +331,171 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#ifdef CONFIG_ULP_DDP
> +
> +static struct net_device *
> +nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
> +{
> +	struct net_device *netdev;
> +	int ret;
> +
> +	if (!ddp_offload)
> +		return NULL;
> +
> +	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
> +	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk, &ctrl->netdev_tracker, GFP_KERNEL);
> +	if (!netdev) {
> +		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
> +		return NULL;
> +	}
> +
> +	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
> +		goto err;
> +
> +	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
> +	if (ret)
> +		goto err;
> +
> +	if (ctrl->ctrl.opts->tls && !ctrl->ddp_limits.tls)
> +		goto err;
> +
> +	return netdev;
> +err:
> +	netdev_put(netdev, &ctrl->netdev_tracker);
> +	return NULL;
> +}
> +
> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> +	.resync_request		= nvme_tcp_resync_request,
> +};
> +
> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	int ret;
> +
> +	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
> +	config.nvmeotcp.cpda = 0;
> +	config.nvmeotcp.dgst =
> +		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.dgst |=
> +		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
> +	config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);

I forget, why is the queue_id needed? it does not travel the wire outside
of the connect cmd.

> +
> +	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
> +			     queue->sock->sk,
> +			     &config,
> +			     &nvme_tcp_ddp_ulp_ops);
> +	if (ret)
> +		return ret;
> +
> +	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +
> +	return 0;
> +}
> +
> +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{
> +	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
> +}
> +
> +static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
> +{
> +	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
> +	ctrl->ctrl.max_hw_sectors =
> +		ctrl->ddp_limits.max_ddp_sgl_len << (ilog2(SZ_4K) - SECTOR_SHIFT);

I think you can use NVME_CTRL_PAGE_SHIFT instead of ilog2(SZ_4K)?

The rest looks fine to me.


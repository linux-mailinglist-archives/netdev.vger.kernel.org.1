Return-Path: <netdev+bounces-33243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 294AD79D202
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E9628100B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842918048;
	Tue, 12 Sep 2023 13:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76248F60
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:24:53 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B974410CE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:24:52 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2be4d132654so20394381fa.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525091; x=1695129891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VntrwCUMkXJA9F3I2MFqhyP+yrcYH7KPVjh0eZzdVEc=;
        b=T4LIwDR44se3Od5DJG6Gkmq3iY1IaepLi6AsuK25lLGVw32gTmYKpLzTUtkBk2TNJT
         oE6GO3Ct7v1cD4cH/a1jXTq6q0PKdfvnyXtavNG8nevqlnM3JP9WNUXidJFA+qr+Hh18
         NEHb8p8toNTuGXLogyBqpl53IHLKn4cDKatIZly8WWkSHgo54ARzLRseYMEUd0rTw0w4
         1fNs2DzQb/7BDhUayUtMz3Lhi1YdUsc2URQ7ngIGlISNnwwUND8KHMr1SJq+SyTy6Wxu
         8W0vN74q6x683Dc9ZGKGeD5h2a3mJH56qmX08gSgwtZzCe7QPb3iHImwtFxYYFsb6Rzu
         1jDw==
X-Gm-Message-State: AOJu0YwCWs0lQXXBvPPw/VkOnt691dcAoN14CZlFoLju1mFgsEpj0ktF
	ApXefPPv0XVKw6NjXwYRfMgDHp8S89o=
X-Google-Smtp-Source: AGHT+IHPhbvSOeGC1XPyRSOo70lZadF9558vDx5hUXoBzirLccARRsOUYpNNbQwXIUa7VaeMd7+xaw==
X-Received: by 2002:a2e:390b:0:b0:2b9:e10b:a511 with SMTP id g11-20020a2e390b000000b002b9e10ba511mr6839657lja.0.1694525090558;
        Tue, 12 Sep 2023 06:24:50 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id lj16-20020a170906f9d000b00992d0de8762sm6832503ejb.216.2023.09.12.06.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:24:49 -0700 (PDT)
Message-ID: <db2cbdc2-2a6d-a632-3584-6aeafc5738e2@grimberg.me>
Date: Tue, 12 Sep 2023 16:24:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-6-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230912095949.5474-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/23 12:59, Aurelien Aptel wrote:
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
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 226 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 217 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 5b332d9f87fc..f8322a07e27e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -16,6 +16,10 @@
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
> @@ -31,6 +35,16 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
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
> @@ -104,6 +118,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFF_DDP	= 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -131,6 +146,18 @@ struct nvme_tcp_queue {
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
>   
> +#ifdef CONFIG_ULP_DDP
> +	/*
> +	 * resync_req is a speculative PDU header tcp seq number (with
> +	 * an additional flag at 32 lower bits) that the HW send to
> +	 * the SW, for the SW to verify.
> +	 * - The 32 high bits store the seq number
> +	 * - The 32 low bits are used as a flag to know if a request
> +	 *   is pending (ULP_DDP_RESYNC_PENDING).
> +	 */
> +	atomic64_t		resync_req;
> +#endif
> +
>   	/* send state */
>   	struct nvme_tcp_request *request;
>   
> @@ -170,6 +197,12 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +
> +#ifdef CONFIG_ULP_DDP
> +	struct net_device	*ddp_netdev;
> +	u32			ddp_threshold;
> +	struct ulp_ddp_limits	ddp_limits;
> +#endif
>   };
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
> @@ -273,6 +306,136 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#ifdef CONFIG_ULP_DDP
> +
> +static bool nvme_tcp_ddp_query_limits(struct nvme_tcp_ctrl *ctrl)
> +{
> +	return ddp_offload &&
> +		ulp_ddp_query_limits(ctrl->ddp_netdev,
> +				     &ctrl->ddp_limits,
> +				     ULP_DDP_NVME,
> +				     ULP_DDP_C_NVME_TCP_BIT,
> +				     false /* tls */);
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
> +	config.nvmeotcp.io_cpu = queue->sock->sk->sk_incoming_cpu;
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
> +	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
> +
> +	/* offloading HW doesn't support full ccid range, apply the quirk */
> +	ctrl->ctrl.quirks |=
> +		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
> +}
> +
> +/* In presence of packet drops or network packet reordering, the device may lose
> + * synchronization between the TCP stream and the L5P framing, and require a
> + * resync with the kernel's TCP stack.
> + *
> + * - NIC HW identifies a PDU header at some TCP sequence number,
> + *   and asks NVMe-TCP to confirm it.
> + * - When NVMe-TCP observes the requested TCP sequence, it will compare
> + *   it with the PDU header TCP sequence, and report the result to the
> + *   NIC driver
> + */
> +static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> +				     struct sk_buff *skb, unsigned int offset)
> +{
> +	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
> +	struct net_device *netdev = queue->ctrl->ddp_netdev;
> +	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
> +	u64 resync_val;
> +	u32 resync_seq;
> +
> +	resync_val = atomic64_read(&queue->resync_req);
> +	/* Lower 32 bit flags. Check validity of the request */
> +	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
> +		return;
> +
> +	/*
> +	 * Obtain and check requested sequence number: is this PDU header
> +	 * before the request?
> +	 */
> +	resync_seq = resync_val >> 32;
> +	if (before(pdu_seq, resync_seq))
> +		return;
> +
> +	/*
> +	 * The atomic operation guarantees that we don't miss any NIC driver
> +	 * resync requests submitted after the above checks.
> +	 */
> +	if (atomic64_cmpxchg(&queue->resync_req, pdu_val,
> +			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
> +			     atomic64_read(&queue->resync_req))
> +		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
> +}
> +
> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
> +{
> +	struct nvme_tcp_queue *queue = sk->sk_user_data;
> +
> +	/*
> +	 * "seq" (TCP seq number) is what the HW assumes is the
> +	 * beginning of a PDU.  The nvme-tcp layer needs to store the
> +	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
> +	 * indicate that a request is pending.
> +	 */
> +	atomic64_set(&queue->resync_req, (((uint64_t)seq << 32) | flags));
> +
> +	return true;
> +}
> +
> +#else
> +
> +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{}
> +
> +static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> +				     struct sk_buff *skb, unsigned int offset)
> +{}
> +
> +#endif
> +
>   static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>   		unsigned int dir)
>   {
> @@ -715,6 +878,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_resync_response(queue, skb, *offset);
> +
>   	ret = skb_copy_bits(skb, *offset,
>   		&pdu[queue->pdu_offset], rcv_len);
>   	if (unlikely(ret))
> @@ -1665,6 +1831,15 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	nvme_tcp_restore_sock_ops(queue);
>   	cancel_work_sync(&queue->io_work);
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_unoffload_socket(queue);
> +#ifdef CONFIG_ULP_DDP
> +	if (nvme_tcp_admin_queue(queue) && queue->ctrl->ddp_netdev) {
> +		/* put back ref from get_netdev_for_sock() */
> +		dev_put(queue->ctrl->ddp_netdev);
> +		queue->ctrl->ddp_netdev = NULL;
> +	}
> +#endif

Lets avoid spraying these ifdefs in the code.
the ddp_netdev struct member can be lifted out of the ifdef I think
because its only controller-wide.

>   }
>   
>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> @@ -1707,19 +1882,52 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   	nvme_tcp_init_recv_ctx(queue);
>   	nvme_tcp_setup_sock_ops(queue);
>   
> -	if (idx)
> +	if (idx) {
>   		ret = nvmf_connect_io_queue(nctrl, idx);
> -	else
> +		if (ret)
> +			goto err;
> +
> +#ifdef CONFIG_ULP_DDP
> +		if (ctrl->ddp_netdev) {
> +			ret = nvme_tcp_offload_socket(queue);
> +			if (ret) {
> +				dev_info(nctrl->device,
> +					 "failed to setup offload on queue %d ret=%d\n",
> +					 idx, ret);
> +			}
> +		}
> +#endif
> +	} else {
>   		ret = nvmf_connect_admin_queue(nctrl);
> +		if (ret)
> +			goto err;
>   
> -	if (!ret) {
> -		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
> -	} else {
> -		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> -			__nvme_tcp_stop_queue(queue);
> -		dev_err(nctrl->device,
> -			"failed to connect queue: %d ret=%d\n", idx, ret);
> +#ifdef CONFIG_ULP_DDP
> +		/*
> +		 * Admin queue takes a netdev ref here, and puts it
> +		 * when the queue is stopped in __nvme_tcp_stop_queue().
> +		 */
> +		ctrl->ddp_netdev = get_netdev_for_sock(queue->sock->sk);
> +		if (ctrl->ddp_netdev) {
> +			if (nvme_tcp_ddp_query_limits(ctrl)) {
> +				nvme_tcp_ddp_apply_limits(ctrl);
> +			} else {
> +				dev_put(ctrl->ddp_netdev);
> +				ctrl->ddp_netdev = NULL;
> +			}
> +		} else {
> +			dev_info(nctrl->device, "netdev not found\n");

Would prefer to not print offload specific messages in non-offload code
paths. at best, dev_dbg.

If the netdev is derived by the sk, why does the interface need a netdev
at all? why not just pass sk and derive the netdev from the sk behind
the interface?

Or is there a case that I'm not seeing here?


Return-Path: <netdev+bounces-25713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4667753C2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27CC1C21130
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6AB6107;
	Wed,  9 Aug 2023 07:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E1525F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:13:09 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8C1BFF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:13:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b70357ca12so21624081fa.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 00:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691565186; x=1692169986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf7QihKD+H420gS0JLfiYSlcEPf5+xxtpLYLKldkCwo=;
        b=dA8CS5atFO0ts+Y7+4isW4pY5olJ/loD7/mVAGgl68FVN4wt1Uz01WXydzjdlcV4sI
         gi3FLXYBQ9ctbO31t9UpHWHPmwwIF9EQ5ZZ2c+zalAnmXCmfGVJs7HpxVAQRlhN+jvHa
         G1npamyN71+v4GsNmfTRA6z4N2ELxqLvyDPxm+cjdz+1eEhaf3JcL8w/ddTuBFu1fmfK
         mMxzKFvQab7V4o/m+iqWh5dmL43hIJPrNRe+LRwFdMXmPfN94u30W6b/N/mbjIDMsvMO
         Ld1JTDkDNfb2yFRNyWMG9TC2lmAbw/kAfiuvyHFft3bzSa+ikXE3vd+ce4Vnd6WL1exM
         l5cg==
X-Gm-Message-State: AOJu0YzxxZe3nfnxhtkehMuJdQrm+2L3SL5sZARfTriD7/NgGYKYVP9B
	AS8oHW9wj2eYimZHyKTj9Yw=
X-Google-Smtp-Source: AGHT+IGGak25eU3tIK6vPcmTpAKLfhDG/zggLxSZ1CXacnnm7YGmygMnQWKZSG5Kyr/274MK+437pg==
X-Received: by 2002:a2e:8e31:0:b0:2b9:e10b:a511 with SMTP id r17-20020a2e8e31000000b002b9e10ba511mr963851ljk.0.1691565185648;
        Wed, 09 Aug 2023 00:13:05 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b003fe0bb31a6asm1012980wmm.43.2023.08.09.00.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:13:04 -0700 (PDT)
Message-ID: <fa07042c-3d13-78cd-3bec-b1e743dc347d@grimberg.me>
Date: Wed, 9 Aug 2023 10:13:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-8-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hey,

Sorry for the late review on this, I've been struggling with
prioritizing this due to lack of time.

I'll most likely review in batches.

On 7/12/23 19:14, Aurelien Aptel wrote:
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
>   drivers/nvme/host/tcp.c | 272 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 263 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4a8b32bd5257..7d3b0ac65c03 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -20,6 +20,10 @@
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
> @@ -118,6 +122,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFF_DDP	= 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -145,6 +150,19 @@ struct nvme_tcp_queue {
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
> +	struct ulp_ddp_limits	ddp_limits;
> +#endif
> +
>   	/* send state */
>   	struct nvme_tcp_request *request;
>   
> @@ -187,6 +205,9 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +
> +	struct net_device	*offloading_netdev;
> +	u32			offload_io_threshold;

ddp_netdev
ddp_io_threashold

>   };
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
> @@ -290,6 +311,204 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#ifdef CONFIG_ULP_DDP
> +
> +static bool nvme_tcp_ddp_query_limits(struct net_device *netdev,
> +				      struct nvme_tcp_queue *queue)
> +{
> +	int ret;
> +
> +	if (!netdev->netdev_ops->ulp_ddp_ops->limits)
> +		return false;

Can we expose all of these ops in wrappers ala:

netdev_ulp_ddp_limits(netdev, &limits)
netdev_ulp_ddp_sk_add(netdev, sk, &nvme_tcp_ddp_ulp_ops)
netdev_ulp_ddp_sk_del(netdev, sk)
netdev_ulp_ddp_resync(netdev, skb, seq)

etc...

> +
> +	queue->ddp_limits.type = ULP_DDP_NVME;
> +	ret = netdev->netdev_ops->ulp_ddp_ops->limits(netdev, &queue->ddp_limits);
> +	if (ret == -EOPNOTSUPP) {
> +		return false;
> +	} else if (ret) {
> +		WARN_ONCE(ret, "ddp limits failed (ret=%d)", ret);
> +		return false;
> +	}
> +
> +	dev_dbg_ratelimited(queue->ctrl->ctrl.device,
> +			    "netdev %s offload limits: max_ddp_sgl_len %d\n",
> +			    netdev->name, queue->ddp_limits.max_ddp_sgl_len);
> +
> +	return true;
> +}
> +
> +static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
> +						struct nvme_tcp_queue *queue)
> +{
> +	if (!netdev || !queue)
> +		return false;

Is it reasonable to be called here with !netdev or !queue ?

> +
> +	/* If we cannot query the netdev limitations, do not offload */
> +	if (!nvme_tcp_ddp_query_limits(netdev, queue))
> +		return false;
> +
> +	/* If netdev supports nvme-tcp ddp offload, we can offload */
> +	if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
> +		return true;

This should be coming from the API itself, have the limits query
api fail if this is off.

btw, what is the active thing? is this driven from ethtool enable?
what happens if the user disables it while there is a ulp using it?

> +
> +	return false;

This can be folded to the above function.

> +}
> +
> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> +	.resync_request		= nvme_tcp_resync_request,
> +};
> +
> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	int ret;
> +
> +	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;

Question, what happens if the pfv changes, is the ddp guaranteed to
work?

> +	config.nvmeotcp.cpda = 0;
> +	config.nvmeotcp.dgst =
> +		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.dgst |=
> +		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
> +	config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
> +	config.nvmeotcp.io_cpu = queue->io_cpu;
> +
> +	/* Socket ops keep a netdev reference. It is put in
> +	 * nvme_tcp_unoffload_socket().  This ref is dropped on
> +	 * NETDEV_GOING_DOWN events to allow the device to go down
> +	 */
> +	dev_hold(netdev);
> +	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev,
> +						      queue->sock->sk,
> +						      &config);

It would be preferred if dev_hold would be taken in sk_add
and released in sk_del so that the ulp does not need to worry
acount it.

> +	if (ret) {
> +		dev_put(netdev);
> +		return ret;
> +	}
> +
> +	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;

can also be folded inside an api.

> +	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	return 0;
> +}
> +
> +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +
> +	if (!netdev) {
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
> +		return;
> +	}

Again, is it reasonable to be called here with !netdev?

> +
> +	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +
> +	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, queue->sock->sk);
> +
> +	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
> +	dev_put(netdev); /* held by offload_socket */

Both can be done by the api instead of the ulp itself.

> +}
> +
> +static void nvme_tcp_offload_apply_limits(struct nvme_tcp_queue *queue,
> +					  struct net_device *netdev)
> +{
> +	queue->ctrl->offloading_netdev = netdev;
> +	queue->ctrl->ctrl.max_segments = queue->ddp_limits.max_ddp_sgl_len;
> +	queue->ctrl->ctrl.max_hw_sectors =
> +		queue->ddp_limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);

this is SECTOR_SHIFT?

> +	queue->ctrl->offload_io_threshold = queue->ddp_limits.io_threshold;
> +
> +	/* offloading HW doesn't support full ccid range, apply the quirk */
> +	queue->ctrl->ctrl.quirks |=
> +		queue->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
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
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
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
> +		netdev->netdev_ops->ulp_ddp_ops->resync(netdev,
> +							queue->sock->sk,
> +							pdu_seq);

Who else is doing an atomic on this value? and what happens
if the cmpxchg fails?

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

Question, is this coming from multiple contexts? what contexts are
competing here that make it an atomic operation? It is unclear what is
going on here tbh.

> +
> +	return true;
> +}
> +
> +#else
> +
> +static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
> +						struct nvme_tcp_queue *queue)
> +{
> +	return false;
> +}
> +
> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{}
> +
> +static void nvme_tcp_offload_apply_limits(struct nvme_tcp_queue *queue,
> +					  struct net_device *netdev)
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
> @@ -732,6 +951,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_resync_response(queue, skb, *offset);
> +
>   	ret = skb_copy_bits(skb, *offset,
>   		&pdu[queue->pdu_offset], rcv_len);
>   	if (unlikely(ret))
> @@ -1795,6 +2017,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	nvme_tcp_restore_sock_ops(queue);
>   	cancel_work_sync(&queue->io_work);
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_unoffload_socket(queue);
>   }
>   
>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> @@ -1831,25 +2055,55 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[idx];
> +	struct net_device *netdev;
>   	int ret;
>   
>   	queue->rd_enabled = true;
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
> +		netdev = queue->ctrl->offloading_netdev;
> +		if (is_netdev_ulp_offload_active(netdev, queue)) {

Seems redundant to pass netdev as an argument here.

> +			ret = nvme_tcp_offload_socket(queue);
> +			if (ret) {
> +				dev_info(nctrl->device,
> +					 "failed to setup offload on queue %d ret=%d\n",
> +					 idx, ret);
> +			}
> +		}
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
> +		netdev = get_netdev_for_sock(queue->sock->sk);

Is there any chance that this is a different netdev than what is
already recorded? doesn't make sense to me.

> +		if (!netdev) {
> +			dev_info_ratelimited(ctrl->ctrl.device, "netdev not found\n");
> +			ctrl->offloading_netdev = NULL;
> +			goto done;
> +		}
> +		if (is_netdev_ulp_offload_active(netdev, queue))
> +			nvme_tcp_offload_apply_limits(queue, netdev);
> +		/*
> +		 * release the device as no offload context is
> +		 * established yet.
> +		 */
> +		dev_put(netdev);

the put is unclear, what does it pair with? the get_netdev_for_sock?

>   	}
> +
> +done:
> +	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
> +	return 0;
> +err:
> +	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> +		__nvme_tcp_stop_queue(queue);
> +	dev_err(nctrl->device,
> +		"failed to connect queue: %d ret=%d\n", idx, ret);
>   	return ret;
>   }
>   


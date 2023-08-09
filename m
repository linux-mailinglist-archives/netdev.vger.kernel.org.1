Return-Path: <netdev+bounces-25727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C4775497
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62462819E8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1463C7;
	Wed,  9 Aug 2023 07:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652B63C1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:59:17 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46831736
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:59:15 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b9b6c57c94so20141791fa.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 00:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691567954; x=1692172754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n8/6w7yhql79Lt1EY1uSKvblBxD8K1x2ezScZOM+lc=;
        b=cPwUiMBQVcr/91YdyLynYb2B/B/Z04M/JMgnNRX7zls9RdHkVa5wmKe2BrwdI6/vOm
         OdpDXYfPwoRKpms1ChcLCxHyD8kKNqHQ9TFp6IZH04joH6TowfoKPYGgY73k8VblsgoC
         JszLv6y34+MfbifhVHQqUcV2+Zqy4SYcPJwurJ6tWtJ0GBEy9QP3yQb5OKad97Srde3b
         Mf1TdKnryFQA39hPpqDv2r5rH2Jn5dQeottRFOJLqgLcns5xWC4cFBPVGpDJ14msab8R
         nQq0ZXcNsq8FLEDXC0KSeYCq/JscvIMnwuX6RRlRAuNIp7IQYOESqcPqsX50HDbMaMFS
         Bw7w==
X-Gm-Message-State: AOJu0YwwR81HPl6wtz14hDNokqwL8wwHyXMvPnKN4UCulFYdb5Cj9K5E
	t07FCHTGasvhcS9rexGQVpg=
X-Google-Smtp-Source: AGHT+IHX9MdDgYZ/P3MqcMC4IJ3QItCoeNGeGhTKAzymUrtzwvr890CzYwmE/X8qCOrmaiSs+eZXEQ==
X-Received: by 2002:a05:651c:c8a:b0:2b6:cd7f:5ea8 with SMTP id bz10-20020a05651c0c8a00b002b6cd7f5ea8mr1388775ljb.1.1691567953660;
        Wed, 09 Aug 2023 00:59:13 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709067b8c00b00992b50fbbe9sm7691220ejo.90.2023.08.09.00.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:59:13 -0700 (PDT)
Message-ID: <2a75b296-edff-3151-7c6e-22209f09a100@grimberg.me>
Date: Wed, 9 Aug 2023 10:59:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 09/26] nvme-tcp: RX DDGST offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-10-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-10-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/12/23 19:14, Aurelien Aptel wrote:
> From: Yoray Zack <yorayz@nvidia.com>
> 
> Enable rx side of DDGST offload when supported.
> 
> At the end of the capsule, check if all the skb bits are on, and if not
> recalculate the DDGST in SW and check it.
> 
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 120 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 112 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 6057cd424a19..df58668cbad6 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -130,6 +130,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_OFF_DDP	= 3,
> +	NVME_TCP_Q_OFF_DDGST_RX = 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -168,6 +169,7 @@ struct nvme_tcp_queue {
>   	 */
>   	atomic64_t		resync_req;
>   	struct ulp_ddp_limits	ddp_limits;
> +	bool			ddp_ddgst_valid;
>   #endif
>   
>   	/* send state */
> @@ -358,9 +360,29 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   	if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
>   		return true;
>   
> +	/*
> +	 * Otherwise, if netdev supports nvme-tcp ddgst offload and it
> +	 * was enabled, we can offload
> +	 */
> +	if (queue->data_digest && test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
> +					   netdev->ulp_ddp_caps.active))
> +		return true;
> +
>   	return false;
>   }
>   
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
> +{
> +	return queue->ddp_ddgst_valid;
> +}
> +
> +static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
> +					     struct sk_buff *skb)
> +{
> +	if (queue->ddp_ddgst_valid)
> +		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
> +}
> +
>   static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request *rq)
>   {
>   	int ret;
> @@ -375,6 +397,38 @@ static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request
>   	return 0;
>   }
>   
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{
> +	struct nvme_tcp_request *req;
> +
> +	if (!rq)
> +		return;
> +
> +	req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!req->offloaded) {
> +		/* if we have DDGST_RX offload without DDP the request
> +		 * wasn't mapped, so we need to map it here
> +		 */
> +		if (nvme_tcp_req_map_ddp_sg(req, rq))
> +			return;

grr.. wondering if this is something we want to support (crc without
ddp).

> +	}
> +
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;

Why is this assignment needed? why not pass req->ddp.first_sgl ?

> +	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
> +				req->data_len);
> +	crypto_ahash_digest(hash);
> +
> +	if (!req->offloaded) {
> +		/* without DDP, ddp_teardown() won't be called, so
> +		 * free the table here
> +		 */
> +		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +	}
> +}
> +
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
>   static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> @@ -434,6 +488,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
>   	struct net_device *netdev = queue->ctrl->offloading_netdev;
>   	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	bool offload_ddp = test_bit(ULP_DDP_C_NVME_TCP_BIT,
> +				    netdev->ulp_ddp_caps.active);
> +	bool offload_ddgst_rx = test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
> +					 netdev->ulp_ddp_caps.active);
>   	int ret;
>   
>   	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
> @@ -460,7 +518,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   	}
>   
>   	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
> -	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	if (offload_ddp)
> +		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	if (queue->data_digest && offload_ddgst_rx)
> +		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   	return 0;
>   }
>   
> @@ -474,6 +535,7 @@ static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>   	}
>   
>   	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   
>   	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, queue->sock->sk);
>   
> @@ -562,6 +624,20 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   	return false;
>   }
>   
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
> +{
> +	return false;
> +}
> +
> +static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
> +					     struct sk_buff *skb)
> +{}
> +
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{}
> +
>   static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue, u16 command_id,
>   			      struct request *rq)
>   {
> @@ -844,6 +920,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->pdu_offset = 0;
>   	queue->data_remaining = -1;
>   	queue->ddgst_remaining = 0;
> +#ifdef CONFIG_ULP_DDP
> +	queue->ddp_ddgst_valid = true;
> +#endif
>   }
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> @@ -1047,7 +1126,8 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>   	int ret;
>   
> -	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))

This now becomes two atomic bitops to check for each capability, where
its more likely that neighther are on...

Is this really racing with anything? maybe just check with bitwise AND?
or a local variable (or struct member)
I don't think that we should add any more overhead for the normal path
than we already have.

>   		nvme_tcp_resync_response(queue, skb, *offset);
>   
>   	ret = skb_copy_bits(skb, *offset,
> @@ -1111,6 +1191,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
> +	if (queue->data_digest &&
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))

And a third atomic bitop..

> +		nvme_tcp_ddp_ddgst_update(queue, skb);
> +
>   	while (true) {
>   		int recv_len, ret;
>   
> @@ -1139,7 +1223,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		recv_len = min_t(size_t, recv_len,
>   				iov_iter_count(&req->iter));
>   
> -		if (queue->data_digest)
> +		if (queue->data_digest &&
> +		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))

and a 4'th atomic bitop...

>   			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
>   				&req->iter, recv_len, queue->rcv_hash);
>   		else
> @@ -1181,8 +1266,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	struct request *rq;
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);

and a 5'th atomic bitop...

>   	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
>   	if (unlikely(ret))
>   		return ret;
> @@ -1193,9 +1281,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	if (queue->ddgst_remaining)
>   		return 0;
>   
> +	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> +			    pdu->command_id);
> +
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {

and a 6'th... ok this is just spraying atomic bitops on the data
path. Please find a better solution to this.

> +		/*
> +		 * If HW successfully offloaded the digest
> +		 * verification, we can skip it
> +		 */
> +		if (nvme_tcp_ddp_ddgst_ok(queue))
> +			goto out;
> +		/*
> +		 * Otherwise we have to recalculate and verify the
> +		 * digest with the software-fallback
> +		 */
> +		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
> +					  &queue->exp_ddgst);
> +	}
> +
>   	if (queue->recv_ddgst != queue->exp_ddgst) {
> -		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> -					pdu->command_id);
>   		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
>   		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
> @@ -1206,9 +1310,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   			le32_to_cpu(queue->exp_ddgst));
>   	}
>   
> +out:
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> -		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> -					pdu->command_id);
>   		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
>   		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
> @@ -2125,7 +2228,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	nvme_tcp_restore_sock_ops(queue);
>   	cancel_work_sync(&queue->io_work);
> -	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   		nvme_tcp_unoffload_socket(queue);
>   }
>   


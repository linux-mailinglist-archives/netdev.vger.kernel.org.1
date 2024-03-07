Return-Path: <netdev+bounces-78309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22956874A8B
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CB9B23C3B
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0B82D98;
	Thu,  7 Mar 2024 09:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DC839EA
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803091; cv=none; b=oT8vz82+YCl54VTa393Y/YaMw8BCC9jSmQh3Fsfa5FRg4LE9iuxCTlPVxDntrbQmYIm9zokFKnAApO151G1EXfomvIitHkVMxU/WT77SrpOnT0KkQWHPfVPb3IBnL8mI4V9pXJkgPFarFpFM7B8N+xUjJpkTSEEdKlrnaDEJjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803091; c=relaxed/simple;
	bh=oY6Ix2tRTCQm1iO8TkMeuP+Q/mj/JCg6X8/TmmwBO28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCxJkZ0l8+lhjHOnp6MrU7RzuCv1zTeVZa2pBzer5VrdkmVuGJCvw6zflcvJSqnx99aApCgTIB+xRkZY+GQWceBsb0eubVw+jQv+wrq8I6jiQw0FRyvEv7ycv5iwmAGy+wSlYOpHaZl9TthQuypCQbuXZWIvI02qrcikvgsDadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5132bd70e7dso170780e87.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803088; x=1710407888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jYCYIkiLKOmH3hbqFdCsnIQYuJXKlJhi19cZlr5ON8=;
        b=N9b99+pbHyOvPKYqe10uxtv1+nerslrQPS0Ocbh3Xrtw4xHUFy8+V5T+jDU9oN5+HW
         +TVU7cihd7KyfBRALtVHQILj46l94L+LvnKM9Gu/pdhfHPdIKd/QtOI3RlWzet8phbRn
         3wFfafpvniFEoixNzEwYjV0ySRaI4khuHtvmLFkt6evl5hyRN1bmyT+NgWbNZ+t6ksOA
         doeIrx9dAvf6G4dfYMCHc8fS9RHASZr8iNHFKx061/3LimNuIsSaLOmdRHafI8va/wvj
         6AEXlwdq59Dpit+Nn6P1XMVyc7MiyxwDsb4Yl4TOOOKeVum8Zqkvw/uIEUyx/o7KUysP
         fjZw==
X-Forwarded-Encrypted: i=1; AJvYcCWzIziHjfnMP1ha9OAiwOFx/LD1WJ+BMOoQOEhYVcLu1DFyQnml8nkxQrJ0QNLoa7khdt3dLzTXVc3JE8Jk65Lf5dPIpIug
X-Gm-Message-State: AOJu0YxGCTARta2CElKB6QXPIT2J3f7nFl20QBq/8nMkkj2wNxTIo4Ar
	SpewTRgw0hnSmKORiUaigGyqSpuzUWuYUmlFpTqnGyr0JRqo5HEj
X-Google-Smtp-Source: AGHT+IF7wqY42WTgiTtIvAx5OyS1uQdFyLA+BiVAmSiZ3OAEcCIBjGOAnMKh5E/fHC/RqFQXo1+CNQ==
X-Received: by 2002:a19:771c:0:b0:513:30fd:2991 with SMTP id s28-20020a19771c000000b0051330fd2991mr923434lfc.0.1709803087808;
        Thu, 07 Mar 2024 01:18:07 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b00412f2136793sm2061506wmq.44.2024.03.07.01.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:18:07 -0800 (PST)
Message-ID: <91318572-af38-464c-9c7a-4f6d1f642eee@grimberg.me>
Date: Thu, 7 Mar 2024 11:18:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 07/20] nvme-tcp: RX DDGST offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240228125733.299384-8-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240228125733.299384-8-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/2024 14:57, Aurelien Aptel wrote:
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
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 96 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 91 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b7cfe14661d6..2eebd9d2aee5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -143,6 +143,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_OFF_DDP	= 3,
> +	NVME_TCP_Q_OFF_DDGST_RX = 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -180,6 +181,7 @@ struct nvme_tcp_queue {
>   	 *   is pending (ULP_DDP_RESYNC_PENDING).
>   	 */
>   	atomic64_t		resync_tcp_seq;
> +	bool			ddp_ddgst_valid;
>   #endif
>   
>   	/* send state */
> @@ -393,6 +395,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   	return NULL;
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
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{
> +	struct nvme_tcp_request *req;
> +
> +	req = blk_mq_rq_to_pdu(rq);
> +	if (!req->offloaded) {
> +		/* if we have DDGST_RX offload but DDP was skipped
> +		 * because it's under the min IO threshold then the
> +		 * request won't have an SGL, so we need to make it
> +		 * here
> +		 */
> +		if (nvme_tcp_ddp_alloc_sgl(req, rq))
> +			return;
> +	}
> +
> +	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
> +				req->data_len);
> +	crypto_ahash_digest(hash);
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
> @@ -478,6 +520,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   		return ret;
>   
>   	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	if (queue->data_digest &&
> +	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
> +				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
> +		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   
>   	return 0;
>   }
> @@ -485,6 +531,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>   {
>   	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
>   }
>   
> @@ -593,6 +640,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
>   				     struct sk_buff *skb, unsigned int offset)
>   {}
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
>   #endif
>   
>   static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
> @@ -853,6 +914,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->pdu_offset = 0;
>   	queue->data_remaining = -1;
>   	queue->ddgst_remaining = 0;
> +#ifdef CONFIG_ULP_DDP
> +	queue->ddp_ddgst_valid = true;
> +#endif
>   }
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> @@ -1118,6 +1182,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);
> +
>   	while (true) {
>   		int recv_len, ret;
>   
> @@ -1146,7 +1213,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		recv_len = min_t(size_t, recv_len,
>   				iov_iter_count(&req->iter));
>   
> -		if (queue->data_digest)
> +		if (queue->data_digest &&
> +		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
>   				&req->iter, recv_len, queue->rcv_hash);
>   		else
> @@ -1188,8 +1256,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	struct request *rq;
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);
>   	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
>   	if (unlikely(ret))
>   		return ret;
> @@ -1200,9 +1271,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	if (queue->ddgst_remaining)
>   		return 0;
>   
> +	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> +			    pdu->command_id);
> +
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
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
> @@ -1213,9 +1300,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   			le32_to_cpu(queue->exp_ddgst));
>   	}
>   
> +out:

Nit: you can rename the label to ddgst_valid: or ddgst_ok:

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


Return-Path: <netdev+bounces-260630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM1jMOXznWk2SwQAu9opvQ
	(envelope-from <netdev+bounces-260630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:54:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E5418B980
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0D0A301F6AA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32572DAFA2;
	Tue, 24 Feb 2026 18:54:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5502874FE;
	Tue, 24 Feb 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959263; cv=none; b=DaQ9icaA34aPyqZbhw5Hlh51jIO8iBtH8/fU/3Z9HQlxDEVMjJDnn9Sluqu9PKOaikmnDTBDRXhtT3o9ymgPl9rO87lZqjaHqrZLTJJmMFxYYc7rfieJRWlPyVX6MrdYGVGY0gJ/RoqACAAbn8xteYb9VoH3SQ37YCQOIKm2+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959263; c=relaxed/simple;
	bh=UpTosX86DrDzX7q+/PILM8zK74C3x8l7orLRpFK7kxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZShYoTAyD0R/mWrMu124MGbpqOeLPDqATmsDkr/XxjBIEMHWMVspiB7fqJVZrkK95A1/vQlieE8uya2pGl68ZGl5WIXNZe4CEGmIygp11tiJxx8uJ4jHmbV94+rWH0Ck2M+q0DjmEY++NAX7Im7Lwmi18ruh2sYWIjXubRXkC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.44.143] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 187524C442FFED;
	Tue, 24 Feb 2026 19:53:14 +0100 (CET)
Message-ID: <4dbf4f75-0474-4583-a2ca-77e4886c2dec@molgen.mpg.de>
Date: Tue, 24 Feb 2026 19:53:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 1/5] libeth: pass Rx queue
 index to PP when creating a fill queue
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kohei Enju <kohei@enjuk.jp>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260224174618.2780516-1-aleksander.lobakin@intel.com>
 <20260224174618.2780516-2-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260224174618.2780516-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260630-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,molgen.mpg.de:mid,intel.com:email]
X-Rspamd-Queue-Id: D3E5418B980
X-Rspamd-Action: no action

Dear Alexander,


Thank you for your patch.

Am 24.02.26 um 18:46 schrieb Alexander Lobakin:
> Since recently, page_pool_create() accepts optional stack index of
> the Rx queue which the pool will be created for. It can then be
> used on control path for stuff like memory providers.
> Add the same field to libeth_fq and pass the index from all the
> drivers using libeth for managing Rx to simplify implementing MP
> support later.
> idpf has one libeth_fq per buffer/fill queue and each Rx queue has
> two fill queues, but since fill queues can never be shared, we can
> store the corresponding Rx queue index there during the
> initialization to pass it to libeth.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h |  2 ++
>   include/net/libeth/rx.h                     |  2 ++
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c |  1 +
>   drivers/net/ethernet/intel/ice/ice_base.c   |  2 ++
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 13 +++++++++++++
>   drivers/net/ethernet/intel/libeth/rx.c      |  1 +
>   6 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index 4be5b3b6d3ed..a0d92adf11c4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -748,6 +748,7 @@ libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
>    * @size: Length of descriptor ring in bytes
>    * @dma: Physical address of ring
>    * @q_vector: Backreference to associated vector
> + * @rxq_idx: stack index of the corresponding Rx queue
>    * @rx_buffer_low_watermark: RX buffer low watermark
>    * @rx_hbuf_size: Header buffer size
>    * @rx_buf_size: Buffer size
> @@ -791,6 +792,7 @@ struct idpf_buf_queue {
>   	dma_addr_t dma;
>   
>   	struct idpf_q_vector *q_vector;
> +	u16 rxq_idx;
>   
>   	u16 rx_buffer_low_watermark;
>   	u16 rx_hbuf_size;
> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
> index 5d991404845e..3b3d7acd13c9 100644
> --- a/include/net/libeth/rx.h
> +++ b/include/net/libeth/rx.h
> @@ -71,6 +71,7 @@ enum libeth_fqe_type {
>    * @xdp: flag indicating whether XDP is enabled
>    * @buf_len: HW-writeable length per each buffer
>    * @nid: ID of the closest NUMA node with memory
> + * @idx: stack index of the corresponding Rx queue
>    */
>   struct libeth_fq {
>   	struct_group_tagged(libeth_fq_fp, fp,
> @@ -88,6 +89,7 @@ struct libeth_fq {
>   
>   	u32			buf_len;
>   	int			nid;
> +	u32			idx;

The type above and here is different (u16 vs u32), despite the 
description being the same. Could you enlighten me why, and maybe add it 
to the commit message?


Kind regards,

Paul


>   };
>   
>   int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi);
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index 363c42bf3dcf..d3c68659162b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -771,6 +771,7 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
>   		.count		= rx_ring->count,
>   		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
>   		.nid		= NUMA_NO_NODE,
> +		.idx		= rx_ring->queue_index,
>   	};
>   	int ret;
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index afbff8aa9ceb..1b7d10fad4f2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -607,6 +607,7 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
>   	struct libeth_fq fq = {
>   		.count		= rq->count,
>   		.nid		= NUMA_NO_NODE,
> +		.idx		= rq->q_index,
>   		.hsplit		= rq->vsi->hsplit,
>   		.xdp		= ice_is_xdp_ena_vsi(rq->vsi),
>   		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
> @@ -629,6 +630,7 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
>   		.count		= rq->count,
>   		.type		= LIBETH_FQE_HDR,
>   		.nid		= NUMA_NO_NODE,
> +		.idx		= rq->q_index,
>   		.xdp		= ice_is_xdp_ena_vsi(rq->vsi),
>   	};
>   
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 376050308b06..36e2050dbb04 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -558,6 +558,7 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
>   		.type	= LIBETH_FQE_HDR,
>   		.xdp	= idpf_xdp_enabled(bufq->q_vector->vport),
>   		.nid	= idpf_q_vector_to_mem(bufq->q_vector),
> +		.idx	= bufq->rxq_idx,
>   	};
>   	int ret;
>   
> @@ -700,6 +701,7 @@ static int idpf_rx_bufs_init_singleq(struct idpf_rx_queue *rxq)
>   		.type		= LIBETH_FQE_MTU,
>   		.buf_len	= IDPF_RX_MAX_BUF_SZ,
>   		.nid		= idpf_q_vector_to_mem(rxq->q_vector),
> +		.idx		= rxq->idx,
>   	};
>   	int ret;
>   
> @@ -760,6 +762,7 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
>   		.hsplit		= idpf_queue_has(HSPLIT_EN, bufq),
>   		.xdp		= idpf_xdp_enabled(bufq->q_vector->vport),
>   		.nid		= idpf_q_vector_to_mem(bufq->q_vector),
> +		.idx		= bufq->rxq_idx,
>   	};
>   	int ret;
>   
> @@ -1919,6 +1922,16 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
>   							LIBETH_RX_LL_LEN;
>   			idpf_rxq_set_descids(rsrc, q);
>   		}
> +
> +		if (!idpf_is_queue_model_split(rsrc->rxq_model))
> +			continue;
> +
> +		for (u32 j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
> +			struct idpf_buf_queue *bufq;
> +
> +			bufq = &rx_qgrp->splitq.bufq_sets[j].bufq;
> +			bufq->rxq_idx = rx_qgrp->splitq.rxq_sets[0]->rxq.idx;
> +		}
>   	}
>   
>   err_alloc:
> diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
> index 62521a1f4ec9..8874b714cdcc 100644
> --- a/drivers/net/ethernet/intel/libeth/rx.c
> +++ b/drivers/net/ethernet/intel/libeth/rx.c
> @@ -156,6 +156,7 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
>   		.order		= LIBETH_RX_PAGE_ORDER,
>   		.pool_size	= fq->count,
>   		.nid		= fq->nid,
> +		.queue_idx	= fq->idx,
>   		.dev		= napi->dev->dev.parent,
>   		.netdev		= napi->dev,
>   		.napi		= napi,


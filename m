Return-Path: <netdev+bounces-275707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FoHFwYB1GnmpAcAu9opvQ
	(envelope-from <netdev+bounces-275707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:52:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868E3A6684
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87386300D0F5
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D49393DF9;
	Mon,  6 Apr 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3l3XyPbC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097C38D69D;
	Mon,  6 Apr 2026 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501565; cv=none; b=CqViHW2y7TMFTigziqzvR+LwtBC+Klm7n+1zzdKGrXUqivp2IE3Yxr0NOmliHxDykdp6pemJ7PLt47hJL18Cz0bBt0paBaDkIPG/wCfXNbTAN5PYPE6EBFkE7Gl5gANd7fcsif9NzOuCfQ+AewAmTPtrhMn9M7GiAMZ1Uo9msGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501565; c=relaxed/simple;
	bh=Btug6ZJeILanBg3PLRQR8Ocy7XfSp499v0ueosxflE8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=czLTvDjqyKMTyt7JzNoGCTdzr9s1VQuZHmfE38YtEimmUBTEcHfNit8thDkP7eZWT6De5DgReglXCvtsnKtPhICLjYFvHQfa+vlrjIVYge2wCU8r7mZMP6IEfXAbLDh0AcPkV8O5Up9pOVlTix9TYN1VCPbWsm0BUFb1UMxs7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3l3XyPbC; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E71CAA5888;
	Mon,  6 Apr 2026 20:52:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775501559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MGVBfP1GfxH7n4J0genDO+OlYwuOcQMc0kvsZz0r+Rk=;
	b=3l3XyPbCsklC7BVDvcBdLMOD7uEzcTvh0nGFIEas54a08hIzMfkEUXLKrmclnkQDxFlBmy
	Nd2beX2cWklURb9X3HAclwu96BCKL/mVQVlwUWE87bfkEWRn1SxwEyH+cZlohlDaC+kcTE
	SizX7Gps1t5NM2KBWpEQOdHwuda/NH1DaSIRqBXa5Y4HOq9rE2ZnQIdY0HVU1oo1vqiEd1
	BhYx1IhhTNQLHzijPYDKO6v1+4BPtMDHfryn+dKHdTnKO+zuowwYwV6MeHBtiO4Ut4RQFv
	GK9sZukipbTgp1FSKncES5d3ff4Uzb9mjiqQkeU8ymA7H3GicY/fZyUuUfwYjg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 20:52:37 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 4/7] net: bcmgenet: add XDP_TX support
In-Reply-To: <20260406083536.839517-5-nb@tipi-net.de>
References: <20260406083536.839517-1-nb@tipi-net.de>
 <20260406083536.839517-5-nb@tipi-net.de>
Message-ID: <97d07c9ee2fa450fcf5329847491e392@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275707-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 4868E3A6684
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6.4.2026 10:35, Nicolai Buchwitz wrote:
> Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
> descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.

> [...]

> +
> +	if (dma_map) {
> +		void *tsb_start;
> +
> +		/* The GENET MAC has TBUF_64B_EN set globally, so hardware
> +		 * expects a 64-byte TSB prefix on every TX buffer.  For
> +		 * redirected frames (ndo_xdp_xmit) we prepend a zeroed TSB
> +		 * using the frame's headroom.
> +		 */
> +		if (unlikely(xdpf->headroom < sizeof(struct status_64))) {
> +			bcmgenet_put_txcb(priv, ring);
> +			spin_unlock(&ring->lock);
> +			return false;
> +		}
> +
> +		tsb_start = xdpf->data - sizeof(struct status_64);
> +		memset(tsb_start, 0, sizeof(struct status_64));

Sashiko:
Does this memset() overwrite the struct xdp_frame? The xdp_frame is 
typically
stored in the headroom immediately before xdpf->data (or before the 
metadata).
If the 64-byte status_64 block is zeroed out here, could it destroy the
xdp_frame memory structure and cause a panic when xdp_return_frame() is 
later
called during TX completion?

Reponse:
No. The xdp_frame struct ends at data_hard_start + sizeof(xdp_frame).
The headroom (xdpf->headroom) is the gap between that and xdpf->data.
The TSB is written at xdpf->data - 64, which falls inside the headroom, 
after
the xdp_frame. The check xdpf->headroom < sizeof(struct status_64) 
prevents overlap.

> +
> +		dma_len = xdpf->len + sizeof(struct status_64);
> +		mapping = dma_map_single(kdev, tsb_start, dma_len,
> +					 DMA_TO_DEVICE);
> +		if (dma_mapping_error(kdev, mapping)) {
> +			tx_cb_ptr->skb = NULL;
> +			tx_cb_ptr->xdpf = NULL;
> +			bcmgenet_put_txcb(priv, ring);
> +			spin_unlock(&ring->lock);
> +			return false;
> +		}
> +	} else {
> +		struct page *page = virt_to_page(xdpf->data);
> +
> +		/* For local XDP_TX the caller already prepended the TSB
> +		 * into xdpf->data/len, so dma_len == xdpf->len.
> +		 */
> +		dma_len = xdpf->len;
> +		mapping = page_pool_get_dma_addr(page) +
> +			  sizeof(*xdpf) + xdpf->headroom;

Sashiko:
Is this DMA address calculation correct? It evaluates to the offset of
xdp->data_meta relative to xdp->data_hard_start, which completely drops 
the
GENET_XDP_HEADROOM (256 bytes) offset applied to the page pool base 
address.
Also, if metadata is present, this will point to the metadata instead of
xdpf->data. Could this cause the hardware to read the wrong memory 
location
for the Transmit Status Block and truncate the payload?

Reponse:
Correct. page_pool_get_dma_addr() returns the DMA address of the page 
start,
not offset by the pool's .offset. sizeof(*xdpf) + xdpf->headroom equals
xdpf->data - data_hard_start, pointing to the TSB. No metadata issue:
for local XDP_TX, data already includes the prepended TSB.

> +		dma_sync_single_for_device(kdev, mapping, dma_len,

> [...]

>  	}
> @@ -2542,9 +2684,15 @@ static int bcmgenet_rx_poll(struct napi_struct 
> *napi, int budget)
>  {
>  	struct bcmgenet_rx_ring *ring = container_of(napi,
>  			struct bcmgenet_rx_ring, napi);
> +	struct bcmgenet_priv *priv = ring->priv;
>  	struct dim_sample dim_sample = {};
>  	unsigned int work_done;
> 
> +	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
> +	if (priv->xdp_tx_ring.free_bds < priv->xdp_tx_ring.size)
> +		bcmgenet_tx_reclaim(priv->dev,
> +				    &priv->xdp_tx_ring, false);

Sashiko:
Since the XDP TX ring capacity is 32 (GENET_Q16_TX_BD_CNT) and the NAPI
budget can be up to 64, could a burst of XDP_TX packets exhaust the TX 
ring?
Because the reclaim only happens once at the beginning of the poll, 
would
subsequent XDP_TX packets within the same poll be dropped when the ring
fills up?

Reponse:
By design. If the ring fills, frames are dropped, which is kinda 
standard XDP backpressure.
Same approach as bnxt, mvneta, and other piggybacked-reclaim drivers.
Adding mid-poll reclaim would add complexity for probably minimal 
benefit at 1Gbps.

> [...]


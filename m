Return-Path: <netdev+bounces-286370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XS9WLJPSAGp8NAEAu9opvQ
	(envelope-from <netdev+bounces-286370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:46:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228A505C2C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CC203001D78
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A32DB785;
	Sun, 10 May 2026 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbj3DT6G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA65299937;
	Sun, 10 May 2026 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438800; cv=none; b=P1ApocoBwqN5+BicDhU0w1qP/gshmzBAFK1YZmOAKHqAdCPBnqsBgeAoS6pBXMfB+M1KgEGDmWeGJQ8Zpsv59fbEI0aSdIy3n+r00HWPDscg9SrL56+gPi1axAEr7S5dXFjRF/312zYGPIqNFOmOI62y+IDXyr4zPvqH06+2suo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438800; c=relaxed/simple;
	bh=IwYOrwZ7eQp+cKAEyKgHC5eMB9X4OpwrQD/eF9OWMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZNae6WLiMvLwj3oEm3DKMkxS7f7keTsQ975d6VFwXGQ9EEVorerN6801qtn+ZEVWAMJ0FfoT6E5QeS9aTvGdhw4Mi+UxwXh8hbmws9b8nhzDTyYcdUoqbCpTgSXh1P6r5l+PHVCXvBldv7EGEBy3Nu2KoJxgOMYOMNcnBUUOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbj3DT6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E525AC2BCB8;
	Sun, 10 May 2026 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778438799;
	bh=IwYOrwZ7eQp+cKAEyKgHC5eMB9X4OpwrQD/eF9OWMHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbj3DT6GCe0czXCx486RoRKas9fXkiIYSTxPIe++aOf93h3ZlCyG+DQVxYfeCEdkz
	 XSA7pMbBWMtaC2MKyp7dV0ODT70EFBFTmuFPJBXsv5JbB4cbcwhmB0FYqgDOS9C2yY
	 owXzXnSCl+Ip1a7pYOHEqodP7q0EqDTCmfvLosvRmB1Yr58+fbFuO8rONaTG3l82Hs
	 NFIS8E0CH6YfrFJBqwv1BupDGPij5IqC4tDc5H6o1yiHs6C254luM0WjhbxnUUL3bY
	 IXaMo6symwhZkgYMdtwq5WPFypPaJwbcX3MDENl9zBEooh6aYr57pn4VyKkcZf7rdW
	 dW0U45k+/5HPA==
From: Jakub Kicinski <kuba@kernel.org>
To: nb@tipi-net.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	justin.chen@broadcom.com,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	hmohsin@meta.com,
	davem@davemloft.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v9 1/7] net: bcmgenet: convert RX path to page_pool
Date: Sun, 10 May 2026 11:46:37 -0700
Message-ID: <20260510184637.3952320-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506095553.55357-2-nb@tipi-net.de>
References: <20260506095553.55357-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3228A505C2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,google.com,redhat.com,meta.com,davemloft.net,iogearbox.net,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-286370-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmgenet: convert RX path to page_pool

This patch replaces the per-packet __netdev_alloc_skb() + dma_map_single()
in the RX path with page_pool, and builds skbs via napi_build_skb() with
skb_mark_for_recycle() so pages are returned to the pool automatically.
A per-ring page_pool is created with PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
and the buffer layout reserves XDP_PACKET_HEADROOM before the HW RSB.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 54f71b1e85fc..df11c4977e8f 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2341,25 +2325,29 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  	while ((rxpktprocessed < rxpkttoprocess) &&
>  	       (rxpktprocessed < budget)) {
>  		struct status_64 *status;
> +		struct page *rx_page;
> +		unsigned int rx_off;
>  		__be16 rx_csum;
> +		void *hard_start;
>  
>  		cb = &priv->rx_cbs[ring->read_ptr];
> -		skb = bcmgenet_rx_refill(priv, cb);
>  
> -		if (unlikely(!skb)) {
> +		/* Save the received page before refilling */
> +		rx_page = cb->rx_page;
> +		rx_off = cb->rx_page_offset;
> +
> +		if (bcmgenet_rx_refill(ring, cb)) {
>  			BCMGENET_STATS64_INC(stats, dropped);
>  			goto next;
>  		}
>  
> -		status = (struct status_64 *)skb->data;
> +		/* Sync the RSB first to read the frame length */
> +		page_pool_dma_sync_for_cpu(ring->page_pool, rx_page, 0,
> +					   sizeof(struct status_64));
> +
> +		hard_start = page_address(rx_page) + rx_off;
> +		status = (struct status_64 *)hard_start;
>  		dma_length_status = status->length_status;

rx_off is saved from cb->rx_page_offset, but bcmgenet_rx_refill() always
sets that field to XDP_PACKET_HEADROOM.  The adjacent napi_build_skb()
call further down hardcodes the same constant as:

    napi_build_skb(hard_start, PAGE_SIZE - XDP_PACKET_HEADROOM);

Is the intent that rx_page_offset eventually varies (for XDP layouts),
or should the two sites either both use the constant or both derive the
size from rx_off (for example PAGE_SIZE - rx_off)?  If the offset ever
changes without updating the hardcoded napi_build_skb() argument the
skb_shared_info placement becomes incorrect.

>  
>  		/* DMA flags and length are still valid no matter how
>  		 * we got the Receive Status Vector (64B RSB or register)
> @@ -2367,15 +2355,23 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  		dma_flag = dma_length_status & 0xffff;
>  		len = dma_length_status >> DMA_BUFLENGTH_SHIFT;
>  
> +		/* Sync the rest of the actual received frame */
> +		if (len > sizeof(struct status_64))
> +			page_pool_dma_sync_for_cpu(ring->page_pool, rx_page,
> +						   sizeof(struct status_64),
> +						   len - sizeof(struct status_64));
> +

Can this drive a cache-maintenance operation with an unbounded length?

len is extracted from the HW-written RSB as:

    len = dma_length_status >> DMA_BUFLENGTH_SHIFT;

which is a 16-bit field (up to 65535), and the bounds check against
RX_BUF_LENGTH only happens in the next hunk.  page_pool_dma_sync_for_cpu()
on a non-coherent system ends up invalidating the cache over
[dma_addr + 64, dma_addr + 64 + (len - 64)].  If the hardware ever reports
a bogus length (glitch, stale RSB on an error condition, etc.) the
invalidation would drop dirty cache lines belonging to whatever kernel
allocation follows this page.

The previous code used a fixed priv->rx_buf_len for dma_unmap_single(),
so the HW-controlled length never sized a DMA-maintenance operation.

Would it be safer to validate len against RX_BUF_LENGTH / GENET_RSB_PAD
before this second page_pool_dma_sync_for_cpu() call, or clamp the sync
size to min(len - 64, RX_BUF_LENGTH - 64)?

>  		netif_dbg(priv, rx_status, dev,
>  			  "%s:p_ind=%d c_ind=%d read_ptr=%d len_stat=0x%08x\n",
>  			  __func__, p_index, ring->c_index,
>  			  ring->read_ptr, dma_length_status);
>  
> -		if (unlikely(len > RX_BUF_LENGTH)) {
> -			netif_err(priv, rx_status, dev, "oversized packet\n");
> +		if (unlikely(len > RX_BUF_LENGTH || len < GENET_RSB_PAD)) {
> +			netif_err(priv, rx_status, dev,
> +				  "invalid packet length %d\n", len);
>  			BCMGENET_STATS64_INC(stats, length_errors);
> -			dev_kfree_skb_any(skb);
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
>  			goto next;
>  		}

Is the lower bound here tight enough?

len == GENET_RSB_PAD (66) is accepted and then:

    __skb_put(skb, len - GENET_RSB_PAD);

yields a 0-byte skb.  eth_type_trans() -> eth_skb_pull_mac() will still
read h_proto from skb->data, which points into page_pool memory that the
hardware did not write for this packet.

Similarly, if priv->crc_fwd_en is set and skb->len < ETH_FCS_LEN (len
in [66..69]):

    skb_trim(skb, skb->len - ETH_FCS_LEN);

underflows to a huge unsigned value, but skb_trim()'s internal
"if (skb->len > len)" evaluates to false so the trim silently no-ops and
FCS bytes remain in the payload.

Would a bound like
len < GENET_RSB_PAD + ETH_ZLEN + (crc_fwd_en ? ETH_FCS_LEN : 0)
reject these runts more cleanly?

[ ... ]

> @@ -2411,24 +2408,47 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,

[ ... ]

> -		skb_put(skb, len);
> +		/* Build SKB from the page - data starts at hard_start,
> +		 * frame begins after RSB(64) + pad(2) = 66 bytes.
> +		 */
> +		skb = napi_build_skb(hard_start, PAGE_SIZE - XDP_PACKET_HEADROOM);
> +		if (unlikely(!skb)) {
> +			BCMGENET_STATS64_INC(stats, dropped);
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			goto next;
> +		}
> +
> +		skb_mark_for_recycle(skb);
>  
> -		/* remove RSB and hardware 2bytes added for IP alignment */
> -		skb_pull(skb, 66);
> -		len -= 66;
> +		/* Reserve the RSB + pad, then set the data length */
> +		skb_reserve(skb, GENET_RSB_PAD);
> +		__skb_put(skb, len - GENET_RSB_PAD);
>  
>  		if (priv->crc_fwd_en) {
> -			skb_trim(skb, len - ETH_FCS_LEN);
> -			len -= ETH_FCS_LEN;
> +			skb_trim(skb, skb->len - ETH_FCS_LEN);
>  		}

Separately, the pre-patch code incremented priv->mib.rx_dma_failed on
dma_mapping_error() inside bcmgenet_rx_refill().  With page_pool taking
over DMA mapping, nothing increments rx_dma_failed anymore, but the
counter is still exported via ethtool -S through:

    STAT_GENET_SOFT_MIB("rx_dma_failed", mib.rx_dma_failed)

So the field will be permanently zero after this patch, which is an
implicit user-visible change not mentioned in the commit message.  Should
rx_dma_failed be removed from the stats table (or folded into
alloc_rx_buff_failed) as part of this conversion, and the change noted in
the commit log?

[ ... ]
-- 
pw-bot: cr


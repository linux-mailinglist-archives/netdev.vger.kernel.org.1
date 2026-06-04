Return-Path: <netdev+bounces-295366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ElU+D4K5IWqIMgEAu9opvQ
	(envelope-from <netdev+bounces-295366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:44:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA516425F1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:44:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KAMvaTYv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295366-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295366-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1DEF3085AEC
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56524C9560;
	Thu,  4 Jun 2026 17:33:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B84C954A;
	Thu,  4 Jun 2026 17:33:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594396; cv=none; b=mxyakoIglgNy7l9ujQ8Xj0IRz/dFuhRsejjGaL1eFXy+28uWLxog9G0sqP9oK0fUgG0OUU9pwWOR2AhplcMzyQmXTJk2pf75jKbuaeX5f8j38eKD6h8RKN3qk83+L2UqDQibOyH+q1mGdZ7GfS9DaD46uunhzgk4KyceDOlRvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594396; c=relaxed/simple;
	bh=K7kw/I3eF2aRMgsjq6hJCOCmmCvvffqpzX0AsR7dY2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOO30mkRDHVVxV06wgVZS78G/VtS7HeO90hoKdWnbt8M5HvqcXdcEaoy7ohclkV1ljsp/6RvULYe8GORy1XyjdU9dPQdXWCsDoH6aFfGywSoOWOocwejJ8vOlXZAM2EmpMXJ32/QLP1nDk6D/Ahy6g3UD0qJygQ5WoBYxIoARCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAMvaTYv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134521F00893;
	Thu,  4 Jun 2026 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780594393;
	bh=KE+uMkWXsI4pHqJPpGFmy8f2FxY+qMoC/T/rfy5gO7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KAMvaTYvDvB4hnp/67u6AT0NyXI8HNFOOSF7atosC10cAnrq6Ek44404qw48A/SbE
	 UZ1ruN3mLI1zxR9JzULFaAir6JN6DU/gwjv2fIKewb8ZloyVDrbahkjF89Kw1YkS4u
	 CjzudcGsriEIhruwFzo64urOtOFSBOq7fpR/clqI63xDZ9qp6GXmeaXRH73yhCdjAp
	 V5jUU3qk9Fg5a6vdSQrO9VhJyTKqN8+X7aS1pscBiMWqWK1/2bbxIYV4PCxFKoBwZa
	 j8A2VOVOcD8Ue7wG2RTcicXZq5sJnoIWW0M8dtaA4/f+1NrdZppaS0bgEIi8o1yw6B
	 Ab6Qjrrsuw7cA==
From: Simon Horman <horms@kernel.org>
To: nb@tipi-net.de
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	justin.chen@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	vikas.gupta@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	bhargava.marreddy@broadcom.com,
	fmancera@suse.de,
	markus@blochl.de,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: convert RX path to page_pool
Date: Thu,  4 Jun 2026 18:32:06 +0100
Message-ID: <20260604173205.3989025-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602094248.4130712-1-nb@tipi-net.de>
References: <20260602094248.4130712-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295366-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:horms@kernel.org,m:netdev@vger.kernel.org,m:justin.chen@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:vikas.gupta@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:bhargava.marreddy@broadcom.com,m:fmancera@suse.de,m:markus@blochl.de,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,suse.de,blochl.de,arndb.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tipi-net.de:email,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CA516425F1

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Now I have the exact diff. Let me produce the report.

commit ff8ce4b2334ded9490897cdd2cff5a25a4a0a438
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: convert RX path to page_pool

This patch converts the bcmgenet RX path from per-packet
__netdev_alloc_skb() + dma_map_single() to page_pool, builds SKBs from
pool pages via napi_build_skb() with skb_mark_for_recycle(), and removes
the now-unused priv->rx_buf_len field and rx_dma_failed soft MIB
counter.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 7c11cf916762..80dbfba9fa88 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -1153,7 +1159,6 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
>  			UMAC_RBUF_ERR_CNT_V1),
>  	STAT_GENET_MISC("mdf_err_cnt", mib.mdf_err_cnt, UMAC_MDF_ERR_CNT),
>  	STAT_GENET_SOFT_MIB("alloc_rx_buff_failed", mib.alloc_rx_buff_failed),
> -	STAT_GENET_SOFT_MIB("rx_dma_failed", mib.rx_dma_failed),
>  	STAT_GENET_SOFT_MIB("tx_dma_failed", mib.tx_dma_failed),

[Medium]
The string "rx_dma_failed" exposed via ethtool -S is user-visible: monitoring
agents (collectd, telegraf, Prometheus exporters, ad-hoc scripts) may key off
that name, and the strings list is ordered, so removing one shifts the index
of every counter that follows for tools that index by offset rather than name.

Should the changelog mention this user-visible change explicitly, or could
the entry be retained reporting 0 to preserve the existing string set?

Worth noting that the sibling driver drivers/net/ethernet/broadcom/bcmsysport.c
still exposes rx_dma_failed, so the two drivers in the same Broadcom directory
will diverge after this patch.

> @@ -2249,46 +2246,30 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>  	goto out;
>  }
>  
> -static struct sk_buff *bcmgenet_rx_refill(struct bcmgenet_priv *priv,
> -					  struct enet_cb *cb)
> +static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
> +			      struct enet_cb *cb)
>  {
> -	struct device *kdev = &priv->pdev->dev;
> -	struct sk_buff *skb;
> -	struct sk_buff *rx_skb;
> +	struct bcmgenet_priv *priv = ring->priv;
>  	dma_addr_t mapping;
> +	struct page *page;
>  
> -	/* Allocate a new Rx skb */
> -	skb = __netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT,
> -				 GFP_ATOMIC | __GFP_NOWARN);
> -	if (!skb) {
> +	page = page_pool_alloc_pages(ring->page_pool,
> +				     GFP_ATOMIC);
> +	if (!page) {
>  		priv->mib.alloc_rx_buff_failed++;
>  		netif_err(priv, rx_err, priv->dev,
> -			  "%s: Rx skb allocation failed\n", __func__);
> -		return NULL;
> -	}
> -
> -	/* DMA-map the new Rx skb */
> -	mapping = dma_map_single(kdev, skb->data, priv->rx_buf_len,
> -				 DMA_FROM_DEVICE);
> -	if (dma_mapping_error(kdev, mapping)) {
> -		priv->mib.rx_dma_failed++;
> -		dev_kfree_skb_any(skb);
> -		netif_err(priv, rx_err, priv->dev,
> -			  "%s: Rx skb DMA mapping failed\n", __func__);
> -		return NULL;
> +			  "%s: Rx page allocation failed\n", __func__);
> +		return -ENOMEM;
>  	}
>  
> -	/* Grab the current Rx skb from the ring and DMA-unmap it */
> -	rx_skb = bcmgenet_free_rx_cb(kdev, cb);
> +	/* page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
> +	mapping = page_pool_get_dma_addr(page);
>  
> -	/* Put the new Rx skb on the ring */
> -	cb->skb = skb;
> -	dma_unmap_addr_set(cb, dma_addr, mapping);
> -	dma_unmap_len_set(cb, dma_len, priv->rx_buf_len);
> +	cb->rx_page = page;
> +	cb->rx_page_offset = 0;
>  	dmadesc_set_addr(priv, cb->bd_addr, mapping);
>  
> -	/* Return the current Rx skb to caller */
> -	return rx_skb;
> +	return 0;
>  }

[High]
Has a one-page-per-RX-descriptor scheme been considered against the
platforms bcmgenet actually runs on?

The pool is created with order=0 and max_len=RX_BUF_LENGTH (2048):

	struct page_pool_params pp_params = {
		.order = 0,
		...
		.max_len = RX_BUF_LENGTH,
	};

bcmgenet_rx_refill() always sets cb->rx_page_offset = 0, and
bcmgenet_desc_rx() then does:

	skb = napi_build_skb(hard_start, PAGE_SIZE - rx_off);

so each ~1.5KB frame ends up with skb->truesize == PAGE_SIZE.

bcmgenet runs on BCM2711/2712 (Raspberry Pi 4/5) and Brahma-B53 STB SoCs,
which are commonly built with 16K or 64K page sizes. With ring->size of
256 and one full page per descriptor, that is e.g. 256 * 64K = 16MB of
DMA-mapped memory per ring on a 64K-page kernel, for ~512KB of frame
data. Every ~1.5KB packet also bills PAGE_SIZE bytes against sk_rcvbuf
and per-socket memory accounting, which can drive TCP receivers into
memory pressure on a Gigabit MAC.

The newly added struct enet_cb::rx_page_offset is set but never to a
non-zero value:

	cb->rx_page = page;
	cb->rx_page_offset = 0;

Was a fragmented allocation (page_pool_dev_alloc_frag(), or a higher
.order) the original intent here? If so, would it make sense to either
implement that in this patch, or drop the unused rx_page_offset field
until it is needed?

> @@ -2340,25 +2321,31 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,

[ ... ]

> -		if (unlikely(len > RX_BUF_LENGTH)) {
> -			netif_err(priv, rx_status, dev, "oversized packet\n");
> +		/* Reject obviously bogus lengths to keep the SKB build path
> +		 * safe against runt frames.
> +		 */
> +		min_len = GENET_RSB_PAD + ETH_ZLEN +
> +			  (priv->crc_fwd_en ? ETH_FCS_LEN : 0);
> +		if (unlikely(len > RX_BUF_LENGTH || len < min_len)) {
> +			netif_err(priv, rx_status, dev,
> +				  "invalid packet length %d\n", len);
>  			BCMGENET_STATS64_INC(stats, length_errors);
> -			dev_kfree_skb_any(skb);
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
>  			goto next;
>  		}

[Low, Low]
This combined check changes the per-counter attribution for short frames.
Previously, only len > RX_BUF_LENGTH short-circuited into length_errors;
runts that also had DMA_RX_CRC_ERROR / DMA_RX_OV / DMA_RX_NO / DMA_RX_LG /
DMA_RX_RXER set would fall through to the dma_flag-driven block and be
counted as crc_errors / over_errors / frame_errors / errors as appropriate.

After this patch any sub-min_len frame is bucketed only as length_errors,
even if dma_flag indicates a CRC or RXER condition. Is the loss of finer
attribution intentional, and could the changelog mention it?

A related question on the lower bound itself: min_len is computed as
GENET_RSB_PAD + ETH_ZLEN (+ ETH_FCS_LEN if crc_fwd_en), so any HW-reported
frame below ETH_ZLEN on the wire is dropped. Frames below the minimum
that the MAC nevertheless delivers (for example with promiscuous mode or
runt-pass enabled, or some PHY-side debug captures) used to reach the
stack with DMA_RX_LG / DMA_RX_NO flagging.

The commit message describes this as "a runt cannot underflow the SKB
build path". The actual underflow precondition for the skb_reserve() /
__skb_put() sequence is len < GENET_RSB_PAD (= 66):

		skb_reserve(skb, GENET_RSB_PAD);
		__skb_put(skb, len - GENET_RSB_PAD);

Would a tighter check of len < GENET_RSB_PAD satisfy the stated safety
goal without filtering legitimate sub-ETH_ZLEN frames the HW chose to
deliver?


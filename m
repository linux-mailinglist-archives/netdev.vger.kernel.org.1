Return-Path: <netdev+bounces-283068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKmBI6UE9GnR9gEAu9opvQ
	(envelope-from <netdev+bounces-283068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:40:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA54A9A8C
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33EC03003E9B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066F2D7398;
	Fri,  1 May 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSGYgkWO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD732296BCC;
	Fri,  1 May 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599601; cv=none; b=Mfc4WQTNR5/tJedrp+kpFq63qA9picPlc7aPZ8qnRzieIqQ0g5JmnmTfhyckJLMb2J0gBiSGdSXvW65zNNiTGX/ETZ82Svr81uwzQugvWdSjXfGtR7kVMSlcJ4IAIUXK26GPDPqp20LdLRPDOAFy2ZQ51Hl1tulHJigU+r6cm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599601; c=relaxed/simple;
	bh=GOsfo1wRbu74Tcp5qyZ5uUS0nXD/Uj24m8TIY2AwNo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoCfg2qHgKYKjlTQOwRSM1PHJ8LMPGUfzgwBn195mYmI4wZHAhSI46onlxIn7IEPd5G7wNcoHSkna+PAZakUCjjH4o/BzTevEeoMT2oyvxzJAe+wr50IBVngcqIZxig5GKWI6kAGUb8IpfQnHihhNysNzoJ6nnsS44CTvJlVlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSGYgkWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955CBC2BCB3;
	Fri,  1 May 2026 01:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777599601;
	bh=GOsfo1wRbu74Tcp5qyZ5uUS0nXD/Uj24m8TIY2AwNo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSGYgkWOX8HEUsdKJEhA7Xkk6YEpUkLDJN5R0msHCWTDHNzTSI9RHZCxQ85BhnDt7
	 uYuNunHcXy1Va40054bPtit6AoGuRGhkrik+HnaHE5iHt/xuJ3OJ2Hdy4DpBAK3Enx
	 /SZv7gU72ti1ZmGC/rV0klCHpyEL+T1gSVQjIR1DK219Nu1a/Fd89evw1pyt+AgyEt
	 wW4cLCyhvjcF691I7P1yesd/ezq1ZfLmgtDfdefa1z6CauONPaDYiANu33AC0hjfdn
	 kBKM9HVA51TJbAkX3S1WjRqI+lRXRGxBUNVW81V+oiMtzQh5/VQ34ZRQF+L/MVxcYj
	 kRnsN1h3d+VZw==
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
	davem@davemloft.net,
	rajashekar.hudumula@broadcom.com,
	vikas.gupta@broadcom.com,
	bhargava.marreddy@broadcom.com,
	sashal@kernel.org,
	ebiggers@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/7] net: bcmgenet: add XDP_TX support
Date: Thu, 30 Apr 2026 18:39:36 -0700
Message-ID: <20260501013935.3169102-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428205846.2625550-5-nb@tipi-net.de>
References: <20260428205846.2625550-5-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAEA54A9A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-283068-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmgenet: add XDP_TX support

This patch adds XDP_TX support to bcmgenet by dedicating ring 16
(DESC_INDEX) to XDP TX, carving 32 BDs from ring 0's allocation and
piggybacking TX completion on the RX NAPI poll.  The page_pool DMA
direction is switched from DMA_FROM_DEVICE to DMA_BIDIRECTIONAL.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 1b60571446e1..3c3b0c44ea8a 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -1940,8 +1956,15 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
>  
>  	/* Reclaim transmitted buffers */
>  	while (txbds_processed < txbds_ready) {
> -		skb = bcmgenet_free_tx_cb(&priv->pdev->dev,
> -					  &priv->tx_cbs[ring->clean_ptr]);
> +		tx_cb = &priv->tx_cbs[ring->clean_ptr];
> +		if (tx_cb->xdpf) {
> +			pkts_compl++;
> +			bytes_compl += tx_cb->xdp_dma_map
> +				? tx_cb->xdpf->len
> +				: tx_cb->xdpf->len -
> +				  sizeof(struct status_64);
> +		}
> +		skb = bcmgenet_free_tx_cb(&priv->pdev->dev, tx_cb);
>  		if (skb) {
>  			pkts_compl++;
>  			bytes_compl += GENET_CB(skb)->bytes_sent;
> @@ -1963,8 +1986,11 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
>  	u64_stats_add(&stats->bytes, bytes_compl);
>  	u64_stats_update_end(&stats->syncp);
>  
> -	netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->index),
> -				  pkts_compl, bytes_compl);
> +	/* Ring DESC_INDEX (XDP TX) has no netdev TX queue; skip BQL */
> +	if (ring->index != DESC_INDEX)
> +		netdev_tx_completed_queue(netdev_get_tx_queue(dev,
> +							      ring->index),
> +					  pkts_compl, bytes_compl);
>  
>  	return txbds_processed;
>  }

The guard here skips netdev_get_tx_queue() for the XDP TX ring, but the
outer wrapper bcmgenet_tx_reclaim() still calls:

    netdev_tx_reset_queue(netdev_get_tx_queue(dev, ring->index));
    ...
    bcmgenet_tdma_ring_writel(priv, ring->index, ring->prod_index, ...);

unconditionally when invoked with all=true.

For the XDP TX ring, ring->index == DESC_INDEX == 16, but bcmgenet_probe()
allocates the netdev via alloc_etherdev_mqs(..., GENET_MAX_MQ_CNT + 1,
GENET_MAX_MQ_CNT + 1), which is only 5 TX queues.  So netdev_get_tx_queue(dev,
16) returns &dev->_tx[16], well past the end of the allocated _tx[] array.

On CONFIG_BQL=y (the default), netdev_tx_reset_queue() then writes into that
memory through dql_reset() and clear_bit(__QUEUE_STATE_STACK_XOFF, &q->state).

Can this path corrupt memory past dev->_tx[] whenever bcmgenet_tx_reclaim_all()
runs on the XDP TX ring?  See the new call added below:

[ ... ]

> @@ -2043,6 +2069,9 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
>  	do {
>  		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++], true);
>  	} while (i <= priv->hw_params->tx_queues && netif_is_multiqueue(dev));
> +
> +	/* Also reclaim XDP TX ring */
> +	bcmgenet_tx_reclaim(dev, &priv->xdp_tx_ring, true);
>  }

bcmgenet_tx_reclaim_all() is reached from bcmgenet_netif_stop() (ifconfig
down), the WoL/suspend reconfigure path, and open/reset-failure cleanup, so
this is triggerable from userspace on every interface-down.

Should the netdev_tx_reset_queue() in bcmgenet_tx_reclaim()'s all-branch be
guarded with the same ring->index != DESC_INDEX check that was added to
__bcmgenet_tx_reclaim()?

[ ... ]

> @@ -3008,14 +3161,18 @@ static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)

[ ... ]

>  static void bcmgenet_init_tx_queues(struct net_device *dev)
>  {
> @@ -3028,7 +3185,8 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
>  
>  	/* Initialize Tx priority queues */
>  	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
> -		bcmgenet_init_tx_ring(priv, i, end - start, start, end);
> +		bcmgenet_init_tx_ring(priv, &priv->tx_rings[i],
> +				      i, end - start, start, end);
>  		start = end;
>  		end += priv->hw_params->tx_bds_per_q;
>  		dma_priority[DMA_PRIO_REG_INDEX(i)] |=
> @@ -3036,13 +3194,19 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
>  			<< DMA_PRIO_REG_SHIFT(i);
>  	}
>  
> +	/* Initialize ring 16 (descriptor ring) for XDP TX */
> +	bcmgenet_init_tx_ring(priv, &priv->xdp_tx_ring,
> +			      DESC_INDEX, GENET_Q16_TX_BD_CNT,
> +			      TOTAL_DESC - GENET_Q16_TX_BD_CNT, TOTAL_DESC);
> +
>  	/* Set Tx queue priorities */
>  	bcmgenet_tdma_writel(priv, dma_priority[0], DMA_PRIORITY_0);
>  	bcmgenet_tdma_writel(priv, dma_priority[1], DMA_PRIORITY_1);
>  	bcmgenet_tdma_writel(priv, dma_priority[2], DMA_PRIORITY_2);

What priority does ring 16 end up with under strict-priority arbitration?

dma_priority[] is declared as:

    u32 dma_priority[3] = {0, 0, 0};

and only rings 0..tx_queues populate it.  Ring 16's priority field lives in
DMA_PRIORITY_2, bits [20..24] (DMA_PRIO_REG_INDEX(16) == 2,
DMA_PRIO_REG_SHIFT(16) == 20), and is left as zero.

In this driver priority 0 is the highest:

    #define GENET_Q1_PRIORITY   0   /* Default highest priority queue */
    #define GENET_Q0_PRIORITY   1

A few lines above, arbitration is set to strict priority:

    bcmgenet_tdma_writel(priv, DMA_ARBITER_SP, DMA_ARB_CTRL);

So ring 16 ends up at priority 0, outranking Q0 (priority 1) and equal to
the user-configured high-priority queues Q1..Q4.  Should ring 16 be given
an explicit priority (for example the same as Q0, or lower) so XDP_TX does
not preempt normal SKB TX under strict-priority arbitration?


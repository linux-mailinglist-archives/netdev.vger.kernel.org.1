Return-Path: <netdev+bounces-268149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIcaOVf2t2mfXQEAu9opvQ
	(envelope-from <netdev+bounces-268149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:23:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E7F29970C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8246D30056E4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD9C3909A0;
	Mon, 16 Mar 2026 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ImhfIs12"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61E34EEFB
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663601; cv=none; b=jHWVyH5TE7ce6wK3lrwwlCb7Z3LG40DoO5AiqDk0OLJgirBuDzev/wuvbbEarVGY7ny0kvLLWM92S7IgjDFGA8+4erAr4fbxwwIk4l5rTJywW5v9cHJv3xCNnehM0PfYqmr0DPpzkmNSLTSyHlL0wIln4OrGmwJB/0c0rutnn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663601; c=relaxed/simple;
	bh=V9Iwa2pcqgeOnhxlvAxXtX8SgYmVBbqN0rIBnHHMx9s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=X2jYqE2fikAlbQcNW/TKU7UiCoWs8H4cvDUvoDrNtNfZ66BmmC7EpUsnpWg8qknwRd0f6GwmyuaAcXDOAmMLAmb6B3PirtQmPX4m4j9Nw0cEItJaip+qzDrMevBS9XlIR7+cbDF9UfWOGRfGukclqn1ruyFd3Uf57hi02hKwfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ImhfIs12; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E83CA22FD;
	Mon, 16 Mar 2026 13:19:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773663597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zK/5CH68TULYQKal3KKBaPnNj3jLytugk1OKWSuiGOQ=;
	b=ImhfIs12amDLPNw4lU/CPJEiZNJErS+IqoLlD9ZlixGrLfwIjXEf4ODWkTA1XX029DeFkJ
	peLoqAcrzkKQqDzAeidTZEhQOHAaKObMgrB/N6zeEA2domC2uNxqc5L7rtXBfqmA00yZ1X
	gUnQDXLxQy5gEpxyf+Qtg8YCacos6OcFjs++tu+M7PLa16d1jlUlZG5kYlpteSpguBZbtM
	WyGsuSdo5LbTFNe0flnrtrTy12p9/9pYUmAcv03eQUWCLtgLza7VY4xWd1k+JNXilx9ega
	1MpeNFSu7ffPG142L5meI+VEW5ibyvXHO6vlVmnNC1uzXl311xvWeCuoGsNXHQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 13:19:55 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 1/8] net: macb: move Rx buffers alloc from
 link up to open
In-Reply-To: <20260313201433.2346119-2-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
 <20260313201433.2346119-2-pvalerio@redhat.com>
Message-ID: <45248cc48e32958303121b90255b553f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268149-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48E7F29970C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13.3.2026 21:14, Paolo Valerio wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> mog_alloc_rx_buffers(), getting called at open, does not do rx buffer
> alloc on GEM. The bulk of the work is done by gem_rx_refill() filling
> up all slots with valid buffers.
> 
> gem_rx_refill() is called at link up by
> gem_init_rings() == bp->macbgem_ops.mog_init_rings().
> 
> Move operation to macb_open(), mostly to allow it to fail early and
> loudly rather than init the device with Rx mostly broken.
> 
> About `bool fail_early`:
>  - When called from macb_open(), ring init fails as soon as a queue
>    cannot be refilled.
>  - When called from macb_hresp_error_task(), we do our best to reinit
>    the device: we still iterate over all queues and try refilling all
>    even if a previous queue failed.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |  2 +-
>  drivers/net/ethernet/cadence/macb_main.c | 35 ++++++++++++++++++------
>  2 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index c69828b27dae..0acc188fe547 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1195,7 +1195,7 @@ struct macb_queue;
>  struct macb_or_gem_ops {
>  	int	(*mog_alloc_rx_buffers)(struct macb *bp);
>  	void	(*mog_free_rx_buffers)(struct macb *bp);
> -	void	(*mog_init_rings)(struct macb *bp);
> +	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
>  	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
>  			  int budget);
>  };
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 5e27e0e87a55..2c36d3844bf5 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1474,13 +1474,14 @@ static int macb_tx_complete(struct macb_queue 
> *queue, int budget)
>  	return packets;
>  }
> 
> -static void gem_rx_refill(struct macb_queue *queue)
> +static int gem_rx_refill(struct macb_queue *queue)
>  {
>  	unsigned int		entry;
>  	struct sk_buff		*skb;
>  	dma_addr_t		paddr;
>  	struct macb *bp = queue->bp;
>  	struct macb_dma_desc *desc;
> +	int err = 0;
> 
>  	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
>  			bp->rx_ring_size) > 0) {
> @@ -1497,6 +1498,7 @@ static void gem_rx_refill(struct macb_queue 
> *queue)
>  			if (unlikely(!skb)) {
>  				netdev_err(bp->dev,
>  					   "Unable to allocate sk_buff\n");
> +				err = -ENOMEM;
>  				break;
>  			}
> 
> @@ -1546,6 +1548,7 @@ static void gem_rx_refill(struct macb_queue 
> *queue)
> 
>  	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail 
> %d\n",
>  			queue, queue->rx_prepared_head, queue->rx_tail);
> +	return err;
>  }
> 
>  /* Mark DMA descriptors from begin up to and not including end as 
> unused */
> @@ -1998,7 +2001,7 @@ static void macb_hresp_error_task(struct 
> work_struct *work)
>  	netif_tx_stop_all_queues(dev);
>  	netif_carrier_off(dev);
> 
> -	bp->macbgem_ops.mog_init_rings(bp);
> +	bp->macbgem_ops.mog_init_rings(bp, false);
> 
>  	/* Initialize TX and RX buffers */
>  	macb_init_buffers(bp);
> @@ -2772,8 +2775,6 @@ static int macb_alloc_consistent(struct macb *bp)
>  		if (!queue->tx_skb)
>  			goto out_err;
>  	}
> -	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
> -		goto out_err;
> 
>  	/* Required for tie off descriptor for PM cases */
>  	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
> @@ -2785,6 +2786,11 @@ static int macb_alloc_consistent(struct macb 
> *bp)
>  			goto out_err;
>  	}
> 
> +	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
> +		goto out_err;
> +	if (bp->macbgem_ops.mog_init_rings(bp, true))
> +		goto out_err;
> +
>  	return 0;
> 
>  out_err:
> @@ -2805,11 +2811,13 @@ static void macb_init_tieoff(struct macb *bp)
>  	desc->ctrl = 0;
>  }
> 
> -static void gem_init_rings(struct macb *bp)
> +static int gem_init_rings(struct macb *bp, bool fail_early)
>  {
>  	struct macb_queue *queue;
>  	struct macb_dma_desc *desc = NULL;
> +	int last_err = 0;
>  	unsigned int q;
> +	int err;
>  	int i;
> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> @@ -2825,13 +2833,24 @@ static void gem_init_rings(struct macb *bp)
>  		queue->rx_tail = 0;
>  		queue->rx_prepared_head = 0;
> 
> -		gem_rx_refill(queue);
> +		/* We get called in two cases:
> +		 *  - open: we can propagate alloc errors (so fail early),
> +		 *  - HRESP error: cannot propagate, we attempt to reinit
> +		 *    all queues in case of failure.
> +		 */
> +		err = gem_rx_refill(queue);
> +		if (err) {
> +			last_err = err;
> +			if (fail_early)
> +				break;
> +		}
>  	}
> 
>  	macb_init_tieoff(bp);
> +	return last_err;
>  }
> 
> -static void macb_init_rings(struct macb *bp)
> +static int macb_init_rings(struct macb *bp, bool fail_early)
>  {
>  	int i;
>  	struct macb_dma_desc *desc = NULL;
> @@ -2848,6 +2867,7 @@ static void macb_init_rings(struct macb *bp)
>  	desc->ctrl |= MACB_BIT(TX_WRAP);
> 
>  	macb_init_tieoff(bp);
> +	return 0;
>  }
> 
>  static void macb_reset_hw(struct macb *bp)
> @@ -3179,7 +3199,6 @@ static int macb_open(struct net_device *dev)
>  		goto pm_exit;
>  	}
> 
> -	bp->macbgem_ops.mog_init_rings(bp);
>  	macb_init_buffers(bp);
> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai


Return-Path: <netdev+bounces-268151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDDyEtL1t2mfXQEAu9opvQ
	(envelope-from <netdev+bounces-268151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:21:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DDA2996AC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A3EC300C311
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458FB355F41;
	Mon, 16 Mar 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="x5qLpUVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41D2BE639
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663696; cv=none; b=QffIbuwjhA9DSwhblhy8ZQYzg96XJU7RDaggVX0A/C8H6t49eAv6TKEdPr9D9Eldz0ihQ7rrFFQ0ynuqT9zLNEaxbrkDqQsXkU+epud8BUszJlwXnwOENfu71Ri4fGPXf56CcyJcMbZVTIIBKGcbNXHMHSrVSxPfadZnB6Y7IV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663696; c=relaxed/simple;
	bh=Cepol8gs073CI7rcZ7RljjQnJHL1Tvafssf+3ZBAZVQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RWcs30NXv0Eg7ufaERoF3eTjpAymh2AIRtS04nPzg6fngMMUztdsvwI2lIjuehreonmav0VfdHSHFq82Yl+GFd1X72unLil2weHYiNF5ovZeKsPxB5610O7W2lnE5nQfTerMadivhjCwbb+PfrhnFzip8vJn/e0IT7ZG1u5iujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=x5qLpUVe; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 742F2A50F9;
	Mon, 16 Mar 2026 13:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773663692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g0+H9bZIu9cG9Ku/kbyRx4xfJdJEr2/OtkmCO3wfdNk=;
	b=x5qLpUVeT6PXQgj7wpqWJHK+2/TYaBuNzd/BFT4mml2GOmoyyYlQG/aqOaeXq+g2e/ETBW
	vf3yIQPy77AXbJ1DUOSyA1Tib31pFFtfGkeIcw1GPxvZ96IQMkWwdlEg5xCaLkH+bTnFS3
	M2D16vSnhEUzUqYhg2S9N1QtTs+v6gn93spvQWmpn154qxrkUxyQ0HJN1gHZzXtFqiAlko
	deEX/naojgMTLHYXck+RKDeSjmIlRawr6eyPsdX5IuCQDVLpi1QhDJJEuumJ5MQuQLC9aa
	hEJr/UvGz88ugYeVqYw5eOsQB7gsiCV+tLMbf97N5JdF+Addam8HbWFc6nTO0w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 13:21:32 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 5/8] net: macb: make macb_tx_skb generic
In-Reply-To: <20260313201433.2346119-6-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
 <20260313201433.2346119-6-pvalerio@redhat.com>
Message-ID: <b81f229909433b277d9b23ef97a2082f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268151-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3DDA2996AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13.3.2026 21:14, Paolo Valerio wrote:
> The macb_tx_skb structure is renamed to macb_tx_buff with
> no functional changes.
> 
> This is a preparatory step for adding xdp xmit support.
> 
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   8 +-
>  drivers/net/ethernet/cadence/macb_main.c | 112 +++++++++++------------
>  2 files changed, 60 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index 2c6ba1b63aab..1cc626088174 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -965,7 +965,7 @@ struct macb_dma_desc_ptp {
>  /* Scaled PPM fraction */
>  #define PPM_FRACTION	16
> 
> -/* struct macb_tx_skb - data about an skb which is being transmitted
> +/* struct macb_tx_buff - data about an skb which is being transmitted
>   * @skb: skb currently being transmitted, only set for the last buffer
>   *       of the frame
>   * @mapping: DMA address of the skb's fragment buffer
> @@ -973,7 +973,7 @@ struct macb_dma_desc_ptp {
>   * @mapped_as_page: true when buffer was mapped with 
> skb_frag_dma_map(),
>   *                  false when buffer was mapped with dma_map_single()
>   */
> -struct macb_tx_skb {
> +struct macb_tx_buff {
>  	struct sk_buff		*skb;
>  	dma_addr_t		mapping;
>  	size_t			size;
> @@ -1267,7 +1267,7 @@ struct macb_queue {
>  	spinlock_t		tx_ptr_lock;
>  	unsigned int		tx_head, tx_tail;
>  	struct macb_dma_desc	*tx_ring;
> -	struct macb_tx_skb	*tx_skb;
> +	struct macb_tx_buff	*tx_buff;
>  	dma_addr_t		tx_ring_dma;
>  	struct work_struct	tx_error_task;
>  	bool			txubr_pending;
> @@ -1345,7 +1345,7 @@ struct macb {
>  	phy_interface_t		phy_interface;
> 
>  	/* AT91RM9200 transmit queue (1 on wire + 1 queued) */
> -	struct macb_tx_skb	rm9200_txq[2];
> +	struct macb_tx_buff	rm9200_txq[2];
>  	unsigned int		max_tx_length;
> 
>  	u64			ethtool_stats[GEM_STATS_LEN + QUEUE_STATS_LEN * 
> MACB_MAX_QUEUES];
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index fbeaa85b4a9c..1dff136cc63a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -158,10 +158,10 @@ static struct macb_dma_desc *macb_tx_desc(struct 
> macb_queue *queue,
>  	return &queue->tx_ring[index];
>  }
> 
> -static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
> -				       unsigned int index)
> +static struct macb_tx_buff *macb_tx_buff(struct macb_queue *queue,
> +					 unsigned int index)
>  {
> -	return &queue->tx_skb[macb_tx_ring_wrap(queue->bp, index)];
> +	return &queue->tx_buff[macb_tx_ring_wrap(queue->bp, index)];
>  }
> 
>  static dma_addr_t macb_tx_dma(struct macb_queue *queue, unsigned int 
> index)
> @@ -791,7 +791,7 @@ static void macb_mac_link_down(struct 
> phylink_config *config, unsigned int mode,
>  static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>  {
>  	unsigned int head, tail, count, ring_size, desc_size;
> -	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
> +	struct macb_tx_buff tx_buff, *buff_curr, *buff_next;
>  	struct macb_dma_desc *desc_curr, *desc_next;
>  	unsigned int i, cycles, shift, curr, next;
>  	struct macb *bp = queue->bp;
> @@ -823,8 +823,8 @@ static void gem_shuffle_tx_one_ring(struct 
> macb_queue *queue)
> 
>  	for (i = 0; i < cycles; i++) {
>  		memcpy(&desc, macb_tx_desc(queue, i), desc_size);
> -		memcpy(&tx_skb, macb_tx_skb(queue, i),
> -		       sizeof(struct macb_tx_skb));
> +		memcpy(&tx_buff, macb_tx_buff(queue, i),
> +		       sizeof(struct macb_tx_buff));
> 
>  		curr = i;
>  		next = (curr + shift) % ring_size;
> @@ -840,9 +840,9 @@ static void gem_shuffle_tx_one_ring(struct 
> macb_queue *queue)
>  			if (curr == ring_size - 1)
>  				desc_curr->ctrl |= MACB_BIT(TX_WRAP);
> 
> -			skb_curr = macb_tx_skb(queue, curr);
> -			skb_next = macb_tx_skb(queue, next);
> -			memcpy(skb_curr, skb_next, sizeof(struct macb_tx_skb));
> +			buff_curr = macb_tx_buff(queue, curr);
> +			buff_next = macb_tx_buff(queue, next);
> +			memcpy(buff_curr, buff_next, sizeof(struct macb_tx_buff));
> 
>  			curr = next;
>  			next = (curr + shift) % ring_size;
> @@ -854,8 +854,8 @@ static void gem_shuffle_tx_one_ring(struct 
> macb_queue *queue)
>  			desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
>  		if (curr == ring_size - 1)
>  			desc_curr->ctrl |= MACB_BIT(TX_WRAP);
> -		memcpy(macb_tx_skb(queue, curr), &tx_skb,
> -		       sizeof(struct macb_tx_skb));
> +		memcpy(macb_tx_buff(queue, curr), &tx_buff,
> +		       sizeof(struct macb_tx_buff));
>  	}
> 
>  	queue->tx_head = count;
> @@ -1190,21 +1190,21 @@ static int macb_halt_tx(struct macb *bp)
>  					bp, TSR);
>  }
> 
> -static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, 
> int budget)
> +static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff 
> *tx_buff, int budget)
>  {
> -	if (tx_skb->mapping) {
> -		if (tx_skb->mapped_as_page)
> -			dma_unmap_page(&bp->pdev->dev, tx_skb->mapping,
> -				       tx_skb->size, DMA_TO_DEVICE);
> +	if (tx_buff->mapping) {
> +		if (tx_buff->mapped_as_page)
> +			dma_unmap_page(&bp->pdev->dev, tx_buff->mapping,
> +				       tx_buff->size, DMA_TO_DEVICE);
>  		else
> -			dma_unmap_single(&bp->pdev->dev, tx_skb->mapping,
> -					 tx_skb->size, DMA_TO_DEVICE);
> -		tx_skb->mapping = 0;
> +			dma_unmap_single(&bp->pdev->dev, tx_buff->mapping,
> +					 tx_buff->size, DMA_TO_DEVICE);
> +		tx_buff->mapping = 0;
>  	}
> 
> -	if (tx_skb->skb) {
> -		napi_consume_skb(tx_skb->skb, budget);
> -		tx_skb->skb = NULL;
> +	if (tx_buff->skb) {
> +		napi_consume_skb(tx_buff->skb, budget);
> +		tx_buff->skb = NULL;
>  	}
>  }
> 
> @@ -1250,7 +1250,7 @@ static void macb_tx_error_task(struct work_struct 
> *work)
>  	u32			queue_index;
>  	u32			packets = 0;
>  	u32			bytes = 0;
> -	struct macb_tx_skb	*tx_skb;
> +	struct macb_tx_buff	*tx_buff;
>  	struct macb_dma_desc	*desc;
>  	struct sk_buff		*skb;
>  	unsigned int		tail;
> @@ -1290,16 +1290,16 @@ static void macb_tx_error_task(struct 
> work_struct *work)
> 
>  		desc = macb_tx_desc(queue, tail);
>  		ctrl = desc->ctrl;
> -		tx_skb = macb_tx_skb(queue, tail);
> -		skb = tx_skb->skb;
> +		tx_buff = macb_tx_buff(queue, tail);
> +		skb = tx_buff->skb;
> 
>  		if (ctrl & MACB_BIT(TX_USED)) {
>  			/* skb is set for the last buffer of the frame */
>  			while (!skb) {
> -				macb_tx_unmap(bp, tx_skb, 0);
> +				macb_tx_unmap(bp, tx_buff, 0);
>  				tail++;
> -				tx_skb = macb_tx_skb(queue, tail);
> -				skb = tx_skb->skb;
> +				tx_buff = macb_tx_buff(queue, tail);
> +				skb = tx_buff->skb;
>  			}
> 
>  			/* ctrl still refers to the first buffer descriptor
> @@ -1328,7 +1328,7 @@ static void macb_tx_error_task(struct work_struct 
> *work)
>  			desc->ctrl = ctrl | MACB_BIT(TX_USED);
>  		}
> 
> -		macb_tx_unmap(bp, tx_skb, 0);
> +		macb_tx_unmap(bp, tx_buff, 0);
>  	}
> 
>  	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
> @@ -1406,7 +1406,7 @@ static int macb_tx_complete(struct macb_queue 
> *queue, int budget)
>  	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
>  	head = queue->tx_head;
>  	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) 
> {
> -		struct macb_tx_skb	*tx_skb;
> +		struct macb_tx_buff	*tx_buff;
>  		struct sk_buff		*skb;
>  		struct macb_dma_desc	*desc;
>  		u32			ctrl;
> @@ -1426,8 +1426,8 @@ static int macb_tx_complete(struct macb_queue 
> *queue, int budget)
> 
>  		/* Process all buffers of the current transmitted frame */
>  		for (;; tail++) {
> -			tx_skb = macb_tx_skb(queue, tail);
> -			skb = tx_skb->skb;
> +			tx_buff = macb_tx_buff(queue, tail);
> +			skb = tx_buff->skb;
> 
>  			/* First, update TX stats if needed */
>  			if (skb) {
> @@ -1447,7 +1447,7 @@ static int macb_tx_complete(struct macb_queue 
> *queue, int budget)
>  			}
> 
>  			/* Now we can safely release resources */
> -			macb_tx_unmap(bp, tx_skb, budget);
> +			macb_tx_unmap(bp, tx_buff, budget);
> 
>  			/* skb is set only for the last buffer of the frame.
>  			 * WARNING: at this point skb has been freed by
> @@ -2325,8 +2325,8 @@ static unsigned int macb_tx_map(struct macb *bp,
>  	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
>  	unsigned int len, i, tx_head = queue->tx_head;
>  	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
> +	struct macb_tx_buff *tx_buff = NULL;
>  	unsigned int eof = 1, mss_mfs = 0;
> -	struct macb_tx_skb *tx_skb = NULL;
>  	struct macb_dma_desc *desc;
>  	unsigned int offset, size;
>  	dma_addr_t mapping;
> @@ -2349,7 +2349,7 @@ static unsigned int macb_tx_map(struct macb *bp,
> 
>  	offset = 0;
>  	while (len) {
> -		tx_skb = macb_tx_skb(queue, tx_head);
> +		tx_buff = macb_tx_buff(queue, tx_head);
> 
>  		mapping = dma_map_single(&bp->pdev->dev,
>  					 skb->data + offset,
> @@ -2358,10 +2358,10 @@ static unsigned int macb_tx_map(struct macb 
> *bp,
>  			goto dma_error;
> 
>  		/* Save info to properly release resources */
> -		tx_skb->skb = NULL;
> -		tx_skb->mapping = mapping;
> -		tx_skb->size = size;
> -		tx_skb->mapped_as_page = false;
> +		tx_buff->skb = NULL;
> +		tx_buff->mapping = mapping;
> +		tx_buff->size = size;
> +		tx_buff->mapped_as_page = false;
> 
>  		len -= size;
>  		offset += size;
> @@ -2378,7 +2378,7 @@ static unsigned int macb_tx_map(struct macb *bp,
>  		offset = 0;
>  		while (len) {
>  			size = umin(len, bp->max_tx_length);
> -			tx_skb = macb_tx_skb(queue, tx_head);
> +			tx_buff = macb_tx_buff(queue, tx_head);
> 
>  			mapping = skb_frag_dma_map(&bp->pdev->dev, frag,
>  						   offset, size, DMA_TO_DEVICE);
> @@ -2386,10 +2386,10 @@ static unsigned int macb_tx_map(struct macb 
> *bp,
>  				goto dma_error;
> 
>  			/* Save info to properly release resources */
> -			tx_skb->skb = NULL;
> -			tx_skb->mapping = mapping;
> -			tx_skb->size = size;
> -			tx_skb->mapped_as_page = true;
> +			tx_buff->skb = NULL;
> +			tx_buff->mapping = mapping;
> +			tx_buff->size = size;
> +			tx_buff->mapped_as_page = true;
> 
>  			len -= size;
>  			offset += size;
> @@ -2398,13 +2398,13 @@ static unsigned int macb_tx_map(struct macb 
> *bp,
>  	}
> 
>  	/* Should never happen */
> -	if (unlikely(!tx_skb)) {
> +	if (unlikely(!tx_buff)) {
>  		netdev_err(bp->dev, "BUG! empty skb!\n");
>  		return 0;
>  	}
> 
>  	/* This is the last buffer of the frame: save socket buffer */
> -	tx_skb->skb = skb;
> +	tx_buff->skb = skb;
> 
>  	/* Update TX ring: update buffer descriptors in reverse order
>  	 * to avoid race condition
> @@ -2435,10 +2435,10 @@ static unsigned int macb_tx_map(struct macb 
> *bp,
> 
>  	do {
>  		i--;
> -		tx_skb = macb_tx_skb(queue, i);
> +		tx_buff = macb_tx_buff(queue, i);
>  		desc = macb_tx_desc(queue, i);
> 
> -		ctrl = (u32)tx_skb->size;
> +		ctrl = (u32)tx_buff->size;
>  		if (eof) {
>  			ctrl |= MACB_BIT(TX_LAST);
>  			eof = 0;
> @@ -2461,7 +2461,7 @@ static unsigned int macb_tx_map(struct macb *bp,
>  			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
> 
>  		/* Set TX buffer descriptor */
> -		macb_set_addr(bp, desc, tx_skb->mapping);
> +		macb_set_addr(bp, desc, tx_buff->mapping);
>  		/* desc->addr must be visible to hardware before clearing
>  		 * 'TX_USED' bit in desc->ctrl.
>  		 */
> @@ -2477,9 +2477,9 @@ static unsigned int macb_tx_map(struct macb *bp,
>  	netdev_err(bp->dev, "TX DMA map failed\n");
> 
>  	for (i = queue->tx_head; i != tx_head; i++) {
> -		tx_skb = macb_tx_skb(queue, i);
> +		tx_buff = macb_tx_buff(queue, i);
> 
> -		macb_tx_unmap(bp, tx_skb, 0);
> +		macb_tx_unmap(bp, tx_buff, 0);
>  	}
> 
>  	return -ENOMEM;
> @@ -2802,8 +2802,8 @@ static void macb_free_consistent(struct macb *bp)
>  	dma_free_coherent(dev, size, bp->queues[0].rx_ring, 
> bp->queues[0].rx_ring_dma);
> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		kfree(queue->tx_skb);
> -		queue->tx_skb = NULL;
> +		kfree(queue->tx_buff);
> +		queue->tx_buff = NULL;
>  		queue->tx_ring = NULL;
>  		queue->rx_ring = NULL;
>  	}
> @@ -2881,9 +2881,9 @@ static int macb_alloc_consistent(struct macb *bp)
>  		queue->rx_ring = rx + macb_rx_ring_size_per_queue(bp) * q;
>  		queue->rx_ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
> 
> -		size = bp->tx_ring_size * sizeof(struct macb_tx_skb);
> -		queue->tx_skb = kmalloc(size, GFP_KERNEL);
> -		if (!queue->tx_skb)
> +		size = bp->tx_ring_size * sizeof(struct macb_tx_buff);
> +		queue->tx_buff = kmalloc(size, GFP_KERNEL);
> +		if (!queue->tx_buff)
>  			goto out_err;
>  	}


Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai


Return-Path: <netdev+bounces-304107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4aIxHTdDRmpwNAsAu9opvQ
	(envelope-from <netdev+bounces-304107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC46F63E1
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:53:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b="YyCq/OUg";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304107-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304107-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20514319B6FD
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432DB3A7F6B;
	Thu,  2 Jul 2026 10:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC439D6F2;
	Thu,  2 Jul 2026 10:43:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988997; cv=none; b=lod43z5O9Jqo3D57Gvw+nprXf2r8eLgvfmWrCXYsjXfTacMRjNABKbowCVAjxW7hH51FIiZa20zV5EvFth9XryPu0hOAWHgf7lcF2Ip+vnhHIp/IW5h3mIP413qE1VQnqYMCPDWZY9tZT+pOW1aBddgXUNIKSXYunm6V+q9uPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988997; c=relaxed/simple;
	bh=nsPzh/zgN7ngRSlLTkKGe5aFUbv/ow2gLvGD1TkU8bY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jFuFgOZ+0iPDfytL1qOc5epebc3rWphPzKw5xue8yTp1Z8CKuthpIL8WJkbWaNBhaq+DkxLQB9mSBS7/fJR2qunpS4tXk8ei3vcm9PQXiO+g/CQwFsrMPaDkMXb4fktzhf79vwo97dm/bttaw+MkO8dTA0g/ZHmYFdFDWKHsIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YyCq/OUg; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DE2FA47FB;
	Thu,  2 Jul 2026 12:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782988993; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=djGlSa1buOQKB09c6s+Wra8IujoJXlF1brDw/moIWjQ=;
	b=YyCq/OUgNZaF9E2UgYkCt52zcoy1FIybsqm7EVp6pjiuT96VGjo4hNmEl+QeZJb8L7hw7P
	g6EE2jhM5w/2CqlPCs8HfVTEuRREr7A+oJRlU2a8xxiSxEVo9o8fIb3v9yZyeiBUpe2VcV
	5vQ6W5AeZDooNsSc7ch7Czj5YgJd5d5tBupG8d0uSX++BdMXDJDpmFNUJuxY2GMvm08wH8
	A47WjV36/iX2FKT+j1lpGCjaCqmuoWueasCfEEHY/Hhy/OoC07uHQMBBjjx/5wTPlSoWdY
	h7/+MuFMMI7sUc1zj0oNMsyvNfgu8plnxTuc3HRgA492EmTw7JvCHEOdJHdlxg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 12:43:12 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 04/15] net: macb: unify queue index variable
 naming convention and types
In-Reply-To: <20260701-macb-context-v3-4-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-4-00268d5b1502@bootlin.com>
Message-ID: <34ac1fa491f6f12ef4154f3ca1a9fb58@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-304107-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:email,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9CC46F63E1

On 1.7.2026 17:59, Théo Lebrun wrote:
> Variables are named q or queue_index. Types are int, unsigned int, u32
> and u16. Use `unsigned int q` everywhere.
> 
> Skip over taprio functions. They use `u8 queue_id` which fits with the
> `struct macb_queue_enst_config` field. Using `queue_id` everywhere
> would be too verbose.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 32 
> ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 86c0e9ccbfce..3b75797381b6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -877,7 +877,7 @@ static void gem_shuffle_tx_one_ring(struct 
> macb_queue *queue)
>  static void gem_shuffle_tx_rings(struct macb *bp)
>  {
>  	struct macb_queue *queue;
> -	int q;
> +	unsigned int q;
> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; q++, queue++)
>  		gem_shuffle_tx_one_ring(queue);
> @@ -1258,7 +1258,7 @@ static void macb_tx_error_task(struct work_struct 
> *work)
>  						      tx_error_task);
>  	bool			halt_timeout = false;
>  	struct macb		*bp = queue->bp;
> -	u32			queue_index;
> +	unsigned int		q;
>  	u32			packets = 0;
>  	u32			bytes = 0;
>  	struct macb_tx_skb	*tx_skb;
> @@ -1267,9 +1267,9 @@ static void macb_tx_error_task(struct work_struct 
> *work)
>  	unsigned int		tail;
>  	unsigned long		flags;
> 
> -	queue_index = queue - bp->queues;
> +	q = queue - bp->queues;
>  	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = 
> %u\n",
> -		    queue_index, queue->tx_tail, queue->tx_head);
> +		    q, queue->tx_tail, queue->tx_head);
> 
>  	/* Prevent the queue NAPI TX poll from running, as it calls
>  	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
> @@ -1342,7 +1342,7 @@ static void macb_tx_error_task(struct work_struct 
> *work)
>  		macb_tx_unmap(bp, tx_skb, 0);
>  	}
> 
> -	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, 
> queue_index),
> +	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
>  				  packets, bytes);
> 
>  	/* Set end of TX queue */
> @@ -1407,7 +1407,7 @@ static bool ptp_one_step_sync(struct sk_buff 
> *skb)
>  static int macb_tx_complete(struct macb_queue *queue, int budget)
>  {
>  	struct macb *bp = queue->bp;
> -	u16 queue_index = queue - bp->queues;
> +	unsigned int q = queue - bp->queues;
>  	unsigned long flags;
>  	unsigned int tail;
>  	unsigned int head;
> @@ -1469,14 +1469,14 @@ static int macb_tx_complete(struct macb_queue 
> *queue, int budget)
>  		}
>  	}
> 
> -	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, 
> queue_index),
> +	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
>  				  packets, bytes);
> 
>  	queue->tx_tail = tail;
> -	if (__netif_subqueue_stopped(bp->netdev, queue_index) &&
> +	if (__netif_subqueue_stopped(bp->netdev, q) &&
>  	    CIRC_CNT(queue->tx_head, queue->tx_tail,
>  		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
> -		netif_wake_subqueue(bp->netdev, queue_index);
> +		netif_wake_subqueue(bp->netdev, q);
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
> 
>  	if (packets)
> @@ -2470,10 +2470,10 @@ static int macb_pad_and_fcs(struct sk_buff 
> **skb, struct net_device *netdev)
>  static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
>  				   struct net_device *netdev)
>  {
> -	u16 queue_index = skb_get_queue_mapping(skb);
>  	struct macb *bp = netdev_priv(netdev);
> -	struct macb_queue *queue = &bp->queues[queue_index];
> +	unsigned int q = skb_get_queue_mapping(skb);
>  	unsigned int desc_cnt, nr_frags, frag_size, f;
> +	struct macb_queue *queue = &bp->queues[q];
>  	unsigned int hdrlen;
>  	unsigned long flags;
>  	bool is_lso;
> @@ -2512,8 +2512,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff 
> *skb,
> 
>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
>  	netdev_vdbg(bp->netdev,
> -		    "start_xmit: queue %hu len %u head %p data %p tail %p end %p\n",
> -		    queue_index, skb->len, skb->head, skb->data,
> +		    "start_xmit: queue %u len %u head %p data %p tail %p end %p\n",
> +		    q, skb->len, skb->head, skb->data,
>  		    skb_tail_pointer(skb), skb_end_pointer(skb));
>  	print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_OFFSET, 16, 1,
>  		       skb->data, 16, true);
> @@ -2539,7 +2539,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff 
> *skb,
>  	/* This is a hard error, log it. */
>  	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
>  		       bp->tx_ring_size) < desc_cnt) {
> -		netif_stop_subqueue(netdev, queue_index);
> +		netif_stop_subqueue(netdev, q);
>  		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
>  			   queue->tx_head, queue->tx_tail);
>  		ret = NETDEV_TX_BUSY;
> @@ -2555,7 +2555,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff 
> *skb,
>  	/* Make newly initialized descriptor visible to hardware */
>  	wmb();
>  	skb_tx_timestamp(skb);
> -	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, queue_index),
> +	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, q),
>  			     skb->len);
> 
>  	spin_lock(&bp->lock);
> @@ -2564,7 +2564,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff 
> *skb,
>  	spin_unlock(&bp->lock);
> 
>  	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
> -		netif_stop_subqueue(netdev, queue_index);
> +		netif_stop_subqueue(netdev, q);
> 
>  unlock:
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);


Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai


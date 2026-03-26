Return-Path: <netdev+bounces-271918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMfjOdLoxGkz5AQAu9opvQ
	(envelope-from <netdev+bounces-271918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:05:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9908D330D68
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFE353016292
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1032D0D8;
	Thu, 26 Mar 2026 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="FOPWcjiw"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284A3358CA
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512328; cv=none; b=JkjmCDAygnyqpVggfNZuwaz6WXfXj6GkAtohGghRa/QjjFTScti6UrNii8gU+mMNal04b29n7ECquljGTwxh6qal7D9os8qqrTQuSBOEN1ekYsfIA6z20aftJ1gqmhVtoqqX29CbsuP7ij5lZF1DriConvJA5+Sxj88C544SxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512328; c=relaxed/simple;
	bh=9wJ71LxpILJl44YL113wokPkiVEFEtGh/MJTaDW7wrQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XOyJYc+DVP/roqFQkFkCwxA7mqBl+be3FQU9Y6G8lx1ObWFkIMouNKZUmNAWNpNWpXkmkm9zpgQtQ2wcHoCqXhxDmahCjqpqXZZY/m2JrHxRw9GzNYj/NA9CctRUJ2PeV/6M3y1ruITeZL/GzQK73oTb9P6pC/JF+H93XU3gmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=FOPWcjiw; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49283A01B0;
	Thu, 26 Mar 2026 09:05:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774512307; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=whsWTcW5PiCLfz/qARG/Bj4nETnVxdesXeV+0obqvbM=;
	b=FOPWcjiwyTstifNuReH1UAYl18XV1FzgTojUZSlQqIU+a9iN8xMy+6qHP4s81d653zH+SR
	M8udR+PhJgph3+B1zeIz+AwsxpJAPmBXe+1UKl/Pijx48TpaAeW/JALtBSsb+5A0SyrHoF
	hWM/8kjBfw9rmn64hq1W3HJUq75mmvmEgSPXtkjgmA83X0kHXI3FwqgL8GQy+dbykMT0Le
	jMEdCUkXNlarqdyHOA16t3861bcvDiMzix+qGzMfScB41v1lqER3raMWR5lxIHzXO/sF9D
	kvEKnSvP2JzMNV3XufZhstjN2bD3QJi0PL5j3BKHupBPxyG5soYk//5kY/sfNw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 09:05:04 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: justin.chen@broadcom.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com
Subject: Re: [PATCH RFC net] net: bcmgenet: fix leaking and racing timeout
 handler
In-Reply-To: <20260325173602.3676778-1-justin.chen@broadcom.com>
References: <20260325173602.3676778-1-justin.chen@broadcom.com>
Message-ID: <df5781320ba8e27f55743c0613fea23a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271918-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.444];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9908D330D68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25.3.2026 18:36, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> The bcmgenet_timeout handler tries to take down all tx queues when
> a single queue times out. This is over zealous and causes many race
> conditions with queues that are still chugging along. Instead lets
> only restart the timed out queue.
> 
> While reclaiming the tx queue we fast forward the write pointer to
> drop any data in flight. These dropped frames are not added back
> to the pool of free bds. We also need to tell the netdev that we
> are dropping said data.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  .../net/ethernet/broadcom/genet/bcmgenet.c    | 24 +++++++++----------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 482a31e7b72b..f69cf490445c 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -1985,6 +1985,7 @@ static unsigned int bcmgenet_tx_reclaim(struct 
> net_device *dev,
>  		drop = (ring->prod_index - ring->c_index) & DMA_C_INDEX_MASK;
>  		released += drop;
>  		ring->prod_index = ring->c_index & DMA_C_INDEX_MASK;
> +		ring->free_bds += drop;
>  		while (drop--) {
>  			cb_ptr = bcmgenet_put_txcb(priv, ring);
>  			skb = cb_ptr->skb;
> @@ -1996,6 +1997,7 @@ static unsigned int bcmgenet_tx_reclaim(struct 
> net_device *dev,
>  		}
>  		if (skb)
>  			dev_consume_skb_any(skb);
> +		netdev_tx_reset_queue(netdev_get_tx_queue(dev, ring->index));
>  		bcmgenet_tdma_ring_writel(priv, ring->index,
>  					  ring->prod_index, TDMA_PROD_INDEX);
>  		wr_ptr = ring->write_ptr * WORDS_PER_BD(priv);
> @@ -3475,27 +3477,23 @@ static void bcmgenet_dump_tx_queue(struct 
> bcmgenet_tx_ring *ring)
>  static void bcmgenet_timeout(struct net_device *dev, unsigned int 
> txqueue)
>  {
>  	struct bcmgenet_priv *priv = netdev_priv(dev);
> -	u32 int1_enable = 0;
> -	unsigned int q;
> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[txqueue];
> +	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
> 
>  	netif_dbg(priv, tx_err, dev, "bcmgenet_timeout\n");
> 
> -	for (q = 0; q <= priv->hw_params->tx_queues; q++)
> -		bcmgenet_dump_tx_queue(&priv->tx_rings[q]);
> -
> -	bcmgenet_tx_reclaim_all(dev);
> +	bcmgenet_dump_tx_queue(ring);
> 
> -	for (q = 0; q <= priv->hw_params->tx_queues; q++)
> -		int1_enable |= (1 << q);
> +	bcmgenet_tx_reclaim(dev, ring, true);
> 
> -	/* Re-enable TX interrupts if disabled */
> -	bcmgenet_intrl2_1_writel(priv, int1_enable, INTRL2_CPU_MASK_CLEAR);
> +	/* Re-enable the TX interrupt for this ring */
> +	bcmgenet_intrl2_1_writel(priv, 1 << txqueue, INTRL2_CPU_MASK_CLEAR);
> 
> -	netif_trans_update(dev);
> +	txq_trans_cond_update(txq);
> 
> -	BCMGENET_STATS64_INC((&priv->tx_rings[txqueue].stats64), errors);
> +	BCMGENET_STATS64_INC((&ring->stats64), errors);
> 
> -	netif_tx_wake_all_queues(dev);
> +	netif_tx_wake_queue(txq);
>  }
> 
>  #define MAX_MDF_FILTER	17

Can confirm that the lockup is gone with this patch. The watchdog still 
reports a timeout (as already mentioned by you):

[Thu Mar 26 08:00:30 2026] bcmgenet fd580000.ethernet eth0: NETDEV 
WATCHDOG: CPU: 0: transmit queue 0 timed out 2377 ms
[Thu Mar 26 08:00:32 2026] bcmgenet fd580000.ethernet eth0: NETDEV 
WATCHDOG: CPU: 0: transmit queue 4 timed out 4361 ms
[Thu Mar 26 08:00:34 2026] bcmgenet fd580000.ethernet eth0: NETDEV 
WATCHDOG: CPU: 0: transmit queue 4 timed out 2001 ms

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de
Tested-by: Nicolai Buchwitz <nb@tipi-net.de

Thanks
Nicolai


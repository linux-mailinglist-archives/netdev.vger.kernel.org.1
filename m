Return-Path: <netdev+bounces-297990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gT77L/xsKmqipAMAu9opvQ
	(envelope-from <netdev+bounces-297990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5F666FB44
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:08:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b="uavAd0B/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297990-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297990-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6B8E3008D5F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB48376A1F;
	Thu, 11 Jun 2026 08:08:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022D376463;
	Thu, 11 Jun 2026 08:08:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165305; cv=none; b=cQBmY2lJk1gbHZXAUu5XU5xjl8qSvlsO/ajgreZPWGcj603vA7JhqMkeYGpxFkFk+y98hAZ9E+f9cDmtRTtlrTXI2qO1GIvsd6RZIPBLS7OS//6fnIdwXQ9LwjHW1nC7mBOP2x6gcGJK8gyiHZrQD90CCAijgkwuNRX1Q40enL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165305; c=relaxed/simple;
	bh=YeEFsRjcZN9SAER9k43kKoxLaDdlVU5dxDMH8Wj5Iuk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cGt22c8UDqEkxd8Nz2ZSgDDAQlzHzj95el2qaASxYhUyjcw+a6zc7buVGimEb7nXlgRoA7h8FyODdqnhjTIqypne+yZ0vvO0JMcPKl8C3sljTh2v99IqX05BdeE77P1u/wDAFwwHB/z9wWiofUZrVrlz4VuYQPmjlOimc7eA1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=uavAd0B/; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0774A02E1;
	Thu, 11 Jun 2026 10:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781165297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AZlM9qbYrXNUN+PrXoDdUvcgMafUMaCV7VEgzQFqPqY=;
	b=uavAd0B/0mM+xgYi17vRN8GESYUuExOqZBJrA6q/+Abz4FLnv19eq96L8hI6xJymKqFvrm
	b597GqXNHbwQheFy6SFErM6+oXytOce2wL7unwxO3X78U1+OCVr/eGrCqkIlCj8YVmxqPy
	goqaQhDQXF6I2OyEy0mUFRL8Hr6nUoDNi5iKvBv3EE9AHo4wSnpH1cUfVLYWbOgshEX/Fr
	VUrASKKR3rIpYEfkWF1Xl/atwCoDCk7JbuBhupPmJ24eR6Ovqhp6dNzbWkBXiPlE+mZrLz
	YyThA60AHzKfvi45qeWtzi+ug00L4yj21RiYrKRCS0ktqm7E2H0rS9oloPtcWg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Jun 2026 10:08:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: Use weighted round-robin TX DMA
 arbitration
In-Reply-To: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
References: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
Message-ID: <2f7e70123887fcfd8bbf4ce92f73574d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297990-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ovidiu.panait.rb@renesas.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A5F666FB44

Hi Ovidiu

This seems to be a good follow-up to Justin's earlier series [1].

On 10.6.2026 10:52, Ovidiu Panait wrote:
> Under heavy network traffic, we observed sporadic TX queue timeouts on 
> the
> Raspberry Pi 4. The timeouts can be reproduced by stress testing the TX
> path with multiple concurrent iperf UDP streams:
> 
>     iperf3 -c <ip> -u -b0 -P16 -t60
>     NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 2044 ms
>     NETDEV WATCHDOG: CPU: 3: transmit queue 0 timed out 2004 ms
> 
> Investigation showed that the timeouts are caused by the priority-based
> arbiter. Under heavy load the highest priority queue starves the lower
> priority ones, causing timeouts. The TX strict priority arbiter is not
> suitable for the default use case where all the traffic gets spread
> across all the TX queues.
> 
> Therefore, to fix this, switch the TX DMA arbiter to Weighted 
> Round-Robin,
> which services all queues, so they do not stall. The weights were 
> chosen
> to follow the existing priority scheme: q0 gets the smallest weight, 
> while
> q1-4 get the bulk of the TX bandwidth.
> 
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---

AFAIK the existing queue mechanism dates back to the STB QoS use cases 
Florian
had in mind when he wrote the driver, so let's hear what he has to say 
on this.

The change itself looks correct to me. My concern is the targeting. This
flips the default policy for every GENET user rather than fixing a 
specific
defect, and Justin's series already called the persistent timeouts a 
design
issue rather than a bug.

So isn't this more net-next material than net with a broad Fixes: tag?
Please also add to the commit message that it drops the existing 
priority
handling for rings 1-4.

>  .../net/ethernet/broadcom/genet/bcmgenet.c    | 23 +++++++------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 7c11cf916762..ad08c67269be 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -40,9 +40,8 @@
> 
>  #include "bcmgenet.h"
> 
> -/* Default highest priority queue for multi queue support */
> -#define GENET_Q1_PRIORITY	0
> -#define GENET_Q0_PRIORITY	1
> +#define GENET_Q0_WEIGHT		1
> +#define GENET_Q1_WEIGHT		4
> 
>  #define GENET_Q0_RX_BD_CNT	\
>  	(TOTAL_DESC - priv->hw_params->rx_queues * 
> priv->hw_params->rx_bds_per_q)
> @@ -2129,13 +2128,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff 
> *skb, struct net_device *dev)
>  	int i;
> 
>  	index = skb_get_queue_mapping(skb);
> -	/* Mapping strategy:
> -	 * queue_mapping = 0, unclassified, packet xmited through ring 0
> -	 * queue_mapping = 1, goes to ring 1. (highest priority queue)
> -	 * queue_mapping = 2, goes to ring 2.
> -	 * queue_mapping = 3, goes to ring 3.
> -	 * queue_mapping = 4, goes to ring 4.
> -	 */
>  	ring = &priv->tx_rings[index];
>  	txq = netdev_get_tx_queue(dev, index);
> 
> @@ -2881,8 +2873,9 @@ static int bcmgenet_rdma_disable(struct 
> bcmgenet_priv *priv)
> 
>  /* Initialize Tx queues
>   *
> - * Queues 1-4 are priority-based, each one has 32 descriptors,
> - * with queue 1 being the highest priority queue.
> + * Queues 1-4 are the priority queues, each one has 32 descriptors.
> + * The weighted round-robin arbiter gives them a larger share of TX
> + * bandwidth than the default queue 0.
>   *
>   * Queue 0 is the default Tx queue with
>   * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
> @@ -2900,8 +2893,8 @@ static void bcmgenet_init_tx_queues(struct 
> net_device *dev)
>  	unsigned int start = 0, end = GENET_Q0_TX_BD_CNT;
>  	u32 i, ring_mask, dma_priority[3] = {0, 0, 0};
> 
> -	/* Enable strict priority arbiter mode */
> -	bcmgenet_tdma_writel(priv, DMA_ARBITER_SP, DMA_ARB_CTRL);
> +	/* Enable Weighted Round-Robin arbiter mode */
> +	bcmgenet_tdma_writel(priv, DMA_ARBITER_WRR, DMA_ARB_CTRL);
> 
>  	/* Initialize Tx priority queues */
>  	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
> @@ -2909,7 +2902,7 @@ static void bcmgenet_init_tx_queues(struct 
> net_device *dev)
>  		start = end;
>  		end += priv->hw_params->tx_bds_per_q;
>  		dma_priority[DMA_PRIO_REG_INDEX(i)] |=
> -			(i ? GENET_Q1_PRIORITY : GENET_Q0_PRIORITY)
> +			(i ? GENET_Q1_WEIGHT : GENET_Q0_WEIGHT)
>  			<< DMA_PRIO_REG_SHIFT(i);
>  	}

[1] 
https://lore.kernel.org/netdev/20260406175756.134567-1-justin.chen@broadcom.com/

Thanks
Nicolai


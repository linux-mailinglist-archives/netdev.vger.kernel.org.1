Return-Path: <netdev+bounces-253573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGU6BFq+d2l8kgEAu9opvQ
	(envelope-from <netdev+bounces-253573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:19:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB138C7EA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B31230238D1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34B27AC5C;
	Mon, 26 Jan 2026 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tRgO1tz+"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42CC279DB3
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455072; cv=none; b=p8k4P0iKfK5Ehg5TdKI4rR0mjae9Yh/bDCw8QOOdCi7gsz/7D9jgmUhwI2yIQd10eID3I/5iZJBSdsRaO6wJQUGvj48hysA02vAIQBSyWtuLltBiZI6GrX5+YoSXJ/N1LT3f36hBeBviDiPLu5Zz1YMvBcDHXaAK4hR6sIcqCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455072; c=relaxed/simple;
	bh=LbjZePeNTvTkkMh5FiU3nnSxLkqi2vYMrRy0ZrGHjXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcNYntWFZuEijb24jF8K6Dx5iSucwPE03K8aiq4re5oqWxyBJtdJWXuvj8gqgVU9n5cdJTqoAi2DSMwYL89EXyvy2iGd1TJMgglbUVfyxHcvvFmWLvG7HZxVJ2UObI83kZZOcJMkH2btPPgzlXVVFNLdQ0LkaZJvMuxtcV0iDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tRgO1tz+; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <77e06763-76a8-46ab-9a51-efc708720a98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769455067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpzz2UljQE3YZ9pOoTuAUnr4osF8V6q48LrSRhifpHs=;
	b=tRgO1tz+fphioTCkeEXld67Mf3fvL/ltdmMKnA3VwBlgXj6mSkDEd21S8MCkKzF0l79rst
	ZmpmriDg9gGMo773dWMBKPPRh8bFaf+LMVQ73ruR3HgkV9LmfX+k9ESfaCQo0osv2kLbn4
	GCMMg8l6QKKsmUTJp7eR885LirKi9CY=
Date: Mon, 26 Jan 2026 19:17:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next] net: systemport: Use u64_stats_t with
 u64_stats_sync properly
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260122201545.2792428-1-mmyangfl@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260122201545.2792428-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253573-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 5EB138C7EA
X-Rspamd-Action: no action

On 22/01/2026 20:15, David Yang wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> RFC Comment:
> 
> I couldn't find the lock associated with u64_stats_sync. Should this be
> considered an issue?

Didn't get the question. u64_stats_sync structure has it's own lock for 
cases where atomic operations are not possible.

>   drivers/net/ethernet/broadcom/bcmsysport.c | 56 ++++++++++++----------
>   drivers/net/ethernet/broadcom/bcmsysport.h | 12 ++---
>   2 files changed, 37 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index bc4e1f3b3752..7017b2d2a1b5 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -435,8 +435,8 @@ static void bcm_sysport_update_tx_stats(struct bcm_sysport_priv *priv,
>   		ring = &priv->tx_rings[q];
>   		do {
>   			start = u64_stats_fetch_begin(&priv->syncp);
> -			bytes = ring->bytes;
> -			packets = ring->packets;
> +			bytes = u64_stats_read(&ring->bytes);
> +			packets = u64_stats_read(&ring->packets);
>   		} while (u64_stats_fetch_retry(&priv->syncp, start));

please, look the comment below which includes reference to this block...

>   
>   		*tx_bytes += bytes;
> @@ -458,8 +458,10 @@ static void bcm_sysport_get_stats(struct net_device *dev,
>   	if (netif_running(dev)) {
>   		bcm_sysport_update_mib_counters(priv);
>   		bcm_sysport_update_tx_stats(priv, &tx_bytes, &tx_packets);
> -		stats64->tx_bytes = tx_bytes;
> -		stats64->tx_packets = tx_packets;
> +		u64_stats_update_begin(&priv->syncp);
> +		u64_stats_set(&stats64->tx_bytes, tx_bytes);
> +		u64_stats_set(&stats64->tx_packets, tx_packets);
> +		u64_stats_update_end(&priv->syncp);
>   	}
>   
>   	for (i =  0, j = 0; i < BCM_SYSPORT_STATS_LEN; i++) {
> @@ -482,28 +484,32 @@ static void bcm_sysport_get_stats(struct net_device *dev,
>   		    s->type == BCM_SYSPORT_STAT_NETDEV64) {
>   			do {
>   				start = u64_stats_fetch_begin(syncp);
> -				data[i] = *(u64 *)p;
> +				data[i] = u64_stats_read((u64_stats_t *)p);
>   			} while (u64_stats_fetch_retry(syncp, start));
>   		} else
>   			data[i] = *(u32 *)p;
>   		j++;
>   	}
>   
> -	/* For SYSTEMPORT Lite since we have holes in our statistics, j would
> -	 * be equal to BCM_SYSPORT_STATS_LEN at the end of the loop, but it
> -	 * needs to point to how many total statistics we have minus the
> -	 * number of per TX queue statistics
> -	 */
> -	j = bcm_sysport_get_sset_count(dev, ETH_SS_STATS) -
> -	    dev->num_tx_queues * NUM_SYSPORT_TXQ_STAT;
> +	do {
> +		/* For SYSTEMPORT Lite since we have holes in our statistics, j
> +		 * would be equal to BCM_SYSPORT_STATS_LEN at the end of the
> +		 * loop, but it needs to point to how many total statistics we
> +		 * have minus the number of per TX queue statistics
> +		 */
> +		j = bcm_sysport_get_sset_count(dev, ETH_SS_STATS) -
> +		    dev->num_tx_queues * NUM_SYSPORT_TXQ_STAT;
>   
> -	for (i = 0; i < dev->num_tx_queues; i++) {
> -		ring = &priv->tx_rings[i];
> -		data[j] = ring->packets;
> -		j++;
> -		data[j] = ring->bytes;
> -		j++;
> -	}
> +		start = u64_stats_fetch_begin(syncp);
> +
> +		for (i = 0; i < dev->num_tx_queues; i++) {
> +			ring = &priv->tx_rings[i];
> +			data[j] = u64_stats_read(&ring->packets);
> +			j++;
> +			data[j] = u64_stats_read(&ring->bytes);
> +			j++;
> +		}
> +	} while (u64_stats_fetch_retry(syncp, start));

ring is protected by ring::lock, there is no need to introduce another
per-device lock. ring statistics can be protected by the same lock, and
to improve the code, ring::lock can be converted into seqlock_t.


>   }
>   
>   static void bcm_sysport_get_wol(struct net_device *dev,
> @@ -829,8 +835,8 @@ static unsigned int bcm_sysport_desc_rx(struct bcm_sysport_priv *priv,
>   		ndev->stats.rx_packets++;
>   		ndev->stats.rx_bytes += len;
>   		u64_stats_update_begin(&priv->syncp);
> -		stats64->rx_packets++;
> -		stats64->rx_bytes += len;
> +		u64_stats_inc(&stats64->rx_packets);
> +		u64_stats_add(&stats64->rx_bytes, len);
>   		u64_stats_update_end(&priv->syncp);
>   
>   		napi_gro_receive(&priv->napi, skb);
> @@ -914,8 +920,8 @@ static unsigned int __bcm_sysport_tx_reclaim(struct bcm_sysport_priv *priv,
>   	}
>   
>   	u64_stats_update_begin(&priv->syncp);
> -	ring->packets += pkts_compl;
> -	ring->bytes += bytes_compl;
> +	u64_stats_add(&ring->packets, pkts_compl);
> +	u64_stats_add(&ring->bytes, bytes_compl);
>   	u64_stats_update_end(&priv->syncp);

here again, no need for device-wide lock in hot path.

>   
>   	ring->c_index = c_index;
> @@ -1857,8 +1863,8 @@ static void bcm_sysport_get_stats64(struct net_device *dev,
>   
>   	do {
>   		start = u64_stats_fetch_begin(&priv->syncp);
> -		stats->rx_packets = stats64->rx_packets;
> -		stats->rx_bytes = stats64->rx_bytes;
> +		stats->rx_packets = u64_stats_read(&stats64->rx_packets);
> +		stats->rx_bytes = u64_stats_read(&stats64->rx_bytes);
>   	} while (u64_stats_fetch_retry(&priv->syncp, start));
>   }
>   
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
> index a34296f989f1..91b1c8293a23 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.h
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.h
> @@ -652,10 +652,10 @@ struct bcm_sysport_stats {
>   
>   struct bcm_sysport_stats64 {
>   	/* 64bit stats on 32bit/64bit Machine */
> -	u64	rx_packets;
> -	u64	rx_bytes;
> -	u64	tx_packets;
> -	u64	tx_bytes;
> +	u64_stats_t	rx_packets;
> +	u64_stats_t	rx_bytes;
> +	u64_stats_t	tx_packets;
> +	u64_stats_t	tx_bytes;
>   };
>   
>   /* Software house keeping helper structure */
> @@ -698,8 +698,8 @@ struct bcm_sysport_tx_ring {
>   	unsigned int	clean_index;	/* Current clean index */
>   	struct bcm_sysport_cb *cbs;	/* Transmit control blocks */
>   	struct bcm_sysport_priv *priv;	/* private context backpointer */
> -	unsigned long	packets;	/* packets statistics */
> -	unsigned long	bytes;		/* bytes statistics */
> +	u64_stats_t	packets;	/* packets statistics */
> +	u64_stats_t	bytes;		/* bytes statistics */
>   	unsigned int	switch_queue;	/* switch port queue number */
>   	unsigned int	switch_port;	/* switch port queue number */
>   	bool		inspect;	/* inspect switch port and queue */



Return-Path: <netdev+bounces-274492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDMuAR1VzmnPmwYAu9opvQ
	(envelope-from <netdev+bounces-274492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6F33886CF
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5361312794B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902263D3302;
	Thu,  2 Apr 2026 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="IcmjhvQf"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470E3C5DBE;
	Thu,  2 Apr 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129362; cv=none; b=o1bjoooaoC/aBcDinmrp5wLaj6gJESMeOBcBrDJhvtTPEAct1B4tHzy0pyTm2j5shZix6xfuEYuiT0I4wUWriAqlHgmQZPauFfG6S77V1lPSM157qsWLfeDGq6faUmJNwdwVxXojUKy8anDYURvi6/hST4wZxdgNWcF2L1MsOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129362; c=relaxed/simple;
	bh=UFM3F4KxTa/Q/A6kQ2KBWsGLMi8ygz/21/zclF/AMew=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FK4qRdkj1Nxqq0BPObdwA8My/MyJcGvnxK9xEmuA/aeGnTvcrOuy7DkAE9BtCej669NlWsI4OPgKFZf8vfBLprztnSPda4/ApnmiGOPedEcSLDiyTZqjZMr8GcFbjBnTcRoKuRGv0YVxURmL+c0AwIiSqM6VjVERrDOhhem4jGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=IcmjhvQf; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51FB6A5888;
	Thu,  2 Apr 2026 13:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775129350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S6Fc+VQFNJS59febgRn5r7bQIXRkfyasJ4vaWi2ydds=;
	b=IcmjhvQfDyvEvVVKXQmqSORotoC1OhiBAhN2nE4jTRwaow33IY8SGWASuzdmP/gQPm6tBY
	5uRT3ZQHHeY1hwa4GRNzyYMpsWbWilxqR2WSHkVqZr5CULNgMRlk9JFBzuJ5ArSZGnJ4NJ
	QCJTasyNQcqIgZv8yrdPzEOB+Eh2e1AK2xC9uuKFDDsPRNrzQZeix6jT8TB4qhfOlurlN+
	Oilg85Po74PQwvE3fEU5FuDTcNL7Jwbph4wIu0W22T3qsd51eeChPyY7vtPBQ8OET4XU9P
	6pt/krU45O7hS+Jr3J7qo2pZRegZsNS4g/SwK4kZEEAY9Gubq+t3CYIgqv+KDQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 13:29:08 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>, Paolo
 Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/11] net: macb: use context swapping in
 .set_ringparam()
In-Reply-To: <20260401-macb-context-v1-10-9590c5ab7272@bootlin.com>
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-10-9590c5ab7272@bootlin.com>
Message-ID: <90f843aa3940bdbabadddce27314c1f1@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,mobileye.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tipi-net.de:dkim,tipi-net.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C6F33886CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 18:39, Théo Lebrun wrote:
> ethtool_ops.set_ringparam() is implemented using the primitive close /
> update ring size / reopen sequence. Under memory pressure this does not
> fly: we free our buffers at close and cannot reallocate new ones at
> open. Also, it triggers a slow PHY reinit.
> 
> Instead, exploit the new context mechanism and improve our sequence to:
>  - allocate a new context (including buffers) first
>  - if it fails, early return without any impact to the interface
>  - stop interface
>  - update global state (bp, netdev, etc)
>  - pass buffer pointers to the hardware
>  - start interface
>  - free old context.
> 
> The HW disable sequence is inspired by macb_reset_hw() but avoids
> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
> 
> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
> over register writes which would be redundant (because values have not
> changed).
> 
> The generic context swapping parts are isolated into helper functions
> macb_context_swap_start|end(), reusable by other operations 
> (change_mtu,
> set_channels, etc).
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 89 
> +++++++++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 42b19b969f3e..543356554c11 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2905,6 +2905,76 @@ static struct macb_context 
> *macb_context_alloc(struct macb *bp,
>  	return ctx;
>  }
> 
> +static void macb_context_swap_start(struct macb *bp)
> +{
> +	struct macb_queue *queue;
> +	unsigned int q;
> +	u32 ctrl;
> +
> +	/* Disable software Tx, disable HW Tx/Rx and disable NAPI. */
> +
> +	netif_tx_disable(bp->netdev);
> +
> +	ctrl = macb_readl(bp, NCR);
> +	macb_writel(bp, NCR, ctrl & ~(MACB_BIT(RE) | MACB_BIT(TE)));
> +
> +	macb_writel(bp, TSR, -1);
> +	macb_writel(bp, RSR, -1);
> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		queue_writel(queue, IDR, -1);
> +		queue_readl(queue, ISR);
> +		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +			queue_writel(queue, ISR, -1);
> +	}
> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		napi_disable(&queue->napi_rx);
> +		napi_disable(&queue->napi_tx);
> +	}

tx_error_task, hresp_err_bh_work, and tx_lpi_work all dereference
bp->ctx and could race with the pointer swap in swap_end.
macb_close() cancels at least tx_lpi_work here. Should these be
flushed too?

> +}
> +
> +static void macb_context_swap_end(struct macb *bp,
> +				  struct macb_context *new_ctx)
> +{
> +	struct macb_context *old_ctx;
> +	struct macb_queue *queue;
> +	unsigned int q;
> +	u32 ctrl;
> +
> +	/* Swap contexts & give buffer pointers to HW. */
> +
> +	old_ctx = bp->ctx;
> +	bp->ctx = new_ctx;
> +	macb_init_buffers(bp);
> +
> +	/* Start NAPI, HW Tx/Rx and software Tx. */
> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		napi_enable(&queue->napi_rx);
> +		napi_enable(&queue->napi_tx);
> +	}
> +
> +	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
> +		for (q = 0, queue = bp->queues; q < bp->num_queues;
> +		     ++q, ++queue) {
> +			queue_writel(queue, IER,
> +				     bp->rx_intr_mask |
> +				     MACB_TX_INT_FLAGS |
> +				     MACB_BIT(HRESP));
> +		}
> +	}
> +
> +	ctrl = macb_readl(bp, NCR);
> +	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> +
> +	netif_tx_start_all_queues(bp->netdev);
> +
> +	/* Free old context. */
> +
> +	macb_free_consistent(old_ctx);

1. kfree(old_ctx) is missing. The context struct itself leaks on
    every swap.

2. macb_close() calls netdev_tx_reset_queue() for each queue.
    Shouldn't the swap do the same? BQL accounting will be stale
    after switching to a fresh context.

3. macb_configure_dma() is not called after the swap. For
    set_ringparam this is probably fine since rx_buffer_size
    does not change, but this becomes a problem in patch 11.

> [...]


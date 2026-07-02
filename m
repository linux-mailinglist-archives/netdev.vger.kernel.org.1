Return-Path: <netdev+bounces-304101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zeCjKz1BRmqdMwsAu9opvQ
	(envelope-from <netdev+bounces-304101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51E6F61D6
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:45:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=qPDkpXWA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304101-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304101-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367CC30A57BF
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E08E3A3E60;
	Thu,  2 Jul 2026 10:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32A3909B7;
	Thu,  2 Jul 2026 10:37:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988669; cv=none; b=N8YCy6xEz6L9Gg1R9ThRQx/qxDp0lh2otWNX/QtfFiZDfw2+UdlC8kN0jam66aNx7ox0b5jTaHt1c3EI8NLvgHe954/qFHSITsgQixbRwdDi1icsdP6D2QbffdbhJ6Tx7ExHhPpsN/ljJnKM3nVEj7JQK/+SGRDjVnM56+g6Upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988669; c=relaxed/simple;
	bh=TQq8BM94Llody7zTcDlCR0KlHOODS5DNv3CKEQ0Mhe8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rclF5rak5JQGE/s7Y/UGb7whknz1hPDcKehb0WntfC2/84SsUAuXdA4WyR3Tg8y4qh65EBszOJ3JqMWQ/L1coj70NvnNzlnS9pqv7O8/fNPkV/4HDxEiKfNeInEiUt3HoCVoaLMIjA0CpFdxlfZv2oQwVlTJADWlpu3rx/YN19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=qPDkpXWA; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48BF9A47FB;
	Thu,  2 Jul 2026 12:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782988652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MfZeDdxf2No1OlsrMN9kkuz/n4uke4QXkJDunc5dEJY=;
	b=qPDkpXWAORCZ5ekz21SDE5BJhRE068qo6n+8qYePkMKoFQhxx8Z/N5pCfZv88SCrcZXou+
	zUAHZ7/p2OUrjV/o++VFsBOGGzIIJm2WZiYgDvRnQ6VW3WO7zu9AdwisfpKmsGZqBaR+IA
	6iYTmTtEVG7vcDI7ezBEV5uVTaLQm+fY/zEy/2+05KbdlcBRfUWl0W62x1LembmdaNBPk6
	dv/W64tb3nSHFQPCj1Yzeg0Pr9DIZ0mylSsWeCFoPJU2O3KZTjLDuHXMy+/ZS0FkuswNnI
	SBekAZRJdYLb1Wx4/cg8DaRshpyXxSNB1NSeeOB/Wh9bwyMGpo9NMPLP2difFg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 12:37:29 +0200
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
Subject: Re: [PATCH net-next v3 14/15] net: macb: use context swapping in
 .set_ringparam()
In-Reply-To: <20260701-macb-context-v3-14-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-14-00268d5b1502@bootlin.com>
Message-ID: <be3fb533fb7a93a809e71efef04edb91@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-304101-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E51E6F61D6

Hi Théo

On 1.7.2026 17:59, Théo Lebrun wrote:
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
> Introduce a new locking primitive (mac_cfg_lock mutex) to serialise 
> swap
> with phylink MAC callbacks. Avoid stopping phylink to avoid a slow PHY
> retrain. Those callbacks grab phydev->lock if it exists so we could
> imagine grabbing that from the swap op, but phydev->lock doesn't exist
> in the SFP case.
> 
> AT91 EMAC is handled differently as their buffer management is separate
> and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
> context swapping for them.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   2 +
>  drivers/net/ethernet/cadence/macb_main.c | 142 
> +++++++++++++++++++++++++++++--

> [...]

> +static void macb_context_swap_start(struct macb *bp)
> +{
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	unsigned int q;
> +	u32 ctrl;
> +
> +	mutex_lock(&bp->mac_cfg_lock);
> +
> +	/* Mask interrupts before disabling BH features. */
> +	spin_lock_irqsave(&bp->lock, flags);
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		queue_writel(queue, IDR, -1);
> +		queue_readl(queue, ISR);
> +		macb_queue_isr_clear(bp, queue, -1);
> +	}
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	/* Drain BH features. HW is still active and usable at this point. */
> +
> +	cancel_work_sync(&bp->hresp_err_bh_work);
> +	cancel_delayed_work_sync(&bp->tx_lpi_work);
> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		napi_disable(&queue->napi_rx);
> +		napi_disable(&queue->napi_tx);
> +		cancel_work_sync(&queue->tx_error_task);
> +		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
> +	}

Can this deadlock against a pending tx_error_task?

AFAIU macb_tx_error_task() does napi_disable(&queue->napi_tx) and later
napi_enable() on the same napi, and it can already be queued 
(macb_interrupt()
schedules it on a TX error) by the time the swap runs:

   swap_start: napi_disable(napi_tx)          /* sets SCHED, returns */
   worker:     tx_error_task: napi_disable(napi_tx)  /* spins on SCHED */
   swap_start: cancel_work_sync(tx_error_task)       /* waits on worker 
*/

napi_disable() spins until napi_enable() clears SCHED, but here the swap 
won't
re-enable until macb_context_swap_end(), and cancel_work_sync() is 
what's
holding it up. Nothing clears it.

Maybe cancel_work_sync() before the napi_disable() calls would work 
instead? IRQs
are masked just above, so AFAICT nothing can reschedule tx_error_task by 
then.

(Same path via .ndo_change_mtu() in the next patch.)

> [...]

Thanks
Nicolai


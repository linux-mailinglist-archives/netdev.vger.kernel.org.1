Return-Path: <netdev+bounces-307157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CSc/CVfgVGoKgQAAu9opvQ
	(envelope-from <netdev+bounces-307157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:55:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C2674B280
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:55:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=akqST7Ud;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307157-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307157-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B49A930379A5
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D2407CCA;
	Mon, 13 Jul 2026 12:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8513F58D9
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:54:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947248; cv=none; b=lEtndNPTJdiUD3bL+Bi2B6a0avmLWaAm0HWhUPNR4PYkoeQ2rOyxtmr4ZZxmSWuFNlSznkvb/DVSnBFLIzpwhVsvRwznCnFZadOPusipqPKz64SaXZY+c1EPmeWimGG413hZkA+quu7hf0Yedsm3xWqfAePU/fYC+Rw0g+t3/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947248; c=relaxed/simple;
	bh=OehZxVccAC4wd2LYjDLh/JhSucxZ1vPgwbdr9jlaUfw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OQNhASR6e8AVSyFwW7k7XDQjjQ0Srad2smUHzNNC6bUGH4+v9+zxrFdGgCP9oPuWiDWkxVeW4PU1IkLvSfcmAz5VUdfWXHUz3Dq7Sp8BXkzgJMc1EGmjxWAT0oISRCgFdu9/OskKaho2VaXGshbgpQdDbkcDAB/monoTBA9PvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=akqST7Ud; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4DCDF4E40D89;
	Mon, 13 Jul 2026 12:54:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0782760341;
	Mon, 13 Jul 2026 12:54:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2CDB11BD065D;
	Mon, 13 Jul 2026 14:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783947241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mj3k62TTmvevSWsdsH8Qj5L3u63d6OuBtUz4wfOK5ds=;
	b=akqST7UdTMzCuKRFjIrwGwSHlPOPFdcYWE6F9jUA2qAXNURZskV0DK6PyOUmjpmSB3s7Do
	K8myJbwXXuhvQowFp63Zy9l5R/6YxiobsJzcmB5L5rCLKa726oDEqoCTvJH2wS0j/tPYBA
	eqXro9zeKKdHa2JMYfFl/X1acfDKqeB0dM7a82y+i624zVW/vMGusR3XDobrx3xhJQXBLs
	ymh+ric142H4bQQlZheW0eBz6qNqMLyL6tvo5m+Xb2Unz2dq04QS47nMq64EqM/DhkvEbI
	7yNTH+QGPYiPTFCTUYrwdw8X7IoCs2Kzj3z6i961CHV+/AU7YIpZAUW9KQcmeQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 14:53:55 +0200
Message-Id: <DJXGIM9EGPT8.4UHNYP2Y0GOP@bootlin.com>
Subject: Re: [PATCH net-next v3 07/15] net: macb: introduce macb_context
 struct for buffer management
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <pvalerio@redhat.com>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <benoit.monin@bootlin.com>, <tawfik.bayouk@mobileye.com>,
 <thomas.petazzoni@bootlin.com>, <maxime.chevallier@bootlin.com>
To: "Paolo Abeni" <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-macb-context-v3-7-00268d5b1502@bootlin.com>
 <20260708102716.169767-1-pabeni@redhat.com>
In-Reply-To: <20260708102716.169767-1-pabeni@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307157-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,redhat.com,tipi-net.de,mobileye.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:url,bootlin.com:mid,bootlin.com:dkim,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64C2674B280

Hello Paolo's LLM,

On Wed Jul 8, 2026 at 12:27 PM CEST, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: macb: introduce macb_context struct for buffer management
>
> This patch moves per-queue ring buffers and ring-size parameters out of
> struct macb / struct macb_queue into a new struct macb_context that is
> allocated on open and freed on close, so future patches can swap in a
> new context while the interface is running.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 951a7f080225..dfb1d49d841c 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
>> @@ -1257,6 +1288,7 @@ static void macb_tx_error_task(struct work_struct =
*work)
>>  	struct macb_queue *queue =3D container_of(work, struct macb_queue,
>>  						tx_error_task);
>>  	unsigned int q =3D queue - queue->bp->queues;
>> +	struct macb_txq *txq =3D macb_txq(queue);
>>  	struct macb *bp =3D queue->bp;
>
> [High]
> Can macb_tx_error_task() dereference a freed context?
>
> macb_tx_error_task is scheduled from macb_interrupt():
>
>     schedule_work(&queue->tx_error_task);
>
> After this patch, the very first thing the worker does is:
>
>     struct macb_txq *txq =3D macb_txq(queue);
>
> which expands to &bp->ctx->txq[q] and dereferences bp->ctx.
>
> Looking at macb_close():
>
>     macb_reset_hw(bp);
>     ...
>     macb_free(bp);
>     kfree(bp->ctx);
>     bp->ctx =3D NULL;
>
> There is no cancel_work_sync(&queue->tx_error_task), and macb_reset_hw()
> does not drain the workqueue. If an interrupt scheduled the work just
> before close, or the work was already pending, the worker can run after
> kfree(bp->ctx) and hit a NULL dereference (and a use-after-free if
> macb_open() re-allocates ctx concurrently via ethtool ring reconfig).
>
> The same reasoning applies to bp->hresp_err_bh_work, which is queued
> from macb_interrupt() and whose handler calls
> mog_init_rings()/macb_init_buffers() that read bp->ctx->tx_ring_size and
> bp->ctx->{tx,rx}q[q]. cancel_work_sync(&bp->hresp_err_bh_work) is only
> called from macb_remove(), not macb_close().

All of this is a valid concern.

> Pre-patch these fields lived inside the embedded struct macb_queue so a
> late worker would touch stale-but-addressable memory; post-patch the
> first indirection through bp->ctx faults.

This pre-series analysis is wrong however. Current upstream would crash:
macb_tx_error_task() restarts the HW and it even assigns
queue->tx_ring_dma which still contains the freed DMA address
(macb_free()/macb_close() don't reset that value).

Summary: this patch turns potential memory corruption into a NULL
pointer dereference.

> Would adding cancel_work_sync(&queue->tx_error_task) per queue and
> cancel_work_sync(&bp->hresp_err_bh_work) before kfree(bp->ctx) in
> macb_close() close this window?

Yes that is the way forward. It will probably be separate and target
net/main. Not specifically because I want it backported (it'd be nice
but issue is super unlikely and no one reported it) but mostly because
this series is already 15 patches long.

>> @@ -3690,8 +3778,8 @@ static int macb_set_ringparam(struct net_device *n=
etdev,
>>  		macb_close(bp->netdev);
>>  	}
>> =20
>> -	bp->rx_ring_size =3D new_rx_size;
>> -	bp->tx_ring_size =3D new_tx_size;
>> +	bp->configured_rx_ring_size =3D new_rx_size;
>> +	bp->configured_tx_ring_size =3D new_tx_size;
>> =20
>>  	if (reset)
>>  		macb_open(bp->netdev);
>
> [Medium]
> Should the return value of macb_open() be checked here?
>
> This patch adds a new failure point inside macb_open():
>
>     bp->ctx =3D kzalloc_obj(*bp->ctx);
>     if (!bp->ctx) {
>         err =3D -ENOMEM;
>         goto pm_exit;
>     }
>
> On failure, bp->ctx remains NULL and the interface stays down, but
> macb_set_ringparam() ignores the return value and reports success to
> userspace. The commit message says the motivation is to improve
> reliability under memory pressure, but this caller silently swallows the
> new allocation failure.

No need, this series ends with context swapping and the
macb_context_swap_end() operation, which replaces the macb_open()
highlighted here, cannot fail.

>> @@ -5039,6 +5125,12 @@ static int at91ether_open(struct net_device *netd=
ev)
>>  	if (ret < 0)
>>  		return ret;
>> =20
>> +	bp->ctx =3D kzalloc_obj(*bp->ctx);
>> +	if (!bp->ctx) {
>> +		ret =3D -ENOMEM;
>> +		goto pm_exit;
>> +	}
>> +
>>  	/* Clear internal statistics */
>>  	ctl =3D macb_readl(bp, NCR);
>>  	macb_writel(bp, NCR, ctl | MACB_BIT(CLRSTAT));
>
> [Low]
> Should bp->ctx->rx_ring_size, tx_ring_size and rx_buffer_size be
> initialized on this path?
>
> macb_open() sets them from configured_{rx,tx}_ring_size and calls
> macb_init_rx_buffer_size(), but at91ether_open() leaves them at zero
> after kzalloc_obj().
>
> Helpers such as macb_rx_ring_wrap() compute:
>
>     return index & (bp->ctx->rx_ring_size - 1);
>
> which becomes index & 0xFFFFFFFF when rx_ring_size is 0. It happens to
> be harmless today because the at91ether path constrains indices to
> [0, AT91ETHER_MAX_RX_DESCR-1] independently and macb_get_regs() reports
> zeroed head/tail for the tx-less at91ether, but pre-patch macb_init_dflt(=
)
> unconditionally set bp->rx_ring_size =3D DEFAULT_RX_RING_SIZE.
>
> Any future shared helper that used tx_ring_size as a stride or divisor
> would misbehave on at91ether.

Yes. Null impact (but it would be better in theory).

>> @@ -5076,6 +5171,9 @@ static int at91ether_close(struct net_device *netd=
ev)
>> =20
>>  	at91ether_stop(bp);
>> =20
>> +	kfree(bp->ctx);
>> +	bp->ctx =3D NULL;
>> +
>>  	pm_runtime_put(&bp->pdev->dev);
>> =20
>>  	return 0;
>
> [High]
> Is there IRQ synchronization missing before freeing bp->ctx on this
> path?
>
> at91ether_stop() disables MAC RX/TX and writes IDR to mask further
> interrupts, but does not synchronize with a handler already running or
> already dispatched on another CPU. at91ether_interrupt() calls
> at91ether_rx(), which after this patch does:
>
>     struct macb_rxq *rxq =3D &bp->ctx->rxq[0];
>     ...
>     desc =3D macb_rx_desc(queue, rxq->tail);
>     ...
>     p_recv =3D rxq->buffers + rxq->tail * AT91ETHER_MAX_RBUFF_SZ;
>
> If the handler is in flight when kfree(bp->ctx); bp->ctx =3D NULL runs,
> the next access through bp->ctx faults. The macb_open()/macb_close()
> path is somewhat protected by napi_disable() before macb_free(), but
> at91ether does not use NAPI and has no equivalent barrier.
>
> Would a synchronize_irq(bp->netdev->irq) between at91ether_stop() and
> kfree(bp->ctx) close this?

Ah at91ether_interrupt() doesn't grab bp->lock as macb_interrupt() does.
Indeed synchronize_irq() would solve this.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



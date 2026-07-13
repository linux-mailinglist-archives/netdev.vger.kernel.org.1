Return-Path: <netdev+bounces-307251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zBSrJEMVVWoajwAAu9opvQ
	(envelope-from <netdev+bounces-307251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:41:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8766274DB03
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:41:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=weK7KLPX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307251-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307251-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DCB93001A48
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA983382F1;
	Mon, 13 Jul 2026 16:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232B1DFDA1;
	Mon, 13 Jul 2026 16:41:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960892; cv=none; b=m/iQvfppSQAmf2uyBsMMQ1KIny8u7GranuzI7bgxeSfosb/gSMtRHL5Bejq759/8KBPo38p3EaRcj5/7FbCMgcZCYRxZJIefDzVCb6z7Pvkbm2Ja1dWNcTjRH+36nzpUZUtnojMVe0ZKDg6XfJtRzERAVApmFt+KHtuU1sLeH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960892; c=relaxed/simple;
	bh=bcg6tFwoVL3YWWFogN2mO0WDKz5TBe7Q+dyN50fZm7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tUTGozscq2dbokmqUEA7cajsntaaLrCv0PU2RzyHytc1W1BLf1XImj8/PGjV7ME0HuoNhYBOZEtBWH9L2B/k+pjAbs7jJo36QdRe+HOvF3nO7WKAmMprko86biqJ77TEuh3M899N+fAQHSywEaQ/UZmFSmmOe3c9WMfdIZWumFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=weK7KLPX; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 72D1FC2BB14;
	Mon, 13 Jul 2026 16:41:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3A45660345;
	Mon, 13 Jul 2026 16:41:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AE3B11BD3A20;
	Mon, 13 Jul 2026 18:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783960886; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kznHa91E/ci3RkkQNuYqHNzjA7ZryX0m9Z2e76kwoqU=;
	b=weK7KLPX2TutxqjG5P8AQyQnhAhvywxiqfdPL0pmCXnz+GEJVlq9/KdH5xb5JnCpUjL5I3
	G5thWT74FUIk0QlxtAbUGKI0Ph3suqw7gQwRNcRM93uh/GNNJI4Zx2EGb6EBtE/8LzI1pa
	vkTraxZkNeNctFUbmLlE7tvTeR38v//agVtwQ9ZC9kN6SYzSzYvmMZRdl7upQdhEkgbNbU
	TII0dwimSTMS2+inKMMtUJXHI7kZABAz33BOYkeEDWq1ZSCEiub94gvRkn+m/R64hlawNI
	Sssi0+X1VXsQwYqjJoshTxSZ4++bHnNZPm4ih4kIf38Cw/S1E8dnikzREAe1tg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 18:41:19 +0200
Message-Id: <DJXLCQC0CQHH.1RMJWGMG8OE2D@bootlin.com>
Subject: Re: [PATCH net-next v3 14/15] net: macb: use context swapping in
 .set_ringparam()
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-14-00268d5b1502@bootlin.com>
 <be3fb533fb7a93a809e71efef04edb91@tipi-net.de>
In-Reply-To: <be3fb533fb7a93a809e71efef04edb91@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307251-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:url,bootlin.com:from_mime,bootlin.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8766274DB03

On Thu Jul 2, 2026 at 12:37 PM CEST, Nicolai Buchwitz wrote:
> On 1.7.2026 17:59, Th=C3=A9o Lebrun wrote:
>> ethtool_ops.set_ringparam() is implemented using the primitive close /
>> update ring size / reopen sequence. Under memory pressure this does not
>> fly: we free our buffers at close and cannot reallocate new ones at
>> open. Also, it triggers a slow PHY reinit.
>>=20
>> Instead, exploit the new context mechanism and improve our sequence to:
>>  - allocate a new context (including buffers) first
>>  - if it fails, early return without any impact to the interface
>>  - stop interface
>>  - update global state (bp, netdev, etc)
>>  - pass buffer pointers to the hardware
>>  - start interface
>>  - free old context.
>>=20
>> The HW disable sequence is inspired by macb_reset_hw() but avoids
>> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
>>=20
>> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
>> over register writes which would be redundant (because values have not
>> changed).
>>=20
>> The generic context swapping parts are isolated into helper functions
>> macb_context_swap_start|end(), reusable by other operations=20
>> (change_mtu,
>> set_channels, etc).
>>=20
>> Introduce a new locking primitive (mac_cfg_lock mutex) to serialise=20
>> swap
>> with phylink MAC callbacks. Avoid stopping phylink to avoid a slow PHY
>> retrain. Those callbacks grab phydev->lock if it exists so we could
>> imagine grabbing that from the swap op, but phydev->lock doesn't exist
>> in the SFP case.
>>=20
>> AT91 EMAC is handled differently as their buffer management is separate
>> and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
>> context swapping for them.
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.h      |   2 +
>>  drivers/net/ethernet/cadence/macb_main.c | 142=20
>> +++++++++++++++++++++++++++++--
>
>> [...]
>
>> +static void macb_context_swap_start(struct macb *bp)
>> +{
>> +	struct macb_queue *queue;
>> +	unsigned long flags;
>> +	unsigned int q;
>> +	u32 ctrl;
>> +
>> +	mutex_lock(&bp->mac_cfg_lock);
>> +
>> +	/* Mask interrupts before disabling BH features. */
>> +	spin_lock_irqsave(&bp->lock, flags);
>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> +		queue_writel(queue, IDR, -1);
>> +		queue_readl(queue, ISR);
>> +		macb_queue_isr_clear(bp, queue, -1);
>> +	}
>> +	spin_unlock_irqrestore(&bp->lock, flags);
>> +
>> +	/* Drain BH features. HW is still active and usable at this point. */
>> +
>> +	cancel_work_sync(&bp->hresp_err_bh_work);
>> +	cancel_delayed_work_sync(&bp->tx_lpi_work);
>> +
>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> +		napi_disable(&queue->napi_rx);
>> +		napi_disable(&queue->napi_tx);
>> +		cancel_work_sync(&queue->tx_error_task);
>> +		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
>> +	}
>
> Can this deadlock against a pending tx_error_task?
>
> AFAIU macb_tx_error_task() does napi_disable(&queue->napi_tx) and later
> napi_enable() on the same napi, and it can already be queued=20
> (macb_interrupt()
> schedules it on a TX error) by the time the swap runs:
>
>    swap_start: napi_disable(napi_tx)          /* sets SCHED, returns */
>    worker:     tx_error_task: napi_disable(napi_tx)  /* spins on SCHED */
>    swap_start: cancel_work_sync(tx_error_task)       /* waits on worker=
=20
> */
>
> napi_disable() spins until napi_enable() clears SCHED, but here the swap=
=20
> won't
> re-enable until macb_context_swap_end(), and cancel_work_sync() is=20
> what's
> holding it up. Nothing clears it.
>
> Maybe cancel_work_sync() before the napi_disable() calls would work=20
> instead? IRQs
> are masked just above, so AFAICT nothing can reschedule tx_error_task by=
=20
> then.

Ah yes, good catch. macb_tx_error_task() should never enter if NAPI is
disabled, else its napi_disable() will hang.

The fix sounds easy enough, as you indicated. We'll move the
cancel_work_sync(queue->tx_error_task) call to be above our swap start
napi_disable().

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



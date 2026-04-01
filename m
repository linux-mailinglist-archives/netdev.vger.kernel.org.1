Return-Path: <netdev+bounces-274251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDr4IVR9zWnGeAYAu9opvQ
	(envelope-from <netdev+bounces-274251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 22:17:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072E38008A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 22:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66E2D303FB9B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5555E344D9B;
	Wed,  1 Apr 2026 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JBqI6Pix"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5A175A7C;
	Wed,  1 Apr 2026 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074641; cv=none; b=rOOl+mpl6VWYaNlsgoBpTKF/G22irz1310exhAKeK0xDbtKB/pM0sVmWiJAG1MKj5eO+5An8Q9EZ/pWqq90gdDv5DDYJLHl+nr5EPsrSAbJ9QGppbB3BSSjvST4BuCYkU+TO7UwMW8F21Z3WP5RiHV5Lr70Pb9pURpp/BPpjqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074641; c=relaxed/simple;
	bh=v3Zi02j8XSKpJYgY+TReSXZ8p8R78iQOdOQeul8Z+A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APzrWoBZ/JokLUdrU0ALwiC5pHapnJszBek/To8qy/0usjsvL8h/FdTMtZQJiQzKhVVy1refTqNaTqZtACzAyGjS1n3F/i4CGxOgqmuETBSI5nwwCJ24/gStR5Rs+6zgeYFJ8gtY6XnNVDBUzqTb4Hoq0K0HHd3U8XeDVR9zWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JBqI6Pix; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B872D1A30DD;
	Wed,  1 Apr 2026 20:17:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7EC9C602BF;
	Wed,  1 Apr 2026 20:17:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55A5A1045029A;
	Wed,  1 Apr 2026 22:17:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775074634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2GCQ+LE9PxgYYfOKzQxTAtrzpSM2QKLd+I5JPK0w2ew=;
	b=JBqI6PixiVKd2O9cMxOt1AHLiYAzY8kKY+ID5Q4oydU3qqoUjCzjkLvn5Q8jenINtuHP4f
	iQQPeNWFqVqU1bWckwreX1Xuj+QVYGbEM4v4asdqUm4JhnBZkJ2Mkoqo+11jaCnkED1kCN
	HqMavBlAgeBn6VYISiaj9zh4hT8t+3mSbs7mYfdK9yUP2aRbS2oEEFssao46Vs69buh/d4
	qUoQsRkmL+EYeA+UCKlaHXlpUht3dEC2PLF4X/UXGVmhUQF/CyFbZtxU9LqmyKuLBBgMsW
	Pd1CTXxPEfJ90zmxUjt/c+7FOlUC/yyH/aklDlKw157BphD+yJFfSx0Omw57wQ==
Message-ID: <bc874437-1cf8-4ca6-8383-f6e3e1e888ee@bootlin.com>
Date: Wed, 1 Apr 2026 22:17:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/11] net: macb: use context swapping in
 .set_ringparam()
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>,
 Nicolai Buchwitz <nb@tipi-net.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-10-9590c5ab7272@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260401-macb-context-v1-10-9590c5ab7272@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274251-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3072E38008A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Théo,

this is nice work !

On 01/04/2026 18:39, Théo Lebrun wrote:
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
> macb_context_swap_start|end(), reusable by other operations (change_mtu,
> set_channels, etc).
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 89 +++++++++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 42b19b969f3e..543356554c11 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2905,6 +2905,76 @@ static struct macb_context *macb_context_alloc(struct macb *bp,
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

These registers appear to be protected by bp->lock, any chance that this
may race with an interrupt in the middle of them being configured here ?

Maxime



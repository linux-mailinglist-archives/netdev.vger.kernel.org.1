Return-Path: <netdev+bounces-274489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLClMF1SzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 530CA3884BF
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8F6C307BC12
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142E3D7D8B;
	Thu,  2 Apr 2026 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="W0n58ZqW"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893794F5E0;
	Thu,  2 Apr 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128939; cv=none; b=VH3hlf+24oPAlLNajTtUnBoCveKfBiKxecmxKke1V2d4cUUcbEglmUaHaCioI3Oe7IW3p/AIJs1RU7fCgfONW+0775BrcWevqAGAHUw+X9mmP/tE1F15yT3XAb9ly41/rBGRzvRlZUkUeMXUKIvWO/JlxqEJyBRyEfcLFL9OFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128939; c=relaxed/simple;
	bh=hjr6ojkuRNSl6LVoDdBk8yV13sGquuNYKr3xcE4SeW0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CG+q81flGXuEJ+Wys+7Y2hLxugwyTqIQT8oGepNb9PAoCrIDp8eZ5HY0Wm+uD39fcZTaSR9glAiesgoqWg75tJtu/U4Z5LbA4St5Waj84yacEQqib7hLQjCgWsxORpq+T8UbeEURHdihSFlcNCoTyslsHBTAEeITesu9yWussio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=W0n58ZqW; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1804A5870;
	Thu,  2 Apr 2026 13:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775128923; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ux5zG94XjCgnx6hr3W9PDluCcjL1CnnDi9B7O/Fve9c=;
	b=W0n58ZqW6rdcjRyeJzKmMsAevxhouIz9tkEoerr6HnGxaKWzpZg3+RkfL5pF33nkC3xkRQ
	Hwg3R4up2KKz2QwWtNAJSSSifkfYJbimKvPmZdKyjq4EC+4MimW66Gd8+8cHCedRrOTV3G
	3M0Mtuw2ovHHYgj+KBmeAlxYwB9uvCVamnOmu0+ALbjN3VPmGT6Vvpo6VeFUaCj/pIB203
	SbzwAuaPhwMlnYx75Shm41K8Z6/EFU+vLcDw8Ko/rvzZyEJt6pTJn1k1cBqtKtdZfh7MuD
	uCAUOmTV5c/Pqk387Iehf8IzkpDD8/6tlSpAEoxGDW4nQL6kOgrOyd4RWchi9A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 13:22:01 +0200
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
Subject: Re: [PATCH net-next 06/11] net: macb: introduce macb_context struct
 for buffer management
In-Reply-To: <20260401-macb-context-v1-6-9590c5ab7272@bootlin.com>
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-6-9590c5ab7272@bootlin.com>
Message-ID: <70b176b84fbff4a57d7f6be5f42fc753@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274489-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 530CA3884BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 18:39, Théo Lebrun wrote:
> Whenever an operation requires buffer realloc, we close the interface,
> update parameters and reopen. To improve reliability under memory
> pressure, we should rather alloc new buffers, reconfigure HW and free
> old buffers. This requires MACB to support having multiple "contexts"
> in parallel.
> 
> Introduce this concept by adding the macb_context struct, which owns 
> all
> queue buffers and the parameters associated. We do not yet support
> multiple contexts in parallel, because all functions access bp->ctx
> (the currently active context) directly.
> 
> Steps:
> 
>  - Introduce `struct macb_context` and its children `struct macb_rxq`
>    and `struct macb_txq`. Context fields are stolen from `struct macb`
>    and rxq/txq fields are from `struct macb_queue`.
> 
>    Making it two separate structs per queue simplifies accesses: we 
> grab
>    a txq/rxq local variable and access fields like txq->head instead of
>    queue->tx_head. It also anecdotally improves data locality.
> 
>  - macb_init_dflt() does not set bp->ctx->{rx,tx}_ring_size to default
>    values as ctx is not allocated yet. Instead, introduce
>    bp->configured_{rx,tx}_ring_size which get updated on user requests.
> 
>  - macb_open() starts by allocating bp->ctx. It gets freed in the
>    open error codepath or by macb_close().
> 
>  - Guided by compile errors, update all codepaths. Most diff is 
> changing
>    `queue->tx_*` to `txq->*` and `queue->rx_*` to `rxq->*`, with a new
>    local variable. Also rx_buffer_size / rx_ring_size / tx_ring_size
>    move from bp to bp->ctx.
> 
>    Introduce two helpers macb_tx|rx() functions to convert macb_queue
>    pointers.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |  49 ++--
>  drivers/net/ethernet/cadence/macb_main.c | 442 
> ++++++++++++++++++-------------
>  2 files changed, 296 insertions(+), 195 deletions(-)
> 

> [...]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index d5023fdc0756..0f63d9b89c11 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

> [...]

> @@ -3596,14 +3677,15 @@ static void macb_get_regs(struct net_device 
> *netdev, struct ethtool_regs *regs,
>  			  void *p)
>  {
>  	struct macb *bp = netdev_priv(netdev);
> +	struct macb_txq *txq = &bp->ctx->txq[0];

bp->ctx is NULL when the interface is down. This will crash if
ethtool -d is called while the interface is not running. Same
issue below in macb_get_ringparam().

>  	unsigned int tail, head;
>  	u32 *regs_buff = p;
> 
>  	regs->version = (macb_readl(bp, MID) & ((1 << MACB_REV_SIZE) - 1))
>  			| MACB_GREGS_VERSION;
> 
> -	tail = macb_tx_ring_wrap(bp, bp->queues[0].tx_tail);
> -	head = macb_tx_ring_wrap(bp, bp->queues[0].tx_head);
> +	tail = macb_tx_ring_wrap(bp, txq->tail);
> +	head = macb_tx_ring_wrap(bp, txq->head);
> 
>  	regs_buff[0]  = macb_readl(bp, NCR);
>  	regs_buff[1]  = macb_or_gem_readl(bp, NCFGR);
> @@ -3682,8 +3764,8 @@ static void macb_get_ringparam(struct net_device 
> *netdev,
>  	ring->rx_max_pending = MAX_RX_RING_SIZE;
>  	ring->tx_max_pending = MAX_TX_RING_SIZE;
> 
> -	ring->rx_pending = bp->rx_ring_size;
> -	ring->tx_pending = bp->tx_ring_size;
> +	ring->rx_pending = bp->ctx->rx_ring_size;
> +	ring->tx_pending = bp->ctx->tx_ring_size;

Same NULL ctx issue as above. This one could just read from
bp->configured_{rx,tx}_ring_size instead.

> [...]

Thanks
Nicolai


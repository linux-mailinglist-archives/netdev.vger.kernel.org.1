Return-Path: <netdev+bounces-264890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ6FD9UUq2lzZwEAu9opvQ
	(envelope-from <netdev+bounces-264890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:54:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917912267B5
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEEA5306DF27
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3F3EFD09;
	Fri,  6 Mar 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aO99BrO1"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC835DA53;
	Fri,  6 Mar 2026 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819626; cv=none; b=IqYcWDnZe+9+LRxnLY/qWxDPjZkKk0fBfd1Af0IrzkSwBNjAtKCo977656GGzYTvMp/2KfoQAvNpUFTzVwFjx/Vgwtnvj3jE3DH/d96AgsQN0AQiY6Gx9ICqWSkgbuONa4Skh9J9Q+xJGHO/3crB4ZlG/JuCIFAbFUluUzw0V+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819626; c=relaxed/simple;
	bh=xaRaXrVUft9NCgWfvw5rWwHWlI4HGj7GGRn8sy+FOuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8kHVZyyhSqCj+n7xBQZanspHusdlQGxUjlIweDZulnbCwG2KsCPYLH6YmwYoGBJ6OJwuXygZ7y+qsdkMamGnaRhJRWHKmKw1WUZ3NYacTVsIDTNXbbxUDNq/68EY5dgizFWyX42Vsw2KpFi/luhUM1sGE/2IPdI2Qxidhq6n54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aO99BrO1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DD8C64E42594;
	Fri,  6 Mar 2026 17:53:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 941875FF92;
	Fri,  6 Mar 2026 17:53:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51EAC1036984D;
	Fri,  6 Mar 2026 18:53:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772819620; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KKNCuFHaFr6BJTaxfs+dcw4Wa/Lo3Pwr4xaWxWGksWs=;
	b=aO99BrO18C30kMmI4oFITYpPXe3YSJ4jRafzY4QPAeWFGOqtDvJj6FBdW3gnjcScakd4bG
	Pv1O2yFlz8AHrbfW8jSLVXx6z/I1LKImpmjGXPOWmRyhoHymc4NwmA6lieFibRO8KdZwcf
	mOT8+T7AeRGea8/Lk+z3dSZxnjvyUftDZ8wahT4pZqlG9JGUCFAUnS/WpIXFEmjslbn7xV
	qChx4etHzU87tH+K8fGyXhXMWH3gvGvfLXrNxIyl3y8emZdlccQ+Ez99RyxBWqwcB/5wq/
	h09UeBXfJo50VmiNmwUIHGTpRLXiBVkeXYO2Vzq64OyNmgendFWkGGcEKL7MSw==
Message-ID: <d9643b78-66e6-4f04-9e94-426b99ed250d@bootlin.com>
Date: Fri, 6 Mar 2026 18:53:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] net: macb: add Tx zero-copy AF_XDP support
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
 <20260304-macb-xsk-v1-8-ba2ebe2bdaa3@bootlin.com>
 <74089907-d7d3-4242-92a5-909812779932@bootlin.com>
 <DGVVCKPUZVSQ.3U7SG8TTTA1CM@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <DGVVCKPUZVSQ.3U7SG8TTTA1CM@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 917912267B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264890-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Hi,

On 06/03/2026 18:18, Théo Lebrun wrote:
> Hello!
> 
> On Fri Mar 6, 2026 at 1:48 PM CET, Maxime Chevallier wrote:
>> On 04/03/2026 19:24, Théo Lebrun wrote:
>>> Add a new buffer type (to `enum macb_tx_buff_type`). Near the end of
>>> macb_tx_complete(), we go and read the XSK buffers using
>>> xsk_tx_peek_release_desc_batch() and append those buffers to our Tx
>>> ring.
>>>
>>> Additionally, in macb_tx_complete(), we signal to the XSK subsystem
>>> number of bytes completed and conditionally mark the need_wakeup
>>> flag.
>>>
>>> Lastly, we update XSK wakeup by writing the TCOMP bit in the per-queue
>>> IMR register, to ensure NAPI scheduling will take place.
>>>
>>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>
>> [...]
>>
>>> +static void macb_xdp_xmit_zc(struct macb *bp, unsigned int queue_index, int budget)
>>> +{
>>> +	struct macb_queue *queue = &bp->queues[queue_index];
>>> +	struct xsk_buff_pool *xsk = queue->xsk_pool;
>>> +	dma_addr_t mapping;
>>> +	u32 slot_available;
>>> +	size_t bytes = 0;
>>> +	u32 batch;
>>> +
>>> +	guard(spinlock_irqsave)(&queue->tx_ptr_lock);
>>> +
>>> +	/* This is a hard error, log it. */
>>> +	slot_available = CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size);
>>> +	if (slot_available < 1) {
>>> +		netif_stop_subqueue(bp->dev, queue_index);
>>> +		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
>>> +			   queue->tx_head, queue->tx_tail);
>>> +		return;
>>> +	}
>>> +
>>> +	batch = min_t(u32, slot_available, budget);
>>> +	batch = xsk_tx_peek_release_desc_batch(xsk, batch);
>>> +	if (!batch)
>>> +		return;
>>> +
>>> +	for (u32 i = 0; i < batch; i++) {
>>> +		struct xdp_desc *desc = &xsk->tx_descs[i];
>>> +
>>> +		mapping = xsk_buff_raw_get_dma(xsk, desc->addr);
>>> +		xsk_buff_raw_dma_sync_for_device(xsk, mapping, desc->len);
>>> +
>>> +		macb_xdp_submit_buff(bp, queue_index, (struct macb_tx_buff){
>>> +			.ptr = NULL,
>>> +			.mapping = mapping,
>>> +			.size = desc->len,
>>> +			.mapped_as_page = false,
>>> +			.type = MACB_TYPE_XSK,
>>> +		});
>>> +
>>> +		bytes += desc->len;
>>> +	}
>>> +
>>> +	/* Make newly initialized descriptor visible to hardware */
>>> +	wmb();
>>> +	spin_lock(&bp->lock);
>>> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
>>> +	spin_unlock(&bp->lock);
>>
>> this lock is also taken in interrupt context, this should probably use a
>> irqsave/restore variant. Now, there are a few other parts of this driver
>> that use a plain spin_lock() call and except for the paths that actually
>> run in interrupt context, they don't seem correct to me :(
> 
> I almost sent a reply agreeing with you, but actually here is the
> exhaustive `spin_lock(&bp->lock)` list:
> 
>    #   Function                Context
>    ------------------------------------------
>    1   gem_wol_interrupt()     irq
>    2   macb_interrupt()        irq
>    3   macb_wol_interrupt()    irq
>    4   macb_tx_error_task()    workqueue/user
>    5   macb_tx_restart()       napi/softirq
>    6   macb_xdp_xmit_zc()      napi/softirq
>    7   macb_start_xmit()       user
>    8   macb_xdp_submit_frame() user
> 
> And all contexts are safe because it always is this sequence in non-IRQ
> contexts (#4-8):
> 
>    spin_lock_irqsave(&queue->tx_ptr_lock, flags);
>    spin_lock(&bp->lock);
>    spin_unlock(&bp->lock);
>    spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);

Is it because of the guard statement ?

  guard(spinlock_irqsave)(&queue->tx_ptr_lock);

It really doesn't make it obvious that this is how it plays out :(

> 
> So bp->tx_ptr_lock always wraps bp->lock and does the local CPU IRQ
> disabling.
> 
> (I also checked we don't risk ABBA deadlock, and we don't: all code
> acquires bp->tx_ptr_lock THEN bp->lock.)
> 
> However, there is still a bug in the code you quoted: setting
> BIT(TSTART) is done twice by macb_xdp_xmit_zc():
>  - once in the helper function macb_xdp_submit_buff() and,
>  - once in its own body (code you quoted)
> This is fixed for V2!

great :)

Maxime


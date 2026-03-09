Return-Path: <netdev+bounces-265475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LYRKmSnrmkFHQIAu9opvQ
	(envelope-from <netdev+bounces-265475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:56:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413772376E5
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAACF3004D12
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC9393DE9;
	Mon,  9 Mar 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DtdmIMfW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7493392C4C
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053789; cv=none; b=iGYfP2yuQkDPhrvbZahuwe86Sib04vWSqqtBNtuL1u/Q7BaSjzntIV7bcDvj9Xkj9lLCG62aPZ7rCjDkDzLRDnp+zmpz8f3h91i+9SmiwYl7VMx0cdywNUATmoubINQhB9Lnfb9gdqJcENHWrliIB452oQR09sZqMoENAfOWmlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053789; c=relaxed/simple;
	bh=+dc6Lnwo5YZ7/3JzHek9nuMZRXBo/9cGU84S0tcDqyQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=PxIUqr3ThT6vGa+7JdI2uAKR4N+nFO1pQXL+hJ6AAe3gLKQQpxCRDhgGJR8GhU3drv6YnzzZCa5PLgHhIgNYIJy2YVNWVIGf5uoP6svTanX9fx1dU4WBIzTzVFW8svtD45RRzTiHHkELKgfyC7pomZnctx5cKtGColmggitHf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DtdmIMfW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 27EA04E4251A;
	Mon,  9 Mar 2026 10:56:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E800E5FFB8;
	Mon,  9 Mar 2026 10:56:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6F6610369B53;
	Mon,  9 Mar 2026 11:56:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773053782; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Gzr14tOSv8CsjphFxN1CH5k+Wd2mUuktsUCoITd4ydI=;
	b=DtdmIMfWFsDTwbpFaa3qJVfmdBivebdRRUV51CDLf68QcJQzLcX+IavHOIfxbdSVrrMKt7
	ZwDbzNremPKThMvqMoRwZR91Fo6ApLa8JiihVvdiR0BZVSvIUFxpsCTBTzarb/2yeaydfH
	MNxvGdWPARLwMwnoagBOsgx9JmWKm82GX+Wcltws1g4JD05nDSMZAROegGaBFnWTUhtb1j
	8LokKLNO7jqwaIHUJOzMk1vw+9IWXHfFm2kJNpllgQXNvUfUi1SpcgkUOocFx/0ZAmluZj
	kkWuAp5IVHqr7+l4B655xMReNyVuN7AyFESyLpY/2Xr04B9guY2YagSrSsjytw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 11:56:17 +0100
Message-Id: <DGY73WJ12XE3.32N9A9PF2QBKJ@bootlin.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Richard Cochran" <richardcochran@gmail.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 8/8] net: macb: add Tx zero-copy AF_XDP support
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
 <20260304-macb-xsk-v1-8-ba2ebe2bdaa3@bootlin.com>
 <74089907-d7d3-4242-92a5-909812779932@bootlin.com>
 <DGVVCKPUZVSQ.3U7SG8TTTA1CM@bootlin.com>
 <d9643b78-66e6-4f04-9e94-426b99ed250d@bootlin.com>
In-Reply-To: <d9643b78-66e6-4f04-9e94-426b99ed250d@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 413772376E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265475-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gnu.org:url]
X-Rspamd-Action: no action

Hello Maxime,

On Fri Mar 6, 2026 at 6:53 PM CET, Maxime Chevallier wrote:
> On 06/03/2026 18:18, Th=C3=A9o Lebrun wrote:
>> Hello!
>>=20
>> On Fri Mar 6, 2026 at 1:48 PM CET, Maxime Chevallier wrote:
>>> On 04/03/2026 19:24, Th=C3=A9o Lebrun wrote:
>>>> Add a new buffer type (to `enum macb_tx_buff_type`). Near the end of
>>>> macb_tx_complete(), we go and read the XSK buffers using
>>>> xsk_tx_peek_release_desc_batch() and append those buffers to our Tx
>>>> ring.
>>>>
>>>> Additionally, in macb_tx_complete(), we signal to the XSK subsystem
>>>> number of bytes completed and conditionally mark the need_wakeup
>>>> flag.
>>>>
>>>> Lastly, we update XSK wakeup by writing the TCOMP bit in the per-queue
>>>> IMR register, to ensure NAPI scheduling will take place.
>>>>
>>>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +static void macb_xdp_xmit_zc(struct macb *bp, unsigned int queue_inde=
x, int budget)
>>>> +{
>>>> +	struct macb_queue *queue =3D &bp->queues[queue_index];
>>>> +	struct xsk_buff_pool *xsk =3D queue->xsk_pool;
>>>> +	dma_addr_t mapping;
>>>> +	u32 slot_available;
>>>> +	size_t bytes =3D 0;
>>>> +	u32 batch;
>>>> +
>>>> +	guard(spinlock_irqsave)(&queue->tx_ptr_lock);
>>>> +
>>>> +	/* This is a hard error, log it. */
>>>> +	slot_available =3D CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx=
_ring_size);
>>>> +	if (slot_available < 1) {
>>>> +		netif_stop_subqueue(bp->dev, queue_index);
>>>> +		netdev_dbg(bp->dev, "tx_head =3D %u, tx_tail =3D %u\n",
>>>> +			   queue->tx_head, queue->tx_tail);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	batch =3D min_t(u32, slot_available, budget);
>>>> +	batch =3D xsk_tx_peek_release_desc_batch(xsk, batch);
>>>> +	if (!batch)
>>>> +		return;
>>>> +
>>>> +	for (u32 i =3D 0; i < batch; i++) {
>>>> +		struct xdp_desc *desc =3D &xsk->tx_descs[i];
>>>> +
>>>> +		mapping =3D xsk_buff_raw_get_dma(xsk, desc->addr);
>>>> +		xsk_buff_raw_dma_sync_for_device(xsk, mapping, desc->len);
>>>> +
>>>> +		macb_xdp_submit_buff(bp, queue_index, (struct macb_tx_buff){
>>>> +			.ptr =3D NULL,
>>>> +			.mapping =3D mapping,
>>>> +			.size =3D desc->len,
>>>> +			.mapped_as_page =3D false,
>>>> +			.type =3D MACB_TYPE_XSK,
>>>> +		});
>>>> +
>>>> +		bytes +=3D desc->len;
>>>> +	}
>>>> +
>>>> +	/* Make newly initialized descriptor visible to hardware */
>>>> +	wmb();
>>>> +	spin_lock(&bp->lock);
>>>> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
>>>> +	spin_unlock(&bp->lock);
>>>
>>> this lock is also taken in interrupt context, this should probably use =
a
>>> irqsave/restore variant. Now, there are a few other parts of this drive=
r
>>> that use a plain spin_lock() call and except for the paths that actuall=
y
>>> run in interrupt context, they don't seem correct to me :(
>>=20
>> I almost sent a reply agreeing with you, but actually here is the
>> exhaustive `spin_lock(&bp->lock)` list:
>>=20
>>    #   Function                Context
>>    ------------------------------------------
>>    1   gem_wol_interrupt()     irq
>>    2   macb_interrupt()        irq
>>    3   macb_wol_interrupt()    irq
>>    4   macb_tx_error_task()    workqueue/user
>>    5   macb_tx_restart()       napi/softirq
>>    6   macb_xdp_xmit_zc()      napi/softirq
>>    7   macb_start_xmit()       user
>>    8   macb_xdp_submit_frame() user
>>=20
>> And all contexts are safe because it always is this sequence in non-IRQ
>> contexts (#4-8):
>>=20
>>    spin_lock_irqsave(&queue->tx_ptr_lock, flags);
>>    spin_lock(&bp->lock);
>>    spin_unlock(&bp->lock);
>>    spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>
> Is it because of the guard statement ?
>
>   guard(spinlock_irqsave)(&queue->tx_ptr_lock);
>
> It really doesn't make it obvious that this is how it plays out :(

Yes! A guard does an operation when called and one at scope end (in our
case at the end of macb_xdp_xmit_zc()). That way we don't forget the
cleanup, and we can do early returns without a list of labels and
gotos (and mess up along the way).

It uses the __attribute__((cleanup(cleanup_function))) compiler feature,
that is aliased to `__cleanup()` in the kernel.
https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-cleanup
https://elixir.bootlin.com/linux/v6.19.6/source/include/linux/compiler_attr=
ibutes.h#L76

Guard definition for `spinlock_irqsave`:
https://elixir.bootlin.com/linux/v6.19.6/source/include/linux/spinlock.h#L5=
85-L588
(delving into those macros is not recommended)

Code documentation is good:
https://elixir.bootlin.com/linux/v6.19.6/source/include/linux/cleanup.h#L10

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



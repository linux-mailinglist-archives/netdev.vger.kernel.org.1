Return-Path: <netdev+bounces-274071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAUfBTgIzWl/ZgYAu9opvQ
	(envelope-from <netdev+bounces-274071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB788379FB9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 662BF300B194
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8133FA5D8;
	Wed,  1 Apr 2026 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="COkK3Re4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A83FA5ED
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044175; cv=none; b=Zasum2ZliTfuSB9aGtY1MA0tH2ektk2zI4K1CHey0JByKFb6tLhBMEPCP6ADpOxXH9YBv2Bh5SFoWCOcK0e1K8pwz2XPwUENcEnWYLuNJMjQ2U1mRKj2r1cJYoz9m5GnfUQ0dnthangsQ740gsy8M4SNSP1hlBiZQzrLgs7Lo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044175; c=relaxed/simple;
	bh=6oRoLskwAGlXTt80qmU/MI4DxmyyW7n1QL7t+nmrl/8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Apl9qSlnAHShg5bzRAcnRt1JfE3uUPNCFwUh2JFGktkzgwZktTyB507Xk6lpmN5tN9XDfq7ApT6A6746AVALPiz48lGRakt57fA7+y8/t+3bJVrtGJSPMthkN9g3AV4hQo636zbTSmuHjzoL5OyrS6JQmsNn/k3XOMDM8IwS1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=COkK3Re4; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0E5DA5870;
	Wed,  1 Apr 2026 13:49:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775044171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PqRRDW9iPqbXfy7QEPdb11ILmT2E/NUguvdj7/u2OJQ=;
	b=COkK3Re4f6nb7kXHa5GnQJqjsMVnDkBFyGDXnqx1mhUMFkqIzPEsFch8ojltWV6W/fAtlL
	oPKWjopBOJXd9stik4l6O2+ooO0fYDW/rwcA9WvcGACHYe4yFIWZaXqXi64DV9emNBajlo
	2E/EZkhSg+WTfc5HPi4/VecURrft1Xl5p9IAlQYuyEZrDtJytvUBvUWyi/u7JVHtxhcyZt
	uuyXcX+AVFThaFy1mz6yBpNnxdoH5IAeNpJya3S7x6sTANCVDeXNejcXQ9XNqo8M5H3I0f
	Tju6izy7MdNaofvX+BfL56jTgqZznl0r+sOkshcd+Nkx5JWSTQN5hhl+sWaZXg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Apr 2026 13:49:28 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Kevin Hao <haokexin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: macb: Consolidate
 MACB_CAPS_ISR_CLEAR_ON_WRITE checks in IRQ handler
In-Reply-To: <aczly5AD_PkYv6mJ@pek-khao-d3>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
 <20260328-macb-irq-v1-2-7b3e622fb46c@gmail.com>
 <20260331195400.16bb697c@kernel.org> <aczly5AD_PkYv6mJ@pek-khao-d3>
Message-ID: <e113d9e0ad3d3b63bfe124509c4af851@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274071-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB788379FB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 11:30, Kevin Hao wrote:
>> On Sat, 28 Mar 2026 18:17:46 +0800 Kevin Hao wrote:
> On Tue, Mar 31, 2026 at 07:54:00PM -0700, Jakub Kicinski wrote:
>> > Currently, the MACB_CAPS_ISR_CLEAR_ON_WRITE flag is checked in every
>> > branch of the IRQ handler. This repeated evaluation is unnecessary.
>> > By consolidating the flag check, we eliminate redundant loads of
>> > bp->caps when TX and RX events occur simultaneously, a common scenario
>> > under high network throughput. Additionally, this optimization reduces
>> > the function size from 0x2e8 to 0x2c4.
>> 
>> feels a bit subjective TBH. An alternative improvement would be to
>> factor out the conditional to a helper:
>> 
>> static void macb_queue_isr_clear(bp, queue, mask)
>> {
>> 	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
>> 		queue_writel(queue, ISR, mask);
>> }
> 
> In addition to the similar pattern in the macb_interrupt() function, 
> there are
> seven other instances of this pattern in the macb driver.
>   $ git grep "if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)" 
> drivers/net/ethernet/cadence/ | wc -l
>   7
> 
> I agree that using a helper function, as you proposed, would reduce the 
> number
> of source code lines and improve the readability of the driver. 
> However, such
> changes would not affect the final generated code.
> 
> The goal of my changes is to reduce both the footprint of 
> macb_interrupt() and
> the number of assembly instructions executed within its event loop.
> 
> Before the patch, the condition `if (bp->caps & 
> MACB_CAPS_ISR_CLEAR_ON_WRITE)`
> produced the following assembly:
>   ffff800080d58b1c:       387b6a68        ldrb    w8, [x19, x27]
>   ffff800080d58b20:       360000c8        tbz     w8, #0, 
> ffff800080d58b38 <macb_interrupt+0xd0>
> 
> After the patch, the condition `if (isr_clear)` results in:
>   ffff800080d58a4c:       360000d8        tbz     w24, #0, 
> ffff800080d58a64 <macb_interrupt+0xac>
> 
> Thus, we eliminate two `ldrb` overheads per iteration of the event loop 
> in
> macb_interrupt() when both TX and RX events occur simultaneously. This 
> also
> reduces the function's footprint by 36 bytes, as the `ldrb` 
> instructions are
> omitted in each event branch.
> 
> Therefore, your proposed changes and mine serve different purposes.
> I acknowledge that my change represents only a very slight optimization 
> for
> the interrupt handler. I am also open to your preference for improving 
> source
> code readability. Please let me know your decision.

I'm always a fan of optimizations, but I guess in this case the
saved ldrb is negligible next to the MMIO in the same path. We're
talking a single L1 cache hit (~1ns) vs an uncacheable register
write (~100ns+). Patch 3 also re-reads bp->caps in
macb_interrupt_misc() anyway, undoing the local bool for the misc
path.

I'd ack Jakub's helper approach. A macb_queue_isr_clear() would
be consistent across all callsites, including the 7 other
instances you counted outside macb_interrupt().

> Thanks,
> Kevin

Nicolai


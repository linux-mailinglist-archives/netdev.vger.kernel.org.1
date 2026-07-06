Return-Path: <netdev+bounces-305203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UCdUO8cPTGrsfgEAu9opvQ
	(envelope-from <netdev+bounces-305203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:27:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 758557156D2
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:27:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=hL0wCrsm;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=gVnWzwzw;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305203-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305203-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B8953105567
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A583290D1;
	Mon,  6 Jul 2026 19:35:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-15.smtp-out.amazonses.com (a9-15.smtp-out.amazonses.com [54.240.9.15])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0D3254A8;
	Mon,  6 Jul 2026 19:35:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366539; cv=none; b=E3O0Mo6w6+LbNLOvsVtuHv/OEhz7UnHckZeVYk8Q4S4JFa4Q1GVpfLCZEe1Tcsu+abzKdCaH2vny1+j1C3wqujF3nwo4EVbaIQi0JpshZ27daaHbZWVf9Gvxa3I5IHAkzk9+oRSPW7DsYTGRjqOe1irHwTi0/SZTZnX4/tp5cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366539; c=relaxed/simple;
	bh=+yaV2nYwgAaxNIV72gm61ALSOYBmm7bDIUElv0EL4As=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=sOB/A2pNowCblAx5H+v/FOmMf/R3yhFX8nJoj7n6VHE5/cDb6wh5v9RAkTVXzSFyFkIw8mWT0kewRfLd6kJZe2AUhkAdythSspwvQK4JNcI/UpqfLqpCClbb7sObKravS9vo9SwqzrXVUuL6cpojrn+ZBiQrdyueq1FvRCybenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=hL0wCrsm; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=gVnWzwzw; arc=none smtp.client-ip=54.240.9.15
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783366537;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=+yaV2nYwgAaxNIV72gm61ALSOYBmm7bDIUElv0EL4As=;
	b=hL0wCrsmMvM/WL3klErCI7+e6LOjEUUctPNEZaFkHnTRBojfAVNZrLQMzvq1Mwhm
	bhJTmtTGMYZ2Xg5XTwzuLXCUW5jY4sg7JTmzPlFMqQCXd/x+lveUo+Es1081OR1wrBO
	jB+MwlBXsKA/oYmVCdWHcps6XG4e8J/XFBk4hS8c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783366537;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=+yaV2nYwgAaxNIV72gm61ALSOYBmm7bDIUElv0EL4As=;
	b=gVnWzwzwHjUX9eiYko7eUirjGQIErf3nRIOYjarUqELpOAatA3LR7ojnEBez5MT5
	WdsfIlUvD2FVQALsgRhw605ngZ4vLE7iOdb6NclAoB7FqJb3wBBzk4i077i8kwn7tqy
	G5igf6jTNVFWPmAQ5hRv3IfX+2Kpgnh+wSRtxd6s=
In-Reply-To: <akuLzI9GVGn4eI1j@boxer>
From: Johan Alvarado <contact@c127.dev>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Jose.Abreu@synopsys.com, pavel@ucw.cz, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: raise TX completion interrupt at the
 end of an xmit burst
Message-ID: <0100019f38edce40-fcb1cb45-6136-4563-8289-df75ca13eaa1-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Mon, 6 Jul 2026 19:35:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.06-54.240.9.15
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:Jose.Abreu@synopsys.com,m:pavel@ucw.cz,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305203-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[c127.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,synopsys.com,ucw.cz,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,email.amazonses.com:mid,c127.dev:from_mime,c127.dev:dkim,amazonses.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 758557156D2

On Mon, Jul 06, 2026 at 01:04:44PM +0200, Maciej Fijalkowski wrote:
> Very messy thread. To reiterate - does tx coalescing do any good in this
> driver?

It does, but today only for traffic that queues deeply enough. Within an
xmit_more batch the frame counter reduces the IC density to one descriptor
per tx_coal_frames, and that keeps working with this patch applied: in the
447 Mbit/s test from the changelog the NIC raised ~3.3k IRQs/s for ~40 kpps
on the wire, i.e. roughly 12 packets per interrupt, because qdisc bulk
dequeue, TSO and the intra-batch frame counter still coalesce. What was
broken is only the case where a flow never accumulates tx_coal_frames
in-flight frames; there the timer was the sole completion mechanism.

> I did some digging and seems there was a rework of coalescing in 2018 and
> then some more polishing happened in 2023 (net: stmmac: improve TX timer
> arm logic).

The 2023 change only avoids re-arming the timer while NAPI is already
scheduled, which helps the loaded case. For a lightly queued flow NAPI is
idle, so the timer still gets armed and the completion still waits out the
full tx_coal_timer. That is the path this patch addresses.

> Wouldn't your change imply that tx coalescing could be dropped altogether?
> I do agree that each single batch of tx descs should be signalled with ic
> bit at the end.

I don't think it can be dropped, for one correctness reason and two
practical ones.

The correctness one: the frame counter enforces an upper bound of
tx_coal_frames descriptors on the distance between IC bits in the TX ring.
If coalescing were dropped and the IC bit only set on batch tails, that
distance becomes unbounded, and a batch larger than the ring can fill it
without a single IC descriptor: every frame queued had xmit_more set, and
the tail frame that would have carried the IC bit is never queued because
stmmac_xmit stops the queue first. The hardware drains the entire ring
without raising a completion interrupt, and only the coalesce timer can
restart the queue - reintroducing the same timer-bound stall this patch
removes, now on the bulk path and once per ring drain. With the bound in
place a full ring always contains at least dma_tx_size / tx_coal_frames
completion points; even the minimum 64-descriptor ring (DMA_MIN_TX_SIZE)
still holds two.

The practical ones: the frame counter is what keeps IC density low inside
large batches (one IC per 25 descriptors rather than a single one at the
tail with nothing in between), and tx-frames / tx-usecs are user-visible
ethtool knobs on this driver that users can rely on.

Dropping the frame/timer machinery would also be a rework rather than a
fix. If there is appetite for that I would rather keep this patch minimal
for net and discuss a rework separately for net-next.

Best regards,
Johan


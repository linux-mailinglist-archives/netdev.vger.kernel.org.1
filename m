Return-Path: <netdev+bounces-284292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG8qF3S++WnxCwMAu9opvQ
	(envelope-from <netdev+bounces-284292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:55:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D001F4CA347
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431D030847AF
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089D3368AC;
	Tue,  5 May 2026 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="reJO5yV5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aVgCylbr"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA23336EDA
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974742; cv=none; b=QBVSFuqWk9ivaSlJGGLYa3c9RMGwTgvjT2W6l2x63C00PcbGZNkLJxE6Kkq5J3DnrblRpq1ZGKzK+C/unOg8m6xWbuos1kgYZhb19hm0c2d8vK9UYHug8WWtZ74kh4nMymS10FORWB+Pe1Ghz/tb+wSCg8xQj+j48ViLKnldc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974742; c=relaxed/simple;
	bh=mRPZME3LM56e0lzSeM5pxALY5cGtdBF6z/L1d+RxwbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7yFnQw0CBuR3wV5WTG78/wNewn3fFhj1MmMkUqwWGlXESPVLEkdHuy22du77spjLI8/aW8TZCGIPtiAcPwRC7F5bY3+ciOlMdLaYZsyNJVAEzoHQgUb6AWkGUSMrI2jzSXdJLraUhuzwKyIrIeY5bV4hGJZ7qXHjMUnDTtZ9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=reJO5yV5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aVgCylbr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 5 May 2026 11:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777974738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8eMmdkipJzE7eL4KAxso7/4fu2d+k1GeL2q3lF/Jnk=;
	b=reJO5yV5gcxlKrcvYoTAPEjxpC6yDVZjKXMBLf0QQIcaRe/X6PuLFwTuignss2aseJ/Lkp
	tt5aKILJKTglnBkQ05+c7i0S1gpPUw8wEM0qv7qvGalEBAsNYi3pxrO2zHkHO+zTvlrLUF
	MNXQIWAKrLXFi3J3xd64UaSr9+seKdOZdekRFR3f3fzzW013SukDS/m6B2A5bwmKaMXVFm
	7kTR2ull1sf0xEmJr5XZhRhnHDD7kxAe43Y30m8jABCBYeDj9pQ0uGVtfqB6lMrSAKAlYl
	ntGQFrKywYVqKnYE2g2WjIF8eAypP+h8adSso+VB0w/4fUmbnHKM0EX5OW6/5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777974738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8eMmdkipJzE7eL4KAxso7/4fu2d+k1GeL2q3lF/Jnk=;
	b=aVgCylbrpBIcGLTZe0J4JtiYVcLTfNITiz+Knu6Ku5+ZpMemNSXfN3oxsqY6atHIPd6In5
	FulRJsYTJyS8osCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH RFC net-next v3] hsr: Allow to send a specific port and
 with HSR header
Message-ID: <20260505095216.T02Z4R1T@linutronix.de>
References: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
 <willemdebruijn.kernel.31592d82701e5@gmail.com>
 <20260504085911.nLZLRjPF@linutronix.de>
 <willemdebruijn.kernel.22897601ad5fe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.22897601ad5fe@gmail.com>
X-Rspamd-Queue-Id: D001F4CA347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]

On 2026-05-04 13:08:04 [-0400], Willem de Bruijn wrote:
> > > > +#define HSR_INLINE_HDR	0xaf485352
> > > > +struct hsr_inline_header {
> > > > +	uint8_t tx_port;
> > > > +	uint8_t hsr_hdr;
> > > > +	uint8_t __pad0[4];
> > > > +	uint32_t magic;
> > > > +	uint8_t __pad1[2];
> > > > +	uint16_t eth_type;
> > > > +} __packed;
> > > > +
> > > 
> > > No specific need to make this header ethhdr like?
> > 
> > What do you mean? eth_type is at the same spot or do you mean it should
> > be named h_proto?
> 
> I mean there is no reason your fake header needs to be 14B or
> or otherwise resemble an Ethernet header.
> 
> That ties into my last comment to use sizeof(struct hsr_inline_header)
> where working with that header, rather than ETH_HLEN. It is an
> independent header.

But I can't expect that the header is always there. A random ping/ arp
packet goes via the same flow. At the same time I don't want to make it
mandatory for all AF_PACKET users by checking the skb's socket.

The skb starts always with the ethernet header. To avoid collisions with
a regular packet that looks similar I use the ether-type of the ethernet
frame and it has to match PTP. It makes no sense to send a PTP packet via
HSR. Since ether-type is at the end, I can't make it smaller than 14b.
So eth-type is safeguard #1 and the second is SRC-MAC with a multicast
sender bit set which is usually not the case.

> This padding and packing is unnecessary.

The padding is needed to match the ethernet-type and restrict it to PTP
only. Then packing is needed so it is not aligned by the compiler.

> > > > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > > > index 5555b71ab19b5..ac39b2347aa0f 100644
> > > > --- a/net/hsr/hsr_device.c
> > > > +++ b/net/hsr/hsr_device.c
> > > > @@ -228,20 +228,51 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >  
> > > >  	rcu_read_lock();
> > > >  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> > > > -	if (master) {
> > > > -		skb->dev = master->dev;
> > > > -		skb_reset_mac_header(skb);
> > > > -		skb_reset_mac_len(skb);
> > > > -		spin_lock_bh(&hsr->seqnr_lock);
> > > > -		hsr_forward_skb(skb, master);
> > > > -		spin_unlock_bh(&hsr->seqnr_lock);
> > > > -	} else {
> > > > -		dev_core_stats_tx_dropped_inc(dev);
> > > > -		dev_kfree_skb_any(skb);
> > > > +	if (!master)
> > > > +		goto drop;
> > > > +
> > > > +	skb->dev = master->dev;
> > > > +	if (skb->len > ETH_HLEN * 2) {
> > > > +		struct hsr_inline_header *hsr_opt;
> > > > +
> > > > +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> > > > +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> > > > +		if (hsr_opt->eth_type == htons(ETH_P_1588) &&
> > > > +		    hsr_opt->magic == htonl(HSR_INLINE_HDR)) {
> > > > +			enum hsr_port_type tx_port;
> > > > +			bool has_header;
> > > > +
> > > > +			has_header = hsr_opt->hsr_hdr;
> > > > +			tx_port = hsr_opt->tx_port;
> > > > +			if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> > > > +				goto drop;
> > > > +
> > > > +			if (!hsr_skb_add_header_port(skb, has_header, tx_port))
> > > > +				goto drop;
> > > 
> > > All use of this information happens in the context of this ndo_start_xmit?
> > 
> > I receive it from af_packet in HSR's ndo_start_xmit, yes. Then
> > hsr_xmit() is forwarding it to the slave device via dev_queue_xmit().
> > Here the skb->cb information gets overwritten.
> > 
> > I need this hint in the slave eth driver in case there is hsr-offloading
> > available. 
> 
> This assumes that the slave device is somehow HSR aware. But standard
> net_devices are not?

Yes, standard devices are not hsr-aware. It is just your average
ethernet device that sends everything as-is.
But you can have devices with HSR-offload capabilities such as
NETIF_F_HW_HSR_FWD, NETIF_F_HW_HSR_DUP, NETIF_F_HW_HSR_TAG_INS,
NETIF_F_HW_HSR_TAG_RM.

So if a device provides NETIF_F_HW_HSR_TAG_INS and it is enabled
(via ethtool -K) then the HSR stack will pass regular skb and the device
will prepend the HSR-header (and maintain the HSR-sequence number and so
on) before putting it on the wire.
Also, the HSR stack will send a skb on both slave interfaces which are
regular ethernet devices. But with NETIF_F_HW_HSR_DUP enabled it will
pass it only to the first slave and expect the underlying device to
forward it also via the other slave interface.

So I need to pass skb which is can be sent by a dumb device but at the
same time a device which does offload needs to be able to know when it
should not do it.

> Isn't it HSR's ndo_start_xmit that selects which slave to forward to,
> based on the information in this header?

Yes, this is correct. I needed to verify that the slave device with
offload capabilities does not send the skb on both ports and add a
HSR header while doing so. The non-offloading devices are not an issue,
it sends packets as-is.
I managed to rework it and it works without the skb-ext. I just track
the HSR mode (HSR vs PRP) and then parse the packet for its type and
decide what needs to be done.
This works now. Once we settle on the header I can repost it.

Sebastian


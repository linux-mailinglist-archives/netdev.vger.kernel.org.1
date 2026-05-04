Return-Path: <netdev+bounces-283755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOMDIc5g+GnKtgIAu9opvQ
	(envelope-from <netdev+bounces-283755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:03:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DA4BAB76
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2465A30A6B4C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BED34CFCB;
	Mon,  4 May 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tWf4A869";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKF0dgq9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041134B404
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885158; cv=none; b=Rfg3JKWVV0plmessTA7xi9HW1rCrNF3dZ2Fu2ONgIEUox4UuBJZ50uEEpwubCI7eAk1MwP409/IKFSVN8x9eDUSvFrekXU88x/TSBSKVqCYej2WJeGILV/1V7uWcv4LFelmyDKESDLoPtxRkxd+xYEF7ghK8z3Jove+HBqXQae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885158; c=relaxed/simple;
	bh=nwk3rKxj8zBg6ZLgNLtIeotN/2N48tSK8SIH+ptMLRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA6X3NqiIta0eY2DDFhm62BZzv+/hTLIE64socIvna7KI+n6R0mxmLMso+j8sxtmSvLBNADRuo9edPyUDgbeiP62ktT4RvLy4khxIdCZEx+UCWh5HajoqhS92DZ0Am+Vg6llzMGPGbfsTaHL7b0rbSHvNxYItVDTFZPzzmx3CoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tWf4A869; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TKF0dgq9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 4 May 2026 10:59:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777885153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+zduhlhFOQramj5libwhQ+jRbJi/CbF6hYkNVB6WPc=;
	b=tWf4A869FAXvse90KPGP9ci7675m5TXd+cRR/ndnZNSoMff+CraZby+MaZQ/ByopclFvFi
	vGshP6m7zjN7tgC0LBGr+SsswzUXmafVZAD/GAgs+29aBwrhvoiabQopLhTsojiTP/VIBd
	hPFYwgcnbo3maqZj/1AxXnTlUbjc7fjfkxLgnD41ZkN5okCW3YM/ZKZUjn70HOhb6emAcT
	UOIYuXAZc9Tt3mf6SsiEWFTad7+G2h2uGgKmIfKbNY9gdqCKR6BtEjFbBNXE8sdMiq/h9X
	xzmJbOL4SY9QFdP3qlUIhVzX4wzcHum1WmYYZfRXwyTNxAVgPqrMS3jHPbkObg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777885153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+zduhlhFOQramj5libwhQ+jRbJi/CbF6hYkNVB6WPc=;
	b=TKF0dgq930JTKwpurnDXF7CyWyHV+n5Ut6aVxOa2eUbxtsTLhwhy7EWQjEAvcVKURHPN8U
	S+jiF6rAsmHtP5DQ==
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
Message-ID: <20260504085911.nLZLRjPF@linutronix.de>
References: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
 <willemdebruijn.kernel.31592d82701e5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.31592d82701e5@gmail.com>
X-Rspamd-Queue-Id: 057DA4BAB76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283755-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 2026-04-29 13:46:13 [-0400], Willem de Bruijn wrote:
> 
> Great to see a solution that keeps the added logic mostly within HSR
> itself, and works for the userspace component too.

;)

> 
> > diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> > index f4cf2dd36d193..220f6e5d7b24c 100644
> > --- a/include/linux/if_hsr.h
> > +++ b/include/linux/if_hsr.h
> > @@ -3,6 +3,7 @@
> >  #define _LINUX_IF_HSR_H_
> >  
> >  #include <linux/types.h>
> > +#include <linux/skbuff.h>
> >  
> >  struct net_device;
> >  
> > @@ -22,6 +23,21 @@ enum hsr_port_type {
> >  	HSR_PT_PORTS,	/* This must be the last item in the enum */
> >  };
> >  
> > +struct hsr_ptp_ext {
> > +	u8	port;
> > +	u8	header;
> > +};
> > +
> > +#define HSR_INLINE_HDR	0xaf485352
> > +struct hsr_inline_header {
> > +	uint8_t tx_port;
> > +	uint8_t hsr_hdr;
> > +	uint8_t __pad0[4];
> > +	uint32_t magic;
> > +	uint8_t __pad1[2];
> > +	uint16_t eth_type;
> > +} __packed;
> > +
> 
> No specific need to make this header ethhdr like?

What do you mean? eth_type is at the same spot or do you mean it should
be named h_proto?

> >  /* HSR Tag.
> >   * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
> >   * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
> > @@ -45,6 +61,60 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
> >  				     enum hsr_port_type pt);
> >  int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
> >  		      enum hsr_port_type *type);
> > +
> > +static inline bool hsr_skb_has_header(struct sk_buff *skb)
> > +{
> > +	struct hsr_ptp_ext *ptp_ext;
> > +
> > +	ptp_ext = skb_ext_find(skb, SKB_EXT_HSR);
> > +	if (!ptp_ext)
> > +		return false;
> > +	return ptp_ext->header;
> > +}
> > +
> > +static inline unsigned int hsr_skb_has_port(struct sk_buff *skb)
> > +{
> > +	struct hsr_ptp_ext *ptp_ext;
> > +
> > +	if (!skb)
> > +		return 0;
> > +
> > +	ptp_ext = skb_ext_find(skb, SKB_EXT_HSR);
> > +	if (!ptp_ext)
> > +		return 0;
> > +	return ptp_ext->port;
> > +}
> > +
> > +static inline bool hsr_skb_get_header_port(struct sk_buff *skb, bool *header,
> > +					   enum hsr_port_type *port_type)
> > +{
> > +	struct hsr_ptp_ext *ptp_ext;
> > +
> > +	*port_type = HSR_PT_NONE;
> > +	*header = false;
> > +
> > +	ptp_ext = skb_ext_find(skb, SKB_EXT_HSR);
> > +	if (!ptp_ext)
> > +		return false;
> > +
> > +	*port_type = ptp_ext->port;
> > +	*header = ptp_ext->header;
> > +	return true;
> > +}
> > +
> > +static inline bool hsr_skb_add_header_port(struct sk_buff *skb, bool header,
> > +					   enum hsr_port_type port)
> > +{
> > +	struct hsr_ptp_ext *ptp_ext;
> > +
> > +	ptp_ext = skb_ext_add(skb, SKB_EXT_HSR);
> > +	if (!ptp_ext)
> > +		return false;
> > +	ptp_ext->port = port;
> > +	ptp_ext->header = header;
> > +	return true;
> > +}
> > +
> > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > index 5555b71ab19b5..ac39b2347aa0f 100644
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -228,20 +228,51 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> >  
> >  	rcu_read_lock();
> >  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> > -	if (master) {
> > -		skb->dev = master->dev;
> > -		skb_reset_mac_header(skb);
> > -		skb_reset_mac_len(skb);
> > -		spin_lock_bh(&hsr->seqnr_lock);
> > -		hsr_forward_skb(skb, master);
> > -		spin_unlock_bh(&hsr->seqnr_lock);
> > -	} else {
> > -		dev_core_stats_tx_dropped_inc(dev);
> > -		dev_kfree_skb_any(skb);
> > +	if (!master)
> > +		goto drop;
> > +
> > +	skb->dev = master->dev;
> > +	if (skb->len > ETH_HLEN * 2) {
> > +		struct hsr_inline_header *hsr_opt;
> > +
> > +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> > +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> > +		if (hsr_opt->eth_type == htons(ETH_P_1588) &&
> > +		    hsr_opt->magic == htonl(HSR_INLINE_HDR)) {
> > +			enum hsr_port_type tx_port;
> > +			bool has_header;
> > +
> > +			has_header = hsr_opt->hsr_hdr;
> > +			tx_port = hsr_opt->tx_port;
> > +			if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> > +				goto drop;
> > +
> > +			if (!hsr_skb_add_header_port(skb, has_header, tx_port))
> > +				goto drop;
> 
> All use of this information happens in the context of this ndo_start_xmit?

I receive it from af_packet in HSR's ndo_start_xmit, yes. Then
hsr_xmit() is forwarding it to the slave device via dev_queue_xmit().
Here the skb->cb information gets overwritten.

I need this hint in the slave eth driver in case there is hsr-offloading
available. Now that I look at it again, there a netdev-event once the
HSR-master is set/ changed. So maybe I can use this and look at the
skb frame to decide what is required. Le me see.

> If so, no skb_ext needed. Can store the data in skb->cb[], which in
> that case is assured to not be overwritten by another layer.
> 
> Among various options. skb_ext works, but is a bit heavyhanded for
> passing around state within the same layer and call stack.

Sure.

> > +
> > +			skb_pull(skb, ETH_HLEN);
> 
> Prefer sizeof(struct hsr_inline_header)

Okay.

Sebastian


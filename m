Return-Path: <netdev+bounces-280429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIjkJC3P6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:37:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B3446D30
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AE283084B6F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AA93CBE97;
	Wed, 22 Apr 2026 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tIY2zndc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1AZNVJHo"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862E3D331A
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864462; cv=none; b=GKwytYS9JrkkJOD1WyEiLsux/Ry+5xANkoLX+2aP6K341fchGaP3rSkKDVRl/dqTYAYRlFL0LwDN3+VFfK7Hn8VkqmeZQ4z5hWknlP5/G4q0oHYchgOHvc2V1Mhr4VKfRkeNrNft379rg19xeEGK0mw3c9V3Om3HKmVXyrTzoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864462; c=relaxed/simple;
	bh=Pql9kSun8yhCpr7OB5Y/ZbxhKxZIRI5uVLS8Hj2D8hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAWw+h4yCOMUlUt8k6/elqTUZiqjgadqK/kmMIt4B7JKBBH6CcJPc2nwWmOHaWL+kZ/FDWzGtfANVrKlCGJN60G/Vglb3sEw3aXS+T8bhWheVTiAQOVARZs1E7uwe9wjiXbo0QE2dhcTFoGBigIvws9Qq5wu3n6U0O9Y8Bw5u6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tIY2zndc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1AZNVJHo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Apr 2026 15:27:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776864458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gp6I89CelbWfiY620SyiAMASHDD2+76IuwJlP04E4n0=;
	b=tIY2zndcq8hF9Tl7K7KqJ5j/T2dhuxPAm8cm4AjJ76BG1wf5WbNH3WT6WwbrGA1IHL9lUU
	bbvw/rJI5iPxPDkT7+RWDyXNb9Ippua5HUcQBbkQjrjoizGMiroGkypUwG/7WvoSWzz7nw
	U5rVRZHt8rIWEHBf1JR3wz9f/+ziavrbOAQpNFG2cF8W77AgkxFYzLprXs5rq4EcJdYqhD
	asAIC2Fl9eiNGvuZGbeZJd49Lk3yzQf57PduNWUeGYrra7nz9XsLtnqzEDCvyhdwwOaEX1
	kqWboKSWxJZ8U0NlLC6TFjVAlI3DwoRATWUl1THcVbJise5LE7YLLhzStfflZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776864458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gp6I89CelbWfiY620SyiAMASHDD2+76IuwJlP04E4n0=;
	b=1AZNVJHo4BGnMjVxXaZWLcJeWZVsVZU2Nkp/M1teUqvTucjsrng3Xheo+zBb7sVrmZ4svQ
	WvjJSrSFP4fobuAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"Raghavendra, Vignesh" <vigneshr@ti.com>,
	"Bajjuri, Praneeth" <praneeth@ti.com>,
	"TK, Pratheesh Gangadhar" <pratheesh@ti.com>,
	"Muralidharan, Neelima" <neelima@ti.com>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260422132736.TakH_dhQ@linutronix.de>
References: <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
 <willemdebruijn.kernel.17068ce38efa5@gmail.com>
 <20260319142613.KHz32I-V@linutronix.de>
 <willemdebruijn.kernel.8e323262df61@gmail.com>
 <20260324163820.p9M2z27W@linutronix.de>
 <20260402163237.EIE16Pj_@linutronix.de>
 <willemdebruijn.kernel.1f3d8356e4a5a@gmail.com>
 <20260416161856.CsL4npMH@linutronix.de>
 <willemdebruijn.kernel.270fa204f615f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.270fa204f615f@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280429-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B21B3446D30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-21 03:41:52 [-0400], Willem de Bruijn wrote:
> Sebastian Andrzej Siewior wrote:
Hi Willem,

> > I understand your concern. I tried to make as self contained as
> > possible and little runtime overhead as possible.
> > 
> > > One perhaps interesting Rx only option I had missed before is
> > > SOF_TIMESTAMPING_OPT_PKTINFO. Would that give you the original
> > > device ifindex today?
> > 
> > The upper logic expects to poll() on the fd. If I need to filter the
> > device based on this then breaks the expectations.
> > I need also to receive packets without a timestamp so I don't think this
> > works.
> 
> I don't follow this. My suggestion is to optionally receive this
> additional metadata along with the data. Not as a filter.

Yes. Just ignore that part.

> > cb[] is limited to one layer. I do have a skb_ext variant working but
> > this requires cmsg to set it. Do you think about generic skb_ext which
> > is set from af_packet? But I don't think it brings much value if I can't
> > filter on the RX side before returning the packet to userland.
> > 
> > > But at this point I see enough options that do not require changes
> > > to packet sockets.
> > > 
> > > To get back to the simplest approach: skb->mark. Is there any
> > > concrete risk that on this path that would conflict with other
> > > uses of that field? If packet sockets inject directly into this
> > > driver (possibly even with PACKET_QDISC_BYPASS)?
> > 
> > So I have a skb->mark variant working. I do read on the ethX interface
> 
> When reading on both ethX interfaces, that gives you all the info you
> need on Rx, right? Or alternatively by attaching to hsr0 with
> SOF_TIMESTAMPING_OPT_PKTINFO.
> 
> So skb->mark is only relevant to the Tx side, right? There might be
> yet another way to identify in the hsr ndo_start_xmit that a packet
> arrived from a PF_PACKET socket. E.g., by checking skb->sk->sk_family.
> As alternative or complement to skb->protocol.
> 
> Btw, on receive the inverse could also be true: insert a synthetic
> header and pop that in userspace, e.g., a VLAN tag.

So I made this:
I open hsr0 for TX with a custom header. The header is expected if the
ether-type is set to PTP. This extra header holds the HSR-header
information and port request.
I open eth0 for RX. I set PACKET_IGNORE_OUTGOING to avoid the feedback
from hsr0 writes. This is part is crucial ;)

I use skb_ext to pass the information from the inline-header to
the network driver since the data pointer of the skb is forwarded after
that header. In the end I have no idea if the network driver supports HW
offloading and needs this information or not and sends the packet as-is.

HW offloading becomes a bit tricky but relying on skb_ext (for HSR) and
checking otherwise for the ether type vs PTP (in the PRP case) does the
trick.

So it is slightly more complicated but seems to work.
Let me wait until after the merge window and then I present what I have.

Sebastian


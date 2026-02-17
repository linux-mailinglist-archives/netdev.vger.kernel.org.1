Return-Path: <netdev+bounces-259076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFMUG6aOlGkeFgIAu9opvQ
	(envelope-from <netdev+bounces-259076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:52:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE014DB8A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABEBD301D970
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21536D4F0;
	Tue, 17 Feb 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OqZyJYf4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGfU50uW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287036D4E6
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343522; cv=none; b=jpeYikRI/iGq4Qhi8mUKL/7mYGVg9g93tvOmY1ieeS8jC4OZGpE8IMCBFtX3BF4PaPpQBYMKmNluQPw58c9XPUYqeY59BTArxj11+9M+jjiFIUxyjpLW6HH3K+1tAX+7+noM3efpd4A/6gRC0pwGt1ry4q4P3fCDiWkdPT3v7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343522; c=relaxed/simple;
	bh=8jhbaRnuqNk/mGH7KRKu3CeICQrb80U5tLlGNrWu3pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdWajP28U3XTvZA/eeyLw3sm3whW8xzX8HYpQJrRw61EXyNv2HItWGggV2TUn7PTit+QbldunPOf108GXPtdncrCI9RPMJOFpd2/IgOI5bHHsyhTvLiDnAhR5w00+ssroZQO6lvRgZYXiH8iI+GQeitjP38ejfgt9ZTujg1axgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OqZyJYf4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGfU50uW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 16:51:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771343517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYyscHf1mR4TgK8/yct5f9ow0r9VnipBrjwN8a8rT0E=;
	b=OqZyJYf4vU+Smd9yrS0y1dPYpjtjJzd2ih7KhFDG3B7A7KNlsDsgJvVmnb1uMXevB0IA0j
	Pa+ZKqLyYFBNUmKruTQrNWCi2MkaoinJNCqqg9Yd5KcgH3zg1/5HlMRIL/D+HgF1Yg9ekB
	trh5Xo7AZ0Lj0cVcTWmX5g+RAX0zYHj3f90DG9chckumF3SrO///rWQcCYn7dcEGV4zZOv
	X26sYmH+ElL0Gz3xRCcqRM1xIGlELQ5EmMhxrgy/NwHbPUwvuZ8QsU5T8DsrUiqmVuVDAV
	GoXCj1BNxXLyJo7xOc14HY1MAEbohw8gmkZ5zDf65bp945G7vRkt1xkwWojNiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771343517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYyscHf1mR4TgK8/yct5f9ow0r9VnipBrjwN8a8rT0E=;
	b=mGfU50uWWaCJMRuWRqxtSu6kM8yJlDZ8pg/ngVyod7etkXj8YTw6C0i0fbYDk/SqJKi052
	eIljex/pjcRV93Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next 2/2] af_packet: Add port specific handling
 for HSR
Message-ID: <20260217155156.4q1GWQSK@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-2-b421c69a77da@linutronix.de>
 <willemdebruijn.kernel.2a1e4d7240fd4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2a1e4d7240fd4@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259076-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: DDCE014DB8A
X-Rspamd-Action: no action

On 2026-02-04 12:36:36 [-0500], Willem de Bruijn wrote:
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2131,6 +2168,13 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
> >  	if (!net_eq(dev_net(dev), sock_net(sk)))
> >  		goto drop;
> >  
> > +	if (po->hsr_bound_port) {
> > +		struct skb_shared_info *si = skb_shinfo(skb);
> > +
> > +		if (po->hsr_bound_port != si->hsr_ptp)
> > +			goto drop;
> > +	}
> > +
> 
> Similar to the high level comment to patch 1/2: this is quite a rare
> use case, but this implementation imposes cost on every user. By
> adding branches in the hot path, among others.
> 
> It is simply not scalable to extend core infra in this way for every
> use case. The cross product of features is too great. We'll have to
> find a way that is less HSR specific.
> 
> There are existing mechanisms for binding to a specific interface or
> port, such as SO_BINDTOIFINDEX and packet bind().

Would a static_branch_unlikely() be okay to have it off by default and
only enable once there is at least one user doing it?

I do
   setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, name, strlen(name))

which is probably the same thing. With this I get to the "hsr0" device.
The hsr device has two slave ports which are hidden from the user in
general and only copy gets passed. For PTP I need to know which (PTP)
packet was received on the individual port. This is purpose of it. So I
have one fd for port A and one fd port B. (+ timestamps).

For the RX side I could simply use that device directly instead of the
hsr device.
But for TX I need to send a PTP packet with system's HSR header
(including the HSR-sequence number). I don't know how to achieve this
without using the hsr device. And the packet must not be sent on both
ports (like it is usually the case) but only on one of the ports (either
A or B).

Sebastian


Return-Path: <netdev+bounces-259084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCF/BiyTlGl3FgIAu9opvQ
	(envelope-from <netdev+bounces-259084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:11:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43814DEBD
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B84301588C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D836BCF4;
	Tue, 17 Feb 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t12cETo0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNNg3Ojd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03EA36BCC5
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344658; cv=none; b=AMmHoh06MMcVjyi9a/YH82dsx4wCFkZYVFV7K210NfzyNnCMNemtDv8wIgQIUlbd+VvXV0P8wLo1XtloEdkRKj6t6rR8psB9loCS2OrXTiApaVZFU3Cbqu9ZQJuxaVDAgP281v+pem9YADQATQimR8TE6ggoDMZBBFbGSArsLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344658; c=relaxed/simple;
	bh=p+uCUKhVP8DzvkBlCG/a5C0OAUe9Iw5kiDqsEYWg3LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk09s4cNyqo1zIqx660dwZknQjcfHE4aIVPAueN0sn+FMenjkfbODG8Byg1KyAtUFqLlSXr9CGO+niBkOeTQUP4ahizNjvjwIu5+0x9+JiJKV2fTUuSSMjsepifV88m+r6l54ReeFHlL3Tax9qR87DUUQ1OtA6AmPZf2s/W5eK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t12cETo0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNNg3Ojd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 17:10:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771344655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qp3z3cLWxmI2ZKIW4Hi+ySZosFYVscIFYciVpCgFXII=;
	b=t12cETo0nFqqFSfP6psu6XPvSAvB7LDd4oMCZvCnE5PmZp1gZDqxGTs8KvC3qOzPaolF34
	EJT6HDHl6+VJxOoomxiG7fm2kuiVfujz27vbHXQhVKX1LpBcTcgTaMx0ECX7juqj8ZRrPQ
	K/CF8ZyUUolKQsXoAxGaLHQ37i/tpXbIhD7OV5ZeIUJT+t+cwv+zB5uidcmMMBWMs+SVZe
	ai3tCv0TSpHdkjTCMwSL8kuNpy4mB78WigSvDZhndMY1EEDfIwmn05R+1Fjx/hnL+XsSvS
	DLpBHDOqz9V69P6L+VblcVpr0WKMiU5c8uQwdWv75Y61MZTLCWPYZ9xJie5jSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771344655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qp3z3cLWxmI2ZKIW4Hi+ySZosFYVscIFYciVpCgFXII=;
	b=pNNg3OjdSAgQvJq6jLl6/ee7MIzZ/pUl7jE8AS9u6aQzOW/wvi9hM1hgSERHCfV9udg9Lh
	S224Xrpe5yHz0XBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Message-ID: <20260217161053.XMFBwFXg@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZNBfh81p1zBvbi2@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-259084-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D43814DEBD
X-Rspamd-Action: no action

On 2026-02-16 17:10:38 [+0100], Felix Maurer wrote:
> Hi Sebastian,
Hi,

> I agree with Willem that the changes are pretty invasive in core parts
> of the stack for a pretty narrow use case. It got me thinking what would
> already be supported at the moment without any changes in the kernel or
> pretty small changes. For that, I see three parts:
> 
> 1. Userspace needs to get the full HSR+PTP frames including the headers
>    and including the rx port information.
>      a) Userspace should have a way to _only_ receive HSR+PTP frames
>         instead of all traffic on one of the ports.
> 2. We should not forward HSR+PTP frames in HSR interface to prevent
>    creating inaccurate timing information.
> 3. Userspace needs a way to send packets a) over just port A or B of an
>    HSR interface, that b) already include an HSR header and should
>    therefore go mostly unmodified.
> 
> Is that about a correct summary?

Yes. Point 3b needs to be extended by
  " + or does not contain a HSR/PRP header and requires one by the
  system."

> If I understand your patch 2 correctly, you will be maintaining two
> sockets in userspace (one bound to each of the ports A and B through the
> HSR interface using PACKET_HSR_BIND_PORT). Binding through the HSR
> interface to port A/B has the very special meaning of making a socket
> only receive a very small subset of the packets, that is PTP traffic at
> the moment. This seems like a somewhat hidden property of the bound
> sockets and should at least be very explicit.

Technically four sockets (two for A and two for B) but in general yes.
What you mean by hidden property/ very explicit? Document
PACKET_HSR_BIND_PORT in packet(7) or something else?

> Is there a reason not to create and bind one socket directly to each of
> the underlying slave interfaces, with a socket filter attached to only
> receive the HSR+PTP packets you want? The rx port information is
> inherent to the socket this way. I'm not sure if sending over the
> sockets works out of the box, but if something is needed for that, I'd
> assume it's less invasive and more generally usable.

This was v1. The missing part is sending a new packet and not forwarding
one. The specification mandates to use system's sequence number.

> We'd still need to address 2. for this to work, but blocking forwarding
> for PTP could be done in hsr_forward and friends with a much simpler
> patch.

Blocking forwarding is simple as it needs just to look at the ethernet
protocol and drop it if it is PTP. Here I additionally add some
hints to get the port right and the time stamp.

> The other thing that came to my mind: this sounds like XDP with AF_XDP
> could be a solution that could be used already today; not so much
> because of their speed but because you can program what goes to the
> stack and what ends up in userspace. It fulfills 1) + a) directly, 2)
> implicitly by not letting these frames enter the stack, and 3) directly.
> But I also see that handling AF_XDP sockets in userspace is quite some
> work to do if all you really need is to separate out some traffic.

Not forwarding PTP traffic needs to happen unconditionally and not to
wait until the system is up and has the software running. However if we
ignore this detail and can receive on interface A and send on interface
B over XDP and get timestamps right then we have the same as the packet
interface on the two eth devices. What is missing is sending with HSR/
PRP header.

> Thanks,
>    Felix

Sebastian


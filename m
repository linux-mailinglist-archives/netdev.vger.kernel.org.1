Return-Path: <netdev+bounces-264213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGJvOSY6qWnf3AAAu9opvQ
	(envelope-from <netdev+bounces-264213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:09:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B78620D364
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9BB301C8B6
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2636657D;
	Thu,  5 Mar 2026 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eeia+Zjp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sf65DZm7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DEC366576
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698062; cv=none; b=p7HI5u6x9bB03V/6LBpCyPpeaFGmqzq0ckTgwmVeOWGJyB8snj72moaQdg8DY9/NjKNNXzGhAJ8GFXAzKVZdN8DBLlSpef2gyAtVXxg/CUX3v7UwJQVy6Jjga9QvFwk3TAu0dxHVak2GdQ3/ZCJ51ZnKMLyuVfYDHR3eLG+5VKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698062; c=relaxed/simple;
	bh=bk69/p2SgTNlU+YnZAFGljbVPi50q6qt8u8fXNOJqQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMJ4oq2oe7J9P41yycUWW9DbpgerA2J3+QcNR5CCCRNY+1CnxdG4FNgx7/WdpySW8rDF5imJk0yhrjHXwinnrBwdPfN8f5ZVPl7EPxr+4W8dH8UGegfH44udc7iMgOdW1xG2dPBZ3LjecSYL/SbfGSeyLnqVpdWqKLRCiSLx0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eeia+Zjp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sf65DZm7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Mar 2026 09:07:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772698052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jc+VtayfCQ3/IbB735jz+2D02F6KYoK5AM9M6l5p0xo=;
	b=Eeia+ZjpeQOLnkrF2/pG7jiTzrXnusehsE/x1Aumu3pvktIy/zLjSDPRgwETrtcY235jqt
	MPvvVawCb6MpDutfNKHgtEXO+OEuOWkvl24dY61xY5lMxjOFAuHUwTt/pzOvWzV7X2q2zV
	yU+vCUdLW61Qmty+iZdGQZp5QeAbqYoHDOoOoPYCJ+JZr1V82Hk08+KYHAa+WxLY4hzwyS
	FyeNN8bFcRiHidSLn66RafG8ROh+X/wwlw6rWD18RJ5KIZgfb0fayUCWWlKBqXL4ohtPnF
	MpDZF/7hkpP3EFGnFSTdUvXK+VYSvVlVI7x5iV3RwwlpBj8L+74yZxDOk+3ohg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772698052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jc+VtayfCQ3/IbB735jz+2D02F6KYoK5AM9M6l5p0xo=;
	b=sf65DZm7ZFE0XnruseZooGmN8s78Ptt2H/UoXZm67oESVXntzB5t+Xins3jkLinZuHkLut
	KVasj8nIjAguHSCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and
 with HSR header
Message-ID: <20260305080731.xnJ0XtTX@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
 <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
 <20260304145821.TQhzhhjF@linutronix.de>
 <willemdebruijn.kernel.1d699189fce58@gmail.com>
 <20260304161255.VV_7vPBw@linutronix.de>
 <willemdebruijn.kernel.1f5b6b3e8c22d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.1f5b6b3e8c22d@gmail.com>
X-Rspamd-Queue-Id: 4B78620D364
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
	TAGGED_FROM(0.00)[bounces-264213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Action: no action

On 2026-03-04 18:48:19 [-0500], Willem de Bruijn wrote:
> Sebastian Andrzej Siewior wrote:
> > On 2026-03-04 10:56:16 [-0500], Willem de Bruijn wrote:
> > > Sebastian Andrzej Siewior wrote:
> > > > Would it be okay if I occupy three bits in sk_buff which look unused?
> > > 
> > > Have you looked into using skb_extensions?
> > 
> > Yes. I would have allocate memory via __skb_ext_alloc() and attach it to
> > the skb via __skb_ext_set(). That would on receive and while sending
> > (via af_packet).
> > Looking at the current allocations as of skb_ext_type_len, they all need
> > a bit of memory, the smallest is mctp_flow with just a pointer the other
> > are a fair amount larger. For the three bits, I was hoping to avoid it.
> 
> But this is not a performance sensitive path, right? Nor is it very
> complicated to add?

The non-PTP packets are not affected by this and the PTP packets need to
processed in userland before they can be forwarded. So probably not.

> I understand your preference. It's just that if every protocol and
> feature, let alone their cross-product, adds a few bits to struct
> sk_buff, it grows to become unmangeable. A classic tragedy of the
> commons. For this reason pushback is common.
> 
> Devil's advocate, an alternative would be to add a few bits, then
> maybe union them so that other users can use the same bits as long
> as their code does not overlaps. This quickly becomes hard to analyze
> for correctness. In a sense skb extensions resolved some of this.
> 
> That said, happy to hear other opinions or implementation concerns
> that I may have underappreciated, e.g., it may not address the HSR
> specific needs for AF_PACKET.

Let me redo this with the skb-extension variant. If this somehow becomes
later a concern we could have a talk with new arguments. Now given what
I wrote above all I have is that it is simpler.

Thank you for your comments.

Sebastian


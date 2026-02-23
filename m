Return-Path: <netdev+bounces-260125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAQsIneKnGl8JQQAu9opvQ
	(envelope-from <netdev+bounces-260125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:12:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E45F617A770
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBD530C52D3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0332938A;
	Mon, 23 Feb 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJWo2ZTs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wo2tgtZJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C270329E5A
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866481; cv=none; b=GpMr6GVFCg5ydHNG/kW+P5ZCYFiyCxfWzTmYkHb7IVempr39erD+JmND59VdiYvjiZRW1rf00cxHzRscPscub2rIAVXB3OdtGLCGd2+WVm9vYtw2w6kSX4iKG/7ZCTsCgVfZc+fQySoUXGHZktdKzX1vnV6zUetYVQEECDqhdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866481; c=relaxed/simple;
	bh=BbNo0iMc4yzdE9/P4CCI8hkP/obASX0bTQ6Q/v1cJNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egri3hbnsVBlicbl37MqT9MxaVY8E0ScWkB1BXzlyyosCr9iv++HgkTcS0yn5Iteb8jU3Y6cWAe6jiNx9tRIbw5UmSt+9WZW2HU6yz0+aMxxegnY5Ce1X/X8iLDoiAcSFMm5jyDHee3A8OorFG3hy6PDIYlj7khoX7B7mGW+NpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJWo2ZTs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wo2tgtZJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 18:07:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771866472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbNo0iMc4yzdE9/P4CCI8hkP/obASX0bTQ6Q/v1cJNk=;
	b=kJWo2ZTsK6P7DhfivIiy6pQq0mkuZcAHifl3qrD28Vnb1eyKPfbmHE4fIpK12dp8f6C1ic
	uyxQEIww6uhafHpxViZIqwJXZLzlJ034DytoCt8PP5DzlWcAcGeH6BVzzmngw0ve0K/3qT
	eRI7q+CkncKyfdZKGFO3kMoAePkVr3niKm4HwzIDi2LrXWx1YSr5qeQrgqQ7G6Jr9dfSOD
	CSduTLgM203KIFfqjNZe5fqb7ZQo8VRovqZ/QC4mt+HnxgJEaf1MW/mJu0z49XxyDW+Ky3
	loIOevmszCWkb4U291T0FEIS0Wayg5quFTz41Uin27S0d3RUnmaOdG40XT/aJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771866472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbNo0iMc4yzdE9/P4CCI8hkP/obASX0bTQ6Q/v1cJNk=;
	b=wo2tgtZJXxkcPT1hBEYVuVTax/Ps/iV6FQVfSrfR9i71bJdr3flqrIzBYLY9+RQFTuCEAr
	C8Py0oH5ePJ8AjAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260223170750.q5nhbkSe@linutronix.de>
References: <20260220183858.N4ERjFW6@linutronix.de>
 <20260220132932.1ed45656@kernel.org>
 <willemdebruijn.kernel.85c1623c5d65@gmail.com>
 <20260220140241.51be1e30@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260220140241.51be1e30@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,linutronix.de,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-260125-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: E45F617A770
X-Rspamd-Action: no action

On 2026-02-20 14:02:41 [-0800], Jakub Kicinski wrote:
> > > Willem, you don't find that argument convincing? =20
> >=20
> > This narrow case seems fine to me too.
> >=20
> > But I can understand if that would be a global rule. As it simplifies
> > reasoning about correctness of core code quite a bit. In which case
> > that would trump this. No preference from me. Clearly other drivers
> > are quite capable of making this work without requiring updates from
> > hard IRQ.
>=20
> Well put. I guess we're in the same boat then. No strong preference
> here either, but I like the clearly drawn expectations to simplify
> reasoning.

We kind of have NAPI and the rule that we inject packets into the stack
only from within sofirq. As far as I remember we got NAPI within the 2.5
cycle and then this got as an written rule (or written). Simply because
injecting packets from an IRQ could soft lock the system if you receive
a lot.
Using softirq has the benefit of moving the load to ksoftirqd which can
then be preempted by the scheduler.
This was easy to enforce as an argument of its own and the fact that
almost all required locking is BH-only.

Since around v2.3.4 the locking was moved into struct sk_buff_head,
before that there was global skb_queue_lock. Till this day the lock is
acquired with IRQ-off. This kind of makes it possible to queue the skb
=66rom within the IRQ. This, and the fact that the "cloned" skb has no
extra baggage (such as an destructor) and the kfree_skb() works here,
too.

This can be a lot what you have to know especially if you want to extend
things later on and you don't want to think if this can be done here or
if we violate an exception to a rule.

Based on that I would say it is absolutely sane to enforce delivery of
skb here from !hardirq context. After looking into it last week, the BH
worker shouldn't be worst choice here.

How do we move forward? Merge this, backport stable and then convert
in-tree user away from IRQ delivery _or_ fix the driver one by one and
backport them stable? Or=E2=80=A6

Sebastian


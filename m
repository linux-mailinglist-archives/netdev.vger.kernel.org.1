Return-Path: <netdev+bounces-229680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DABDFA73
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6524E3E2D0B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13A3375DC;
	Wed, 15 Oct 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AtcptlUP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDgGd8K0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6688337687
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545770; cv=none; b=QlxzQzyLSrUgZcF5jgH03+XPLT4/+HSC61oB51sZhd4c6SZ/e7ZUAc/3SY7An1wPu1TsMMK/QAd8Bs5aVkeS4CYljDfltCKIxJKrf6AYTC2xS8ndvZUXGQhpi1Ph1M9pgDWuWmeNJGSwta/2AOLr1VmqVFwMgNtvabtSi57Cu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545770; c=relaxed/simple;
	bh=Gk08VLbkpFi1ZC2IutxuohSOPRuJHP5SOA0jS5dQ+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA0irRLoxW4i+wXYqSMGij3NiRUczE+mriQyqr2e4HDawypTyhRw1CS+cngQrXnV4hI0odF2otekT/CGY4DYryPOAH3gXo8iodJbZUx4X+4ZoHnOMlUEEFnB8M79qtEBXykfvkT4BRYN+Tcr9grr6yixUoenQrm+50Rmi0sp2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AtcptlUP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDgGd8K0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 18:23:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760545421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGbjAiF1jSY4711BNsD/ZIqHEDwtp6KfdPgBKFfNs1k=;
	b=AtcptlUPp5d4CErT0D0hFhCau1ubgfYZ6RZPhpKlXTgRfNAQHpPDHWEujZA9Gp3DuOQ7+y
	7fABLmbJLPDYnjNjfXjFeBkgfQGYFRzu1M8OThwd2h6Zoq270jEcglnZpu4TNNwUpG9CWL
	ojGX7I+xUKLmWKPqrOao5IedfOzUA+8B5oP9L1J2ZI9XCkeCUB25bxSJcEN7BnFchDTDrX
	a0zj8wrGMFzeBHIfJu1QFi2jKj0k5g56OMza7ha6QWTma0snSzd3qqCKySZvfpZbDpLf1i
	xufRBHuhMIkI+O5DVy026bsM/2+6cLLQGCouXUdXlTsstOUsemGS4bsRk9cvxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760545421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGbjAiF1jSY4711BNsD/ZIqHEDwtp6KfdPgBKFfNs1k=;
	b=iDgGd8K03a9bWMEnFJyasLik3s7j5+HKVWjWIvnlBN4gmGC0jyT6tujdcyfP+cZJVyFH+L
	+/duVBhJKivkvPDA==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"clrkwllms@kernel.org" <clrkwllms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: RE: Query about the impact of using CONFIG_PREEMPT_RT on locking
 mechanisms within networking drivers
Message-ID: <20251015162340.i7K71rpM@linutronix.de>
References: <TYCPR01MB12093B8476E1B9EC33CBA4953C2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <20251015110809.324e980e@gandalf.local.home>
 <TYCPR01MB120933E9C8A96EE9CF617CF1BC2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCPR01MB120933E9C8A96EE9CF617CF1BC2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>

On 2025-10-15 15:48:46 [+0000], Fabrizio Castro wrote:
> > The reason for the spin locks conversion to mutexes is simply to allow for
> > more preemption. A raw spin lock can not be preempted. If a lock is held
> > for more than a microsecond, you can consider it too long. There's a few
> 
> That actually gives us a good way of gauging when holding a lock is not
> appropriate. Thanks for this.

Other than that, the other thing is that if you have acquired a
raw_spinlock_t the resulting API of what can be used is minimized. You
can't invoke any function that acquires a spinlock_t which includes
something like kmalloc(, GFP_ATOMIC).

> > places that may hold locks longer (like the scheduler) but there's no
> > choice.
> > 
> > To allow spin locks to become mutexes, interrupts are also converted into
> > threads (including softirqs). There are also "local locks" that are used
> > for places that need to protect per-cpu data that is usually protected by
> > preempt_disable().
> > 
> > What issues are you having? It's likely that it can be tweaked so that you
> > do not have issues with PREEMPT_RT.
> 
> The first issue (which is the one that sparked this discussion) has been
> addressed by a patch that was sent out today.
> While the issue addressed by that patch is not related in any way to locking,
> it sparked a series of discussions within my team about locking because when
> PREEMPT_RT is used there are cases where the driver gets preempted at
> inconvenient times (while holding a spin lock, that gets translated to an
> rtmutex with PREEMPT_RT), and the issue itself is fully masked when using
> raw spin locks (and that's because the code doesn't get preempted, making
> the issue a lot less likely to show up).

The driver shouldn't get preempted under normal circumstances. It (the
threaded interrupt where the NAPI callback gets invoked) runs by default
at SCHED_FIFO 50 which is higher than any user thread (there are some HI
priority kernel threads, yes). Unless there is a user thread with a
higher priority there is no preemption.
If it gets preempted due to $reason, the "time out check function"
should check if the condition is true before reporting a failure due to
timeout. (Which mean if the timeout is exceeded but the waiting
condition is met then it should not report an error due to timeout).

> The above picked our curiosity, and therefore we had a look at what's
> under `drivers/net` and there doesn't seem to be much code using raw spin
> locks directly, hence the question.  
> 
> Here is a link to the patch I was mentioning (although not relevant to
> locking):
> https://lore.kernel.org/netdev/20251015150026.117587-4-prabhakar.mahadev-lad.rj@bp.renesas.com/T/#u
> 
> Another issue we have seen is around CPU stalling on a couple of drivers
> when PREEMPT_RT is enabled:
> https://lore.kernel.org/all/CA+V-a8tWytDVmsk-PK23e4gChXH0pMDR9cKc_xEO4WXpNtr3eA@mail.gmail.com/
> 
> The above is more luckily related to locking issues, even though we didn't
> have the time to dive into it just yet, so we are not 100% sure about what's
> happening just yet.

It shouldn't stall. From the backtrace, stmmac_tx_clean() blocks on
spinlock_t so someone should own it. Why is the owner not making
progress?
The second backtrace originates from trylock from within in
mem_cgroup_sk_charge()/ try_charge_memcg(). As far as I remember the
code, it does trylock once and if it fails it moves on. So it could show
up by chance in the backtrace while it got preempted. If it spins on the
lock via trylock then it will lockup as in the backtrace.
If it got preempted, then there needs to be a thread with higher
priority. 

LOCKDEP and CONFIG_DEBUG_ATOMIC_SLEEP might show where something goes
wrong.

> Again, thanks a lot for your answer.
> 
> Kind regards,
> Fab

Sebastian


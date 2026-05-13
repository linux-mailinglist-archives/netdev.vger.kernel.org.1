Return-Path: <netdev+bounces-287662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIlsLkKeBGr3LwIAu9opvQ
	(envelope-from <netdev+bounces-287662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:52:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7E536878
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB9BF3179E7B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5F48122B;
	Wed, 13 May 2026 15:29:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D548122E;
	Wed, 13 May 2026 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686188; cv=none; b=meDz23adHi+PoB35vDF1//6Qdno97W4jkCYptvHJ7gfv6WctfZQe3fEEaAF0e7RcAb73dLy3+PCb3CLJR2s77fi+YpjzcKu+lHqg4Be5yJl3OXr20+q565kNs3Oozes7lCb2Ch7Io6Q5pgmbXmCO/yg4TGiDZ3Z2OFr/OYSbnW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686188; c=relaxed/simple;
	bh=ZsUiVqefahgmgodzAw5phaSSNA5pb/XW+ugf17Uxd3k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gg+uWC3eutpv0KVDerKfCvsiWAJIjnywqczMTGsICYmRn/sdRdlNwkRhPSQj6/uYZa3t8f8k4IAwyCv2yxUvs/FfyqNNSI1mJ+x9PmA3gkZ/hCX8aE8zhlEhGyTvDLAy+B1fxo9iyODSvxAVhRT+tejwRdgQ4nU9K6m/6TF008M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0C33792009C; Wed, 13 May 2026 17:29:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 08B6E92009B;
	Wed, 13 May 2026 16:29:38 +0100 (BST)
Date: Wed, 13 May 2026 16:29:37 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] FDDI: defza: Sanitise the reset safety timer
In-Reply-To: <20260512180631.7c50adff@kernel.org>
Message-ID: <alpine.DEB.2.21.2605131524010.46195@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk> <20260512180631.7c50adff@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 62D7E536878
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,angie.orcam.me.uk:mid]
X-Rspamd-Action: no action

On Tue, 12 May 2026, Jakub Kicinski wrote:

> >  		case FZA_STATE_UNINITIALIZED:
> >  			netif_carrier_off(dev);
> > -			timer_delete_sync(&fp->reset_timer);
> > +			timer_delete_sync_try(&fp->reset_timer);
> >  			fp->ring_cmd_index = 0;
> >  			fp->ring_uns_index = 0;
> >  			fp->ring_rmc_tx_index = 0;
> > @@ -1018,7 +1018,9 @@ static irqreturn_t fza_interrupt(int irq
> >  			fp->queue_active = 0;
> >  			netif_stop_queue(dev);
> >  			pr_debug("%s: queue stopped\n", fp->name);
> > -			timer_delete_sync(&fp->reset_timer);
> > +
> > +			spin_lock(&fp->lock);
> > +			timer_delete(&fp->reset_timer);
> 
> Noob q, why use timer_delete_sync_try() above ?

 I guess it got lost in the lengthy commit description:

> [...]  For the transition 
> to the uninitialised state switch to timer_delete_sync_try() instead, so 
> that a timer isn't deleted that's just been rearmed by the timer handler 
> and needs to watch for the device to come out of reset again (again, an 
> SMP scenario only).

 Does it answer your question, or shall I rephrase it?

 Actually I gave this piece a bit of extra thought before sending this 
final version.  I considered having extra state added and protected with 
the data access spinlock and then using that state to refrain from 
reissuing the reset if the change to the uninitialised state happened 
literally as the reset timer handler has been entered.

 But I concluded it was not worth it given that it's such an unlikely
state to arrive at.  We're talking about recovery from failed recovery 
here.  So I chose to keep it simple: if the timer has already fired, then 
instead just let it re-reset the device and rearm itself, and abandon the 
timer deletion here, exactly what timer_delete_sync_try() does.  After all 
if the device state change happened a moment later, that's what would 
happen anyway with either approach and we gave the device enough time 
margin to come out of reset, so there's no need to be gentle.

 FWIW I want to port this code sometime to the defxx driver, which handles 
a newer generation of devices that are an evolution of and quite similar 
in many respects to ones handled by this defza driver and which in 
particular implement an analogous state machine handled by an RTOS running 
on m68k hardware.  While devices handled by the defxx driver are much 
faster and their reset takes ~1s rather than ~10s, it's still quite a lot 
and the original DEC code which just busy-waits in the hardirq context 
results in a horrible OS latency spike one user has actually complained 
about, as apparently it was quite a frequent event in their setup.

 As the defxx driver can actually run on SMP hardware (and I have MIPS, 
POWER9, RISC-V, and x86 SMP test systems for the defxx driver in addition 
to a bunch of UP machines of various CPU architectures) at that point I 
may revisit the choice made here and make an incremental change so that 
both drivers use the same approach, but I don't think there's a need right 
now.  Then again, I might not, as it might be good enough a path of least 
resistance approach for both drivers after all.

  Maciej


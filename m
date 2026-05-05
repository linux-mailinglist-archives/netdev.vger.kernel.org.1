Return-Path: <netdev+bounces-284425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMBiD5n4+WmNFgMAu9opvQ
	(envelope-from <netdev+bounces-284425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:03:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB4E4CEFFC
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14CA5300B9D1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0925B357A40;
	Tue,  5 May 2026 14:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236C17A31E;
	Tue,  5 May 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989661; cv=none; b=WTcLgv4B7uDoGTcPIiy2/rdHcJc2hsv5qxcbEbGu0csZicvnwx6v9QGcSteQqb5UEcwSKn0aBW0Z8rw1ZEs96oh4WOYFC1/hm/zM+xZPJWIHq6aFq1VSv06/HJCc9PAZY6ROSIcx5DuTUAlb6aDf2mnC9ajXGtEv4iRyzzSDIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989661; c=relaxed/simple;
	bh=A99Lwb/EVkzUM3n7icopGBnxN59R2q53tEB1r7fxhkY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HqtFKKwbgO97NTrPMw58owOotGYNXykWOegsf1O+8eFXy+0YRRP9G+xYzLXFGpJnZUrvHEkuP3LwN2nFNP43t9ImDtNq+vJlSwX3Vufz4jmgDr0JVmxQT0P9dlsk0EIHR3QddDP/7weN/L8uwHe/YOUh6ieq6Un/3p2SJsU+lmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1B4DD92009C; Tue,  5 May 2026 16:00:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 14B5092009B;
	Tue,  5 May 2026 15:00:57 +0100 (BST)
Date: Tue, 5 May 2026 15:00:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: netdev@vger.kernel.org, linux-mips@vger.kernel.org, 
    Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] declance: Remove IRQF_ONESHOT
In-Reply-To: <20260505123203.jifiaxEL@linutronix.de>
Message-ID: <alpine.DEB.2.21.2605051410280.46195@angie.orcam.me.uk>
References: <20260127135334.qUEaYP9G@linutronix.de> <alpine.DEB.2.21.2601271508160.40317@angie.orcam.me.uk> <20260127165430.7ui_LGkg@linutronix.de> <alpine.DEB.2.21.2601271739250.40317@angie.orcam.me.uk> <alpine.DEB.2.21.2603292037020.60268@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605042332070.46195@angie.orcam.me.uk> <20260505072954.Ov2t-FGt@linutronix.de> <alpine.DEB.2.21.2605051233210.46195@angie.orcam.me.uk> <20260505123203.jifiaxEL@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 3EB4E4CEFFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.859];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,angie.orcam.me.uk:mid]

On Tue, 5 May 2026, Sebastian Andrzej Siewior wrote:

> > > With force-threading enabled, the interrupt handler is masked in the
> > > IRQ-chip until after the threaded-handler run. See the cond_unmask_irq()
> > > in handle_level_irq() or the mask_irq() & cond_unmask_eoi_irq() in
> > > handle_fasteoi_ack_irq(). That means the hw-IRQ is done, the thread is
> > > running with interrupts enabled but the hw-IRQ will not trigger again.
> > > The cited commit 5a4a4ad851dd8 ("MIPS: Mark cascade and low level
> > > interrupts IRQF_NO_THREAD") is different as it acts on cascading
> > > interrupts which is not what we have here.
> > 
> >  Not with the current handle_fasteoi_irq() handler.
> 
> Why? There is a mask_irq() in the ONESHOT case.

 Yes, in that case there is.

> > > If you request a threaded interrupt you must either provide two handler
> > > and the primary must mask the interrupt so it does not fire again or you
> > > pass a flag such as IRQF_ONESHOT and which point the IRQ subsystem will
> > > mask the IRQ within the irqchip so it does not fire again.
> > 
> >  Well, yes, but you've just removed the flag from this driver, so either 
> > the flag has to reinstated or the driver adjusted differently for the 
> > threaded case to be handled correctly.
> 
> But there is a plain request_irq() so the handler is invoked directly in
> hardirq context with disabled interrupts. In forced-threaded context,
> such as on PREEMPT_RT, the IRQF_ONESHOT is added.

 Ah, I missed that IRQF_ONESHOT bit in irq_setup_forced_threading().  So 
it seems like we're good.  I'll proceed with the original change then to 
just amend IOASIC DMA IRQ documentation.  Thank you for patience again.

  Maciej


Return-Path: <netdev+bounces-255940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAsdFd3YgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:03:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFACCF535
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D38C3051FDF
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA537419D;
	Mon,  2 Feb 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ov83CI+G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jnb2/wRo"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F441400C
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051427; cv=none; b=uff/+UPflafbKRzU8jbco1MvYU7GJmIhS0zpYxwUaGUWrnAEuFoyixC5I/qwf3F8if32+vwNSgJaAg045vls9GYwL+QEYbcZwjnapjwU5n6bIgeDcrShYHDpKfRvHKh2cPULLnI+IifoM7PyqBI8yqNu6AfYigK7zGLq9qFfgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051427; c=relaxed/simple;
	bh=8E5ONBvcfVT37uh4Jk1fWMzyzXbzCxUf3i5zkxOKb3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC5+9kBKRqH3fTPj/wtZxVAWj3Mc5Yq7/JMcmkIhH74qRosdArECvf6LUvKS7ZzfM9aM8pnn1/351Xt/zPbkvbVo1HN1aXAxbJNFMXecGsv6lkxEPV4gs97dCai8BINY3es3r9MmDarhEUdXeTRWa1JVwadfCMPEeBnAKQ/GMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ov83CI+G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jnb2/wRo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Feb 2026 17:57:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770051423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQHktm7ISLkxwu+7pUbNU9/cZxbB1MkwQDT/LVEjl8k=;
	b=ov83CI+G5kacd3g0kc2yYcmT+fVhlAyQLg5qYqJIZ2j4YZTTaBteXyTIuK4GoL931ZbyIB
	wUBOVmeBepULEQU2YixkcK1e7EHcJ1rjJF3f0UCyMeWU0awxs6+Nd89mJ5YQIXwtld9qna
	S5aB2Bi2lixF9vF5lsAYpEfUrq7r3PClddm6MAzlRFrYo4m4/mBpuhpkEGrgrN8U91SP6C
	RufOr4N5hGuBHv6iURyg2e/P1GRveckDmHVSaFUIZUmEWhS+KoAU+nGHsg0WjL9SstOmyl
	oXzgpwLsrt14MDW/ynC+kCBB9hvVtzH+j6S9440GXLhY3KHlxmR/cFfIbdgE3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770051423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQHktm7ISLkxwu+7pUbNU9/cZxbB1MkwQDT/LVEjl8k=;
	b=Jnb2/wRozuv3JrB/b+l9yAyAZNNiJ9WftxgvvFw8JSdxIcyIkYQLI5p+PVO1pHaLAfUvQT
	Jny1K1jxFEP+zsCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jkarrenpalo@gmail.com, tglx@linutronix.de,
	mingo@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <20260202165702.R9PI3JSM@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
 <20260128163824.GB172540@kernel.org>
 <aXpXY0YSjA-ctoBa@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXpXY0YSjA-ctoBa@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: BFFACCF535
X-Rspamd-Action: no action

On 2026-01-28 19:37:23 [+0100], Felix Maurer wrote:
> > > +	if (!block) {
> > > +		block = &node->block_buf[node->next_block];
> > > +		hsr_forget_seq_block(node, block);
> > > +
> > > +		memset(block, 0, sizeof(*block));
> > > +		block->time = jiffies;
> > > +		block->block_idx = block_idx;
> > > +
> > > +		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
> > > +		if (xa_is_err(res))
> >
> > Hi Felix,
> >
> > I ran Claude Code over this with review-prompts [1] and it flags
> > that in the error path above, the following is needed so that the
> > block can be re-used.
> >
> > 			block->time = 0;
> 
> I agree. It would nonetheless be reused at some point, but not setting
> time = 0 may lead to an unexpected block getting removed when it is
> reused (or at least an attempt to do so). I'll fix this in v3.

Not sure I follow. If xa_store() fails then the block is not added to
the "sequence-blocks" and it will be attempted once the next packet is
received, right?. Otherwise node->next_block is not updated at which
point this block will be added twice which sounds worse.

> Thanks,
>    Felix

Sebastian


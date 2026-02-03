Return-Path: <netdev+bounces-256266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO0WOkbjgWmDLQMAu9opvQ
	(envelope-from <netdev+bounces-256266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:00:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1CFD8B1C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC0E30A7073
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC703385B1;
	Tue,  3 Feb 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aOZplOHn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cy90x2mm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72D314D16
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119843; cv=none; b=lVkXB6mBRqr6Ge3le7SZ5XC0td+O7aXWWaHx2gM76S44TfdDKFusiUlL7F0rswwkUWhynA9EZl6grWB4I6VyYeByZHN1xJ20LynNhp2Gvlyw7Uq3Z9E7cIsoLiE/C6KAvx1XXl9ZvgBZu7aBRus2OSQhRosiv1fQ3mSspDKwkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119843; c=relaxed/simple;
	bh=cAfTxGKxjW5d3vRnbV3xTwC6vBIYq4Av9CerqTSTB1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zfk4t/Rg5sTn+w8neWEhcWOhxkWWL85RtL8BHKwxyhNwXsxhLBbg24dQCC2A1pkNcfM0xRsXoyAFJz9fjhBfKcbPEZrZvnqGZ0QgTf1L9uY3rLvJDgyw2cgQuvvdFzN5NVQk4ulspjIZTjEAJu8i7xF/HWwsOe/42UUhyuiOBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aOZplOHn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cy90x2mm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Feb 2026 12:57:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770119840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9N0zUV33y6tlASOxKp8jQarBDqubWd4gAbaXPL2Ab/s=;
	b=aOZplOHnh934JXndMgTmxlOZjme3HWm8olPhK5NhD5OBlJ+spL8ERw02OYUe61awHmWIKV
	CLDiPn0FkINEXbwH+oupf48dXrKzaHYH0pYxuvfxxjWV6QaNSuQuznROx5cjKuXF6isiIl
	dNcgU61lHIWwop/CprceEZCyiJg9MLOrtdtUtND1Wj+ROjCRXj4O5ocX6KFbqx4IoLkQEf
	XdPYA6Om40pWjBkW3TMVoczyGL4SbWa6EfMRBnBft1nKxQKNx4AoYGTmGwzJKKyw83T0tF
	5VNlatzYg3S0pFO/AQVRoxrVGZGyYltknfMV7xUB/eZz6bwK6qXqFImf3sekGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770119840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9N0zUV33y6tlASOxKp8jQarBDqubWd4gAbaXPL2Ab/s=;
	b=Cy90x2mmllSjtBiS7u4LUYvLCrnp2Rjy+pQXEaV2tIpfaLCb+xOGmdRF3M5bCSyQ7XF0CQ
	vjsPxMdzIcd4XWDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jkarrenpalo@gmail.com, tglx@linutronix.de,
	mingo@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <20260203115719.cU_6tnal@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
 <20260128163824.GB172540@kernel.org>
 <aXpXY0YSjA-ctoBa@thinkpad>
 <20260202165702.R9PI3JSM@linutronix.de>
 <aYHMvaGiuQSHBevG@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYHMvaGiuQSHBevG@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256266-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E1CFD8B1C
X-Rspamd-Action: no action

On 2026-02-03 11:23:57 [+0100], Felix Maurer wrote:
> On Mon, Feb 02, 2026 at 05:57:02PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-28 19:37:23 [+0100], Felix Maurer wrote:
> > > > > +	if (!block) {
> > > > > +		block = &node->block_buf[node->next_block];
> > > > > +		hsr_forget_seq_block(node, block);
> > > > > +
> > > > > +		memset(block, 0, sizeof(*block));
> > > > > +		block->time = jiffies;
> > > > > +		block->block_idx = block_idx;
> > > > > +
> > > > > +		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
> > > > > +		if (xa_is_err(res))
> > > >
> > > > Hi Felix,
> > > >
> > > > I ran Claude Code over this with review-prompts [1] and it flags
> > > > that in the error path above, the following is needed so that the
> > > > block can be re-used.
> > > >
> > > > 			block->time = 0;
> > >
> > > I agree. It would nonetheless be reused at some point, but not setting
> > > time = 0 may lead to an unexpected block getting removed when it is
> > > reused (or at least an attempt to do so). I'll fix this in v3.
> >
> > Not sure I follow. If xa_store() fails then the block is not added to
> > the "sequence-blocks" and it will be attempted once the next packet is
> > received, right?. Otherwise node->next_block is not updated at which
> > point this block will be added twice which sounds worse.
> 
> Yes, it will be attempted again on the next frame that needs a new
> block. But every attempt to recycle the next_block starts with calling
> hsr_forget_seq_block(), which tries to xa_erase() the block if time!=0.
> Generally, time==0 is the marker that a block is not stored in the
> xarray. So for consistency it's correct to set time=0 if the block can't
> be added to the xarray, even though I don't think it would cause any
> trouble at the moment if the time is not reset.

My point is that the block will not be recycled if it failed to be added
here. It remains the "next" block to be used and added to the list if it
fails that xa_store().

> Thanks,
>    Felix

Sebastian


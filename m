Return-Path: <netdev+bounces-268267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKU+GWBguGlbdAEAu9opvQ
	(envelope-from <netdev+bounces-268267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:56:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC06429FF2D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8A0F303433E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27C3ED111;
	Mon, 16 Mar 2026 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGxUvxk2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD333ED10F
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690922; cv=none; b=ghYA0AM+7BNaFeLa1jMog/uexZIsasiLGIYcPVuiD18SZoLvYTznBddLK3iREqR/xGUq1Zppn8y4FLWTKv3QISA1mPwCJkFmAzTqGdaYDf0b7Tihy90D4oRbAYxGxO+zx8iz+fM9EV9pvD5GrWbpVjYq0wnH3L3+R4qhzedRkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690922; c=relaxed/simple;
	bh=6JXdvYuBw39z6Dc4icPdNkTRN0VFaoyYGp8YGPQLTy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQfL3Kl+ohOnoF00gwPqQffohbqe/60Cj+fb/CMsSAAjSGvj77wNV6sBvPERIRB5NKl89rZWYUnBv26Z1KBFw2lWoJdpPcUpgQmXn94z4ILNRNIy8nWfiXvzMMauYUD05TIw7EBrs7sjEs4a2vPE9UjDmHCqkBPXq83TjDtDQCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGxUvxk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37C8C2BC87;
	Mon, 16 Mar 2026 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773690921;
	bh=6JXdvYuBw39z6Dc4icPdNkTRN0VFaoyYGp8YGPQLTy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGxUvxk2YXoH7IyTeuFvCCYUvKNv2KvP58jjlcThgJfSNfJg1xQbC1kstiTHxnLtr
	 6TG6GtlKcGE0rvVP3XYnAyFzxdts2hdxOsQxVAHgaDiUQibmjrmc8YpRGvksDEGDAd
	 ZrJFrUVx5Rxdlsd4b/oOEQRPxlXRojmZ9dLCXQiu0WaDBZwtE/t9q8rTv3pZUsfGsl
	 Lu6GoB/YVVdThFOj/XkIv7jjO6fkdG3b8xh/gpTzZATCtDgwmNeHi9NtCqZdudTOp7
	 +Zzq61EmjdtcM+Av0Rn6BHWUmMKlukCFstTwU55wfqpel/UaTKB3nssRQMEKGpwLDc
	 rn8NuqvRdAoMg==
Date: Mon, 16 Mar 2026 21:55:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <20260316195516.GJ61385@unreal>
References: <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
 <abBv6zR4Qq_lrzuC@strlen.de>
 <20260310194500.GO12611@unreal>
 <abB12Ae769OivuYB@strlen.de>
 <20260310201021.GP12611@unreal>
 <abCQGh5Ce9uDbOo9@krikkit>
 <20260311073635.GR12611@unreal>
 <abLPZa7HNFFE4QXo@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLPZa7HNFFE4QXo@krikkit>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268267-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC06429FF2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 03:36:21PM +0100, Sabrina Dubroca wrote:
> 2026-03-11, 09:36:35 +0200, Leon Romanovsky wrote:
> > On Tue, Mar 10, 2026 at 10:41:46PM +0100, Sabrina Dubroca wrote:
> > > (adding Simon: maybe you can help with the "comment wording" issue here :))
> > > 
> > > 2026-03-10, 22:10:21 +0200, Leon Romanovsky wrote:
> > > > On Tue, Mar 10, 2026 at 08:49:44PM +0100, Florian Westphal wrote:
> > > > > Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > > You can only use xfrm_state_hold() if the refcount is already > 0.
> > > > > > > xfrm_state_hold uses refcount_inc(), so you get a UaF warn splat
> > > > > > > if this assuption doesn't hold true.
> > > > > > 
> > > > > > I know it, the thing that bothers me is that it is unclear how
> > > > > > xfrm_state_hold_rcu() can have refcount equal to 0.
> > > > > > 
> > > > > > xfrm_state_put() decreases refcount and when it is zero, it calls
> > > > > > to __xfrm_state_destroy(). The latter assumes that the state was
> > > > > > already removed from various hlists.
> > > > > 
> > > > > Yes, insertion in the table means refcount is 1, but userspace
> > > > > can zap states at any time, e.g.:
> > > > > 
> > > > > xfrm_del_sa -> xfrm_state_delete -> __xfrm_state_delete (which
> > > > > unlinks from hash lists).
> > > > > 
> > > > > The last xfrm_state_put() in that function may cause 1 -> 0
> > > > > transition.  Parallel lookup can still observe that state,
> > > > > so it has to pretend it wasn't there to begin with.
> > > 
> > > Thanks Florian.
> > > 
> > > 
> > > > Yes, this is possible scenario and this is what is worth to document.
> > > 
> > > 
> > > We could add something like:
> > > 
> > > /* Take a reference to @x, when we know the state has a refcount >= 1.
> > >  * In this case, we can avoid refcount_inc_not_zero and the error
> > >  * handling it requires.
> > >  * In contexts where concurrent state deletion is possible and we
> > >  * don't already hold a reference to that state, xfrm_state_hold_rcu
> > >  * must be used.
> > >  */
> > > 
> > > Though it may not make much sense to refer to xfrm_state_hold_rcu
> > > (implemented in net/xfrm/xfrm_state.c) from include/net/xfrm.h.
> > > 
> > > And if we consider the hashtables to be private to
> > > net/xfrm/xfrm_state.c, nothing outside of it should ever see a state
> > > with refcount=0, since they will only ever see states that already
> > > have one reference held by whatever gave them the pointer.
> > > 
> > > So maybe it's more xfrm_state_hold_rcu that needs a mention of
> > > "concurrent state deletion could bring the refcount to 0 while we're
> > > doing the lookup"? I don't know, for me it's pretty obvious with the
> > > _rcu suffix that RCU -> unlocked -> could be deleted in parallel.
> > 
> > It was the case when xfrm_state had __rcu marker, it is less obvious
> > now. I agree with you that xfrm_state_hold_rcu() needs to be documented
> > and not xfrm_state_hold().
> 
> Ok. Would that work for you?

Yes, it is fine, thanks

> 
> /* Take a reference to @x.
>  * This must be used (and the error handled) for unlocked lookups
>  * where concurrent state deletion could bring the refcount to 0.
>  *
>  * When we know that the state has a refcount >= 1, xfrm_state_hold
>  * can be used.
>  */
> 
> If not, what other information do you need?
> Then I can send the patch separately, as Steffen said.
> 
> -- 
> Sabrina


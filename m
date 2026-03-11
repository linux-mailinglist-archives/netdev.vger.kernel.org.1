Return-Path: <netdev+bounces-266504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLM5LIsbsWmOqwIAu9opvQ
	(envelope-from <netdev+bounces-266504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:36:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B42725E08E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1E293008247
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152A3B0ADB;
	Wed, 11 Mar 2026 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQteAyR9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFE3B27FF
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214600; cv=none; b=cLSQ5+3q7ey5ABc/EOeUhihrb0uqwiJcpuYB5jsms9Vpxyl0CBmrKvdl0fq5zYYtK/TUuzw/oLFWl3X65InYGtMRVEo4yWXiP5jY3kZk5Aqy6EdA6Wi7WKAdzOIEOwAFQGQ11PDRh7xQJRb3ktHpB1WI5YH32EO2nUfTf5qcp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214600; c=relaxed/simple;
	bh=HcCA86If4wMPDKdIAoMLlvJ612HBDwwIc90rcnzJwNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3mmVqEV19i5RzS+37FKOVVkraOpZTJyyPCRVsalfNJEkpDbXbkEkJ5P8sJQfmrSKt5Gp/wQ+BgvxuMwwD2p9M18xZHL7IBByzQHDzzeASY8OnB7QkmWzIzpUEfi4cYNXlFgS6qvdG49hnpVUNygrwmfIFmRz8KCxAKPElR1bH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQteAyR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AC0C4CEF7;
	Wed, 11 Mar 2026 07:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773214599;
	bh=HcCA86If4wMPDKdIAoMLlvJ612HBDwwIc90rcnzJwNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQteAyR9G5imXHR3ZpRw4vBPOx29pmZPQplR5qh0oIqnZGtYv7Ya+df0ECw70+b7G
	 IusGbtgVeF3MVcKPgHFitNHIQCiUeG575GN3ePgbjTgD8hZODdO3LNeQV/wm8+pfQ2
	 rkUxYUBIQ05AtI69hG4DlTl29m/xS5PFRbgEIBquYMypFQn98/CHlr+/Zv4z7V9hE8
	 O6uAWams+6y75vZdqzaQFot3s0qYEb2JT1rV4V1/71EpmSQsU6UJDlU1uQc6uf3hzc
	 X+Aa1t7OmKIU8Sjq4xE46HosRKVs6Ipd5qTSCPNRddmUWFCNDB8X3ardARiecABH9H
	 IokssWnbu7YBw==
Date: Wed, 11 Mar 2026 09:36:35 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <20260311073635.GR12611@unreal>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
 <abBv6zR4Qq_lrzuC@strlen.de>
 <20260310194500.GO12611@unreal>
 <abB12Ae769OivuYB@strlen.de>
 <20260310201021.GP12611@unreal>
 <abCQGh5Ce9uDbOo9@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abCQGh5Ce9uDbOo9@krikkit>
X-Rspamd-Queue-Id: 5B42725E08E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	TAGGED_FROM(0.00)[bounces-266504-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.30.226.201:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:41:46PM +0100, Sabrina Dubroca wrote:
> (adding Simon: maybe you can help with the "comment wording" issue here :))
> 
> 2026-03-10, 22:10:21 +0200, Leon Romanovsky wrote:
> > On Tue, Mar 10, 2026 at 08:49:44PM +0100, Florian Westphal wrote:
> > > Leon Romanovsky <leon@kernel.org> wrote:
> > > > > You can only use xfrm_state_hold() if the refcount is already > 0.
> > > > > xfrm_state_hold uses refcount_inc(), so you get a UaF warn splat
> > > > > if this assuption doesn't hold true.
> > > > 
> > > > I know it, the thing that bothers me is that it is unclear how
> > > > xfrm_state_hold_rcu() can have refcount equal to 0.
> > > > 
> > > > xfrm_state_put() decreases refcount and when it is zero, it calls
> > > > to __xfrm_state_destroy(). The latter assumes that the state was
> > > > already removed from various hlists.
> > > 
> > > Yes, insertion in the table means refcount is 1, but userspace
> > > can zap states at any time, e.g.:
> > > 
> > > xfrm_del_sa -> xfrm_state_delete -> __xfrm_state_delete (which
> > > unlinks from hash lists).
> > > 
> > > The last xfrm_state_put() in that function may cause 1 -> 0
> > > transition.  Parallel lookup can still observe that state,
> > > so it has to pretend it wasn't there to begin with.
> 
> Thanks Florian.
> 
> 
> > Yes, this is possible scenario and this is what is worth to document.
> 
> 
> We could add something like:
> 
> /* Take a reference to @x, when we know the state has a refcount >= 1.
>  * In this case, we can avoid refcount_inc_not_zero and the error
>  * handling it requires.
>  * In contexts where concurrent state deletion is possible and we
>  * don't already hold a reference to that state, xfrm_state_hold_rcu
>  * must be used.
>  */
> 
> Though it may not make much sense to refer to xfrm_state_hold_rcu
> (implemented in net/xfrm/xfrm_state.c) from include/net/xfrm.h.
> 
> And if we consider the hashtables to be private to
> net/xfrm/xfrm_state.c, nothing outside of it should ever see a state
> with refcount=0, since they will only ever see states that already
> have one reference held by whatever gave them the pointer.
> 
> So maybe it's more xfrm_state_hold_rcu that needs a mention of
> "concurrent state deletion could bring the refcount to 0 while we're
> doing the lookup"? I don't know, for me it's pretty obvious with the
> _rcu suffix that RCU -> unlocked -> could be deleted in parallel.

It was the case when xfrm_state had __rcu marker, it is less obvious
now. I agree with you that xfrm_state_hold_rcu() needs to be documented
and not xfrm_state_hold().

Thanks

> 
> 
> We also have __xfrm_state_put, the commit message that introduced it
> states:
> 
>     We often just do an atomic_dec(&x->refcnt) on an xfrm_state object
>     because we know there is more than 1 reference remaining and thus
>     we can elide the heavier xfrm_state_put() call.
> 
> so we could add:
> 
> /* Drop a reference to @x, when we know there is more than 1 reference remaining.
>  * In this case, we can avoid refcount_dec_and_test and just decrement refcnt.
>  */
> 
> but maybe someone has a better suggestion.
> 
> 
> -- 
> Sabrina


Return-Path: <netdev+bounces-173568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B16A59801
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BB93A496F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9F22C352;
	Mon, 10 Mar 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C/GC4lSl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4BzOMNb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBC22B8AF
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617903; cv=none; b=aPHkDLZSg9/FEORrBzzR+AkfnYxAwa0yMjUbS9UYtQMq1JuCnsztwB0C0b2JU2RmChpRCOQ661DOQx8BK42iawUKWi8u/AtUgp1ZcZUZMRIooYvQ55PClkv2wKQwR+UWeezMDmGKH+1qw4tGlUAULpncuDhFl4JMa+agAe20Q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617903; c=relaxed/simple;
	bh=8GSD+KgZs98DDnOVJAJSe62qpLO//p2nYds0VQLQqRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euwWSP+vvAHKRenGA8VyHX8o6VDRe4WlwGvLRgGK45Wnzw4QSe4IOHsfuUa18Ab6/2wPNMtjfi6QQwq2yYAjgCjb8G0P6AQ8KyKTltroeuMbgYdCwc93MMq3LYRmjrvdHosu9hZHcEeYrOOscFc6GqKAt8xdLfUNsmZ1uua8yXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C/GC4lSl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S4BzOMNb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 15:44:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741617900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GexyH34skuGWPgws1YxMmiPZHV9MF5Ub/1DCiTifu3o=;
	b=C/GC4lSlOQo3iW+Ea+toJ/wfPZig7IsZUmqAamBD9HxEUDl0WVSyMs40FucbhYN/7g4Kgk
	jmXMFYzV6XFkTuhYalsXwJoJlDyvVHdsmltJyf/MvnDfAANIEOUbrOhbgKrQ/M9/NEb7/F
	hfNa0n+QJLGwlxqPjjdsbA6oEcWMctRcn+RvBjEBp8y5ifTD0Ngus25uasbJMoEEOALiow
	zeNat067QwrniI4eUa+qQK+xR+OUyg7mpuJdniAThc0q+KO51IOW2VzF4KHSLZdka7QcYd
	4wq/z/2P0msLCjs+kFays4I+iuwjGWH1V1mpAd0K6+529HotTAuwVm6h2q0HMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741617900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GexyH34skuGWPgws1YxMmiPZHV9MF5Ub/1DCiTifu3o=;
	b=S4BzOMNbKmY4vJgXDvdBQEyL2WtFTv3Ev+o6IZflm8BAKMtGyfL64el+Pc+XWpiMUEAYL2
	X5e+gtkX19qPqmAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	dev@openvswitch.org, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 11/18] openvswitch: Use nested-BH
 locking for ovs_actions.
Message-ID: <20250310144459.wjPdPtUo@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-12-bigeasy@linutronix.de>
 <9a1ededa-8b1f-4118-94b4-d69df766c61e@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a1ededa-8b1f-4118-94b4-d69df766c61e@ovn.org>

On 2025-03-10 15:17:17 [+0100], Ilya Maximets wrote:
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -82,6 +82,8 @@ struct ovs_action {
> >  	struct action_fifo action_fifos;
> >  	struct action_flow_keys flow_keys;
> >  	int exec_level;
> > +	struct task_struct *owner;
> > +	local_lock_t bh_lock;
> >  };
> >  
> >  static DEFINE_PER_CPU(struct ovs_action, ovs_actions);
> > @@ -1690,8 +1692,14 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >  			const struct sw_flow_actions *acts,
> >  			struct sw_flow_key *key)
> >  {
> > +	struct ovs_action *ovs_act = this_cpu_ptr(&ovs_actions);
> >  	int err, level;
> >  
> > +	if (ovs_act->owner != current) {
> > +		local_lock_nested_bh(&ovs_actions.bh_lock);
> 
> Wouldn't this cause a warning when we're in a syscall/process context?

My understanding is that is only invoked in softirq context. Did I
misunderstood it? Otherwise that this_cpu_ptr() above should complain
that preemption is not disabled and if preemption is indeed not disabled
how do you ensure that you don't get preempted after the
__this_cpu_inc_return() in several tasks (at the same time) leading to
exceeding the OVS_RECURSION_LIMIT?

> We will also be taking a spinlock in a general case here, which doesn't
> sound particularly great, since we can potentially be holding it for a
> long time and it's also not free to take/release on this hot path.
> Is there a version of this lock that's a no-op on non-RT?

local_lock_nested_bh() does not acquire any lock on !PREEMPT_RT. It only
verifies that in_softirq() is true.

> > +		ovs_act->owner = current;
> > +	}
> > +
> >  	level = __this_cpu_inc_return(ovs_actions.exec_level);
> >  	if (unlikely(level > OVS_RECURSION_LIMIT)) {
> >  		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
> > @@ -1710,5 +1718,10 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >  
> >  out:
> >  	__this_cpu_dec(ovs_actions.exec_level);
> > +
> > +	if (level == 1) {
> > +		ovs_act->owner = NULL;
> > +		local_unlock_nested_bh(&ovs_actions.bh_lock);
> > +	}
> 
> Seems dangerous to lock every time the owner changes but unlock only
> once on level 1.  Even if this works fine, it seems unnecessarily
> complicated.  Maybe it's better to just lock once before calling
> ovs_execute_actions() instead?

My understanding is this can be invoked recursively. That means on first
invocation owner == NULL and then you acquire the lock at which point
exec_level goes 0->1. On the recursive invocation owner == current and
you skip the lock but exec_level goes 1 -> 2.
On your return path once level becomes 1, then it means that dec made it
go 1 -> 0, you unlock the lock.
The locking part happens only on PREEMPT_RT because !PREEMPT_RT has
softirqs disabled which guarantee that there will be no preemption.

tools/testing/selftests/net/openvswitch should cover this?

> Also, the name of the struct ovs_action doesn't make a lot of sense,
> I'd suggest to call it pcpu_storage or something like that instead.
> I.e. have a more generic name as the fields inside are not directly
> related to each other.

Understood. ovs_pcpu_storage maybe?

> Best regards, Ilya Maximets.

Sebastian


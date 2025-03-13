Return-Path: <netdev+bounces-174553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A40A5F36C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265EB17E9EB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56054266B69;
	Thu, 13 Mar 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4XlGdFc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E17I1zcd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000EB266B73
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866625; cv=none; b=AdFKgyC5AlncSVSOFBf7KUhoyWPYh0AvaWjIQEjSMlQsJe4S/GLrpWVJSUmbnAQUpWsxVmQj1YktaIToTtHjxGpywqa96+kBDHN4x6t8cjUJqusG3VDHbYGpyvoFuBKaZdwTPmQIlIhH3+l1AEnWHX6JNVg+b0/w+WjBuCyjxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866625; c=relaxed/simple;
	bh=U0gsi+E+k3dwn/YEhXBoNvUugd/LyG9kvHBZ45yX0aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQGilmZuoxgcdgnXTAeWTJvZCGDKWr0iu2XTTSBQg8hBBt74Wn5lbjtZsx9n7BMQU8uE8v46lr+obeOHztWn8TZCczNYisFp2tHxoAN5UkvS7fMSvctZi6C7bWVQ0x+oUu1SAPxSO6Djwmd3ivY4xP7QuYfRVQZPQwwqs4PjP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4XlGdFc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E17I1zcd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 12:50:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741866620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6UZLQU31/SVLLnCBXmHpww0TaJSbYXeNPsEYKH8Ub4=;
	b=U4XlGdFcm4bxwB+EtvzyubiNM5hrwfb/Fw6fjHgMMaaLxhgs7hdt9MlXtfeCdpZerMKDxj
	Mc9I5MmP21G08sTYmtpxHrJTR1iJseagwxx9Gb8L1EJIKwJuX1aCIajidpaFnZbkj9FzUY
	kx82UsitjXKLb75oAJH9zroYdkn58PA/roGiHGgBmvd3kxFdtsjSJetEwHQTJD13vKM3ua
	mImGqGsUJMEK1+kmnOw+eK8zxre1Y/ee5Ws4jZM2oFZ8AUY31KjrZgisENk8XRc3SEh48t
	SuMZFNiUNJVzNlFG3lWcnc9qNJfU7KBqv1VjMSJKcYUckA/QdkI0clXAH8/y2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741866620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6UZLQU31/SVLLnCBXmHpww0TaJSbYXeNPsEYKH8Ub4=;
	b=E17I1zcdJR80NEjHZUbiC1RoJ8tRGS0KtdwwatG5Mwzzvuop6YwwmXxIwoi1gPSgSDAk+5
	sJR4ww5pMNBB0UAg==
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
Message-ID: <20250313115018.7xe77nJ-@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-12-bigeasy@linutronix.de>
 <9a1ededa-8b1f-4118-94b4-d69df766c61e@ovn.org>
 <20250310144459.wjPdPtUo@linutronix.de>
 <fd4c8167-0c2d-4f5f-bf70-1efcdf3de2fb@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd4c8167-0c2d-4f5f-bf70-1efcdf3de2fb@ovn.org>

On 2025-03-10 17:56:09 [+0100], Ilya Maximets wrote:
> >>> +		local_lock_nested_bh(&ovs_actions.bh_lock);
> >>
> >> Wouldn't this cause a warning when we're in a syscall/process context?
> > 
> > My understanding is that is only invoked in softirq context. Did I
> > misunderstood it?
> 
> It can be called from the syscall/process context while processing
> OVS_PACKET_CMD_EXECUTE request.
> 
> > Otherwise that this_cpu_ptr() above should complain
> > that preemption is not disabled and if preemption is indeed not disabled
> > how do you ensure that you don't get preempted after the
> > __this_cpu_inc_return() in several tasks (at the same time) leading to
> > exceeding the OVS_RECURSION_LIMIT?
> 
> We disable BH in this case, so it should be safe (on non-RT).  See the
> ovs_packet_cmd_execute() for more details.

Yes, exactly. So if BH is disabled then local_lock_nested_bh() can
safely acquire a per-CPU spinlock on PREEMPT_RT here. This basically
mimics the local_bh_disable() behaviour in terms of exclusive data
structures on a smaller scope.

> >>> +		ovs_act->owner = current;
> >>> +	}
> >>> +
> >>>  	level = __this_cpu_inc_return(ovs_actions.exec_level);
> >>>  	if (unlikely(level > OVS_RECURSION_LIMIT)) {
> >>>  		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
> >>> @@ -1710,5 +1718,10 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >>>  
> >>>  out:
> >>>  	__this_cpu_dec(ovs_actions.exec_level);
> >>> +
> >>> +	if (level == 1) {
> >>> +		ovs_act->owner = NULL;
> >>> +		local_unlock_nested_bh(&ovs_actions.bh_lock);
> >>> +	}
> >>
> >> Seems dangerous to lock every time the owner changes but unlock only
> >> once on level 1.  Even if this works fine, it seems unnecessarily
> >> complicated.  Maybe it's better to just lock once before calling
> >> ovs_execute_actions() instead?
> > 
> > My understanding is this can be invoked recursively. That means on first
> > invocation owner == NULL and then you acquire the lock at which point
> > exec_level goes 0->1. On the recursive invocation owner == current and
> > you skip the lock but exec_level goes 1 -> 2.
> > On your return path once level becomes 1, then it means that dec made it
> > go 1 -> 0, you unlock the lock.
> 
> My point is: why locking here with some extra non-obvious logic of owner
> tracking if we can lock (unconditionally?) in ovs_packet_cmd_execute() and
> ovs_dp_process_packet() instead?  We already disable BH in one of those
> and take appropriate RCU locks in both.  So, feels like a better place
> for the extra locking if necessary.  We will also not need to move around
> any code in actions.c if the code there is guaranteed to be safe by holding
> locks outside of it.

I think I was considering it but dropped it because it looks like one
can call the other.
ovs_packet_cmd_execute() is an unique entry to ovs_execute_actions().
This could the lock unconditionally.
Then we have ovs_dp_process_packet() as the second entry point towards
ovs_execute_actions() and is the tricky one. One originates from
netdev_frame_hook() which the "normal" packet receiving.
Then within ovs_execute_actions() there is ovs_vport_send() which could
use internal_dev_recv() for forwarding. This one throws the packet into
the networking stack so it could come back via netdev_frame_hook().
Then there is this internal forwarding via internal_dev_xmit() which
also ends up in ovs_execute_actions(). Here I don't know if this can
originate from within the recursion.

After looking at this and seeing the internal_dev_recv() I decided to
move it to within ovs_execute_actions() where the recursion check itself
is.

> > The locking part happens only on PREEMPT_RT because !PREEMPT_RT has
> > softirqs disabled which guarantee that there will be no preemption.
> > 
> > tools/testing/selftests/net/openvswitch should cover this?
> 
> It's not a comprehensive test suite, it covers some cases, but it
> doesn't test anything related to preemptions specifically.

From looking at the traces, everything originates from
netdev_frame_hook() and there is sometimes one recursion from within
ovs_execute_actions(). I haven't seen anything else.

> >> Also, the name of the struct ovs_action doesn't make a lot of sense,
> >> I'd suggest to call it pcpu_storage or something like that instead.
> >> I.e. have a more generic name as the fields inside are not directly
> >> related to each other.
> > 
> > Understood. ovs_pcpu_storage maybe?
> 
> It's OK, I guess, but see also a point about locking inside datapath.c
> instead and probably not needing to change anything in actions.c.

If you say that adding a lock to ovs_dp_process_packet() and another to
ovs_packet_cmd_execute() then I can certainly update. However based on
what I wrote above, I am not sure.

> >> Best regards, Ilya Maximets.

Sebastian


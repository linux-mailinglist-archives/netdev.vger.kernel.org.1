Return-Path: <netdev+bounces-205962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E8B00F09
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1558516ED87
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADAF23B632;
	Thu, 10 Jul 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6fbpKKz"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274C1D432D
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187853; cv=none; b=SDM9ZjW1MNP+ht3w+DhQIpBjwABy544y/5TrfSNH6BngrpHqMfBZ7CtogOqKKTYjGpbtSQgEG4eblkUmg/NF4L5KdbhcUOBmbRJ6w2fbwzGtsJzRYdfff80iLVMtpjDxl3DUbQ9O2dtxSmuPFNzVZr456IcJqYsnWL/9TTcwVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187853; c=relaxed/simple;
	bh=+EolrvCVJsFGGB9pFMRheCmv0qBdUlfl2FkBbq662Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSH4YWiu4yE1lEiuPhupM67fPyobIC5kQE8nbeRunf77YKJcL8MX/dIumZU9DFjQa2EJieBytnRBB98xbH+OYQpd1UJEC5C/VllXSZtFxGtGztSDXRl+se00lBhoAfdHDG70Vc3XMdWLVVOO6tQUHqaI5YuvtjbqLXfoPC0jUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6fbpKKz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c84518eb-15da-4356-ac6a-b2fcb807d92f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752187844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDk3n0e7IoK91zimJgnk+Q43ItNaULOpQqxSFl9TmHE=;
	b=E6fbpKKz5TX6tsE+IXiP58sPW/EBymDyIjaWwOuxFLX8cq5HIH4bs5FsCVSJntzLmRKkVI
	o78aYFySVzOte86DEiYk5ls60zLdKeL+zOC5GFw0ZlwaCzgz76rtz94oOs7B2ndkXXPSJ4
	STjBmmTGW+8VyEXz0EJgwfA7rMwi65M=
Date: Thu, 10 Jul 2025 18:50:16 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] comparing the propesed implementation for standalone PCS
 drivers
To: Simon Horman <horms@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Lei Wei <quic_leiwei@quicinc.com>,
 Michal Simek <michal.simek@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, John Crispin <john@phrozen.org>,
 Felix Fietkau <nbd@nbd.name>, Robert Marko <robimarko@gmail.com>
References: <aEwfME3dYisQtdCj@pidgin.makrotopia.org>
 <24c4dfe9-ae3a-4126-b4ec-baac7754a669@linux.dev>
 <20250709135216.GA721198@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250709135216.GA721198@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/9/25 09:52, Simon Horman wrote:
> On Fri, Jun 13, 2025 at 12:06:23PM -0400, Sean Anderson wrote:
>> On 6/13/25 08:55, Daniel Golle wrote:
>> > Hi netdev folks,
>> > 
>> > there are currently 2 competing implementations for the groundworks to
>> > support standalone PCS drivers.
>> > 
>> > https://patchwork.kernel.org/project/netdevbpf/list/?series=970582&state=%2A&archive=both
>> > 
>> > https://patchwork.kernel.org/project/netdevbpf/list/?series=961784&state=%2A&archive=both
>> > 
>> > They both kinda stalled due to a lack of feedback in the past 2 months
>> > since they have been published.
>> > 
>> > Merging the 2 implementation is not a viable option due to rather large
>> > architecture differences:
>> > 
>> > 				| Sean			| Ansuel
>> > --------------------------------+-----------------------+-----------------------
>> > Architecture			| Standalone subsystem	| Built into phylink
>> > Need OPs wrapped		| Yes			| No
>> > resource lifecycle		| New subsystem		| phylink
>> > Supports hot remove		| Yes			| Yes
>> > Supports hot add		| Yes (*)		| Yes
>> > provides generic select_pcs	| No			| Yes
>> > support for #pcs-cell-cells	| No			| Yes
>> > allows migrating legacy drivers	| Yes			| Yes
>> > comes with tested migrations	| Yes			| No
>> > 
>> > (*) requires MAC driver to also unload and subsequent re-probe for link
>> > to work again
>> > 
>> > Obviously both architectures have pros and cons, here an incomplete and
>> > certainly biased list (please help completing it and discussing all
>> > details):
>> > 
>> > Standalone Subsystem (Sean)
>> > 
>> > pros
>> > ====
>> >  * phylink code (mostly) untouched
>> >  * doesn't burden systems which don't use dedicated PCS drivers
>> >  * series provides tested migrations for all Ethernet drivers currently
>> >    using dedicated PCS drivers
>> > 
>> > cons
>> > ====
>> >  * needs wrapper for each PCS OP
>> >  * more complex resource management (malloc/free) 
>> >  * hot add and PCS showing up late (eg. due to deferred probe) are
>> >    problematic
>> >  * phylink is anyway the only user of that new subsystem
>> 
>> I mean, if you want I can move the whole thing to live in phylink.c, but
>> that just enlarges the kernel if PCSs are not being used. The reverse
>> criticism can be made for Ansuel's series: most phylink users do not
>> have "dynamic" PCSs but the code is imtimately integrated with phylink
>> anyway.
> 
> At the risk of stating the obvious it seems to me that a key decision
> that needs to be made is weather a new subsystem is the correct direction.
>
> If I understand things correctly it seems that not creating a new subsystem
> is likely to lead to a simpler implementation, at least in the near term.

It's really more of an unusual PCS driver with some routines for
registering and looking up devices. I would like to note that Ansuel's
approach has those same registration and lookup functions.

> While doing so lends itself towards greater flexibility in terms of users,
> I'd suggest a cleaner abstraction layer, and possibly a smaller footprint
> (I assume space consumed by unused code) for cases where PCS is not used.

I think the greatest strength of my implementation is its clean
interface. The rest of phylink doesn't know or care whether the PCS is a
traditional one (tied to the lifetime of the netdev) or whether it is
dynamically looked up. 

> On the last point, I do wonder if there are other approaches to managing
> the footprint. And if so, that may tip the balance towards a new subsystem.
> 
> 
> Another way of framing this is: Say, hypothetically, Sean was to move his
> implementation into phylink.c. Then we might be able to have a clearer
> discussion of the merits of each implementation. Possibly driving towards
> common ground. But it seems hard to do so if we're unsure if there should
> be a new subsystem or not.

I really think it's just cosmetic. For example, in my implementation we have

/* pcs/core.c */
static void pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
			  struct phylink_link_state *state)
{
	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
	struct phylink_pcs *wrapped;

	guard(srcu)(&pcs_srcu);
	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
	if (wrapped)
		wrapped->ops->pcs_get_state(wrapped, neg_mode, state);
	else
		state->link = 0;
}

/* phylink.c */
static void phylink_mac_pcs_get_state(struct phylink *pl,
				      struct phylink_link_state *state)
{
	struct phylink_pcs *pcs;

	/* ... snip ... */

	pcs = pl->pcs;
	if (pcs)
		pcs->ops->pcs_get_state(pcs, pl->pcs_neg_mode, state);
	else
		state->link = 0;
}

and that would turn into

/* phylink.c */
static void phylink_mac_pcs_get_state(struct phylink *pl,
				      struct phylink_link_state *state)
{
	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
	struct phylink_pcs *pcs;

	/* ... snip ... */
	
	guard(srcu)(&pcs_srcu);
	if (pl->pcs->ops == &pcs_wrapper_ops)
		pcs = srcu_dereference(wrapper->wrapped, &pcs_srcu);
	else
		pcs = pl->pcs;

	if (pcs)
		pcs->ops->pcs_get_state(pcs, pl->pcs_neg_mode, state);
	else
		state->link = 0;
}

and TBH I like the former much better since we avoid special-casing the
wrapper stuff. We still have to do the wrapper stuff because the MAC
owns the PCS and we can't prevent it from passing phylink a stale PCS
pointer. Now, we could make phylink own the PCS, but that means going
with Ansuel's approach. And the main problem phylink owning the PCS is
that it complicates lookup for existing MACs that need to accomodate a
variety of nonstandard ways of looking up a PCS for backwards-
compatibility. The only real way to do it is something like

/* In mac_probe() or whatever */
scoped_guard(mutex)(&pcs_remove_lock) {
	/* Just imagine some terrible contortions for compatibility here */
	struct phylink_pcs *pcs = pcs_get(dev, "my_pcs");
	if (IS_ERR(pcs))
		return PTR_ERR(pcs);

	list_add(pcs->list, &config.pcs_list);
	ret = phylink_create(config, dev->fwnode, interface,
			     &mac_phylink_ops);
	if (ret)
		return ret;
}
/* At this point the PCS could have already been removed */

but even then the MAC has no idea how to mux the correct PCS. If you
have more than one dynamically-looked-up PCS they can't be
differentiated because they are both opaque pointers that may point to
stale memory at any time.

This is why I favor a wrapper approach because we can allocate some
memory that's tied to the lifetime of the MAC rather than the lifetime
of the PCS. Then we don't have to worry about whether the PCS is still
valid and we can get on with our lives.

--Sean

>> > phylink-managed standalone PCS drivers (Ansuel)
>> > 
>> > pros
>> > ====
>> >  * trivial resource management
>> 
>> Actually, I would say the resource management is much more complex and
>> difficult to follow due to being spread out over many different
>> functions.
>> 
>> >  * no wrappers needed
>> >  * full support for hot-add and deferred probe
>> >  * avoids code duplication by providing generic select_pcs
>> >    implementation
>> >  * supports devices which provide more than one PCS port per device
>> >    ('#pcs-cell-cells')
>> > 
>> > cons
>> > ====
>> >  * inclusion in phylink means more (dead) code on platforms not using
>> >    dedicated PCS
>> >  * series does not provide migrations for existing drivers
>> >    (but that can be done after)
>> >  * probably a bit harder to review as one needs to know phylink very well
>> > 
>> > 
>> > It would be great if more people can take a look and help deciding the
>> > general direction to go.
>> 
>> I also encourage netdev maintainers to have a look; Russell does not
>> seem to have the time to review either system.
>> 
>> > There are many drivers awaiting merge which require such
>> > infrastructure (most are fine with either of the two), some for more
>> > than a year by now.
>> 
>> This is the major thing. PCS drivers should have been supported from the
>> start of phylink, and the longer there is no solution the more legacy
>> code there is to migrate.
> 
> This seems to be something we can all agree on :)


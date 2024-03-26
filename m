Return-Path: <netdev+bounces-82103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9388C549
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9493B230BC
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89313C3C6;
	Tue, 26 Mar 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkPWnOJ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07304763E6
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463844; cv=none; b=syxHh09zyYjKA2JsUA2eq9z6DyRQENkmVUBB58hSYHhyi1yyhSefXrFgbzQ9UyWAGqDUeus7UKUpv8ppdIPQCl9di6uhY0z6P41Fep31SawyvF1fTI1vspDC3mEO0a3IwVESlR+Ye5eKJldlMpEdo8qmVFbNRuqoGn0BJ+OZITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463844; c=relaxed/simple;
	bh=SsgVfajcFPqkdrwo9VjPDOqStpAEVfBFNrQsxCwMnWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf1nFzteGuny0uqDDTc/WodjfYpCATDK+5UdmGGEBxrdh7dwZGLkiOnA8IoNwYU5x3Fof5mQewSfVvdWfX7+XGfnCy0cEoBPdn7OUnQ5a1u9tu+qY666jLXN1vw3Nw3HsLhMPS1jMpOYFO8Of6HmQE/gSRcZFWUrcZ2PGUtwIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkPWnOJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F7EC43390;
	Tue, 26 Mar 2024 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463843;
	bh=SsgVfajcFPqkdrwo9VjPDOqStpAEVfBFNrQsxCwMnWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pkPWnOJ6S0IyuDR25SsZL1MzLP9EdOdK1LpEmvnGMrTgR43Wk8VwrW3b0MXpTpV1a
	 SW12sZJkygS30U/GScqR3T5pKyKYmeEqEafTa1Bd+lrBjUE5gwqLwWa7tgc9q2cklz
	 rm0fEWWomXTxVO99sf49JeOZpxdhZ7TFJCOG0jzZfaCQPMpDpGEkdTDSOc9rfJl0Jz
	 9zgJKAN9Fk5xHPOCatw3+pL+4JX/zmN8n/gh/75KGCDCf3dWkU0rvJdDnsRFR3MQ4b
	 Wm0X3o7CMAOfBnzmpFutJ2MRJE0mJfHy5VSEA5MxCOaWHGU7prij9sHELBg6VvGaeO
	 AWzDnGLC1tHZQ==
Date: Tue, 26 Mar 2024 07:37:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] using guard/__free in networking
Message-ID: <20240326073722.637e8504@kernel.org>
In-Reply-To: <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
	<20240325190957.02d74258@kernel.org>
	<8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 09:42:43 +0100 Johannes Berg wrote:
> On Mon, 2024-03-25 at 19:09 -0700, Jakub Kicinski wrote:
> > On Mon, 25 Mar 2024 23:31:25 +0100 Johannes Berg wrote:  
> > > Hi,
> > > 
> > > So I started playing with this for wifi, and overall that
> > > does look pretty nice, but it's a bit weird if we can do
> > > 
> > >   guard(wiphy)(&rdev->wiphy);
> > > 
> > > or so, but still have to manually handle the RTNL in the
> > > same code.  
> > 
> > Dunno, it locks code instead of data accesses.  
> 
> Well, I'm not sure that's a fair complaint. After all, without any more
> compiler help, even rtnl_lock()/rtnl_unlock() _necessarily_ locks code.
> Clearly
> 
> 	rtnl_lock();
> 	// something
> 	rtnl_unlock();
> 
> also locks the "// something" code, after all., and yeah that might be
> doing data accesses, but it might also be a function call or a whole
> bunch of other things?
> 
> Or if you look at something like bpf_xdp_link_attach(), I don't think
> you can really say that it locks only data. That doesn't even do the
> allocation outside the lock (though I did convert that one to
> scoped_guard because of that.)
> 
> Or even something simple like unregister_netdev(), it just requires the
> RTNL for some data accesses and consistency deep inside
> unregister_netdevice(), not for any specific data accessed there.
> 
> So yeah, this is always going to be a trade-off, but all the locking is.
> We even make similar trade-offs manually, e.g. look at
> bpf_xdp_link_update(), it will do the bpf_prog_put() under the RTNL
> still, for no good reason other than simplifying the cleanup path there.

At least to me the mental model is different. 99% of the time the guard
is covering the entire body. So now we're moving from "I'm touching X
so I need to lock" to "This _function_ is safe to touch X".

> Anyway, I can live with it either way (unless you tell me you won't pull
> wireless code using guard), just thought doing the wireless locking with
> guard and the RTNL around it without it (only in a few places do we
> still use RTNL though) looked odd.
> 
> 
> > Forgive the comparison but it feels too much like Java to me :)  
> 
> Heh. Haven't used Java in 20 years or so...

I only did at uni, but I think they had a decorator for a method, where
you can basically say "this method should be under lock X" and runtime
will take that lock before entering and drop it after exit,
appropriately. I wonder why the sudden love for this concept :S
Is it also present in Rust or some such?

> > scoped_guard is fine, the guard() not so much.  
> 
> I think you can't get scoped_guard() without guard(), so does that mean
> you'd accept the first patch in the series?

How can we get one without the other.. do you reckon Joe P would let us
add a checkpatch check to warn people against pure guard() under net/ ?

> > Do you have a piece of code in wireless where the conversion
> > made you go "wow, this is so much cleaner"?  
> 
> Mostly long and complex error paths. Found a double-unlock bug (in
> iwlwifi) too, when converting some locking there.
> 
> Doing a more broader conversion on cfg80211/mac80211 removes around 200
> lines of unlocking, mostly error handling, code.
> 
> Doing __free() too will probably clean up even more.

Not super convinced by that one either:
https://lore.kernel.org/all/20240321185640.6f7f4d6b@kernel.org/
maybe I'm too conservative..


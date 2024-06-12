Return-Path: <netdev+bounces-102904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA2905630
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0881C23DFD
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BBE17FAA5;
	Wed, 12 Jun 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLU7p+h2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F717FADE;
	Wed, 12 Jun 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204514; cv=none; b=Qz1Wb7889FDDU/EHCx/v6mLztxkQowP9UwZfD9fVbC3qhqApCO498ua31PeiKejaifXkhCbS7dyXrQKCwUMuDHIVoec9CXP2NqJWJVqWwIJV4HYC0jhVsIpuYIvIOhq9bT4+Z5Rl3Es47I81YJRTy5zWrD9Z3nLElefm1nCmYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204514; c=relaxed/simple;
	bh=hcP2dRqBcbk2aluFXM7c3tT7cDtAwX+vdxiJ/oaPK6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9ZzamYebI/qppx2aFjcb3yOQKoLWgtFQWzZlZ0UquoOgRwNW2jFKOEz/b9FQhqX5XCJcIGcifyVihx4Nyc0hfAw8e0YNEVNbQGEgjX+9dgDIOYkrtMjWWJAuFVbod1/Q/J6adoSA9fuKzFJhdUgmp6/6nV2Tt7h2MfabJP00z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLU7p+h2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CEFC116B1;
	Wed, 12 Jun 2024 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718204513;
	bh=hcP2dRqBcbk2aluFXM7c3tT7cDtAwX+vdxiJ/oaPK6s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oLU7p+h2ImyCTQgWona+f9JJpHDUfaD9TF4pB4ggw0IzxK+jqxvRl6dkoGE/YTItr
	 Bnyweip+56vaNf4JZWP4c/8f/tBrbXMN6sHlOKZmtYCuNCMAJENs/rGQwb/xWIraLV
	 E+5JQPL1UekLt1RmPrkMniL1Q1xjXJMZCw91ndqWqIT5ena62y/CpVleo1mQTqIeSK
	 zwjzVrSg0/kZj9zhFzU7O/CmSsQ2zSB/mJC9J+0oqvnhCx8Z5EuRg4o5GuY34kC9f7
	 CLzsi85Ui4jMSU8Yra05krNIgP2DzCBo31dwhUEiqtFpKi7PMkRwBWr5MVMkHk8n+G
	 3prAFECVoGFUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 79BC3CE0DEA; Wed, 12 Jun 2024 08:01:53 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:01:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <0317ae55-4da3-415b-b03c-ae87d3603bab@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmmzE6Przj0pCHek@sellars>

On Wed, Jun 12, 2024 at 04:39:15PM +0200, Linus Lüssing wrote:
> On Wed, Jun 12, 2024 at 07:06:04AM -0700, Paul E. McKenney wrote:
> > Let me make sure that I understand...
> > 
> > You need rcu_barrier() to wait for any memory passed to kfree_rcu()
> > to actually be freed?  If so, please explain why you need this, as
> > in what bad thing happens if the actual kfree() happens later.
> > 
> > (I could imagine something involving OOM avoidance, but I need to
> > hear your code's needs rather than my imaginations.)
> > 
> > 							Thanx, Paul
> 
> We have allocated a kmem-cache for some objects, which are like
> batman-adv's version of a bridge's FDB entry.
> 
> The very last thing we do before unloading the module is
> free'ing/destroying this kmem-cache with a call to
> kmem_cache_destroy().
> 
> As far as I understand before calling kmem_cache_destroy()
> we need to ensure that all previously allocated objects on this
> kmem-cache were free'd. At least we get this kernel splat
> (from Slub?) otherwise. I'm not quite sure if any other bad things
> other than this noise in dmesg would occur though. Other than a
> stale, zero objects entry remaining in /proc/slabinfo maybe. Which
> gets duplicated everytime we repeat loading+unloading the module.
> At least these entries would be a memory leak I suppose?
> 
> ```
> # after insmod/rmmod'ing batman-adv 6 times:
> $ cat /proc/slabinfo  | grep batadv_tl_cache
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> ```
> 
> That's why we added this rcu_barrier() call on module
> shutdown in the batman-adv module __exit function right before the
> kmem_cache_destroy() calls. Hoping that this would wait for all
> call_rcu() / kfree_rcu() callbacks and their final kfree() to finish.
> This worked when we were using call_rcu() with our own callback
> with a kfree(). However for kfree_rcu() this somehow does not seem
> to be the case anymore (- or more likely I'm missing something else,
> some other bug within the batman-adv code?).

It is quite possible that some of the recent energy-saving changes
have caused rcu_barrier() to not wait for all kfree_rcu() memory
to be freed.  Which is timely, given a bunch of recently proposed
changes that seemed like a good idea to me at the time.  ;-)

							Thanx, Paul


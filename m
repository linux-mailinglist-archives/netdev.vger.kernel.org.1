Return-Path: <netdev+bounces-102934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A81905831
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 18:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B439B26D86
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196BB181313;
	Wed, 12 Jun 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji18+OB0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACD18130D;
	Wed, 12 Jun 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208387; cv=none; b=B7uhb8YJXsj2tjfrdYtBfRnz8wvQ5HF+VMuVpgqxYNom5ynbU94P5VKAh0RcxNG5+wA9xhJqbQRqxBsFNTFCz/3AxwrzfBZACMsHYRHnGHtSZdrcj6PKFkDPixJtJ4OzNiPLY3/zLvQ2Xn/avfzIxggTwpD2VU/IjqBpBEsak1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208387; c=relaxed/simple;
	bh=KfoVhQGh1ffGN+Vv/trt9qEbjqFsRTAgAAT6pA2n4y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZwC4k0IJ+1pJb09m2Zhvl1MO0sWfvTQdjUU+IvUJwwhCD9/eDTuDQ0lL5mYr9SLkkNHOOsALnVYFPICipKnlL0LPtXqk3B98RZBcUrum7qxv3RJytEgP+f1THczJ74h6ueb/OExxw01U8gOGnwG4BWtGpkGrFfYkRy73q5e3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji18+OB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658AAC32786;
	Wed, 12 Jun 2024 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718208386;
	bh=KfoVhQGh1ffGN+Vv/trt9qEbjqFsRTAgAAT6pA2n4y8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ji18+OB0ffeaYYoh2I/BYqePx0vozflXX5LIjRAzhqTtR0WDQyoQBTeQPkQSbIIsi
	 IWrMtYhs8EMKIJHLxyb4pB8O4MOYJukaZZtLizdNvzEFaM4M47VMSiV4eZaGRFNPkL
	 fFZuYzvxgF5Ah0OeZyTMue88PLY1QUyiZM3aNn60YjOp9YllKbTMBjmjlaaGLXJ87N
	 SA/P15Dz1Ofy9c494GHGSXsSoqHe+8nMu8sl5DZve0wDKNngbjO3ZjhgE1PyM/WJUc
	 gTa6k30o/w+z4CI59g9ixPbvXR/0miPVhP7TsfqAho4NfDJyC7ULNptufK8GruQqXz
	 xJt+qsOLEELAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 027C1CE0DEA; Wed, 12 Jun 2024 09:06:25 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:06:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <020489fa-26a3-422c-8924-7dc71f23422c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
 <Zmm2uTHTge-i3eCM@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmm2uTHTge-i3eCM@sellars>

On Wed, Jun 12, 2024 at 04:54:49PM +0200, Linus Lüssing wrote:
> On Wed, Jun 12, 2024 at 04:39:15PM +0200, Linus Lüssing wrote:
> > On Wed, Jun 12, 2024 at 07:06:04AM -0700, Paul E. McKenney wrote:
> > > Let me make sure that I understand...
> > > 
> > > You need rcu_barrier() to wait for any memory passed to kfree_rcu()
> > > to actually be freed?  If so, please explain why you need this, as
> > > in what bad thing happens if the actual kfree() happens later.
> > > 
> > > (I could imagine something involving OOM avoidance, but I need to
> > > hear your code's needs rather than my imaginations.)
> > > 
> > > 							Thanx, Paul
> > [...]
> > As far as I understand before calling kmem_cache_destroy()
> > we need to ensure that all previously allocated objects on this
> > kmem-cache were free'd. At least we get this kernel splat
> > (from Slub?) otherwise. I'm not quite sure if any other bad things
> > other than this noise in dmesg would occur though. Other than a
> > [...]
> 
> I guess, without knowing the details of RCU and Slub, that at
> least nothing super serious, like a segfault, can happen when
> the remaining execution is just a kfree(), which won't need
> access to batman-adv internal functions anymore.

We are looking into nice ways of solving this, but in the meantime,
yes, if you are RCU-freeing slab objects into a slab that is destroyed
at module-unload time, you currently need to stick with call_rcu()
and rcu_barrier().

We do have some potential solutions to allow use of kfree_rcu() with
this sort of slab, but they are still strictly potential.

Apologies for my having failed to foresee this particular trap!

							Thanx, Paul


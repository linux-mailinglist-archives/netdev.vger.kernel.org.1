Return-Path: <netdev+bounces-205986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2870B0104E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21A11C81284
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD03C2E0;
	Fri, 11 Jul 2025 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULp9xaTH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12594BA33;
	Fri, 11 Jul 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194481; cv=none; b=uJuaSiIFeCUS3u6f+LXxiC9yTfp8zS8BmnYiCDyEeIY+v4eb8rfqalVLSBu5l6UDO4K2nj4ZXozzMqyu5Z5K6WgXqHmi6zUIB6UVFOAKXSriVvlw4iP8O2jTZCRi/VuKWaZYPSceTzhz7OZcaQxGeVdcjPGZ9m6A148qCK+ILSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194481; c=relaxed/simple;
	bh=6uR79P5UopYlT+qKqzc27sCkFJjGkxMGLw7pvdPyyuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkaJXbczgW4zBMhBA63n8TDi0Kvs9nM/aA8FT+0gQ3wqfMDVHXWWOSSPWNYCqjYGeAz+8QXrq+gDy1NwiUuvPchMCmel64DGnIgQaSjM+SUe0FPF5bfyS4Bw2bgM4FevWBIxKrWhvntbRcFaSU9US0EeVFQ0Ks4SdND/h4bL9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULp9xaTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A622FC4CEE3;
	Fri, 11 Jul 2025 00:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752194480;
	bh=6uR79P5UopYlT+qKqzc27sCkFJjGkxMGLw7pvdPyyuk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ULp9xaTHWF4K70Kjz2WL419ye2KDqrDpOp91vt1VmyPXpyVDaBjWG0rmqUZUVDREk
	 IEUZ3iuR9geW4NkRfWNyNkOoYdJRUjLbHAweRCCFSz9OuP4ZlI1TQr0tEq9YR5V5Yd
	 AWgjv6f6pGFb4lUAXroOlkpZ9a5lJVB7HmLyuC1jsbg7yohrP3pzJmAElwtfqGrXAp
	 k580fk9iSMCNv3zKMowBzhm6lMIkYMfBGYQ2iX84ZEvVtHuUvDT2PIvB0jhx2Ks2s8
	 aJPYyb3JuvcrnF6kQyhjQ+QEydm2pVM4upKojLrtjpGMCBRMerIC2lSwEMG0GE67oi
	 0NdLJkAUFGlUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 353A1CE0A44; Thu, 10 Jul 2025 17:41:20 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:41:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] shazptr: Add refscale test
Message-ID: <f4c67729-3944-4dc4-9cd3-6e07755ddfc7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-3-boqun.feng@gmail.com>

On Sun, Apr 13, 2025 at 11:00:49PM -0700, Boqun Feng wrote:
> Add the refscale test for shazptr to measure the reader side
> performance.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

One nit below, but with or without that changed:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/refscale.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index f11a7c2af778..154520e4ee4c 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -29,6 +29,7 @@
>  #include <linux/reboot.h>
>  #include <linux/sched.h>
>  #include <linux/seq_buf.h>
> +#include <linux/shazptr.h>
>  #include <linux/spinlock.h>
>  #include <linux/smp.h>
>  #include <linux/stat.h>
> @@ -890,6 +891,43 @@ static const struct ref_scale_ops typesafe_seqlock_ops = {
>  	.name		= "typesafe_seqlock"
>  };
>  
> +static void ref_shazptr_read_section(const int nloops)
> +{
> +	int i;
> +
> +	for (i = nloops; i >= 0; i--) {
> +		preempt_disable();
> +		{ guard(shazptr)(ref_shazptr_read_section); }
> +		preempt_enable();
> +	}
> +}
> +
> +static void ref_shazptr_delay_section(const int nloops, const int udl, const int ndl)
> +{
> +	int i;
> +
> +	for (i = nloops; i >= 0; i--) {
> +		preempt_disable();
> +		{
> +			guard(shazptr)(ref_shazptr_delay_section);
> +			un_delay(udl, ndl);
> +		}
> +		preempt_enable();
> +	}
> +}
> +
> +static bool ref_shazptr_init(void)
> +{
> +	return true;
> +}
> +
> +static const struct ref_scale_ops shazptr_ops = {
> +	.init		= ref_shazptr_init,

You could make this NULL and drop the ref_shazptr_init() function.
As in drop the above .init= initialization along with that function.

Of course, the same is true of the existing rcu_sync_scale_init()
function, so I cannot fault you here.  ;-)

> +	.readsection	= ref_shazptr_read_section,
> +	.delaysection	= ref_shazptr_delay_section,
> +	.name		= "shazptr"
> +};
> +
>  static void rcu_scale_one_reader(void)
>  {
>  	if (readdelay <= 0)
> @@ -1197,6 +1235,7 @@ ref_scale_init(void)
>  		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
>  		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
>  		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
> +		&shazptr_ops,
>  	};
>  
>  	if (!torture_init_begin(scale_type, verbose))
> -- 
> 2.47.1
> 


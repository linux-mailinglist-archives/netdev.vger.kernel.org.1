Return-Path: <netdev+bounces-155598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702B9A03238
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE5F3A101E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E341DE4EB;
	Mon,  6 Jan 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9gYwC93"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D91D5CF8;
	Mon,  6 Jan 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736199663; cv=none; b=a7hyk4mz8ehx230UWSVJccS/1w4o28SIA+F8rlZLGhxSwCwIdm6AN+MScLF42qXPpFNGDKQWngIucu9rFVFsFwjZjGagOYFAicMJkpaOko5hcq0ueIgCVbzrDhoeeNQ1O5S2xyT0acSDINm9fN8s59+viZeQYh76PMku8pZoEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736199663; c=relaxed/simple;
	bh=whkyItMfgglssGje1r+plJGpoFrwosjREQUWHGtHGdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PB7rTeJUUS6dsZrzAyKttiIsR2mCuzebx+j2so8dxwIn0U6CWha3qniJS3U2C5/ZgCJqUryY5jF8/yfmllndjRnSV0113peBjiNb+soW+mQPNK1exFhMMwpCih7zr2cn74b3ScnPlHZK2wGx6yBRIBqYV2fx5uEJhUBAS1ieIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9gYwC93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE4EC4CED2;
	Mon,  6 Jan 2025 21:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736199662;
	bh=whkyItMfgglssGje1r+plJGpoFrwosjREQUWHGtHGdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y9gYwC93ngLFDoWBuMJ0dP9dg+rRgn7vh78osigZS1GZ8sAqrmO5M+4DG/l3OELnu
	 eyWMoDcz+XzCqroyQFgyPybWMUW/wplHTEJ4VQaRb5YTxHa7B4Ib9G6VJzOXuz/uYt
	 o2BXDedTho84pt4siWSXYYx881KuHvwbDjLyGAS/qHk7IfRA080EtaOMXvEngyMlr7
	 UoQLuirVxPhwwBlPeEm+48iN1bmGj+ns0hPFX7Ur9ewZBnuARuOmTEWrxxCk+BYT7Q
	 qNz10jzNXkwWcvOvHiapNonitLllAmnMapFyvnNDWAbjDcHfhlFpet7p32L4I4VCV5
	 Iq1Ett3YKzSZA==
Date: Mon, 6 Jan 2025 13:41:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: John Ousterhout <ouster@cs.stanford.edu>, kernel test robot
 <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v4 12/12] net: homa: create Makefile and
 Kconfig
Message-ID: <20250106134101.2efd5957@kernel.org>
In-Reply-To: <de0a7ef1-c2d0-4db4-8267-9d5ac96f0e23@lunn.ch>
References: <20241217000626.2958-13-ouster@cs.stanford.edu>
	<202412251044.574ee2c0-lkp@intel.com>
	<CAGXJAmzUZLKZj_7M63r2NXHV41_zf7aUH-b9LtAQOMgcheVUrQ@mail.gmail.com>
	<de0a7ef1-c2d0-4db4-8267-9d5ac96f0e23@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 20:08:59 +0100 Andrew Lunn wrote:
> > > [   11.585197][  T133] -> #0 ((console_sem).lock){-...}-{2:2}:
> > > [ 11.585197][ T133] check_prev_add (kernel/locking/lockdep.c:3162)
> > > [ 11.585197][ T133] validate_chain (kernel/locking/lockdep.c:3281 kernel/locking/lockdep.c:3904)
> > > [ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
> > > [ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> > > [ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> > > [ 11.585197][ T133] down_trylock (kernel/locking/semaphore.c:140)
> > > [ 11.585197][ T133] __down_trylock_console_sem (kernel/printk/printk.c:326)
> > > [ 11.585197][ T133] console_trylock_spinning (kernel/printk/printk.c:2852 kernel/printk/printk.c:2009)
> > > [ 11.585197][ T133] vprintk_emit (kernel/printk/printk.c:2431 kernel/printk/printk.c:2378)
> > > [ 11.585197][ T133] vprintk (kernel/printk/printk_safe.c:86)
> > > [ 11.585197][ T133] _printk (kernel/printk/printk.c:2452)
> > > [ 11.585197][ T133] lookup_object_or_alloc+0x3d4/0x590
> > > [ 11.585197][ T133] __debug_object_init (lib/debugobjects.c:744)
> > > [ 11.585197][ T133] hrtimer_init (kernel/time/hrtimer.c:456 kernel/time/hrtimer.c:1606)
> > > [ 11.585197][ T133] homa_timer_main (net/homa/homa_plumbing.c:971)
> > > [ 11.585197][ T133] kthread (kernel/kthread.c:389)
> > > [ 11.585197][ T133] ret_from_fork (arch/x86/kernel/process.c:153)
> > > [ 11.585197][ T133] ret_from_fork_asm (arch/x86/entry/entry_64.S:254)  
> 
> Do you see something in the console log at this point?
> 
> I find it odd that hrtimer_init() results in a console message. Maybe
> the console message itself is a clue, there is something wrong with
> the timer setup. If you can avoid the console message, you might then
> avoid the later lock inversion.

Just eyeballing the code I suspect object debug is upset that
we're initializing an on-stack object. John, you should probably
switch to hrtimer_setup_on_stack() ?


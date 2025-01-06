Return-Path: <netdev+bounces-155578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD3A0302C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D0F188095D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D0B1DF963;
	Mon,  6 Jan 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f7hT5vMW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341641DED57;
	Mon,  6 Jan 2025 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190545; cv=none; b=oVZzpgbTvpB89aMvPYHUdJxRzzFfbRkJBZ+BNvRGetCWlgIKcXCJjN93iC6YdvB2cY/5qVvHOIbbKf/zssGtAwQrQtT1AwT4MHfTT/uLnPfXMw75Xsano8iIZ81G/xVSGrybUOJGS6s57uRmcd1dhw13gd90vydxSZHLjVFCs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190545; c=relaxed/simple;
	bh=nMGfaadlVsGjqu8K+hfU6mQYuUffsCjF2gbZLUjfeDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBnhkWSp7iXrGIavUwc3Vrvuz8oWo/VvXx/6ojG00fBLLZftsS/6PwCGur9Ky+PQexipLIHZvTSqB/dob8tMlAmduQTmAowaWYdEWmOKyxMtEsa1/bzGqkeW2d9TKHuu7ty+HU0oDb8ofkkGK86M3+5PzX7erUxIW1ZLSAlRujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f7hT5vMW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e/R1UdYvxk0YJsmL66xbwctMTho6iYBFo4WoXyUZiCg=; b=f7hT5vMW4IrBQ43+hH+z/RfjyQ
	6amAAN3TLhs7KpMWz87WdUKm0OpwjvYy07NNKrceGw+bW9a8T9N086GT3I6OEpen123+b1kBXcDRj
	px9/hQdZ9VDs8i0PRBmzTzvN9FpnWkvCbFQG48u6v3oesmLn3SzvVJnPECPwM+g5qQ+U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUsTD-001y2y-88; Mon, 06 Jan 2025 20:08:59 +0100
Date: Mon, 6 Jan 2025 20:08:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v4 12/12] net: homa: create Makefile and Kconfig
Message-ID: <de0a7ef1-c2d0-4db4-8267-9d5ac96f0e23@lunn.ch>
References: <20241217000626.2958-13-ouster@cs.stanford.edu>
 <202412251044.574ee2c0-lkp@intel.com>
 <CAGXJAmzUZLKZj_7M63r2NXHV41_zf7aUH-b9LtAQOMgcheVUrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmzUZLKZj_7M63r2NXHV41_zf7aUH-b9LtAQOMgcheVUrQ@mail.gmail.com>

On Mon, Jan 06, 2025 at 09:27:24AM -0800, John Ousterhout wrote:
> I have pored over this message for a while and can't figure out how
> Homa code could participate in this deadlock, other than by calling
> hrtimer_init (which is done without holding any locks). If anyone else
> can figure out exactly what this message means and how it relates to
> Homa, I'd love to hear it. Otherwise I'm going to assume it's either a
> false positive or a problem elsewhere in the Linux kernel.

The problem with ignoring these splats is that after the first splat,
you don't get any more. So if Homa does have a real deadlock, you
might never get it reported, you just deadlock.

Have you reproduced this?

> > [   11.585197][  T133] -> #0 ((console_sem).lock){-...}-{2:2}:
> > [ 11.585197][ T133] check_prev_add (kernel/locking/lockdep.c:3162)
> > [ 11.585197][ T133] validate_chain (kernel/locking/lockdep.c:3281 kernel/locking/lockdep.c:3904)
> > [ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
> > [ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> > [ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> > [ 11.585197][ T133] down_trylock (kernel/locking/semaphore.c:140)
> > [ 11.585197][ T133] __down_trylock_console_sem (kernel/printk/printk.c:326)
> > [ 11.585197][ T133] console_trylock_spinning (kernel/printk/printk.c:2852 kernel/printk/printk.c:2009)
> > [ 11.585197][ T133] vprintk_emit (kernel/printk/printk.c:2431 kernel/printk/printk.c:2378)
> > [ 11.585197][ T133] vprintk (kernel/printk/printk_safe.c:86)
> > [ 11.585197][ T133] _printk (kernel/printk/printk.c:2452)
> > [ 11.585197][ T133] lookup_object_or_alloc+0x3d4/0x590
> > [ 11.585197][ T133] __debug_object_init (lib/debugobjects.c:744)
> > [ 11.585197][ T133] hrtimer_init (kernel/time/hrtimer.c:456 kernel/time/hrtimer.c:1606)
> > [ 11.585197][ T133] homa_timer_main (net/homa/homa_plumbing.c:971)
> > [ 11.585197][ T133] kthread (kernel/kthread.c:389)
> > [ 11.585197][ T133] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 11.585197][ T133] ret_from_fork_asm (arch/x86/entry/entry_64.S:254)

Do you see something in the console log at this point?

I find it odd that hrtimer_init() results in a console message. Maybe
the console message itself is a clue, there is something wrong with
the timer setup. If you can avoid the console message, you might then
avoid the later lock inversion.

      Andrew


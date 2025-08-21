Return-Path: <netdev+bounces-215733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC97B30115
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC7D620FD7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31333A01B;
	Thu, 21 Aug 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF0ltisw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC6321F53;
	Thu, 21 Aug 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797242; cv=none; b=bop0j7/g/O4zq0+BPWoEJjgGAvQLgljysbzZddJbKKLrLAUIM+50vlRhdP5fAaAvN6ajVoh4gT0b/5COKy0K8XMm/Syy1MAAzrG/aq/o6hW56kFoe2UbLlHmQ41d5GSoOT8CZBuy1XxnwnYN4mABUMjEc98/5kj37K7B8Ydj9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797242; c=relaxed/simple;
	bh=cLCla9s2LojKSPoNV8EDyc+1W5sSoN3oOPeQCGlXy1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fq/UOOCZOW1PrGjqnXv2cLvW/CzHu6S1qDetbXsh4PMSxLSIJ89xrASyF6FJ7zxwKiZXW1vvyiEetYx6h8H5UdRBdonSY5X3wJ4PSveVO8YojitCHGRF0PifGAt1WMGVtPe1xNItYFzHNhVTFuxFA0w2W/G/bBZG9uZzwQ8ASx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF0ltisw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B94DC4CEEB;
	Thu, 21 Aug 2025 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797242;
	bh=cLCla9s2LojKSPoNV8EDyc+1W5sSoN3oOPeQCGlXy1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LF0ltiswl3B4fUjQ5Ushzz0wN61Br6JJsS9GrFDzgweZRV9rlcTvqELkAwsP4qXsj
	 IOkNuti9j5rV0UiXfuMXIdD21v81fbMpYXjdK4WVUZRgXJlB83xcdcwUz5/EjURnN6
	 RPl+Bx+nwduKJxIYgkgtEK0wcD9cfZjJWYQeuAp0+akEIW8wb+8TiXKVtxBHC+dfDI
	 ffsV8Yr7fmABabVs181XKC0XNf6JMgC7PAVOHqD7Erl06FzXiUT+rF8lQffi7DNapO
	 sVG/6kTppAaM9+3QH0BdsLWLjo64sU64S5iq23OOvMQqkNTlZ1bXcOJb8whjlGCXr/
	 M0r3Pvp13rw7w==
Date: Thu, 21 Aug 2025 10:27:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.17-rc3
Message-ID: <20250821102721.6deae493@kernel.org>
In-Reply-To: <20250821171641.2435897-1-kuba@kernel.org>
References: <20250821171641.2435897-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 10:16:41 -0700 Jakub Kicinski wrote:
> Hi Linus!

FWIW I'm hitting the splat below from random code paths (futex, epoll,
bpf) when running your tree within Meta. Takes some time to hit, IDK
what exactly triggers it. Could be a driver tho I can hit it on two
different generations of servers.

[ 2121.610162] BUG: sleeping function called from invalid context at mm/vmalloc.c:3409
[ 2121.625698] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3382, name: x
[ 2121.642639] preempt_count: 1, expected: 0
[ 2121.651190] RCU nest depth: 0, expected: 0
[ 2121.660177] INFO: lockdep is turned off.
[ 2121.668619] Preemption disabled at:
[ 2121.668625] [<ffffffff84565d0f>] schedule+0x15f/0x360
[ 2121.686927] CPU: 9 UID: 34126 PID: 3382 Comm: x Kdump: loaded Tainted: G S               N  6.17.0-rc2-00079-g1c656b1efde6 #136 PREEMPT(none) 
[ 2121.686938] Tainted: [S]=CPU_OUT_OF_SPEC, [N]=TEST
[ 2121.686944] Call Trace:
[ 2121.686947]  <TASK>
[ 2121.686950]  dump_stack_lvl+0xe3/0x160
[ 2121.686962]  ? show_regs_print_info+0x10/0x10
[ 2121.686969]  ? thaw_kernel_threads+0x1c0/0x1c0
[ 2121.686985]  ? schedule+0x15f/0x360
[ 2121.686992]  __might_resched+0x474/0x5f0
[ 2121.687001]  ? schedule+0x15f/0x360
[ 2121.687006]  ? __might_sleep+0xe0/0xe0
[ 2121.687012]  ? rcu_force_quiescent_state+0x250/0x250
[ 2121.687020]  ? _raw_spin_unlock_irqrestore+0xa5/0x100
[ 2121.687026]  ? _raw_spin_unlock+0x40/0x40
[ 2121.687041]  vfree+0x41/0x2f0
[ 2121.687052]  __mmdrop+0x25f/0x490
[ 2121.687062]  finish_task_switch+0x31c/0x7a0
[ 2121.687076]  __schedule+0x158a/0x26b0
[ 2121.687098]  ? is_mmconf_reserved+0x390/0x390
[ 2121.687109]  ? schedule+0x92/0x360
[ 2121.687112]  ? rcu_is_watching+0x1b/0x90
[ 2121.687122]  ? rcu_is_watching+0x1b/0x90
[ 2121.687131]  ? _raw_spin_unlock+0x40/0x40
[ 2121.687141]  schedule+0x166/0x360
[ 2121.687148]  schedule_hrtimeout_range_clock+0x110/0x290
[ 2121.687154]  ? ktime_get+0x2b/0x120
[ 2121.687162]  ? schedule_timeout_idle+0xb0/0xb0
[ 2121.687170]  ? hrtimer_dummy_timeout+0x10/0x10
[ 2121.687184]  ? ktime_get+0x64/0x120
[ 2121.687190]  ? do_epoll_wait+0x75e/0xcc0
[ 2121.687197]  do_epoll_wait+0xabe/0xcc0
[ 2121.687205]  ? do_epoll_wait+0x75e/0xcc0
[ 2121.687227]  ? ep_destroy_wakeup_source+0xd0/0xd0
[ 2121.687234]  ? do_epoll_wait+0xcc0/0xcc0
[ 2121.687246]  ? nsecs_to_jiffies+0x20/0x20
[ 2121.687251]  ? kmem_cache_free+0x18c/0x410
[ 2121.687259]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2121.687268]  __x64_sys_epoll_wait+0x179/0x1c0
[ 2121.687276]  ? ep_try_send_events+0xb50/0xb50
[ 2121.687284]  ? rcu_is_watching+0x1b/0x90
[ 2121.687294]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2121.687300]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2121.687305]  do_syscall_64+0x86/0x2d0
[ 2121.687309]  ? trace_irq_enable+0x60/0x180
[ 2121.687319]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2121.687324] RIP: 0033:0x7f46cc32c482
[ 2121.687343] Code: 89 55 f8 48 89 75 f0 89 7d fc 89 4d ec e8 c6 a7 f6 ff 41 89 c0 44 8b 55 ec 8b 55 f8 48 8b 75 f0 8b 7d fc b8 e8 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 44 89 c7 89 45 fc e8 fb a7 f6 ff 8b 45 fc
[ 2121.687347] RSP: 002b:00007f46507cc2a0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e8
[ 2121.687355] RAX: ffffffffffffffda RBX: 00007f467a5bb800 RCX: 00007f46cc32c482
[ 2121.687359] RDX: 0000000000000020 RSI: 00007f467a5bb800 RDI: 000000000000017f
[ 2121.687363] RBP: 00007f46507cc2c0 R08: 0000000000000000 R09: 7fffffffffffffff
[ 2121.687366] R10: 0000000000001b47 R11: 0000000000000293 R12: 0000000000000000
[ 2121.687369] R13: 00007f4668c30000 R14: 00007f4668c30000 R15: 00000000021d3a00


Return-Path: <netdev+bounces-187302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B45CAA649A
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199DA9812D3
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B77227EBB;
	Thu,  1 May 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbb7GODa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1121884B;
	Thu,  1 May 2025 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130375; cv=none; b=bdPZexxE7CBN35r4MkyscrCeQ39d1eF6PoRggNYu+INqW/vhFsooe/4xBmBek+UyXd5jx7CR6rOgQuohf3vNsVTvzis7LyAFMmySDW3hF0g/FRyzjNTJmP8uDilI4GhFqTW3InUqmEMaS5CMn2nGa0+kfHgXuG4y6S4457d4RAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130375; c=relaxed/simple;
	bh=oi9lOW4HgqvO87HHAMfguJvLFFw/cNj3auUdf5ONCKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZy4aeCxPXEZ1tNuGSJ8MzkEfDFsNUV/xi4/85JOLdx0I8lPptk+B+ZqfHzSn3VY8c1oWJCXjzaQdoBvXyHYu9ndwSHqXNdfcJ2kcQOA/hd/9RxYWCQFoMCuV14zOTH5LUtQ4V8Cm8P2hjz5tszkgSVxDKUHBk4DyJo2fjUnN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbb7GODa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95797C4CEE3;
	Thu,  1 May 2025 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746130374;
	bh=oi9lOW4HgqvO87HHAMfguJvLFFw/cNj3auUdf5ONCKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbb7GODaWrlrrTJJilq3NdYjubR2kM5nCHxunKkrf6zW7i+P4knNTyj6vf2oaxqot
	 XwXMiJRdk4OcUxO8GVHe6M8RFIFLF3tKUhBucjtPenHhLD4CJ/gTiQYNY66ebpE0Cc
	 Pe5uUuC4Ff9J1Bmhl46frG8Ar6C1IngYf+n22RJWle1taaCw7TJkAC6KZpJ0osdwLC
	 9vqlmmZxTrimhyHMBEc2MwpU1kzgmqTs7+02WAhx6OxcG48MDnmItOjds/krD2+/Ix
	 KX/eCDhPrliH0oIDVeJqxOUqeX2TqwwrERNozAuYXRx/BDacmnRp80/to9BQhGozcp
	 QDiPY837QPNpA==
Date: Thu, 1 May 2025 13:12:51 -0700
From: Kees Cook <kees@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: syzbot <syzbot+8f8024317adff163ec5a@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, elver@google.com,
	horms@kernel.org, justinstitt@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in
 ip6_rt_copy_init
Message-ID: <202505011302.9C8E5E4@keescook>
References: <68135796.050a0220.14dd7d.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68135796.050a0220.14dd7d.0008.GAE@google.com>

On Thu, May 01, 2025 at 04:14:30AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cc17b4b9c332 Merge branch 'io_uring-zcrx-fix-selftests-and..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10ab50d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e367ce4a19f69ba
> dashboard link: https://syzkaller.appspot.com/bug?extid=8f8024317adff163ec5a
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e2a270580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145a9d74580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0e09cf367bdd/disk-cc17b4b9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4ab63344d74c/vmlinux-cc17b4b9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/14915e0e32b3/bzImage-cc17b4b9.xz
> 
> The issue was bisected to:
> 
> commit 557f8c582a9ba8abe6aa0fd734b6f342af106b26
> Author: Kees Cook <keescook@chromium.org>
> Date:   Thu Jan 18 23:06:05 2024 +0000
> 
>     ubsan: Reintroduce signed overflow sanitizer

Why _this_ patch exposes this, I'm not exactly sure, but ...

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1685d270580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1585d270580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1185d270580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8f8024317adff163ec5a@syzkaller.appspotmail.com
> Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
> 
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in net/ipv6/route.c:1095:9
> index 255 is out of range for type 'const int[12]'

... it looks like a real problem. fib6_type is 255, but the array is
small, causing an out-of-bounds read past the end of the array further
into .rodata:

static int ip6_rt_type_to_error(u8 fib6_type)
{
        return fib6_prop[fib6_type];
}

Perhaps some kind of type confusion, as this is being generated through
ip6_rt_init_dst_reject(). Is the fib6_type not "valid" on a reject?

The reproducer appears to be just absolutely spamming netlink with
requests -- it's not at all obvious to me where the fib6_type is even
coming from. I think this is already only reachable on the error path
(i.e. it's during a "reject", it looks like), so the rt->dst.error is
just being set weird.

This feels like it's papering over the actual problem:

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 96f1621e2381..fba51a42e7ac 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1092,6 +1092,8 @@ static const int fib6_prop[RTN_MAX + 1] = {
 
 static int ip6_rt_type_to_error(u8 fib6_type)
 {
+	if (fib6_type > RTN_MAX)
+		return -EINVAL;
 	return fib6_prop[fib6_type];
 }
 

-Kees

> CPU: 1 UID: 0 PID: 5835 Comm: kworker/1:3 Not tainted 6.15.0-rc3-syzkaller-00584-gcc17b4b9c332 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
> Workqueue: mld mld_ifc_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:231
>  __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:453
>  ip6_rt_type_to_error net/ipv6/route.c:1095 [inline]
>  ip6_rt_init_dst_reject net/ipv6/route.c:1112 [inline]
>  ip6_rt_init_dst net/ipv6/route.c:1137 [inline]
>  ip6_rt_copy_init+0x8e7/0x970 net/ipv6/route.c:1175
>  ip6_rt_pcpu_alloc net/ipv6/route.c:1424 [inline]
>  rt6_make_pcpu_route net/ipv6/route.c:1467 [inline]
>  ip6_pol_route+0xbac/0x1180 net/ipv6/route.c:2302
>  pol_lookup_func include/net/ip6_fib.h:617 [inline]
>  fib6_rule_lookup+0x348/0x6f0 net/ipv6/fib6_rules.c:125
>  ip6_route_output_flags_noref net/ipv6/route.c:2674 [inline]
>  ip6_route_output_flags+0x364/0x5d0 net/ipv6/route.c:2686
>  ip6_route_output include/net/ip6_route.h:93 [inline]
>  ip6_dst_lookup_tail+0x1ae/0x1510 net/ipv6/ip6_output.c:1128
>  ip6_dst_lookup_flow+0x47/0xe0 net/ipv6/ip6_output.c:1259
>  udp_tunnel6_dst_lookup+0x231/0x3c0 net/ipv6/ip6_udp_tunnel.c:165
>  geneve6_xmit_skb drivers/net/geneve.c:957 [inline]
>  geneve_xmit+0xd2e/0x2b70 drivers/net/geneve.c:1043
>  __netdev_start_xmit include/linux/netdevice.h:5203 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5212 [inline]
>  xmit_one net/core/dev.c:3828 [inline]
>  dev_hard_start_xmit+0x2d4/0x830 net/core/dev.c:3844
>  __dev_queue_xmit+0x1adf/0x3a70 net/core/dev.c:4681
>  dev_queue_xmit include/linux/netdevice.h:3349 [inline]
>  neigh_hh_output include/net/neighbour.h:523 [inline]
>  neigh_output include/net/neighbour.h:537 [inline]
>  ip6_finish_output2+0x11bc/0x16a0 net/ipv6/ip6_output.c:141
>  __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
>  ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
>  NF_HOOK+0x9e/0x380 include/linux/netfilter.h:314
>  mld_sendpack+0x800/0xd80 net/ipv6/mcast.c:1868
>  mld_send_cr net/ipv6/mcast.c:2169 [inline]
>  mld_ifc_work+0x835/0xde0 net/ipv6/mcast.c:2702
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> ---[ end trace ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

-- 
Kees Cook


Return-Path: <netdev+bounces-68692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430884796D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A408288556
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108D12F37E;
	Fri,  2 Feb 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayzoPeBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AB12C7F7
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901027; cv=none; b=AU8p/mNaLpk3dgleWxWqXPYZufc48LbCjgGNUzkbm2wdwj+mjTOam4hb9GKyR/HEfReZGEpRyKveadNyIvoP2JGA1bGJJU1CYUYOarT3TiAeS8GAc+hOtVBe6QGMS+fyLxA0SSNYhlVnDNddHYgrGSPQkgffIps0mmXtGaRM0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901027; c=relaxed/simple;
	bh=/f0XjxiCl6wPV5ezuonDc/FarQ467+0GN/sZYbZI/ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rCYBQfNNCLXMfOAO8adZjS6JO9Gceo2s5q0fOQq/TKNiJ6fS2SURifE73ddLSHntf9Y4jaukyQ2BQQf7eUdxfjtLwlotP45ODkMvJECdsJVwYczxZw3GTB+OzPSRnvlIrGcCmnUgNypN5bgU/yUOsyOqLUZwYcpSjm6AhgRz4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayzoPeBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A050AC43390;
	Fri,  2 Feb 2024 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706901026;
	bh=/f0XjxiCl6wPV5ezuonDc/FarQ467+0GN/sZYbZI/ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ayzoPeBl4P1z/AA6QxMioxg/ecSLDFa/dP+lG1sORPRbEfW5IL81bCi6rapLJLRhf
	 c2xQc5MyTnYvTDer3s7E28BrBbx+1ISgO7YfYdydf8KH7I8N0EuGBmBa5kB1V+8nh5
	 tujnA3u3RFqcupblAGtmz9YeOrHNnBuCfWdr6lWeGvvPLVg52natwLCJw3VjHyydmI
	 Gu+FTLLrEP6dTIF9oviHdvbF8h4MQToYvvf+joMeZaB4pLN2LIoJ5G6fPxhitjVU+l
	 XPiuepKBL2OlogdYpveNbB/tZ3ekN+MDYy/P564frSHkP7pVquOSD7qzlxBGSrxrXZ
	 GEg3lo9OO/OoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82815D8C978;
	Fri,  2 Feb 2024 19:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdevsim: avoid potential loop in
 nsim_dev_trap_report_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170690102653.13805.6102586210545621433.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 19:10:26 +0000
References: <20240201175324.3752746-1-edumazet@google.com>
In-Reply-To: <20240201175324.3752746-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Feb 2024 17:53:24 +0000 you wrote:
> Many syzbot reports include the following trace [1]
> 
> If nsim_dev_trap_report_work() can not grab the mutex,
> it should rearm itself at least one jiffie later.
> 
> [1]
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 32383 Comm: kworker/0:2 Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Workqueue: events nsim_dev_trap_report_work
>  RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:89 [inline]
>  RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
>  RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
>  RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
>  RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
>  RIP: 0010:kasan_check_range+0x101/0x190 mm/kasan/generic.c:189
> Code: 07 49 39 d1 75 0a 45 3a 11 b8 01 00 00 00 7c 0b 44 89 c2 e8 21 ed ff ff 83 f0 01 5b 5d 41 5c c3 48 85 d2 74 4f 48 01 ea eb 09 <48> 83 c0 01 48 39 d0 74 41 80 38 00 74 f2 eb b6 41 bc 08 00 00 00
> RSP: 0018:ffffc90012dcf998 EFLAGS: 00000046
> RAX: fffffbfff258af1e RBX: fffffbfff258af1f RCX: ffffffff8168eda3
> RDX: fffffbfff258af1f RSI: 0000000000000004 RDI: ffffffff92c578f0
> RBP: fffffbfff258af1e R08: 0000000000000000 R09: fffffbfff258af1e
> R10: ffffffff92c578f3 R11: ffffffff8acbcbc0 R12: 0000000000000002
> R13: ffff88806db38400 R14: 1ffff920025b9f42 R15: ffffffff92c578e8
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c00994e078 CR3: 000000002c250000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>   instrument_atomic_read include/linux/instrumented.h:68 [inline]
>   atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>   queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
>   debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
>   do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:141
>   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
>   _raw_spin_unlock_irqrestore+0x22/0x70 kernel/locking/spinlock.c:194
>   debug_object_activate+0x349/0x540 lib/debugobjects.c:726
>   debug_work_activate kernel/workqueue.c:578 [inline]
>   insert_work+0x30/0x230 kernel/workqueue.c:1650
>   __queue_work+0x62e/0x11d0 kernel/workqueue.c:1802
>   __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
>   queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1989
>   queue_delayed_work include/linux/workqueue.h:563 [inline]
>   schedule_delayed_work include/linux/workqueue.h:677 [inline]
>   nsim_dev_trap_report_work+0x9c0/0xc80 drivers/net/netdevsim/dev.c:842
>   process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>   process_scheduled_works kernel/workqueue.c:2706 [inline]
>   worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>   kthread+0x2c6/0x3a0 kernel/kthread.c:388
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: avoid potential loop in nsim_dev_trap_report_work()
    https://git.kernel.org/netdev/net/c/ba5e1272142d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




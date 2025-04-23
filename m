Return-Path: <netdev+bounces-184956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52077A97C9E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 04:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E2E1B6172E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3702526460B;
	Wed, 23 Apr 2025 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpMuA8NH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135842641FD
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745374193; cv=none; b=V8v3PeZR3EkYbD2l1jv5cdtmxtiZyfxnRWXi1mi3W0FDO+WbCbNRzG79VB3V31fH+jM5DCjkl2vFMHZIs5B3qOBT5r/84zbszCRJ/9nJn5tjM3tPxsLOo/daThkQfeDDUPeLnruUNxR7b0wHRgdxwZGMAoiBuYgp492rgTDUbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745374193; c=relaxed/simple;
	bh=PGHUODWM5Fuc0lMTH7Q6hIJ7sOBADUG/v5EUMdSSxGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dcJrGwKhALSGdM2n/v/ihzIInZAzAmm8Po86CVTtJ+JBfa5CPlaZkjTDcU5PohFA4rkApnBERuYNJIsrqQ5f5JDVVQLQ6FpbNhDCLfyMFxMDI3DFcKDy1hKXfuNht8c4rjZlTFR8zIbBUmSeApaBf87Irs95CuY7D1qTxS7MlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpMuA8NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848AFC4CEEE;
	Wed, 23 Apr 2025 02:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745374192;
	bh=PGHUODWM5Fuc0lMTH7Q6hIJ7sOBADUG/v5EUMdSSxGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SpMuA8NHPrMYbMlqUf7flDW7tjsz05j85PgNXW99I6cEzUZyZ4yWRyD3aLUVIRmD9
	 cMUmwlA1+Ktsx7kLfPRNHaZYyQ7RPE3I1o5aGlA4WhTazQ/fDssVCULvutbLssJgPD
	 ToAMve8qTtF7CQR4HlH84J9pEeL+ZFVSC4xHGqqTu/ZHHJJQMcCbQleDZLTfZHsv3G
	 GR563sdwAfZleJFxtoabD2gFX1OshQ09IO1N415NcQz9ZGHEd6zpooEtwHDPHu0xHv
	 Yd4IgxoKAWZIceZ0LXFjYp2CWbBWyN61PDBoqjniDm5jdiagpSbS+ZP0nfP2/HpzR4
	 7YykPThrodBEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5B380CEF4;
	Wed, 23 Apr 2025 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix NULL pointer dereference in
 tipc_mon_reinit_self()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537423074.2115098.1335554506325655535.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 02:10:30 +0000
References: <20250417074826.578115-1-tung.quang.nguyen@est.tech>
In-Reply-To: <20250417074826.578115-1-tung.quang.nguyen@est.tech>
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jmaloy@redhat.com,
 syzbot+ed60da8d686dc709164c@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 14:47:15 +0700 you wrote:
> syzbot reported:
> 
> tipc: Node number set to 1055423674
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 3 UID: 0 PID: 6017 Comm: kworker/3:5 Not tainted 6.15.0-rc1-syzkaller-00246-g900241a5cc15 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: events tipc_net_finalize_work
> RIP: 0010:tipc_mon_reinit_self+0x11c/0x210 net/tipc/monitor.c:719
> ...
> RSP: 0018:ffffc9000356fb68 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003ee87cba
> RDX: 0000000000000000 RSI: ffffffff8dbc56a7 RDI: ffff88804c2cc010
> RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
> R13: fffffbfff2111097 R14: ffff88804ead8000 R15: ffff88804ead9010
> FS:  0000000000000000(0000) GS:ffff888097ab9000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000f720eb00 CR3: 000000000e182000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  tipc_net_finalize+0x10b/0x180 net/tipc/net.c:140
>  process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c2/0x780 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> ...
> RIP: 0010:tipc_mon_reinit_self+0x11c/0x210 net/tipc/monitor.c:719
> ...
> RSP: 0018:ffffc9000356fb68 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003ee87cba
> RDX: 0000000000000000 RSI: ffffffff8dbc56a7 RDI: ffff88804c2cc010
> RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
> R13: fffffbfff2111097 R14: ffff88804ead8000 R15: ffff88804ead9010
> FS:  0000000000000000(0000) GS:ffff888097ab9000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000f720eb00 CR3: 000000000e182000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix NULL pointer dereference in tipc_mon_reinit_self()
    https://git.kernel.org/netdev/net/c/d63527e109e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




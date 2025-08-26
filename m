Return-Path: <netdev+bounces-216731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70327B35022
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8351F1B24625
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11D1FBEB0;
	Tue, 26 Aug 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8OmC8Pl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BD4A33;
	Tue, 26 Aug 2025 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167601; cv=none; b=jixaeV4VOUj2Q98I191cA9LIHMDz89peCbJSaW6dgw2hisfd0WdS4IbqEF/r/UT+Osr2YgHDGKYg5hIk1r5M+jHzqcJT7VAoldZgD8AOO8A1SMK8nlAHPkfZ31/lFmG+8o2EZVluShREljfCSzcWCZC5QD69Wx+OxqZGMM4hdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167601; c=relaxed/simple;
	bh=rdAGA8a0vtuFKA5IRGzn2qadcEvgRKjgWMhtJv9Uiio=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oqz69kV4nPamVxNgk7ZMdPjpaVEg05oiJK2qeh8Ui1kWsY9fP7q+O8f83G3z73AObLpjOt48vWkga0TTMbmACVLFW9bAh0lrpQPbJv84/hufsPe13Ba6/vWh9QE2bfz0Ch1D6BBLplzE3rjwF49NnZLFSo9EHjIyPMdQglGLbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8OmC8Pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96839C4CEED;
	Tue, 26 Aug 2025 00:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756167600;
	bh=rdAGA8a0vtuFKA5IRGzn2qadcEvgRKjgWMhtJv9Uiio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h8OmC8Plbx4kx4FtlmgTk+KMt9Ugy2U9Js0jHXCrtKkN9axmUDzLVvNFeKhzag5iu
	 8NRzdQmqi6IwKo76HQFTmNn4BDDZuMJJUBAayiBshfQQ6Nj3/XRVqu/Csle7uqgdWx
	 CsuoqU6EQ8AVyTBPbAMM9JZmXa0qx2Fib7eEKLk5Oca3q/zWHZ+Lt2P49qYsycOn17
	 fUJdonKc17k7LNC7NOoiKwN+ZhARWapFgBtgkR2vH3fOd6tHzvIQ0jJ4M8Ezo6Jso9
	 bDFRv90LR1y6BnPbmDgA09gp8TY3hzWyLFz/6X1l2/fDg2j8XcT5ELT1HfPMPgfYBM
	 fheXAzdE2zy5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6C383BF70;
	Tue, 26 Aug 2025 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mISDN: hfcpci: Fix warning when deleting uninitialized
 timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616760800.3604027.14352969927664790670.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 00:20:08 +0000
References: <aKiy2D_LiWpQ5kXq@vova-pc>
In-Reply-To: <aKiy2D_LiWpQ5kXq@vova-pc>
To: Vladimir Riabchun <ferr.lambarginio@gmail.com>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 20:11:36 +0200 you wrote:
> With CONFIG_DEBUG_OBJECTS_TIMERS unloading hfcpci module leads
> to the following splat:
> 
> [  250.215892] ODEBUG: assert_init not available (active state 0) object: ffffffffc01a3dc0 object type: timer_list hint: 0x0
> [  250.217520] WARNING: CPU: 0 PID: 233 at lib/debugobjects.c:612 debug_print_object+0x1b6/0x2c0
> [  250.218775] Modules linked in: hfcpci(-) mISDN_core
> [  250.219537] CPU: 0 UID: 0 PID: 233 Comm: rmmod Not tainted 6.17.0-rc2-g6f713187ac98 #2 PREEMPT(voluntary)
> [  250.220940] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  250.222377] RIP: 0010:debug_print_object+0x1b6/0x2c0
> [  250.223131] Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 4f 41 56 48 8b 14 dd a0 4e 01 9f 48 89 ee 48 c7 c7 20 46 01 9f e8 cb 84d
> [  250.225805] RSP: 0018:ffff888015ea7c08 EFLAGS: 00010286
> [  250.226608] RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff9be93a95
> [  250.227708] RDX: 1ffff1100d945138 RSI: 0000000000000008 RDI: ffff88806ca289c0
> [  250.228993] RBP: ffffffff9f014a00 R08: 0000000000000001 R09: ffffed1002bd4f39
> [  250.230043] R10: ffff888015ea79cf R11: 0000000000000001 R12: 0000000000000001
> [  250.231185] R13: ffffffff9eea0520 R14: 0000000000000000 R15: ffff888015ea7cc8
> [  250.232454] FS:  00007f3208f01540(0000) GS:ffff8880caf5a000(0000) knlGS:0000000000000000
> [  250.233851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  250.234856] CR2: 00007f32090a7421 CR3: 0000000004d63000 CR4: 00000000000006f0
> [  250.236117] Call Trace:
> [  250.236599]  <TASK>
> [  250.236967]  ? trace_irq_enable.constprop.0+0xd4/0x130
> [  250.237920]  debug_object_assert_init+0x1f6/0x310
> [  250.238762]  ? __pfx_debug_object_assert_init+0x10/0x10
> [  250.239658]  ? __lock_acquire+0xdea/0x1c70
> [  250.240369]  __try_to_del_timer_sync+0x69/0x140
> [  250.241172]  ? __pfx___try_to_del_timer_sync+0x10/0x10
> [  250.242058]  ? __timer_delete_sync+0xc6/0x120
> [  250.242842]  ? lock_acquire+0x30/0x80
> [  250.243474]  ? __timer_delete_sync+0xc6/0x120
> [  250.244262]  __timer_delete_sync+0x98/0x120
> [  250.245015]  HFC_cleanup+0x10/0x20 [hfcpci]
> [  250.245704]  __do_sys_delete_module+0x348/0x510
> [  250.246461]  ? __pfx___do_sys_delete_module+0x10/0x10
> [  250.247338]  do_syscall_64+0xc1/0x360
> [  250.247924]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - mISDN: hfcpci: Fix warning when deleting uninitialized timer
    https://git.kernel.org/netdev/net/c/97766512a995

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




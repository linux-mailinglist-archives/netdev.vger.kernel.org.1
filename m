Return-Path: <netdev+bounces-135797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080199F3B7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF96E1F23670
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9821F76BA;
	Tue, 15 Oct 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCYF6whX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8217335C
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012225; cv=none; b=tGfITjfiWl25tMdOmedpc6AhV1yv3XUc4g7/DAzmtiynbWP9gd8CCmyHOedbMCAx2HKHD6Eh3mQxkF3S+5oIRajStu0y5HdvWGc5QHdOSUZKvaxfL9HKuIWWmgpnhfXdPzkFpYpOqa88DsX/RS/rkVDaAUxqwgQNyiNbjJbd0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012225; c=relaxed/simple;
	bh=p4q75MtGr+Q0cqyEmp0jgXo6XpfkrZoHMJMn9yem+D8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QbZJV7ifBwZmV1LYxmTQKC8ZTtp2qqj+vOmHghn0sSwI6rxby8RqCZP2F0aOIVyRTbwwZFl6SWc1s8IqPwWDpNwWMbofryZI2u5ZI5tFOFeS14pRicsIqa18v02rhooEyatt4bGlAdDK93/zJmYXfUIiByD9CmjmmkyVQWFSJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCYF6whX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0847DC4CEC6;
	Tue, 15 Oct 2024 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012225;
	bh=p4q75MtGr+Q0cqyEmp0jgXo6XpfkrZoHMJMn9yem+D8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gCYF6whXTCS/MKxl/KRbF8MAQV8tdfC7uEI2OyHH4D1Msh0NUBs4ei5T7CxlcuxDh
	 rBX7Z+sIV10QpJ0VRCrpQE1K8sh487fOzKsXyDlust2WdSDt5fzuPRssBiqQ4PEQTi
	 UyT6uCUvTE2F9MvfAZrX8/Odhs2KtpLUYYgYbCfj7iRM+5rXFO38Xv7S3k8WGiynTR
	 cpaiLUzsTZ+CIHp++Y/l7limOKg29neEa16Wd1v9VXAxCRc/YAVWiCm/XEdYME/7D0
	 9ibEp4yOZv5A+5qCwcjeGYeZCXstl0x7lxamYosogbIESOonuKROePuUE/VkSMqgg4
	 vfkqC3KiwQXog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E393809A8A;
	Tue, 15 Oct 2024 17:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] netdevsim: use cond_resched() in
 nsim_dev_trap_report_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901223025.1230547.4087935484646595253.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 17:10:30 +0000
References: <20241012094230.3893510-1-edumazet@google.com>
In-Reply-To: <20241012094230.3893510-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+d383dc9579a76f56c251@syzkaller.appspotmail.com,
 syzbot+c596faae21a68bf7afd0@syzkaller.appspotmail.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Oct 2024 09:42:30 +0000 you wrote:
> I am still seeing many syzbot reports hinting that syzbot
> might fool nsim_dev_trap_report_work() with hundreds of ports [1]
> 
> Lets use cond_resched(), and system_unbound_wq
> instead of implicit system_wq.
> 
> [1]
> INFO: task syz-executor:20633 blocked for more than 143 seconds.
>       Not tainted 6.12.0-rc2-syzkaller-00205-g1d227fcc7222 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:25856 pid:20633 tgid:20633 ppid:1      flags:0x00004006
> ...
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 16760 Comm: kworker/1:0 Not tainted 6.12.0-rc2-syzkaller-00205-g1d227fcc7222 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events nsim_dev_trap_report_work
>  RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:210
> Code: 89 fb e8 23 00 00 00 48 8b 3d 04 fb 9c 0c 48 89 de 5b e9 c3 c7 5d 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 c0 d7 03 00 65 8b 15 60 f0
> RSP: 0018:ffffc90000a187e8 EFLAGS: 00000246
> RAX: 0000000000000100 RBX: ffffc90000a188e0 RCX: ffff888027d3bc00
> RDX: ffff888027d3bc00 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88804a2e6000 R08: ffffffff8a4bc495 R09: ffffffff89da3577
> R10: 0000000000000004 R11: ffffffff8a4bc2b0 R12: dffffc0000000000
> R13: ffff88806573b503 R14: dffffc0000000000 R15: ffff8880663cca00
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc90a747f98 CR3: 000000000e734000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 000000000000002b DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>   __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
>   spin_unlock_bh include/linux/spinlock.h:396 [inline]
>   nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
>   nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [v2,net] netdevsim: use cond_resched() in nsim_dev_trap_report_work()
    https://git.kernel.org/netdev/net/c/a1494d532e28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-92304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A688B67E8
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8082A281AFD
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2BBE5D;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDToFYiI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552F33D5
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443632; cv=none; b=PkekyaOpLmi8GIN2aI180tj21F3X9qjWhLkvrb0M5HP9eyKAYgtcGgd01kK8ak/2C+/htQtKT1Od4JEPyrZOe1Zhr3y5vtOPtR93yRjjTRMFG38u1RS4F+RleReozds5LdUOgFboLwDlbPIntsD7Q5JjG7se8mYm5K9d0qaibNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443632; c=relaxed/simple;
	bh=75uCO5W6YZ+5eFiEslA6psfyrkEHJZO22B/hXLazq+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ch4Yv1z2ht8l3rv+2pP/CD3a19A9ZlH5sTX6qENJcb4GJmDFJTowUqRGSg3hqpx2qenJjrDorsmECQjXfWW+if3okn6qmHyIyc6kBKnpIig0MVkQBIrNJCTuRfO9SqLqWUIxmvWQX+wTpRXunbFel8M9mUj6fDDK/JSY5F8i7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDToFYiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51022C4AF1C;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714443632;
	bh=75uCO5W6YZ+5eFiEslA6psfyrkEHJZO22B/hXLazq+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RDToFYiIpwmG0Sb9DQZWM0nf6fquvX7XJgIJgOSWqMOsraXhXz0ECT5/y3gR9FW01
	 olZIsHOekUSimuC43itTIQaYm4gipGK+e53HD1EMD3OPNlkOzJc8vymkltiMbNtj3i
	 w/r2aoUh4+/y8DtLZZGEGr9xQH9QSBm9/qczOk3BfqQFpOCo1b6m6jgUCnmbzte+D2
	 FQ14VEGmEbTJQywPKpZDIplMSheqcsAKzSDailOBeidGv6JzWmlXu13gPN6K6+02n3
	 vEFQQ7a1Ip8EufFkYLbTDUTnIunNLoopHP9nxinooTLFb5Uxbu9zCvYtQbJic/O01M
	 mBRM0FueekcmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EEDEC54BAD;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hsr: init prune_proxy_timer sooner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171444363225.30384.6401361631915185598.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 02:20:32 +0000
References: <20240426163355.2613767-1-edumazet@google.com>
In-Reply-To: <20240426163355.2613767-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 lukma@denx.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Apr 2024 16:33:55 +0000 you wrote:
> We must initialize prune_proxy_timer before we attempt
> a del_timer_sync() on it.
> 
> syzbot reported the following splat:
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 1 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc5-syzkaller-01199-gfc48de77d69d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:976
>   register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1289
>   __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>   __timer_delete_sync+0x148/0x310 kernel/time/timer.c:1648
>   del_timer_sync include/linux/timer.h:185 [inline]
>   hsr_dellink+0x33/0x80 net/hsr/hsr_netlink.c:132
>   default_device_exit_batch+0x956/0xa90 net/core/dev.c:11737
>   ops_exit_list net/core/net_namespace.c:175 [inline]
>   cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:637
>   process_one_work kernel/workqueue.c:3254 [inline]
>   process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
>   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>   kthread+0x2f0/0x390 kernel/kthread.c:388
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> ODEBUG: assert_init not available (active state 0) object: ffff88806d3fcd88 object type: timer_list hint: 0x0
>  WARNING: CPU: 1 PID: 11 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
> 
> [...]

Here is the summary with links:
  - [net-next] net: hsr: init prune_proxy_timer sooner
    https://git.kernel.org/netdev/net-next/c/3c668cef61ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




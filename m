Return-Path: <netdev+bounces-65068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D531B8390E5
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 15:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873B81F2A3B9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DBC5F848;
	Tue, 23 Jan 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEAHLMHI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465B5F845
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019025; cv=none; b=j+UVC0xrwIuT6CG91JeBTE95v3ogKyDozLyRPDAzdA4h9bcPKLNBy1yEsWbLkKO6GQ8KUCazv89QzpdSJ9M2UjQFLv5iL8YIxfABjXMtm1NVk5CXFz+vczI+rZK0hhMTUbW2raiH7AUEhIsfCdjisDMlfqQEZhXso4koKHXLh7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019025; c=relaxed/simple;
	bh=As4BfAmUzDoiHW5HROtVC2rYFYWioxlJEDCuxr6sRU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FLetN3KIpmN/Z6ONO6ivETtj2jbrEhM3qSMxNW5/GkB7J0VF/Ky2XkUEtDe1Y3rEH+J8vTQPNd9PgyuftWtG4C40f0R/PCOzsptVSBJEGOE8B+8qRmUJ664/X2npzTTU5HGcDxD0eHd2G4eut0QGBKuQazb1Q3Gp5Ib4wlk6Hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEAHLMHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D32AC43394;
	Tue, 23 Jan 2024 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019025;
	bh=As4BfAmUzDoiHW5HROtVC2rYFYWioxlJEDCuxr6sRU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NEAHLMHIOPntJ3x9I1CuZuFWp7o41URraiUHicEaRyNxdRNnfNzhd918ZdmSVxiEv
	 Fwcl+2TDUaIkylBDS26USAKcCpuF/slLw+P/mL66lbbIL0sM65YVGJFwkMtGJEfG9h
	 F8maBEUvfSqE/leMLV1WnggnanT1Fkrz0D+QsNzu6ptaBc40yyFhFz9vk4AQFUJOTU
	 sjy6EHUvWEnWWwSD9EiHRw8i5ik0jCBWmg5MV5JzQcFcboIHTuE8IlamdVoDxZ5yQG
	 vLfshfoMlk0zCqbSl9iEUXPTVhVMmp6kR9w+RHaSQxx7gdCoSrFQfybAgJvtuy3yjj
	 /RdFlrFiBN0Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC797DC99E0;
	Tue, 23 Jan 2024 14:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: init the accept_queue's spinlocks in inet6_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170601902496.22645.15094740282920490034.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 14:10:24 +0000
References: <20240122102001.2851701-1-shaozhengchao@huawei.com>
In-Reply-To: <20240122102001.2851701-1-shaozhengchao@huawei.com>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 Jan 2024 18:20:01 +0800 you wrote:
> In commit 198bc90e0e73("tcp: make sure init the accept_queue's spinlocks
> once"), the spinlocks of accept_queue are initialized only when socket is
> created in the inet4 scenario. The locks are not initialized when socket
> is created in the inet6 scenario. The kernel reports the following error:
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> Call Trace:
> <TASK>
> 	dump_stack_lvl (lib/dump_stack.c:107)
> 	register_lock_class (kernel/locking/lockdep.c:1289)
> 	__lock_acquire (kernel/locking/lockdep.c:5015)
> 	lock_acquire.part.0 (kernel/locking/lockdep.c:5756)
> 	_raw_spin_lock_bh (kernel/locking/spinlock.c:178)
> 	inet_csk_listen_stop (net/ipv4/inet_connection_sock.c:1386)
> 	tcp_disconnect (net/ipv4/tcp.c:2981)
> 	inet_shutdown (net/ipv4/af_inet.c:935)
> 	__sys_shutdown (./include/linux/file.h:32 net/socket.c:2438)
> 	__x64_sys_shutdown (net/socket.c:2445)
> 	do_syscall_64 (arch/x86/entry/common.c:52)
> 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> RIP: 0033:0x7f52ecd05a3d
> Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 73 01 c3 48 8b 0d ab a3 0e 00 f7 d8 64 89 01 48
> RSP: 002b:00007f52ecf5dde8 EFLAGS: 00000293 ORIG_RAX: 0000000000000030
> RAX: ffffffffffffffda RBX: 00007f52ecf5e640 RCX: 00007f52ecd05a3d
> RDX: 00007f52ecc8b188 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007f52ecf5de20 R08: 00007ffdae45c69f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007f52ecf5e640
> R13: 0000000000000000 R14: 00007f52ecc8b060 R15: 00007ffdae45c6e0
> 
> [...]

Here is the summary with links:
  - [net] ipv6: init the accept_queue's spinlocks in inet6_create
    https://git.kernel.org/netdev/net/c/435e202d645c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




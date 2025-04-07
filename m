Return-Path: <netdev+bounces-179858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D0CA7EC68
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD053442A35
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBCE26136F;
	Mon,  7 Apr 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dssUV+bQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845152550CD
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051199; cv=none; b=WLAUXP8Sp2Fo5uEzUi9Q6LRVMAtxcfgWUcJ+igIfr8xB9MRyN3yHoFPK+jQxDKjenhsDF7zgKs0H0D4tAhnj8yEXjSkQq5GkNG8pmpDcVfkbrXSroI4rp4AW1QD7EIfV/2/OY7mFvvAjzUCUMS5Mc1ewLv+DuBaQ8S9bXAFFDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051199; c=relaxed/simple;
	bh=8wxgSqUPzuWBhhGvbK4akHkXDLaIXlOFs0umFsuEcAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lJJ+qnIDBSGY8XOaUh1VAws1a8Xx0nPKXZvjUATM9EpzNXdd7rEXhECf869/iZwzexTICSC+ib+WrVFBHTTqfQP+nGdNveHoP03nPH3bnX2OVn7VjO39OFNaushBddvfsxVo3uMOT5ivmy6we2r4ma3Lm+yuiJKxDsiJBlV7Mj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dssUV+bQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CFEC4CEDD;
	Mon,  7 Apr 2025 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051199;
	bh=8wxgSqUPzuWBhhGvbK4akHkXDLaIXlOFs0umFsuEcAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dssUV+bQRHYHw/spCxGeg7H5beGi2eKfTc1Ic+Hjb/PKG/xZzLLL2iCWDFaesJyC0
	 7zFpK3T9fqk4gFZ22lSJpq3c1PXYnAuzfp+dqhgxH0VeDApCxtYX24coivjoFYPB8k
	 pEAp3XTlSs6UsqtRR+54eGm6GznAqydZUXqMNWlWWlCpIbop4VJnPuVj6P0PD2nKN9
	 /0YkhIjSXlXlCDNDjLXn7+Jnaq6D7FtENyr2Yv5QFhwc11xQcuHYGQgihmsR/TNepY
	 5mP/NrKApl37g8UoT0UudGQmZo5+iO7IWmC5+Or8TgczOBoKB3Go1fLwvrRDWCMbwf
	 gemG2D7VkGqfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71120380CEEF;
	Mon,  7 Apr 2025 18:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv6: Fix null-ptr-deref in addrconf_add_ifaddr().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174405123628.1227543.885502289771154020.git-patchwork-notify@kernel.org>
Date: Mon, 07 Apr 2025 18:40:36 +0000
References: <20250406035755.69238-1-kuniyu@amazon.com>
In-Reply-To: <20250406035755.69238-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com,
 guohui.study@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 5 Apr 2025 20:57:51 -0700 you wrote:
> The cited commit placed netdev_lock_ops() just after __dev_get_by_index()
> in addrconf_add_ifaddr(), where dev could be NULL as reported. [0]
> 
> Let's call netdev_lock_ops() only when dev is not NULL.
> 
> [0]:
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000198: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000cc0-0x0000000000000cc7]
> CPU: 3 UID: 0 PID: 12032 Comm: syz.0.15 Not tainted 6.14.0-13408-g9f867ba24d36 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:addrconf_add_ifaddr (./include/net/netdev_lock.h:30 ./include/net/netdev_lock.h:41 net/ipv6/addrconf.c:3157)
> Code: 8b b4 24 94 00 00 00 4c 89 ef e8 7e 4c 2f ff 4c 8d b0 c5 0c 00 00 48 89 c3 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 4c 89 f2 83 e2 07 38 d0 7f 08 80
> RSP: 0018:ffffc90015b0faa0 EFLAGS: 00010213
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000198 RSI: ffffffff893162f2 RDI: ffff888078cb0338
> RBP: ffffc90015b0fbb0 R08: 0000000000000000 R09: fffffbfff20cbbe2
> R10: ffffc90015b0faa0 R11: 0000000000000000 R12: 1ffff92002b61f54
> R13: ffff888078cb0000 R14: 0000000000000cc5 R15: ffff888078cb0000
> FS: 00007f92559ed640(0000) GS:ffff8882a8659000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f92559ecfc8 CR3: 000000001c39e000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  inet6_ioctl (net/ipv6/af_inet6.c:580)
>  sock_do_ioctl (net/socket.c:1196)
>  sock_ioctl (net/socket.c:1314)
>  __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:906 fs/ioctl.c:892 fs/ioctl.c:892)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130
> RIP: 0033:0x7f9254b9c62d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff f8
> RSP: 002b:00007f92559ecf98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f9254d65f80 RCX: 00007f9254b9c62d
> RDX: 0000000020000040 RSI: 0000000000008916 RDI: 0000000000000003
> RBP: 00007f9254c264d3 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f9254d65f80 R15: 00007f92559cd000
>  </TASK>
> Modules linked in:
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv6: Fix null-ptr-deref in addrconf_add_ifaddr().
    https://git.kernel.org/netdev/net/c/54f5fafcced1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




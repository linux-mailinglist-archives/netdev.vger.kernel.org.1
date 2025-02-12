Return-Path: <netdev+bounces-165329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A567DA31A99
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DF418878D5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F1A271827;
	Wed, 12 Feb 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcRi+QvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4979F2
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320804; cv=none; b=e+fiAgCvG7icNLgEXVF0UxBZBUqIW2BKXC/Hm9GNHKFs3LDoOeOW9lJvtVSbmYeR2c0irbPpn3Dz8pPI95wQuU9FbRyRsSom0FvpXinrf6+8PmF91T0kcbHJ+boXfVfAVSggj4M4LKVxDH0aptCnvLQ0RcbcQ/AUCjnpsmy2wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320804; c=relaxed/simple;
	bh=4gYRKeV/o9Fd5EHF13nzi+WcSxVwigz8FEYtKFA/3Hw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jvt+doX+Xd/th+eIX2CnrmDJxn8ndOsNRVWFGF29a17FNQMuGVzH2abz3zFqbqLbmQbhQ8FfTOurW/rCp4zFI6uZJ13rUUXEJaUCqEVNFTyeaYiluAO6ngXhumugqIskGUizwsa6iw/QCw6Hz2qtWfEFDQFZWWAGz7e/1pYQN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcRi+QvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4417C4CEDD;
	Wed, 12 Feb 2025 00:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320803;
	bh=4gYRKeV/o9Fd5EHF13nzi+WcSxVwigz8FEYtKFA/3Hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LcRi+QvGerp2A/95CkifoUqSNAdbDRxiYwAeGnbSYmCec+4Q7A0DOCIDR9CupzUMt
	 vEJgAYpZOtnz2nHLUU6qd5p7BKIROClPW+PyeofcktUQfwx/YG76QxtsKGaVgrbG4o
	 OD4nT0jrR7fM8wCrqr9SBKuVSUMCaI+a5ecd4NNj7kCNSGPdEFsrXmM3mD2Zf+e50m
	 D0XGxYCddPyrzpb+I6qtEjMz2tGbH3KtprpPS/zn8YNGIsX/iugxuhkSGUnmFXvDth
	 +CI552Fa3KodVsdaTju7Ty0tLwtwPa55l9fbpk5u0kQqhrFlRlt1amMKJ2TjBxOLlm
	 Fgwnf59q7S9uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC614380AA7A;
	Wed, 12 Feb 2025 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: check vxlan_vnigroup_init() return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932083277.51333.10241799841415185239.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 00:40:32 +0000
References: <20250210105242.883482-1-edumazet@google.com>
In-Reply-To: <20250210105242.883482-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com, roopa@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 10:52:42 +0000 you wrote:
> vxlan_init() must check vxlan_vnigroup_init() success
> otherwise a crash happens later, spotted by syzbot.
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000002c: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000160-0x0000000000000167]
> CPU: 0 UID: 0 PID: 7313 Comm: syz-executor147 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>  RIP: 0010:vxlan_vnigroup_uninit+0x89/0x500 drivers/net/vxlan/vxlan_vnifilter.c:912
> Code: 00 48 8b 44 24 08 4c 8b b0 98 41 00 00 49 8d 86 60 01 00 00 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 04 00 00 49 8b 86 60 01 00 00 48 ba 00 00 00
> RSP: 0018:ffffc9000cc1eea8 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8672effb
> RDX: 000000000000002c RSI: ffffffff8672ecb9 RDI: ffff8880461b4f18
> RBP: ffff8880461b4ef4 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000020000
> R13: ffff8880461b0d80 R14: 0000000000000000 R15: dffffc0000000000
> FS:  00007fecfa95d6c0(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fecfa95cfb8 CR3: 000000004472c000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   vxlan_uninit+0x1ab/0x200 drivers/net/vxlan/vxlan_core.c:2942
>   unregister_netdevice_many_notify+0x12d6/0x1f30 net/core/dev.c:11824
>   unregister_netdevice_many net/core/dev.c:11866 [inline]
>   unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11736
>   register_netdevice+0x1829/0x1eb0 net/core/dev.c:10901
>   __vxlan_dev_create+0x7c6/0xa30 drivers/net/vxlan/vxlan_core.c:3981
>   vxlan_newlink+0xd1/0x130 drivers/net/vxlan/vxlan_core.c:4407
>   rtnl_newlink_create net/core/rtnetlink.c:3795 [inline]
>   __rtnl_newlink net/core/rtnetlink.c:3906 [inline]
> 
> [...]

Here is the summary with links:
  - [net] vxlan: check vxlan_vnigroup_init() return value
    https://git.kernel.org/netdev/net/c/5805402dcc56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




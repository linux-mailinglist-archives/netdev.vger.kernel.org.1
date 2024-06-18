Return-Path: <netdev+bounces-104291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7490C10F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07C8B20CBD
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B746AC0;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9bfOMOT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FC1D953A
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673029; cv=none; b=qVoVlzZgKsT3aXGuEJauJJjn4uOe/jooSGCwROJfLonUKcVM69Hvq2gCUaOoPxlWly0ckRHjgoJcSlNqEdCB0lXM/SXiHs+5ROsE0M/MStRIjrzU4JCmRUC6W7mVvJcy87uKgcXIulJl5vB2DWPA9mjInG0PZU9eAszFfef/JJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673029; c=relaxed/simple;
	bh=KHddb9fhrNvZPEn0BK66ob83CmwD7lMQV99ahOxkCmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PC6Mnu8D2m5VOK7osXcFUeLxEcRctUR7EMidP9eItTPkmQatS/4ze9hj63gaN7Fwc/28/g5LFxTwPa/IJLq/oP0Lv0DrSBU0ghoteDm63McfRUts0aRvn7sKVUOgXvWQg05qIthXl2ypyxVWwVXgrB2HhRka7cyqrty1fFMSYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9bfOMOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11102C4AF1D;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718673029;
	bh=KHddb9fhrNvZPEn0BK66ob83CmwD7lMQV99ahOxkCmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n9bfOMOTPCQL0bbNQ4y9ZtNCebD5IOynJLibWjtBdQcYWXz25ZFl1ofCYB//cVr8J
	 xqdXmXsf/MowVasLTC52daLy+8H1TAB1rY0D4CptHbjSSGtleeWaHRtsqktY22qVx7
	 0nWq1XmX6VU3KDxE0V2e6sdyHQSaYmUmVl3+HJzzV7xPtduQNJE2Q0rwbBj4MtDoP+
	 0DgCKdFxuFuUVEaibmK1SZfcYSLm1bTfabUA6Ly1z3wqGP3R/wiLWM2i28Ik3EgTmr
	 bJQdvC4CLSf86wLZsdOQ64GYj8Y/Zn6FWyWJXkbWoLqtZPH1IPFZ8695pXUBC/pxHh
	 jyMxqFpRafs5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1E53D2D0FA;
	Tue, 18 Jun 2024 01:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xfrm6: check ip6_dst_idev() return value in
 xfrm6_get_saddr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867302898.10892.1342644752312335158.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:10:28 +0000
References: <20240615154231.234442-1-edumazet@google.com>
In-Reply-To: <20240615154231.234442-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, steffen.klassert@secunet.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Jun 2024 15:42:31 +0000 you wrote:
> ip6_dst_idev() can return NULL, xfrm6_get_saddr() must act accordingly.
> 
> syzbot reported:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-rc2-syzkaller-00383-gb8481381d4e2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Workqueue: wg-kex-wg1 wg_packet_handshake_send_worker
>  RIP: 0010:xfrm6_get_saddr+0x93/0x130 net/ipv6/xfrm6_policy.c:64
> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 97 00 00 00 4c 8b ab d8 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 6d 00 e8 ca 13 47 01 48 b8 00
> RSP: 0018:ffffc90000117378 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff88807b079dc0 RCX: ffffffff89a0d6d7
> RDX: 0000000000000000 RSI: ffffffff89a0d6e9 RDI: ffff88807b079e98
> RBP: ffff88807ad73248 R08: 0000000000000007 R09: fffffffffffff000
> R10: ffff88807b079dc0 R11: 0000000000000007 R12: ffffc90000117480
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4586d00440 CR3: 0000000079042000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   xfrm_get_saddr net/xfrm/xfrm_policy.c:2452 [inline]
>   xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2481 [inline]
>   xfrm_tmpl_resolve+0xa26/0xf10 net/xfrm/xfrm_policy.c:2541
>   xfrm_resolve_and_create_bundle+0x140/0x2570 net/xfrm/xfrm_policy.c:2835
>   xfrm_bundle_lookup net/xfrm/xfrm_policy.c:3070 [inline]
>   xfrm_lookup_with_ifid+0x4d1/0x1e60 net/xfrm/xfrm_policy.c:3201
>   xfrm_lookup net/xfrm/xfrm_policy.c:3298 [inline]
>   xfrm_lookup_route+0x3b/0x200 net/xfrm/xfrm_policy.c:3309
>   ip6_dst_lookup_flow+0x15c/0x1d0 net/ipv6/ip6_output.c:1256
>   send6+0x611/0xd20 drivers/net/wireguard/socket.c:139
>   wg_socket_send_skb_to_peer+0xf9/0x220 drivers/net/wireguard/socket.c:178
>   wg_socket_send_buffer_to_peer+0x12b/0x190 drivers/net/wireguard/socket.c:200
>   wg_packet_send_handshake_initiation+0x227/0x360 drivers/net/wireguard/send.c:40
>   wg_packet_handshake_send_worker+0x1c/0x30 drivers/net/wireguard/send.c:51
>   process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
>   process_scheduled_works kernel/workqueue.c:3312 [inline]
>   worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
>   kthread+0x2c1/0x3a0 kernel/kthread.c:389
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> [...]

Here is the summary with links:
  - [net] xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
    https://git.kernel.org/netdev/net/c/d46401052c2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




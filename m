Return-Path: <netdev+bounces-248664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C208D0CD4F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611E13047955
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA93254B1F;
	Sat, 10 Jan 2026 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoPCCMDO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498ED2A1CF
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011815; cv=none; b=k8hdZuE2hqq1v657v+whwO9RkS3R1Cdarzz04CVPaJGWCb45Vp4T5XPsPrc6IUqnlY5QiTIjijhk1Ryrvs97kaaRz7y/gOYYu73CDCI38DKL3uJUmcHWdyYvWIfbh+hvh0hwHXI3PzoxKiXLYkJhPu39xagurSXwmSgWX9M94yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011815; c=relaxed/simple;
	bh=mG1xmJmN1nVLgfZe3BszRf36NvN2oPX7a+Y+Ncvsi2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i7jCZUZJhVwbgHVwrMDwLsKOousDyHenMT2gS1ltwlxOplYR74fjGJLB//5S+A2L4oyOh3igebspzORjJR6TSb1t282EDpbDmBbO+umV8SxN1LscHLn1qBgNzYIyU2TWxpqdU/12b6gr5fj/b1C77UfMEOtf/Q3SELEUBf0hYuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoPCCMDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEE1C4CEF1;
	Sat, 10 Jan 2026 02:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768011814;
	bh=mG1xmJmN1nVLgfZe3BszRf36NvN2oPX7a+Y+Ncvsi2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QoPCCMDORXqYw4Nbb4Uh3OxtF8tyJylrVzqU3L/6Uoxb2FY04IR0QkohHZ4uy2lLp
	 MANOljnjc0QZhV4p7benIwEa3YSHc8ad3BvMakem7H6XRWtqkFZ9GI/55xVJGuDigu
	 yYaM+LLcCM9WX+6Eme1x1DACGrU7mw6NvCQRM7hBEebZ02rpFPtA/9ge9c7kQ0ujgI
	 j9WECpbiJCkg98U5VrObGjXsnOuwSJVMq3q1Yxtn2YIELeIbH0qawMyEdAQ2gGtmBf
	 SEMXiMC60XXIV3t05B4tqYpP6adNM9vLpKsB8cTIsyZCc6S9ZUM4xw/hzkB9Mzk2Oe
	 jcNX/ilmhS60w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B57C73AA9F46;
	Sat, 10 Jan 2026 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in
 __ip6_tnl_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176801161029.454777.2817823539150562515.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 02:20:10 +0000
References: <20260107163109.4188620-1-edumazet@google.com>
In-Reply-To: <20260107163109.4188620-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jan 2026 16:31:09 +0000 you wrote:
> Blamed commit did not take care of VLAN encapsulations
> as spotted by syzbot [1].
> 
> Use skb_vlan_inet_prepare() instead of pskb_inet_may_pull().
> 
> [1]
>  BUG: KMSAN: uninit-value in __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
>  BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
>  BUG: KMSAN: uninit-value in IP6_ECN_decapsulate+0x7a8/0x1fa0 include/net/inet_ecn.h:321
>   __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
>   INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
>   IP6_ECN_decapsulate+0x7a8/0x1fa0 include/net/inet_ecn.h:321
>   ip6ip6_dscp_ecn_decapsulate+0x16f/0x1b0 net/ipv6/ip6_tunnel.c:729
>   __ip6_tnl_rcv+0xed9/0x1b50 net/ipv6/ip6_tunnel.c:860
>   ip6_tnl_rcv+0xc3/0x100 net/ipv6/ip6_tunnel.c:903
>  gre_rcv+0x1529/0x1b90 net/ipv6/ip6_gre.c:-1
>   ip6_protocol_deliver_rcu+0x1c89/0x2c60 net/ipv6/ip6_input.c:438
>   ip6_input_finish+0x1f4/0x4a0 net/ipv6/ip6_input.c:489
>   NF_HOOK include/linux/netfilter.h:318 [inline]
>   ip6_input+0x9c/0x330 net/ipv6/ip6_input.c:500
>   ip6_mc_input+0x7ca/0xc10 net/ipv6/ip6_input.c:590
>   dst_input include/net/dst.h:474 [inline]
>   ip6_rcv_finish+0x958/0x990 net/ipv6/ip6_input.c:79
>   NF_HOOK include/linux/netfilter.h:318 [inline]
>   ipv6_rcv+0xf1/0x3c0 net/ipv6/ip6_input.c:311
>   __netif_receive_skb_one_core net/core/dev.c:6139 [inline]
>   __netif_receive_skb+0x1df/0xac0 net/core/dev.c:6252
>   netif_receive_skb_internal net/core/dev.c:6338 [inline]
>   netif_receive_skb+0x57/0x630 net/core/dev.c:6397
>   tun_rx_batched+0x1df/0x980 drivers/net/tun.c:1485
>   tun_get_user+0x5c0e/0x6c60 drivers/net/tun.c:1953
>   tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1999
>   new_sync_write fs/read_write.c:593 [inline]
>   vfs_write+0xbe2/0x15d0 fs/read_write.c:686
>   ksys_write fs/read_write.c:738 [inline]
>   __do_sys_write fs/read_write.c:749 [inline]
>   __se_sys_write fs/read_write.c:746 [inline]
>   __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
>   x64_sys_call+0x30ab/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:2
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
    https://git.kernel.org/netdev/net/c/81c734dae203

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




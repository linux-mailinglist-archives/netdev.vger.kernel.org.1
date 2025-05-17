Return-Path: <netdev+bounces-191252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4291CABA775
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E53A033FB
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7B82BD1B;
	Sat, 17 May 2025 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsBA+yDG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B38C0E
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747444192; cv=none; b=heVW9nAU/c++X35y2EEnrPDSUCGCqh50V165HZ3utQaX8tqIArT2Ms0lD8xBAUp0ortt2ykVqEl7IdDBB2UfUG4aXbwvVnntiVmPD3m+saY6+ADo01+l/Zrmq8KcGtFuSQtuoZD6BZn3AtINbEDqxbREAVcMzA51hc0LyV33ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747444192; c=relaxed/simple;
	bh=XiQRgaxC/Fc6BkY6CZGBW0Mwhn6LHF+5gylg5mgWKTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W0/NYTlKetacwKFg0z0i3MkEDwJSXeKLBQ5NjHva7i2mbxxbU3IjSBr22F6JvlkOp4n0dMdImIVoLTYmlGGq2tC6dNwb3+8iZwIDlePyucbONBy2Ldsovwigcjmu/pPLXPpj/9Xs8m/GiCtMGlM8Fju0Z6fBNmYsCDKSEO/Ffeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsBA+yDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0D6C4CEE4;
	Sat, 17 May 2025 01:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747444191;
	bh=XiQRgaxC/Fc6BkY6CZGBW0Mwhn6LHF+5gylg5mgWKTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NsBA+yDGv6hTYQUYzHTSfDMPuHaicvo3Yca0M15SsbfoKuE4JvKhIsgeAP/dPR/lA
	 ZmBeEy1q8ZBDZhLY1h7JrL9uPpU7TSLdUe3qoqgSbXb45fVRwwGgJrive3JroyVOMR
	 ZY0MBxXeKukOEbY3pe95cjD5T5dbpNnaTxLDRtpGqKTulRWVnP30NQW9L9eoMwcG5c
	 VsPH1SS78QGfpup9jnwbNsm2/72YH05HrPQTWgcsLpowgYPFhXHQCUt1NELbsneJvk
	 53x2O5qskESCUQkwHWC6cFgUMKNicWeAnHZCyT22Sxn/slGVWGK5ZFB501jo/yrpnQ
	 +i0kwoq7SLY3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF20380AAFB;
	Sat, 17 May 2025 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mr: consolidate the ipmr_can_free_table() checks.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174744422850.4114923.1349206474716355813.git-patchwork-notify@kernel.org>
Date: Sat, 17 May 2025 01:10:28 +0000
References: <372dc261e1bf12742276e1b984fc5a071b7fc5a8.1747321903.git.pabeni@redhat.com>
In-Reply-To: <372dc261e1bf12742276e1b984fc5a071b7fc5a8.1747321903.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, y04609127@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 18:49:26 +0200 you wrote:
> Guoyu Yin reported a splat in the ipmr netns cleanup path:
> 
> WARNING: CPU: 2 PID: 14564 at net/ipv4/ipmr.c:440 ipmr_free_table net/ipv4/ipmr.c:440 [inline]
> WARNING: CPU: 2 PID: 14564 at net/ipv4/ipmr.c:440 ipmr_rules_exit+0x135/0x1c0 net/ipv4/ipmr.c:361
> Modules linked in:
> CPU: 2 UID: 0 PID: 14564 Comm: syz.4.838 Not tainted 6.14.0 #1
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:ipmr_free_table net/ipv4/ipmr.c:440 [inline]
> RIP: 0010:ipmr_rules_exit+0x135/0x1c0 net/ipv4/ipmr.c:361
> Code: ff df 48 c1 ea 03 80 3c 02 00 75 7d 48 c7 83 60 05 00 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 71 67 7f 00 e8 4c 2d 8a fd 90 <0f> 0b 90 eb 93 e8 41 2d 8a fd 0f b6 2d 80 54 ea 01 31 ff 89 ee e8
> RSP: 0018:ffff888109547c58 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888108c12dc0 RCX: ffffffff83e09868
> RDX: ffff8881022b3300 RSI: ffffffff83e098d4 RDI: 0000000000000005
> RBP: ffff888104288000 R08: 0000000000000000 R09: ffffed10211825c9
> R10: 0000000000000001 R11: ffff88801816c4a0 R12: 0000000000000001
> R13: ffff888108c13320 R14: ffff888108c12dc0 R15: fffffbfff0b74058
> FS:  00007f84f39316c0(0000) GS:ffff88811b100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f84f3930f98 CR3: 0000000113b56000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  ipmr_net_exit_batch+0x50/0x90 net/ipv4/ipmr.c:3160
>  ops_exit_list+0x10c/0x160 net/core/net_namespace.c:177
>  setup_net+0x47d/0x8e0 net/core/net_namespace.c:394
>  copy_net_ns+0x25d/0x410 net/core/net_namespace.c:516
>  create_new_namespaces+0x3f6/0xaf0 kernel/nsproxy.c:110
>  unshare_nsproxy_namespaces+0xc3/0x180 kernel/nsproxy.c:228
>  ksys_unshare+0x78d/0x9a0 kernel/fork.c:3342
>  __do_sys_unshare kernel/fork.c:3413 [inline]
>  __se_sys_unshare kernel/fork.c:3411 [inline]
>  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3411
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f84f532cc29
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f84f3931038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 00007f84f5615fa0 RCX: 00007f84f532cc29
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000400
> RBP: 00007f84f53fba18 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f84f5615fa0 R15: 00007fff51c5f328
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [net] mr: consolidate the ipmr_can_free_table() checks.
    https://git.kernel.org/netdev/net/c/c46286fdd6aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




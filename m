Return-Path: <netdev+bounces-166125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4DDA34AFE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44A817544B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736E5245013;
	Thu, 13 Feb 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq1Y5lMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB39245010
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465407; cv=none; b=T+KZgrqMad6aJMOrKk0wNQNYhnkccLOyHK0DzvRCnAlsrapk9E/0ZWk9PD28EspXroGtUYoRpO7TyHCG5VLVP2hUzkgylaXze1dR97OWEzNGFHl2vgGG4JN1L75vbO2svoeP2D5DaNnb+siOdwF00/Aj/iWT3NL2bo2Sx4RnR4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465407; c=relaxed/simple;
	bh=ixFdR+K/yash9KB7TeQq0uoh+sAOJobueqiHwANq3a0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eCEj81JLWqib9e+riMcxX5vGZ0IvavrGDEGhxNNbmSyNypRsSz6/SCE7hMp5uwN6b7qRcjckOHS5+SOKZS7Co5Bd82z7eMpArmdxYJU6g3b/qaGX8Vhttg2vEB0LlPfKTf23fImLrYlDRN9gMVPBG/RDTGoQwub1PNvmrjDLtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq1Y5lMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE09AC4CED1;
	Thu, 13 Feb 2025 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465406;
	bh=ixFdR+K/yash9KB7TeQq0uoh+sAOJobueqiHwANq3a0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oq1Y5lMwnbXednxwbV1YClL1q9thVrW2X6urVaJaCpJUnLgvP/fSzJp8ln1ZdpXpn
	 DTzTfqUdgg1Ib8Q4QMwm4A/s6PRYoaPemjIywtdEJRfIvEf4QVaBIBk+2SFEv66urt
	 A58FCIxIDhBlPD/TnO4iv8M0tbDXI+gUGNfD/cK/CZ7vbHKce+vrg/P7h0dN88t2um
	 9zZuplzPoQ/jDgHjF9TFOOZ7Z/FEwxoGE4BB0oj+0PEFZUXBEq+FIv1FtqpcM8PwpA
	 Q40oYaSLsSSHDMo3G1VCYzHTYdDSxHdcUmXSzq73ivgoNitFEP0DfTSpBOMGF1WMcd
	 iInDGhIbQ0e4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA9380CEEF;
	Thu, 13 Feb 2025 16:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] team: better TEAM_OPTION_TYPE_STRING validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173946543582.1295234.1199639571668692011.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 16:50:35 +0000
References: <20250212134928.1541609-1-edumazet@google.com>
In-Reply-To: <20250212134928.1541609-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 13:49:28 +0000 you wrote:
> syzbot reported following splat [1]
> 
> Make sure user-provided data contains one nul byte.
> 
> [1]
>  BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:633 [inline]
>  BUG: KMSAN: uninit-value in string+0x3ec/0x5f0 lib/vsprintf.c:714
>   string_nocheck lib/vsprintf.c:633 [inline]
>   string+0x3ec/0x5f0 lib/vsprintf.c:714
>   vsnprintf+0xa5d/0x1960 lib/vsprintf.c:2843
>   __request_module+0x252/0x9f0 kernel/module/kmod.c:149
>   team_mode_get drivers/net/team/team_core.c:480 [inline]
>   team_change_mode drivers/net/team/team_core.c:607 [inline]
>   team_mode_option_set+0x437/0x970 drivers/net/team/team_core.c:1401
>   team_option_set drivers/net/team/team_core.c:375 [inline]
>   team_nl_options_set_doit+0x1339/0x1f90 drivers/net/team/team_core.c:2662
>   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>   genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
>   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2543
>   genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
>   netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>   netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1348
>   netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1892
>   sock_sendmsg_nosec net/socket.c:718 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:733
>   ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
>   __sys_sendmsg net/socket.c:2659 [inline]
>   __do_sys_sendmsg net/socket.c:2664 [inline]
>   __se_sys_sendmsg net/socket.c:2662 [inline]
>   __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
>   x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] team: better TEAM_OPTION_TYPE_STRING validation
    https://git.kernel.org/netdev/net/c/5bef3ac184b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




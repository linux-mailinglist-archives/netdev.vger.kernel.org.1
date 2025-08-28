Return-Path: <netdev+bounces-217556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA58B390CF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52ED03A79E9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD61CD215;
	Thu, 28 Aug 2025 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXSLP4a9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FC13FEE
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343402; cv=none; b=J2P5RxKnEsHZU+nieqLFOr1LEsnqzGCm91oDI/yCp1Ng68BARZtXWVJKcxmJMKKoMaKG1k6g/wrmgVKdEujnQFP/BtTL41kQwE5P+FekhMJWWxxrpc9Nil0QGg5k2LxhNT8+FIVvXiUDuzd+9wDKMP7uvjBoNm6TmwkFkEybS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343402; c=relaxed/simple;
	bh=Nr8wdygm5ZHasgbTWbKwSJrNjuVQXo8eMAOnPf9F85E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bQ8u4Qjn9mhbjBzTrKcdEB3geJZfmhqBO6mwH7Oe/pbzEz6/RktzIBxDazC1D8HWJeVa1cHZYIdjuIakR6lsO7Rz3UUpK1n4pCz8+mxY7vfz0RW1kuBglAY2XUtqfAy+PaRxlKPou/nyGq6tLLCcLsAVYVb3NB+AbXk60ZwKYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXSLP4a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A79C4CEEB;
	Thu, 28 Aug 2025 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756343400;
	bh=Nr8wdygm5ZHasgbTWbKwSJrNjuVQXo8eMAOnPf9F85E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BXSLP4a9AmfbERLs3ClyzOKoY06KJIBm5PbsgqU/0v3r3BjQPtge8XnqgPQiBVqpN
	 D8WNfI/3+JRyFoadlzsfwvaBgzCKDLX6bxNfHqRifBt1TfDaPVTWqW1eCrzEn0Q281
	 i3lvgr4J3R4Ry78pepRupQV0gqXeFo7VAmR1QRyYSzk7yjZIZwfwIXzoUFZ9CxobwV
	 gUFnQmAKp6BVXNBsGW0RH2iqff/yhp62NpQhx8ptxaw26pPV8+ht6B4uszelHQ6OYe
	 k3TaSZJKVB9hadnqQyq624eD+9ChOrHoCjcjj9TbHHLFjrP2Y5bJwVTNyQkzlBmTP/
	 TAZeYW0dKMAug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF4C383BF76;
	Thu, 28 Aug 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: rose: fix a typo in rose_clear_routes()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634340672.896460.17520772255929782483.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 01:10:06 +0000
References: <20250827172149.5359-1-edumazet@google.com>
In-Reply-To: <20250827172149.5359-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+2eb8d1719f7cfcfa6840@syzkaller.appspotmail.com, takamitz@amazon.co.jp,
 kuniyu@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 17:21:49 +0000 you wrote:
> syzbot crashed in rose_clear_routes(), after a recent patch typo.
> 
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 0 UID: 0 PID: 10591 Comm: syz.3.1856 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>  RIP: 0010:rose_clear_routes net/rose/rose_route.c:565 [inline]
>  RIP: 0010:rose_rt_ioctl+0x162/0x1250 net/rose/rose_route.c:760
>  <TASK>
>   rose_ioctl+0x3ce/0x8b0 net/rose/af_rose.c:1381
>   sock_do_ioctl+0xd9/0x300 net/socket.c:1238
>   sock_ioctl+0x576/0x790 net/socket.c:1359
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:598 [inline]
>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] net: rose: fix a typo in rose_clear_routes()
    https://git.kernel.org/netdev/net/c/1cc8a5b534e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




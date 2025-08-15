Return-Path: <netdev+bounces-213901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C11B27463
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D78A5E0973
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B777E1419A9;
	Fri, 15 Aug 2025 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q154lQ6D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1D319871;
	Fri, 15 Aug 2025 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219595; cv=none; b=iPxzVu2PhVowmadrwvSvYq1HNk0XIzl0z8zp8IaoTx/4LTr7GsKrMRjOQ2DmH71sIpmOWWaYSuC7tED4YTpdx9wMCspZAh1so4pACiQNfmz7P0QXhfmHeBmJJrJzHSqC8/lXGS9Q6r+//1yqImu0wQHOSElSg7MtdjAtmOHAEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219595; c=relaxed/simple;
	bh=HoKdVPAd3FBMKlpMOOlRVFWHJIHLx6qrRJmrY/ez2CI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n2oLmcMcma7/tNpAiq7Wjjh/kfJyI6CcubYp7DqnfGKCYCElN9+nll3D40hwOhTfU/X7B4C+rLDX+ZSEIdj1hd+xrP1mYUsAIrg2zqWJcTB3eGD39TM/Ek//p7qJK13o6CuC7JPV5hAElClMuPB3JXjiLtpnXFQSY4MJ8MXfbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q154lQ6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9A1C4CEED;
	Fri, 15 Aug 2025 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219595;
	bh=HoKdVPAd3FBMKlpMOOlRVFWHJIHLx6qrRJmrY/ez2CI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q154lQ6DnhpU4k2Kf41J/gqrR7XUzgCE1JS0CedR5Edh7g1X36A14I9WsC/B3Tc1n
	 mEIASTorSvQN3zUkBwQ5CDZ4b8U3HUcT7p/zoODVY7S1x08LyV6G9FC3bi9eHUSs6K
	 8zTfpMxP0PEWwvkV4EVNmRzaqgPhBQ8ODTjc3inPr/KEJB8bp8bOlW8mR8blCqJuPJ
	 KbliXal+omo6vL2jO8vqHKL+areSG3XOpoPIdik9NvqGidwqUq6f5z9qoirlIysrd6
	 mvPNBxu2nEauPXAlDBfY43tBmQHdo8zYCUmqKZXDa0cgO4nOzfYlY/OjzoCUHk4Ng7
	 kaKtC7sDBobeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3039D0C3E;
	Fri, 15 Aug 2025 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: bridge: fix soft lockup in
 br_multicast_query_expired()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521960625.502863.7225770030306226732.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 01:00:06 +0000
References: <20250813021054.1643649-1-wangliang74@huawei.com>
In-Reply-To: <20250813021054.1643649-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 10:10:54 +0800 you wrote:
> When set multicast_query_interval to a large value, the local variable
> 'time' in br_multicast_send_query() may overflow. If the time is smaller
> than jiffies, the timer will expire immediately, and then call mod_timer()
> again, which creates a loop and may trigger the following soft lockup
> issue.
> 
>   watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>   CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>   Call Trace:
>    <IRQ>
>    __netdev_alloc_skb+0x2e/0x3a0
>    br_ip6_multicast_alloc_query+0x212/0x1b70
>    __br_multicast_send_query+0x376/0xac0
>    br_multicast_send_query+0x299/0x510
>    br_multicast_query_expired.constprop.0+0x16d/0x1b0
>    call_timer_fn+0x3b/0x2a0
>    __run_timers+0x619/0x950
>    run_timer_softirq+0x11c/0x220
>    handle_softirqs+0x18e/0x560
>    __irq_exit_rcu+0x158/0x1a0
>    sysvec_apic_timer_interrupt+0x76/0x90
>    </IRQ>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: bridge: fix soft lockup in br_multicast_query_expired()
    https://git.kernel.org/netdev/net/c/d1547bf460ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




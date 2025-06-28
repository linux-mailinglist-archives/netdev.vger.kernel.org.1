Return-Path: <netdev+bounces-202158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F86AEC673
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 11:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F3D1BC005F
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B593221F05;
	Sat, 28 Jun 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNHt6feo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F531EF39F
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751104181; cv=none; b=VH67C9fU7xqRfgzaEAW1TGVlhfC5Nha1nXGbwvpOL/ZNMHs/U67N6PXrS92/jWVC3TD67lSS+IBjW0MPKlXIVHPF6oIz2+8HsbLI11KtenqJ2PuQ5Dz/PDtN/rUhuB8TbPanSKrU49F7AywuibahCygPyVFyWggkFYzxg4rDxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751104181; c=relaxed/simple;
	bh=W9jCImTJ0gzGOltdiW9uge4Ir2GuO0+/Drxm3n9kR3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nZnRzSB4txKXsHMtggTvicUghhIxFQRQbvjhzKimQmG6QH+EOla8r4AJQjND6v3nn9V/zKu9suJ8uZk6fj1mjB15UwZ8UZL1sU3wj6XAUyfF9qgZoWvxIcnCuSHntNadNONwlDF1lb2XzmhHQbN/2sbMD6Qhqw3fcOh4GbqkS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNHt6feo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91A9C4CEEA;
	Sat, 28 Jun 2025 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751104180;
	bh=W9jCImTJ0gzGOltdiW9uge4Ir2GuO0+/Drxm3n9kR3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNHt6feoD/zGocw3LEzNnWJFc1zXm68Kwx4spWzyBrBMRyocuzmrCaBaHj15f1zyI
	 /lgQgpXoQ0hMO0kXCNFFvJAjR0XN1x7mb5s1693UMtjGlGeE8xBJuscxcsvX9QCRx7
	 xy1l4mj4bgse8dps395C/ol6kFjBCNNTLFghtWD9mYOcKFcRuprS4rWIUXL6behm99
	 unWQW8RP4gTyVX/isf7uTsjPJsC5UnsVlv5ZqiMoyyBRL3a/6UI6jwYFGxCy7wU3wm
	 ICPrYm6M6n6wFdkasSBeMYnL/8xtiKO+Tt8Q8mCxLBnZP6Xh5F3rZScxIPnPsk/5Gl
	 JdXAw6pPT16cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF3A38111CE;
	Sat, 28 Jun 2025 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ipv4: guard ip_mr_output() with rcu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175110420652.2189604.6501161970436026959.git-patchwork-notify@kernel.org>
Date: Sat, 28 Jun 2025 09:50:06 +0000
References: <20250627114641.3734397-1-edumazet@google.com>
In-Reply-To: <20250627114641.3734397-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com, petrm@nvidia.com,
 roopa@nvidia.com, razor@blackwall.org, bpoirier@nvidia.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 27 Jun 2025 11:46:41 +0000 you wrote:
> syzbot found at least one path leads to an ip_mr_output()
> without RCU being held.
> 
> Add guard(rcu)() to fix this in a concise way.
> 
> WARNING: CPU: 0 PID: 0 at net/ipv4/ipmr.c:2302 ip_mr_output+0xbb1/0xe70 net/ipv4/ipmr.c:2302
> Call Trace:
>  <IRQ>
>   igmp_send_report+0x89e/0xdb0 net/ipv4/igmp.c:799
>  igmp_timer_expire+0x204/0x510 net/ipv4/igmp.c:-1
>   call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>   expire_timers kernel/time/timer.c:1798 [inline]
>   __run_timers kernel/time/timer.c:2372 [inline]
>   __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
>   run_timer_base kernel/time/timer.c:2393 [inline]
>   run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
>   handle_softirqs+0x286/0x870 kernel/softirq.c:579
>   __do_softirq kernel/softirq.c:613 [inline]
>   invoke_softirq kernel/softirq.c:453 [inline]
>   __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
>   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
> 
> [...]

Here is the summary with links:
  - [net-next] net: ipv4: guard ip_mr_output() with rcu
    https://git.kernel.org/netdev/net-next/c/beead7eea896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




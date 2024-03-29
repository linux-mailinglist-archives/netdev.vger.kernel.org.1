Return-Path: <netdev+bounces-83442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBF892452
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029721C226B6
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AD013B7A0;
	Fri, 29 Mar 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GISlnzX4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9D13A86C
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740633; cv=none; b=iyTBQ+V37eEcIy9aN2ghR6LPdPYZ2QoFAxcfsi3NrBR5/q8avEvranL1/iELCPHxTnaNRk7sNh0e2F1ZUhKo8ZqejUm44lP7d+zouLD/IuiZdh1ZxaNuMCd1uptAz3Z8JL1miW9YtBrZIur723eI1MbC4/4Q27fTDkaGr6J8bGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740633; c=relaxed/simple;
	bh=PAlduHF3Km5SgUEsC4ADkK2lgC54Y2AIhKpwrYsW3cA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=US3/QQLEORVZx8Dk/S/AZd+zpJVrpH0THVFFc6eMoi5WqERJPrTtYf1DrawcpDKCKvHHEbXabNxiiE2dBdRXmgt/3EslyituRIfGlRv+Kh6xLP/V3ybEZsfFeDcvlYze1sSUuO9NhS5toYC1He8NSb9dAgquyUhCGeL66bt78S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GISlnzX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DCB3C43601;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740633;
	bh=PAlduHF3Km5SgUEsC4ADkK2lgC54Y2AIhKpwrYsW3cA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GISlnzX4ziWWSAZ87Z9N7wb6Z/+nJ11uGRdjng32IFnjYLKd9i5Ge8w3v3KMpsrKp
	 F0wQwlAop1ZA/VXE3aNgd8FjjHgobrVZWiNkNASwnrpMyQ30vZuAILGRLEuX/tIy3b
	 Ipcxx6QP7hAw/+C9seRRXQLtn7yGiHdBdhlzbdJNwcY/3vijGCRgihob+q4GNtA1hA
	 XJkotICXdtiq3xpLp/e4hC4rsUdFcrmm4FNthY6WEe1ida7Xclg+tLI+3vU0yGTSpx
	 P0eF8dNN3lIS1jCwLefUyRFIk1Y882dlYGhoY3c6E+w+Q9xznKLvmavmBwOoV7k5Rm
	 Jq9U1ukKWLtpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CE6AD2D0EB;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] devlink: use kvzalloc() to allocate devlink
 instance resources
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174063324.18563.6675369360892435443.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:30:33 +0000
References: <20240327082128.942818-1-wenjian1@xiaomi.com>
In-Reply-To: <20240327082128.942818-1-wenjian1@xiaomi.com>
To: Jian Wen <wenjianhn@gmail.com>
Cc: jiri@mellanox.com, aleksander.lobakin@intel.com, edumazet@google.com,
 davem@davemloft.net, wenjian1@xiaomi.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Mar 2024 16:21:28 +0800 you wrote:
> During live migration of a virtual machine, the SR-IOV VF need to be
> re-registered. It may fail when the memory is badly fragmented.
> 
> The related log is as follows.
> 
> Mar  1 18:54:12  kernel: hv_netvsc 6045bdaa-c0d1-6045-bdaa-c0d16045bdaa eth0: VF slot 1 added
> ...
> Mar  1 18:54:13  kernel: kworker/0:0: page allocation failure: order:7, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
> Mar  1 18:54:13  kernel: CPU: 0 PID: 24006 Comm: kworker/0:0 Tainted: G            E     5.4...x86_64 #1
> Mar  1 18:54:13  kernel: Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> Mar  1 18:54:13  kernel: Workqueue: events work_for_cpu_fn
> Mar  1 18:54:13  kernel: Call Trace:
> Mar  1 18:54:13  kernel: dump_stack+0x8b/0xc8
> Mar  1 18:54:13  kernel: warn_alloc+0xff/0x170
> Mar  1 18:54:13  kernel: __alloc_pages_slowpath+0x92c/0xb2b
> Mar  1 18:54:13  kernel: ? get_page_from_freelist+0x1d4/0x1140
> Mar  1 18:54:13  kernel: __alloc_pages_nodemask+0x2f9/0x320
> Mar  1 18:54:13  kernel: alloc_pages_current+0x6a/0xb0
> Mar  1 18:54:13  kernel: kmalloc_order+0x1e/0x70
> Mar  1 18:54:13  kernel: kmalloc_order_trace+0x26/0xb0
> Mar  1 18:54:13  kernel: ? __switch_to_asm+0x34/0x70
> Mar  1 18:54:13  kernel: __kmalloc+0x276/0x280
> Mar  1 18:54:13  kernel: ? _raw_spin_unlock_irqrestore+0x1e/0x40
> Mar  1 18:54:13  kernel: devlink_alloc+0x29/0x110
> Mar  1 18:54:13  kernel: mlx5_devlink_alloc+0x1a/0x20 [mlx5_core]
> Mar  1 18:54:13  kernel: init_one+0x1d/0x650 [mlx5_core]
> Mar  1 18:54:13  kernel: local_pci_probe+0x46/0x90
> Mar  1 18:54:13  kernel: work_for_cpu_fn+0x1a/0x30
> Mar  1 18:54:13  kernel: process_one_work+0x16d/0x390
> Mar  1 18:54:13  kernel: worker_thread+0x1d3/0x3f0
> Mar  1 18:54:13  kernel: kthread+0x105/0x140
> Mar  1 18:54:13  kernel: ? max_active_store+0x80/0x80
> Mar  1 18:54:13  kernel: ? kthread_bind+0x20/0x20
> Mar  1 18:54:13  kernel: ret_from_fork+0x3a/0x50
> 
> [...]

Here is the summary with links:
  - [net-next,v2] devlink: use kvzalloc() to allocate devlink instance resources
    https://git.kernel.org/netdev/net-next/c/730fffce4fd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




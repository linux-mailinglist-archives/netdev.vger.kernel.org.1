Return-Path: <netdev+bounces-106296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41B0915B09
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 02:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843FB1F22707
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53B746E;
	Tue, 25 Jun 2024 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7cpPRz6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75341FA4;
	Tue, 25 Jun 2024 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719275436; cv=none; b=IFBXE2BW7M4RMGbc1nXoj65w+TScQJM0LPu5hKizWktd2rE67fXI95qiiOhE4NvRkLIKOMseCVpV1DNSFkxz6lY0/NbPLCZi7lmc2CMfTo7FPBQhwNLYbzYQ8r/3GrOgmHx6VvTzddKCJ3pKGlfRGrG6C+QMrG5pacamiCEH0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719275436; c=relaxed/simple;
	bh=bX4r/u1tK3TWorg5EsKP/C4as8lEwve1Q/KksP2YT+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ISP4nLwx38cOea1NsLvD6DXrv8dutnIx+t4hZGdxk5buhhZp4BXfGc5RtbGAXttOkjAk90Zeae11hgvcKRZWCXBn6bsnXfsTT1Ek8QVzGviuwGZNg7ZzEy3CA23DXt69ZHaMj9oJiYstTlHZ7Cg3P3kQgyHJJvtUI6d3Uhb5wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7cpPRz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53164C32786;
	Tue, 25 Jun 2024 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719275435;
	bh=bX4r/u1tK3TWorg5EsKP/C4as8lEwve1Q/KksP2YT+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g7cpPRz6z3/2RG8v+7Zo5zM8d90mqjmRubLgbXEM5pLI5e5Bnd6FjmZkAXjV2R02b
	 I/vTzlLkdQab14zc5VV2udpDhQ4ZSysJOWkw1/maluDwIwNrms7CGeicfAaLeiISg8
	 sGFiWsiuwV19p8OELdq3NIJpovH+d9v8KNgkTsLnoS/axR/WRR1mj72XygZMyMWU2y
	 AAYqP0+n+bFOCVCQEQ3bNfp3FDSnxFtmwOFCkKwZb1fsZQ69T1KKoXjywcTIXXowye
	 kgfwVEdSDxJkvgdRi4fKNF4WhGBKAPWVI/dHh76dtz/b0Wv9dweOMbLfobNScofdIl
	 8AffMqgLDaVrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3710EE01F21;
	Tue, 25 Jun 2024 00:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 net-next 00/15] locking: Introduce nested-BH locking.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171927543522.12295.9957726701377633700.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 00:30:35 +0000
References: <20240620132727.660738-1-bigeasy@linutronix.de>
In-Reply-To: <20240620132727.660738-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 bristot@kernel.org, boqun.feng@gmail.com, daniel@iogearbox.net,
 edumazet@google.com, frederic@kernel.org, mingo@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, peterz@infradead.org, tglx@linutronix.de,
 longman@redhat.com, will@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jun 2024 15:21:50 +0200 you wrote:
> Disabling bottoms halves acts as per-CPU BKL. On PREEMPT_RT code within
> local_bh_disable() section remains preemtible. As a result high prior
> tasks (or threaded interrupts) will be blocked by lower-prio task (or
> threaded interrupts) which are long running which includes softirq
> sections.
> 
> The proposed way out is to introduce explicit per-CPU locks for
> resources which are protected by local_bh_disable() and use those only
> on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT builds.
> 
> [...]

Here is the summary with links:
  - [v9,net-next,01/15] locking/local_lock: Introduce guard definition for local_lock.
    https://git.kernel.org/netdev/net-next/c/07e4fd4c0592
  - [v9,net-next,02/15] locking/local_lock: Add local nested BH locking infrastructure.
    https://git.kernel.org/netdev/net-next/c/c5bcab755822
  - [v9,net-next,03/15] net: Use __napi_alloc_frag_align() instead of open coding it.
    https://git.kernel.org/netdev/net-next/c/43d7ca2907cb
  - [v9,net-next,04/15] net: Use nested-BH locking for napi_alloc_cache.
    https://git.kernel.org/netdev/net-next/c/bdacf3e34945
  - [v9,net-next,05/15] net/tcp_sigpool: Use nested-BH locking for sigpool_scratch.
    https://git.kernel.org/netdev/net-next/c/585aa621af6c
  - [v9,net-next,06/15] net/ipv4: Use nested-BH locking for ipv4_tcp_sk.
    https://git.kernel.org/netdev/net-next/c/ebad6d033479
  - [v9,net-next,07/15] netfilter: br_netfilter: Use nested-BH locking for brnf_frag_data_storage.
    https://git.kernel.org/netdev/net-next/c/c67ef53a88db
  - [v9,net-next,08/15] net: softnet_data: Make xmit per task.
    https://git.kernel.org/netdev/net-next/c/ecefbc09e8ee
  - [v9,net-next,09/15] dev: Remove PREEMPT_RT ifdefs from backlog_lock.*().
    https://git.kernel.org/netdev/net-next/c/a8760d0d1497
  - [v9,net-next,10/15] dev: Use nested-BH locking for softnet_data.process_queue.
    https://git.kernel.org/netdev/net-next/c/b22800f9d3b1
  - [v9,net-next,11/15] lwt: Don't disable migration prio invoking BPF.
    https://git.kernel.org/netdev/net-next/c/3414adbd6a6a
  - [v9,net-next,12/15] seg6: Use nested-BH locking for seg6_bpf_srh_states.
    https://git.kernel.org/netdev/net-next/c/d1542d4ae4df
  - [v9,net-next,13/15] net: Use nested-BH locking for bpf_scratchpad.
    https://git.kernel.org/netdev/net-next/c/78f520b7bbe5
  - [v9,net-next,14/15] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
    https://git.kernel.org/netdev/net-next/c/401cb7dae813
  - [v9,net-next,15/15] net: Move per-CPU flush-lists to bpf_net_context on PREEMPT_RT.
    https://git.kernel.org/netdev/net-next/c/3f9fe37d9e16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




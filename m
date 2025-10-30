Return-Path: <netdev+bounces-234214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF77C1DEF2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDF824E4CC0
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E81F2382;
	Thu, 30 Oct 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfLt9GTf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0637A3C7;
	Thu, 30 Oct 2025 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784852; cv=none; b=iOrCn/g6uozO8uKetWpuB8umA8f6Tyh7ddaECD74wKmYT4ym1wGTAqf33wDSIlB4zOEE1ukgxbuXQ9M7osELzguoEj3it6szgxgINUkrc6YpFCOdmlRRPu0RKLQUpB8/OXbxoSaHRZdBM8wkMm9MM22VWdHWQPmKCiVPFvDVDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784852; c=relaxed/simple;
	bh=Ulrn37gOcYvuxOsxcomQBNJR6/tQNVAL6Lwj5NTM9F4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eTbfIn+ustT8ql97asWrRj6NrbUfIVzFfNkVpAGshvPgwmS9Aj7xakrn8cdmPhc1HrhEVnOAQx9WD4j0/LBnpdg/DIifAPFUbxKGK/w1/kNrya9xUuYWzZY5T74rxXOdZh5Sc6qYi8GyBOngUSaGIF1E3ELNjPDYuKCYsBdXPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfLt9GTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB364C4CEFD;
	Thu, 30 Oct 2025 00:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761784851;
	bh=Ulrn37gOcYvuxOsxcomQBNJR6/tQNVAL6Lwj5NTM9F4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OfLt9GTfgJyRWFb479pWNj8NgufLLc8eNrXmTqm3lI9uUKUcMDrVaCj4mXU5Z2ziC
	 oU952pLodNfIGU8+FjWQQUBH5HQ0yU/BSoosd2uRE1YRZj+f2BD5Vo8GcV7ahNkIKk
	 OPaHKiLgvIngvXyT+6kNms3AXpTNjfWs+t/GJ0eUnXts6XTq5ikND6oiDP+Q2JzMvj
	 v5sWzYkp0hpWIvpUBHJpGwFf/BtWlDugf1l4w+ljwvpX4DCJ1cjAzDdJQseILCMs04
	 P1+1lEYNu0/zQStRadpMNe+zAgPlCkrZdcUTTU53+xIwfJuf6MtPKP0fODu8z3lBwi
	 DBPTMCdZsvpLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C083A55EC7;
	Thu, 30 Oct 2025 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] tcp: fix receive autotune again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178482800.3264893.3137378286090520073.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:40:28 +0000
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, martineau@kernel.org, geliang@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 12:57:58 +0100 you wrote:
> Neal Cardwell found that recent kernels were having RWIN limited
> issues, even when net.ipv4.tcp_rmem[2] was set to a very big value like
> 512MB.
> 
> He suspected that tcp_stream default buffer size (64KB) was triggering
> heuristic added in ea33537d8292 ("tcp: add receive queue awareness
> in tcp_rcv_space_adjust()").
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] mptcp: fix subflow rcvbuf adjust
    https://git.kernel.org/netdev/net/c/a6f0459aadf1
  - [net,v3,2/4] trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
    https://git.kernel.org/netdev/net/c/24990d89c23d
  - [net,v3,3/4] tcp: add newval parameter to tcp_rcvbuf_grow()
    https://git.kernel.org/netdev/net/c/b1e014a1f327
  - [net,v3,4/4] tcp: fix too slow tcp_rcvbuf_grow() action
    https://git.kernel.org/netdev/net/c/aa251c84636c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




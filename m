Return-Path: <netdev+bounces-218454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B68B3C788
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DD056759E
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3391826CE07;
	Sat, 30 Aug 2025 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAGgrg/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E824BBE4
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756522216; cv=none; b=oKt/47HXax9novkUKG2HTb+gfOMe0vddyZdx957jRbA2XYThtRtRTW8NbWY5pVBnEsSJiabTF/UXb0ZjvY30iarh8/Jwg2aE87clp0L+LLHIpSgJiISSWaRPLOSAEb5l5XeiI/i7fvmd3nt23Zynxs7AEcVH0SerFo7isCYtkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756522216; c=relaxed/simple;
	bh=0wzl6n/dRDQqOJWPfad0yz99kU/uJPvNtMJdtuxgn2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bUAtWTq9PVgilWXJgxg/kAAzCb5Y6fRu+D+xW6ZUWHN1OyHpWKk5MmqKJWu9ePccYfhYxR7uHgRHYKIl9IaPbgljXvQmInUJD4/epUFOLIhf3Tc2PepBwBb6HyHmrIpQTQIQox0wc/on8WEhe+7RLWYuQhw1IdbGrIzNCGlYrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAGgrg/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7F6C4CEF0;
	Sat, 30 Aug 2025 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756522215;
	bh=0wzl6n/dRDQqOJWPfad0yz99kU/uJPvNtMJdtuxgn2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oAGgrg/AT/IBEByGWg06Tpu3qDNwyTr8y3ZqHxWJ/c3zQfqt8VZ7fX8+zZGQ2ZE1c
	 UGPj2qBrTgRO0BBKdpYLo5PD3mvxOemPOXE/A+fbdJlopoDdG88cT6t3UfVBBLUjik
	 hNvL+h6RSsZuBv+uBpyyFmbuaQ0qNveUHm2sc512OdHVtGDeXapWbErlNXKmFLH9rG
	 XqojWUUNXCYLRhezVnzqVEJOknj2U+c/ax2VQ/zws87MKw+TKYXyDqL/Igm/0aq+8Q
	 YFtkH/k56mMRuD4JDH5uL2Rg2lgmn/tLMXrsUNeGhGtNcb1omr430Wt2yzqw5NxEzF
	 IkO1APyXQX6xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBC4383BF75;
	Sat, 30 Aug 2025 02:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net: add rcu safety to dst->dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652222248.2402606.1552365680516808739.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:50:22 +0000
References: <20250828195823.3958522-1-edumazet@google.com>
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 19:58:15 +0000 you wrote:
> Followup of commit 88fe14253e18 ("net: dst: add four helpers
> to annotate data-races around dst->dev").
> 
> Use lockdep enabled helpers to convert our unsafe dst->dev
> uses one at a time.
> 
> More to come...
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net: dst: introduce dst->dev_rcu
    https://git.kernel.org/netdev/net-next/c/caedcc5b6df1
  - [net-next,2/8] ipv6: start using dst_dev_rcu()
    https://git.kernel.org/netdev/net-next/c/b775ecf1655c
  - [net-next,3/8] ipv6: use RCU in ip6_xmit()
    https://git.kernel.org/netdev/net-next/c/9085e56501d9
  - [net-next,4/8] ipv6: use RCU in ip6_output()
    https://git.kernel.org/netdev/net-next/c/11709573cc4e
  - [net-next,5/8] net: use dst_dev_rcu() in sk_setup_caps()
    https://git.kernel.org/netdev/net-next/c/99a2ace61b21
  - [net-next,6/8] tcp_metrics: use dst_dev_net_rcu()
    https://git.kernel.org/netdev/net-next/c/50c127a69cd6
  - [net-next,7/8] tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
    https://git.kernel.org/netdev/net-next/c/b62a59c18b69
  - [net-next,8/8] ipv4: start using dst_dev_rcu()
    https://git.kernel.org/netdev/net-next/c/6ad8de3cefdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




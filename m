Return-Path: <netdev+bounces-210308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFE3B12BDE
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2667A32F1
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F4288C9C;
	Sat, 26 Jul 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKuoqf1Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257C21C9E3
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555197; cv=none; b=ijyK1VUjXsY1LgIOkx365QrjPtVKTZx2hVQdkJQWov90yq7caN5/2D6AjksYd0EbHrgignzlZuX2px8ddUc/5wnKHwUWiWSfTP3doQA+77zSfUu/bWHcBURb8c6dZe/NWm2vgD0yHPWSniFa4zi+3OztFFMayk+sp51bZfBYvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555197; c=relaxed/simple;
	bh=WohlqhbdZM0Klzr2pGCJsmcoj7wI3UqeeR12+aYPqec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Etrum47qzmLwmtRivrqbWpL8Ug/kQ41q1Ktv4/76CT8mac+VtzB7X7qMIHHg+Y7QxWkjfv9qmtlkIWkU4Vso6aHyE2JnF+1fOIlwe3KFYVRpen5Em2PWMSErwGyezB1YVnovT36WNIPFt/9X481I3JbxfPlLWGQGl8GQ35j8Js4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKuoqf1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E193C4CEED;
	Sat, 26 Jul 2025 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555197;
	bh=WohlqhbdZM0Klzr2pGCJsmcoj7wI3UqeeR12+aYPqec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKuoqf1Zps9uqUsME1NKR1TpksC0xm618r8+Bl+BbVkrkaRWm+xoPiJRqoASLUGbG
	 FjSboDfSebs1+C8U4OBGpLoZFDA1sM7/d0zZjc0bYq3msL3DpZV2sjq2lMOP01XOEz
	 z1AZpu1hBYzBDrPrWst91NKn1DXE3d+D3UnhQ++RhKJQ+J0pc/zo9kFL9aDv2VfIzP
	 GEj/pmxvScrWkZ0FADMAdv8+UQ05zfnBz3yXiBHLd7q3W6sCwtxkd8YpRE979BhWcK
	 mBifoM5O8VBs1EjOqM99K3OK/9M5ZN5qXQdQ2fh/yZjgSqqLWcXkFOOQ/9sMmXhtJF
	 klkmkAqhs0m0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1CF383BF4E;
	Sat, 26 Jul 2025 18:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] ipv6: f6i->fib6_siblings and rt->fib6_nsiblings
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355521476.3664802.1600999957050258134.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 18:40:14 +0000
References: <20250725140725.3626540-1-edumazet@google.com>
In-Reply-To: <20250725140725.3626540-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 14:07:21 +0000 you wrote:
> Series based on an internal syzbot report with a repro.
> 
> After fixing (in the first patch) the original minor issue,
> I found that syzbot repro was able to trigger a second
> more serious bug in rt6_nlmsg_size().
> 
> Code review then led to the two final patches.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ipv6: add a retry logic in net6_rt_notify()
    https://git.kernel.org/netdev/net/c/ea2f921db7a4
  - [net,2/4] ipv6: prevent infinite loop in rt6_nlmsg_size()
    https://git.kernel.org/netdev/net/c/54e6fe9dd3b0
  - [net,3/4] ipv6: fix possible infinite loop in fib6_info_uses_dev()
    https://git.kernel.org/netdev/net/c/f8d8ce1b515a
  - [net,4/4] ipv6: annotate data-races around rt->fib6_nsiblings
    https://git.kernel.org/netdev/net/c/31d7d67ba127

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




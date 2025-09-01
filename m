Return-Path: <netdev+bounces-218899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD287B3EFAA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C867A277D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2826E6F7;
	Mon,  1 Sep 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZsVS90W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A7269B1C
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758605; cv=none; b=dE4cy6beeHKgjahnhMSq1xsZY7XviEeDB3qUIoizDI6y82ilXjDCxwiF01WwvR3+zWWGMCqA/LDL9rRo+VQ66KBKZmuDlCPoewyrW7uxBkQ8g5v24W5uvWbjBS8enUKNkamb2dgOzO5ZFrZxjo/fpvEB5wIAzlB26smbJd9QqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758605; c=relaxed/simple;
	bh=gC50AQnblGHrosXwFFRvF7PoHUvBbyXQy8nN3YZ+pz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZKLm0wzFi7riijMas0Id4aVh+aLSCD+gkrHEuZH8l5So/s4SbZD4NAdCrpogy1vA7v7WrudyL+uuc+FSdBk2h6HfGqbRDWVCFZ2jPTmdtZz06L57Fe0K80FEwrJ4RMlt23cN5l/COpX/1inUs8tboXXEtHQnu9rnLT0jC4njito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZsVS90W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819B6C4CEF7;
	Mon,  1 Sep 2025 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758605;
	bh=gC50AQnblGHrosXwFFRvF7PoHUvBbyXQy8nN3YZ+pz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AZsVS90WYitUmTxot+VmnMD6XnnRUZXqgvsdFzDJAe9slyASXPEEHigz4ylNopmKm
	 T+JepsSU49+cyz0+Wnz+/Qowl8uKEpXCBxA2SOTKnID1HnNtftwz+yn2Zkkxeg3R1m
	 SMJH/QoAFr5hWsRf4/4O7G21vERzqUUlDEYR1jPP9yNImRgEWNMfEIyHkblHiRJbDE
	 o11HDcfmW5OrJgGJ5W1CfSCqkcvhOT9ykKC82dyVfAvLsn8FQkKYTeBhZbSulyynaq
	 3IA3FIr/LVjvyrbOa6RjxZa+b7/Ke0q9x+9MNZvNSqBb8qbfzahsbv5qbxFm5Io825
	 XbITM8T0maAxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717AE383BF4E;
	Mon,  1 Sep 2025 20:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/4] inet: ping: misc changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675861129.3875131.12167630134349327525.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:30:11 +0000
References: <20250829153054.474201-1-edumazet@google.com>
In-Reply-To: <20250829153054.474201-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 15:30:50 +0000 you wrote:
> First and third patches improve security a bit.
> 
> Second patch (ping_hash removal) is a cleanup.
> 
> Fourth patch uses EXPORT_IPV6_MOD[_GPL].
> 
> Eric Dumazet (4):
>   inet: ping: check sock_net() in ping_get_port() and ping_lookup()
>   inet: ping: remove ping_hash()
>   inet: ping: make ping_port_rover per netns
>   inet: ping: use EXPORT_IPV6_MOD[_GPL]()
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/4] inet: ping: check sock_net() in ping_get_port() and ping_lookup()
    https://git.kernel.org/netdev/net-next/c/59f26d86b2a1
  - [v3,net-next,2/4] inet: ping: remove ping_hash()
    https://git.kernel.org/netdev/net-next/c/10343e7e6c7c
  - [v3,net-next,3/4] inet: ping: make ping_port_rover per netns
    https://git.kernel.org/netdev/net-next/c/689adb36bd43
  - [v3,net-next,4/4] inet: ping: use EXPORT_IPV6_MOD[_GPL]()
    https://git.kernel.org/netdev/net-next/c/51ba2d26bcc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




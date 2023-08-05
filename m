Return-Path: <netdev+bounces-24613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99C770D11
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9841C21491
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918EB7E2;
	Sat,  5 Aug 2023 01:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044815A6
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4063C433CA;
	Sat,  5 Aug 2023 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691199023;
	bh=xkmlFyLu+gM1BHG8O1AQtE0w3BadX3zTd71fiqb+EKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OTbCu4ifs8zCJhnrVhggsHSeKojAJXi0BZk+e8X+vfEnBe+x2eDQGP3uAn+FDMGZH
	 TVAsqr8SgoNyIy5t0KFKbLAlT7DXuDEPjNBi3vBz9CfFFS3u1FY2nyzGz2LJ5ymQxG
	 vogQRgYkeWBZQeWF+WQYjonl7MhnZpAJBWK2xZkKUL0gZuYV7v4AzSUxeTmXmfGVlu
	 9eaL6hCF2ca5WL38rTIu0Dwf1q0iKwbzc/4b/1mej8rqC6B9zNXmq3ocVChazPfVID
	 2euBKEpDY4oiw9gokcptjdw353s+KPWWq45lsQhQ0S7xvhlWq8mU/9ZuaK2PGwDfpM
	 0MO019lICYOfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB012C691EF;
	Sat,  5 Aug 2023 01:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] tunnels: fix ipv4 pmtu icmp checksum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169119902376.19124.18286495343920944401.git-patchwork-notify@kernel.org>
Date: Sat, 05 Aug 2023 01:30:23 +0000
References: <20230803152653.29535-1-fw@strlen.de>
In-Reply-To: <20230803152653.29535-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, sbrivio@redhat.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 17:26:48 +0200 you wrote:
> The checksum of the generated ipv4 icmp pmtud message is
> only correct if the skb that causes the icmp error generation
> is linear.
> 
> Fix this and add a selftest for this.
> 
> Florian Westphal (2):
>   tunnels: fix kasan splat when generating ipv4 pmtu error
>   selftests: net: test vxlan pmtu exceptions with tcp
> 
> [...]

Here is the summary with links:
  - [net,1/2] tunnels: fix kasan splat when generating ipv4 pmtu error
    https://git.kernel.org/netdev/net/c/6a7ac3d20593
  - [net,2/2] selftests: net: test vxlan pmtu exceptions with tcp
    https://git.kernel.org/netdev/net/c/136a1b434bbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




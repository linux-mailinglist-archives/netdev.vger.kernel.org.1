Return-Path: <netdev+bounces-163736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC8A2B725
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2904F166D3C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB004C96;
	Fri,  7 Feb 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV9cCPdx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B317BBF
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738888207; cv=none; b=VIDMb8Iyo72VOImokvygD+fJVBNMIWladKoBMAcRe7ve2fsi5IHVBbctKFVAqbQB7VTXtFA0PtxVtwpG8m89uaBF9ifdB11BYyWSNhR1zLifA1aXmfu0zVQP5RPCptKopDLef+mMyVxiuYOfWM4qBeQP1l6ur2jT0lKulHSFGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738888207; c=relaxed/simple;
	bh=27Hz3Zqc8eZHNYOFmKfylrTG2jNQBzb4vz02JC+hk94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UsJKcKjw3FKb6LNEz/sHGq70nhdGIxpxW43NDaC7PjOhqRK9PCprXBw1nQTHtbNfRDyTpGabAmsM5yaCtsRqSkkk8I6hrWZ6SImvLATpC1FWkvwZghKUe6Qtpc1IHIRpdzxPTaEPuz6gatZkmcyAAtvGh2vdx2V+XZegCszfKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV9cCPdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B93C4CEDD;
	Fri,  7 Feb 2025 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738888207;
	bh=27Hz3Zqc8eZHNYOFmKfylrTG2jNQBzb4vz02JC+hk94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CV9cCPdxYKvHle3fEkM6JwE/19H65TAJsY37Hk5EVRSeNURCmG3allcXxMlqAl1+C
	 Qkm0xlyCvrRhgCPvAZFwvIX8RDw81lRqJSgOOAwml/UhrT9hBzcZwzLrR8qBUrMsE+
	 X88dQZz83/FFgXiOrpiPznZ9l/NHT8VKT6T5vmB5anDo8p8ATRlFmhINRT2l27Bj/J
	 a5RiUy6EtEESyE0z/SF8pfu5mG2M2xRHoXEzbAYP7FDwewJ5bnKBU9Y/Tj6xUNYb5O
	 SzS3si9tfpKJi+cRFDMR7uN94F54Jm4HaIUHU3P3mS3jGaG3Jtdc7orS0ZcNIyRHC6
	 Sa5a+LqzIRApA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B58380AAE8;
	Fri,  7 Feb 2025 00:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net 00/12] net: first round to use dev_net_rcu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173888823503.1713650.11309572430849516645.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 00:30:35 +0000
References: <20250205155120.1676781-1-edumazet@google.com>
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kuniyu@amazon.com, horms@kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Feb 2025 15:51:08 +0000 you wrote:
> dev_net(dev) should either be protected by RTNL or RCU.
> 
> There is no LOCKDEP support yet for this helper.
> 
> Adding it would trigger too many splats.
> 
> Instead, add dev_net_rcu() for rcu_read_lock() contexts
> and start to use it to fix bugs and clearly document the
> safety requirements.
> 
> [...]

Here is the summary with links:
  - [v4,net,01/12] net: add dev_net_rcu() helper
    https://git.kernel.org/netdev/net/c/482ad2a4ace2
  - [v4,net,02/12] ipv4: add RCU protection to ip4_dst_hoplimit()
    https://git.kernel.org/netdev/net/c/469308552ca4
  - [v4,net,03/12] ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
    https://git.kernel.org/netdev/net/c/071d8012869b
  - [v4,net,04/12] ipv4: use RCU protection in ipv4_default_advmss()
    https://git.kernel.org/netdev/net/c/71b8471c93fa
  - [v4,net,05/12] ipv4: use RCU protection in rt_is_expired()
    https://git.kernel.org/netdev/net/c/dd205fcc33d9
  - [v4,net,06/12] ipv4: use RCU protection in inet_select_addr()
    https://git.kernel.org/netdev/net/c/719817cd293e
  - [v4,net,07/12] ipv4: use RCU protection in __ip_rt_update_pmtu()
    https://git.kernel.org/netdev/net/c/139512191bd0
  - [v4,net,08/12] ipv4: icmp: convert to dev_net_rcu()
    https://git.kernel.org/netdev/net/c/4b8474a0951e
  - [v4,net,09/12] flow_dissector: use RCU protection to fetch dev_net()
    https://git.kernel.org/netdev/net/c/afec62cd0a41
  - [v4,net,10/12] ipv6: use RCU protection in ip6_default_advmss()
    https://git.kernel.org/netdev/net/c/3c8ffcd248da
  - [v4,net,11/12] ipv6: icmp: convert to dev_net_rcu()
    https://git.kernel.org/netdev/net/c/34aef2b0ce3a
  - [v4,net,12/12] ipv6: Use RCU in ip6_input()
    https://git.kernel.org/netdev/net/c/b768294d449d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




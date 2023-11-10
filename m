Return-Path: <netdev+bounces-47078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D12F7E7B91
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE14E1C20A4D
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD518134C0;
	Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXuhptmI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A90525C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43AB1C433C9;
	Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699614024;
	bh=LcrvrLyGui4XnjP+0yJXYxqfPfvOw2CwHS4zGFcgBAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXuhptmICXy8mrx0lZ8QfcqAc0fnpppeAJFeLgcm6VpwRlBc6SVJdzE8Wyb9poNZY
	 9SYCFev/iTW8vSOXQlWgjF2BJNiBtTEKUOzDCwIIcWaEZCBpWuUMhXRxG/eX6LNDOR
	 2KqIsE4rs6MsabWuXDRAxiPjclygsu0clUgBrXOUzUswFZ1naNlA1h3ne4ERZqLpda
	 YBaFrVtNnsBV0EJyhv+23mhrHURG6Vgdo9U8mLtELgjxPJTSbfcsaoE1elsOg1XM2q
	 G1N8nwS7FAY6y/EQ6nFAB8Qsrxpl5ETam15NACcqFqfy3iKtvGmWe4/MJ8G0Wf1s92
	 nwLPHjV3g6AHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2227EE00084;
	Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipvlan: add ipvlan_route_v6_outbound() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169961402413.16509.14964071732962964958.git-patchwork-notify@kernel.org>
Date: Fri, 10 Nov 2023 11:00:24 +0000
References: <20231109152241.3754521-1-edumazet@google.com>
In-Reply-To: <20231109152241.3754521-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 maheshb@google.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  9 Nov 2023 15:22:41 +0000 you wrote:
> Inspired by syzbot reports using a stack of multiple ipvlan devices.
> 
> Reduce stack size needed in ipvlan_process_v6_outbound() by moving
> the flowi6 struct used for the route lookup in an non inlined
> helper. ipvlan_route_v6_outbound() needs 120 bytes on the stack,
> immediately reclaimed.
> 
> [...]

Here is the summary with links:
  - [net] ipvlan: add ipvlan_route_v6_outbound() helper
    https://git.kernel.org/netdev/net/c/18f039428c7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




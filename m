Return-Path: <netdev+bounces-40835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF27C8C0D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 19:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A20BB20AC3
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32321A0B;
	Fri, 13 Oct 2023 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrhBJOQj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D164219FA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E92A7C43391;
	Fri, 13 Oct 2023 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697217025;
	bh=dagiXg5NlELfXrma+IxndYbcVHMWt12hiS4t2asa7IM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rrhBJOQjTa/jUlGGbdYiaf+QpaD2XY7C0q/K1AUotZ7n8P/hnO8sgv3WLYjLB9IDq
	 +GjbX51PJZiAeLUVU7Dq2ezGuy50bSjm3KXxZGRuqDwoHCDKRG5kziiTzV/AtVqHre
	 NJ8FuxoPYrFQ92zqlHsIYK5CmBApePRdAuV8VDgm7q1i3YdNd27K9wkireHsdZTQst
	 L4q9OXkOiE1S4mQ+PGDM3zvZvEAi8OLHsedVcukQC73t+WrgWnj6g072YmLjclHUtO
	 5Bxsbv8bUda4ieKH9m6RQS13X6zeIWpPieqb/cSiN2RWx+m/UybBl8YVJbxa/n9Iqd
	 GRWtwReFpnJOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2D7DC691EF;
	Fri, 13 Oct 2023 17:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after
 fragment check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169721702485.23617.18347714758647817581.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 17:10:24 +0000
References: <20231011015137.27262-1-heng.guo@windriver.com>
In-Reply-To: <20231011015137.27262-1-heng.guo@windriver.com>
To: Heng Guo <heng.guo@windriver.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 filip.pudak@windriver.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 09:51:37 +0800 you wrote:
> Reproduce environment:
> network with 3 VM linuxs is connected as below:
> VM1<---->VM2(latest kernel 6.5.0-rc7)<---->VM3
> VM1: eth0 ip: 192.168.122.207 MTU 1800
> VM2: eth0 ip: 192.168.122.208, eth1 ip: 192.168.123.224 MTU 1500
> VM3: eth0 ip: 192.168.123.240 MTU 1800
> 
> [...]

Here is the summary with links:
  - net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment check
    https://git.kernel.org/netdev/net-next/c/cf8b49fbd041

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-107499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCFF91B330
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FF71F23CCF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D98196;
	Fri, 28 Jun 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiDnM8FG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AB191;
	Fri, 28 Jun 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533429; cv=none; b=HQf6+yu9iDSJqwvi03QHdsR5kEMtmTcd2V8T4SHXknkI4ZLV8QkqPRysCC0lV3XeUz/Wsq6SRFDwBnRikU2D8CqHEM2EBx3eTe/qoFKzWVDZ5F5kQ+bpk8LN2TjQjSIEinzkIFYBeRRpJSD7Fg9NubOHbD7IZDZkVj3rUkbrv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533429; c=relaxed/simple;
	bh=3GHMMp2TTP4bxQLBDw4fiztif1SW1cL0IEHns4AvqOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t8S8AXcI4Xcx1cWe575kKxEDsuX664Xk4vGsgdqHiPf5a1JrNiv6tAB5B51a0VjsSDuaWW1DJuUbbbkrs4vOwdUgicYwNTuhRmxgGizoSvEhgYuakqiZzS/UF0t+IUOWsaaI80PEgp7EDJNo40Lub9qEBE11RsykuUgdiOk9LKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiDnM8FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27EBBC32789;
	Fri, 28 Jun 2024 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719533429;
	bh=3GHMMp2TTP4bxQLBDw4fiztif1SW1cL0IEHns4AvqOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RiDnM8FG2yKnOg3/0pOpMBb/HS8t1Wc685A2zYiXT3EpV6fJfincqYrnGSwkZpUOh
	 0Bd19t2K0iJO4etdEmLJrMIguWmPfSxM1FJRMhzmOu3iK0UHZPvODQpKlB/sofaITu
	 R1WYocvzroD5OHS3veoNFG7xVMcHcQ3egPC9UO+b4tpnIi5YT7KWY2o41Pghl4EEhQ
	 3HL+G6UGXNevV5kMnU50YaB9R9PvZFs4VVJ66Q80stjRvv+yikYvYB9TmmDaaZnbtB
	 QZJlV7wtzGO8MppSSzfMCODV5I52hcKutxCnTmCZtPhDPCwwGPqKRCaJCMG6RKCjMN
	 6IqW3CItcxokg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14981C43336;
	Fri, 28 Jun 2024 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: thunderx: Unembed netdev structure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171953342907.1107.6780824030224917954.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 00:10:29 +0000
References: <20240626173503.87636-1-leitao@debian.org>
In-Reply-To: <20240626173503.87636-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, sgoutham@marvell.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jun 2024 10:35:02 -0700 you wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_devices from struct lmac by converting them
> into pointers, and allocating them dynamically. Use the leverage
> alloc_netdev() to allocate the net_device object at
> bgx_lmac_enable().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: thunderx: Unembed netdev structure
    https://git.kernel.org/netdev/net-next/c/94833addfaba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




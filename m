Return-Path: <netdev+bounces-208285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1653B0ACFF
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9731C42671
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6ED1A285;
	Sat, 19 Jul 2025 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksU7wsfo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC428F1
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752885586; cv=none; b=AK0kMj74e0ebMOK7VankVj0jo4nNub+UZZ5XaUdiFeZC1nfif0WJng4OUuoMEF8x+QgJafE3k/X9jlLjvHPyqzI1hlyxftoYX9byWfGTCtCMjy0PaJSz76AGcyz2MniNZ1BEx6/0V3vJDf9W9ZQrujQuoYFUnxcHDr1RuGO4r5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752885586; c=relaxed/simple;
	bh=IYr/OiE3qZ9209GwaxM29IVUUvVSG8SEr/tnkiTD7Ps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PT7WANMeoAbXDo/FpcBTkxuKQxf1bFJ+OgAxOqC4KIUsA3Spw7gXHzoM5vFcRYYj8hJI0DzMdpKV7zPE0yNKSKGWOfITaT26wmUfhmtf5vKVPDPzT7nMg26UclssluQnIIkzluTUsTBaZB+N30MIfplQxXtJEoC8ZcqGyy8RXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksU7wsfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E818C4CEEB;
	Sat, 19 Jul 2025 00:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752885586;
	bh=IYr/OiE3qZ9209GwaxM29IVUUvVSG8SEr/tnkiTD7Ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ksU7wsfoN/OgFSlGkJaQbp4LQ3kbQ9SRr/EBEPenQueccU8SkMuA7JDb+BJBksTe6
	 pL2pOy2UdrimNXl1bt2zy2XJDDXggPRkptUD9StIHCwZg8YsrlBsiWD7crkl8e0uO8
	 nxOPBgZsJ+EqHqnKnBiMDAIfs7t1mOGo+YtnX3Lcj1f9gL9VUBdHEsB9DlwQBYN9br
	 x/ChdMLgDlUSENoCbkvW6F6PpCsnjkTtrhAmCrGtIOdA+TK50F0tkQWHpS/IX5h1ux
	 mqhUmEuzZhjO5f/4iny4KmcWJBc5kD8iuX4se2Nt/o+N3dGp771AulwWX1bEKotF6z
	 Kj98JzmbS6fhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C97383BA3C;
	Sat, 19 Jul 2025 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: rtnetlink: Add operational state test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288560626.2837850.17886066144063000523.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:40:06 +0000
References: <20250717125151.466882-1-idosch@nvidia.com>
In-Reply-To: <20250717125151.466882-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 15:51:51 +0300 you wrote:
> Virtual devices (e.g., VXLAN) that do not have a notion of a carrier are
> created with an "UNKNOWN" operational state which some users find
> confusing [1].
> 
> It is possible to set the operational state from user space either
> during device creation or afterwards and some applications will start
> doing that in order to avoid the above problem.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: rtnetlink: Add operational state test
    https://git.kernel.org/netdev/net-next/c/25250f40e2a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-44041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E147D5EB3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D211C20CDE
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929644499;
	Tue, 24 Oct 2023 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/YFz+6X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB932D633
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F2CBC433CA;
	Tue, 24 Oct 2023 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698190223;
	bh=nPcebSjON7KZOPqOoSwka0C7L9a918lmKOHNb+aeH6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b/YFz+6XRZcBn7gGZ7+YLcbAidJA2RGcBpAFQ92RN+1e7QNdNH/zKO8ixhTI1HGgo
	 y+MV7CIT2Z1KFHITWhmSNXCZOmGY00B7h24f+hzNXbFuu3elisR/t0nCHQCFnW1Pt2
	 96ff/xjRFd9DM2Mmu5ZM/U72ZQBdltHV+/JD025wq39DxwOjZMNGf5D9MXMCKTe+eL
	 CxsvS6FC00xfMTwHgDIE3lnvA03VA4s/PGS7L0Lx9zQSxLMhtRcrJLBzoFja6rINR7
	 F9nyANPaMQe0ubxddvDOFmd7Q3tqynz1f/zgSLAGaIes/H/U6S9th4UY9s40T449ng
	 j8fMvnr10FgyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79E03C00446;
	Tue, 24 Oct 2023 23:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: ethernet: renesas: infrastructure
 preparations for upcoming driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169819022349.2903.16516627106945058864.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 23:30:23 +0000
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, niklas.soderlund@ragnatech.se,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 22 Oct 2023 22:53:14 +0200 you wrote:
> Before we upstream a new driver, Niklas and I thought that a few
> cleanups for Kconfig/Makefile will help readability and maintainability.
> Here they are, looking forward to comments.
> 
> 
> Wolfram Sang (2):
>   net: ethernet: renesas: group entries in Makefile
>   net: ethernet: renesas: drop SoC names in Kconfig
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: ethernet: renesas: group entries in Makefile
    https://git.kernel.org/netdev/net-next/c/de0ad34b56de
  - [net-next,2/2] net: ethernet: renesas: drop SoC names in Kconfig
    https://git.kernel.org/netdev/net-next/c/2fc75e370e1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




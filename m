Return-Path: <netdev+bounces-47606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7A7EA9F6
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D569A280D98
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038E3BE5E;
	Tue, 14 Nov 2023 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPzJ3I3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C5BE5B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4545AC433C7;
	Tue, 14 Nov 2023 05:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699938625;
	bh=kl87Qa43XrJVIA6SL4m5M4POINliuSrCNB/IdAlIdWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PPzJ3I3q1sWetn+HLI5e73Qg9cqUFbZ/hKAyqJQ9kyis0HzSqiqGvOgLasy1pu0at
	 EUSzIJ43At+eduuYD2LI3aMyowGfXMr+ps60XX2de2e7q5QiYtSY5UrxCq0K/0MJ5+
	 Sl5LVfBPx9Vu8itQiM1aCL6L8n8S4hNqX9Ri6bsZw6b/845tlg2/1ydhO0P/CmpBfg
	 cafbeBgPQvEqelo/z9336Mte943gSJ1OyLCWsKV49fojeZjOifLt+bHIPRO9Ol1gLI
	 MMbHBRsXXSQzlPNVT3avfeb3T+GrGc+Je72d1ujeXT887KZdkD9M34068UhmNCPVHv
	 gyhWzO9B5hRgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B652E1F674;
	Tue, 14 Nov 2023 05:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] r8169: fix DASH devices network lost issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169993862517.6042.11181056876450979289.git-patchwork-notify@kernel.org>
Date: Tue, 14 Nov 2023 05:10:25 +0000
References: <20231109173400.4573-1-hau@realtek.com>
In-Reply-To: <20231109173400.4573-1-hau@realtek.com>
To: ChunHao Lin <hau@realtek.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Nov 2023 01:33:58 +0800 you wrote:
> This series are used to fix network lost issue on systems that support
> DASH. It has been tested on rtl8168ep and rtl8168fp.
> 
> 
> V3 -> V4: Fix a coding style issue.
> V2 -> V3: Add 'Fixes' tag and correct indentation.
> V1 -> V2: Change variable and function name. And update DASH info message.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] r8169: add handling DASH when DASH is disabled
    https://git.kernel.org/netdev/net/c/0ab0c45d8aae
  - [net,v4,2/2] r8169: fix network lost after resume on DASH systems
    https://git.kernel.org/netdev/net/c/868c3b95afef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-28984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC346781565
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDE31C20B90
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F31C2BE;
	Fri, 18 Aug 2023 22:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7C1C286
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D4D3C433CA;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397227;
	bh=dG/seTSjRPI+tu7gkUXoP3P0aPr0y1BQI3/OiexoifQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oFAtqBtCBBEKUt/gg4H7KP7Teu2NJbhIFvouo50zRvKZkee0zaqOFkUqXJGX22qfs
	 Nsvu4TLckHyA5Zc91CnTLh9qJ1nY3iTAq2Dv3ubjK3dWO0aIsCXjQXOFadpCirNr4F
	 pWWFO4RoDK8kZ60sTVduahWYc443Wqh5roW2luK67d0n1eNPI4lZweE+4ReeTEosad
	 Wv9qT9Qmj5fa2lIrcshh7KdqZsHi7039rWK4gTqNxhwwQQJ7kRyVZpMsEOes4Zt1X7
	 Y/IT4fhUHSGcri+oEIYw+21pLsTnWf6xllwMXUs2CDwUP8sm/E6Ohgf08Rni10hBHV
	 5bj1384MhNtqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79CC9E93B34;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/7] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239722749.24641.16398477164244966628.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:20:27 +0000
References: <20230816164000.190884-2-sw@simonwunderlich.de>
In-Reply-To: <20230816164000.190884-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed, 16 Aug 2023 18:39:54 +0200 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.6.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [1/7] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/2744cefe0337
  - [2/7] batman-adv: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/bbfb428a0cf6
  - [3/7] batman-adv: Avoid magic value for minimum MTU
    https://git.kernel.org/netdev/net-next/c/e4b817804579
  - [4/7] batman-adv: Check hardif MTU against runtime MTU
    https://git.kernel.org/netdev/net-next/c/112cbcb4af90
  - [5/7] batman-adv: Drop unused function batadv_gw_bandwidth_set
    https://git.kernel.org/netdev/net-next/c/950c92bbaa8f
  - [6/7] batman-adv: Keep batadv_netlink_notify_* static
    https://git.kernel.org/netdev/net-next/c/02e61f06a97e
  - [7/7] batman-adv: Drop per algo GW section class code
    https://git.kernel.org/netdev/net-next/c/6f96d46f9a1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




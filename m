Return-Path: <netdev+bounces-87597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C08A3A83
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5C9B22D63
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA260205E03;
	Sat, 13 Apr 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaNH+8dL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5970ED9
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975437; cv=none; b=bY+QFrKShOMzmdPutexwHO+BuGE84t5ZBRWfvva654LJbQ8QErCnXFed7YlPG+hH0IwaRzkHTK2GecoohO728etpREzeJXLlXqpH2523io6/2g6cWdvbKQyTdgRR2gXS3c135bGwq4zuRJEuv4CW+jUOVNJ7/0y8Y4QukFD3qNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975437; c=relaxed/simple;
	bh=hTfwSUwHNVmH1MVHG9bFDFmgRa+V9gM7yu3cxiD+X6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IKJnJ38Lzd+8bhUxyKfkAx4c/KRVxrQmVVeQ4f34xt07Q1/WZ9HZG2GMai0p1uruQ2SzceCIN+mY3nxfSDBB1zB5Q+KtrR3ca7Tj7Xj7XkgqjLKWRDogyvU6oLQ3DTMcGale58ZRWJy1Y+/Q6zqjb1K1dAmaLergMWxFmxD7S14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaNH+8dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3067BC2BBFC;
	Sat, 13 Apr 2024 02:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712975437;
	bh=hTfwSUwHNVmH1MVHG9bFDFmgRa+V9gM7yu3cxiD+X6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jaNH+8dLKL886po2i5PshOTsA79oN2aBpAzyzGL525aceZvTzysisxv53EWCBbIvv
	 g6bgLxvd+iEN+GtZM429k63S+SrEQhoE0Vhpes6THgdf+ouDlsvNVp3wOw6xYrK+cm
	 CuK2zrd7OEEVbbcs2zezglasF7/JuyOFWS4/BfBzZYvKltzfvBFqkAE5Ie2PILYkTC
	 gVVTcvaMZRgNrvbe32S1jvdKPFaWdLpybdoos/23yZOTiSwcQYzSO8tOza2UR87g4C
	 C4THcILyjrTc1u+z7IdLVj2NlH8duwRAz4pqmSO6a/6sPr+ZkginCqaVvX5BBYlwx1
	 vH4gTMRS3A57g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19651C32750;
	Sat, 13 Apr 2024 02:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] mlx5 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297543710.9083.14602018729506343830.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:30:37 +0000
References: <20240411115444.374475-1-tariqt@nvidia.com>
In-Reply-To: <20240411115444.374475-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Apr 2024 14:54:38 +0300 you wrote:
> Hi,
> 
> This patchset provides bug fixes to mlx5 core and Eth drivers.
> 
> Series generated against:
> commit fe87922cee61 ("net/mlx5: fix possible stack overflows")
> 
> [...]

Here is the summary with links:
  - [net,1/6] net/mlx5: Lag, restore buckets number to default after hash LAG deactivation
    https://git.kernel.org/netdev/net/c/37cc10da3a50
  - [net,2/6] net/mlx5: SD, Handle possible devcom ERR_PTR
    https://git.kernel.org/netdev/net/c/aa4ac90d04f4
  - [net,3/6] net/mlx5: Restore mistakenly dropped parts in register devlink flow
    https://git.kernel.org/netdev/net/c/bf729988303a
  - [net,4/6] net/mlx5e: Use channel mdev reference instead of global mdev instance for coalescing
    https://git.kernel.org/netdev/net/c/6c685bdb9e1a
  - [net,5/6] net/mlx5e: Acquire RTNL lock before RQs/SQs activation/deactivation
    https://git.kernel.org/netdev/net/c/fdce06bda7e5
  - [net,6/6] net/mlx5e: Prevent deadlock while disabling aRFS
    https://git.kernel.org/netdev/net/c/fef965764cf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




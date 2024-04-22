Return-Path: <netdev+bounces-90277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC8D8AD68B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 23:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2320F283CCE
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5141CABF;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grVRBt8x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A31CA8A
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821429; cv=none; b=FY2V23c66YSFW3mlhFmb+6MGKCQiLOAy9deSpEtkvKWo3oJfkWWoZACKpvX7feKB5dzWMkIeFMZKAYsTWrawF5se9junUe2Sfm+erlRGHblDmnjrmoDfRpt3gz8QYRQhQTNTDF5DyXoi7JzNxMgh5Hi0pHtvvBnoSi/Aac75FGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821429; c=relaxed/simple;
	bh=pu22MgmctUwNgjVo7hw9DH1dQJ51XqFmOqIDVrQ8HUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rrGnThPZXXj7H6ewDBpNmUP++AqYppAKFm8RnNCPEQqQubccx8cnf4wpS3E+GwPolVeYOavGHabPXTOYDcHd9dtmahibX7AJ46xJ7QTNfXQAIIkpT9AvoSU9nlI8aLEV56R0m5xuf3ohDk21SepF22mtpskBDcwDo0mU4hi0OA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grVRBt8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F49EC3277B;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713821429;
	bh=pu22MgmctUwNgjVo7hw9DH1dQJ51XqFmOqIDVrQ8HUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=grVRBt8xGY3/fzub3vot6YoxA9ex79bLZSy/xdQXsDZ7GkxhgjwdFL/qj3THJChKJ
	 3tDPxJKeeMTd6CAjRO/zLVe7/OJ9WgI35i++BDXH3+VXRD+ATKKUVAfI44JbJhOIsg
	 Sp5FujcDUqnV7GUyNzYUMhyVBXb+QZZdjDHL3jdwT1SAkIMMlqL5G8SLRj8hVhXpMM
	 +foIfSsa4dDkuQS8iV3AHHb6VoMYi59tiBowl90LM/oO4sjMUuWT4rWABRjIgPDnY3
	 8jVOuyFRFlRRib0WbPSJ1tIbgfwRFdyx5Azpfw1RjBcHzarYmOqTbhMceeR3L1+CV+
	 maEDPmn1v4+Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ADBCC4339F;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlx5e per-queue coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171382142903.1995.12644408505409691862.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 21:30:29 +0000
References: <20240419080445.417574-1-tariqt@nvidia.com>
In-Reply-To: <20240419080445.417574-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, dev@nalramli.com, jdamato@fastly.com,
 rrameshbabu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Apr 2024 11:04:40 +0300 you wrote:
> Hi,
> 
> This patchset adds ethtool per-queue coalescing support for the mlx5e
> driver.
> 
> The series introduce some changes needed as preparations for the final
> patch which adds the support and implements the callbacks.  Main
> changes:
> - DIM code movements into its own header file.
> - Switch to dynamic allocation of the DIM struct in the RQs/SQs.
> - Allow coalescing config change without channels reset when possible.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/mlx5e: Move DIM function declarations to en/dim.h
    https://git.kernel.org/netdev/net-next/c/7ec56914d3ac
  - [net-next,2/5] net/mlx5e: Use DIM constants for CQ period mode parameter
    https://git.kernel.org/netdev/net-next/c/eca1e8a62888
  - [net-next,3/5] net/mlx5e: Dynamically allocate DIM structure for SQs/RQs
    https://git.kernel.org/netdev/net-next/c/a5e89a3f353b
  - [net-next,4/5] net/mlx5e: Support updating coalescing configuration without resetting channels
    https://git.kernel.org/netdev/net-next/c/445a25f6e1a2
  - [net-next,5/5] net/mlx5e: Implement ethtool callbacks for supporting per-queue coalescing
    https://git.kernel.org/netdev/net-next/c/651ebaad6e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




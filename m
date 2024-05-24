Return-Path: <netdev+bounces-97959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35F8CE55F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFC51F21017
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDEB1E49E;
	Fri, 24 May 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLK7bAX2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882082D83
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553832; cv=none; b=sWCmoPajvFPYcMfxEcOb2vWILY9w510b6Tu8aWdQPq6NmT1MYu2VE8x6IS/LMm40ZZTKcAcpIoDa1tD+J64sgtsOndJjX0RlzqQVeWJrJij2XSMWtxBmYZq4oHz3PeSotYXk2weqgPm3haTC1oW+XqP6Vn0Pi3CrZy1lHqyrU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553832; c=relaxed/simple;
	bh=LztOJssQF9D7ToTAabrQsBKcYQGVUyG/70ZTfE1B0nE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=otzwBbABpSMnp+QSWPf7mSmD+3EP7pCLn0UNoepFtxZ+yJ9cDD7xmOx3e3O2daEScpIuS2fKFtwvvGI1q0QkI4rLYZb5GrjbWA6ZXLmWmLeqcIt5nAwdiItubF8ngpmScwBYn3wwexnVknP9f2yX84+mAXvrZR4+rX8dbxNWAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLK7bAX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A22AC3277B;
	Fri, 24 May 2024 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716553831;
	bh=LztOJssQF9D7ToTAabrQsBKcYQGVUyG/70ZTfE1B0nE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bLK7bAX26NZfY45aRLYMhG8JJUBGLFAg86CjeqFZTq57p935Dd31P5DQd6voR8xIU
	 hwXPccujX/ZhCMgqIym0WlEaDE51jq+lpwPCFhh/h9rCIufuhGdUxHtoMrxziFP0WU
	 tUKmAM+8LUNeBc5Q3T+7BnMImJjedSbj164ZtM34s5vEHV6eZxhnauDAL9pCCX/xFa
	 g3K73y2x5ua1FTM+oKg5dUKDCACxtj87duDnXYcf2NV2vJrN/9drQ3yanR4TRrSIv1
	 f2XQVEXbLwtBZAvTMWR6yJ7KxBmTlqQHWc0VNEb8BsnfeEaopYyHyX2Ay6/UTUSBDo
	 RLoWcaiMF4unQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 075AECF21E0;
	Fri, 24 May 2024 12:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] mlx5 fixes 24-05-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171655383102.8619.1275133748698105788.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 12:30:31 +0000
References: <20240522192659.840796-1-tariqt@nvidia.com>
In-Reply-To: <20240522192659.840796-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 May 2024 22:26:51 +0300 you wrote:
> Hi,
> 
> This patchset provides bug fixes to mlx5 core and Eth drivers.
> 
> Series generated against:
> commit 9c91c7fadb17 ("net: mana: Fix the extra HZ in mana_hwc_send_request")
> 
> [...]

Here is the summary with links:
  - [net,1/8] net/mlx5: Lag, do bond only if slaves agree on roce state
    https://git.kernel.org/netdev/net/c/51ef9305b8f4
  - [net,2/8] net/mlx5: Do not query MPIR on embedded CPU function
    https://git.kernel.org/netdev/net/c/fca3b4791850
  - [net,3/8] net/mlx5: Fix MTMP register capability offset in MCAM register
    https://git.kernel.org/netdev/net/c/1b9f86c6d532
  - [net,4/8] net/mlx5: Use mlx5_ipsec_rx_status_destroy to correctly delete status rules
    https://git.kernel.org/netdev/net/c/16d66a4fa81d
  - [net,5/8] net/mlx5e: Fix IPsec tunnel mode offload feature check
    https://git.kernel.org/netdev/net/c/9a52f6d44f45
  - [net,6/8] net/mlx5e: Do not use ptp structure for tx ts stats when not initialized
    https://git.kernel.org/netdev/net/c/f55cd31287e5
  - [net,7/8] net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting buffer exhaustion
    https://git.kernel.org/netdev/net/c/5c74195d5dd9
  - [net,8/8] net/mlx5e: Fix UDP GSO for encapsulated packets
    https://git.kernel.org/netdev/net/c/83fea49f2711

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




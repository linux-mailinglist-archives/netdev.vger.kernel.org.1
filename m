Return-Path: <netdev+bounces-78918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D417B876F54
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 06:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF5D281917
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 05:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED5208A9;
	Sat,  9 Mar 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgiCeI8M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9C36B0A
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709962233; cv=none; b=UO4B++8fDJfnbzqSzv497+xs1bCgBVtsY5wVZp3Bemir9vhkCsTZ0YE8AJb1oqXWUMZsZuw9ZkCGR+Qu9ft8GT1BbuOIYw7xgAuWnXpeqYCHrW2f5uerRjqPzedZAhndwd4SH/gpyGkU8b5SxeLxcPFO6oy1ZQsvS6lnJq6Jj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709962233; c=relaxed/simple;
	bh=zLMF7ZgsA3ufr+H/iAxS3nf9m/WR5ZnkFeXYJiQYpVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AqJtEPibySF2zRLe8tjCalr3RvU/VT5kbb7oQJTB/dQZIVcLiC2y6+qfl52jKYCmQlgAzZPabrUT3V4jEMbk/BrUscHCCDMTub/7XNi146Xplu09B5JuT2BNsCVALWku7uC97xS7HVHWGwXY4ANwQvSLEquRQgCzZre76uaASME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgiCeI8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E21BC43399;
	Sat,  9 Mar 2024 05:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709962233;
	bh=zLMF7ZgsA3ufr+H/iAxS3nf9m/WR5ZnkFeXYJiQYpVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XgiCeI8M7ft3M/Q0hGVzdoyZciD9p7g9rQ7w3Il7JQHm0zOwqMmHvGwd7bH/LvjS4
	 T80u6Zc9KO+WsQdVWh5T5x8Lj+kmEQLQUVCyJdcm9iIZGDX6HXgLwaWz4s0mbR4Wfm
	 9b2R9336ZtRgal5ajXzODqemHNdoZ38RCY5m2PtZkQeQbDJildABPMrN43+Mr+G+NA
	 Xtb+37EMhproxpp1Tpt8544O9ABge0hFQ+kp8Tnci8XBgxA9e5YhcpXBCyxZBXCE10
	 MP/caH3ax/+XbBb0F+4GbmIOawnDZtxTEtzl1hBOF4iIPw+HLeOuPslPdweG75/j8/
	 fDfO/rSA8+l2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B95BD84BBF;
	Sat,  9 Mar 2024 05:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V6 01/15] net/mlx5: Add MPIR bit in mcam_access_reg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170996223310.25117.5050920370409521746.git-patchwork-notify@kernel.org>
Date: Sat, 09 Mar 2024 05:30:33 +0000
References: <20240307084229.500776-2-saeed@kernel.org>
In-Reply-To: <20240307084229.500776-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Thu,  7 Mar 2024 00:42:15 -0800 you wrote:
> From: Tariq Toukan <tariqt@nvidia.com>
> 
> Add a cap bit in mcam_access_reg to check for MPIR support.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,V6,01/15] net/mlx5: Add MPIR bit in mcam_access_reg
    https://git.kernel.org/netdev/net-next/c/a0873a5d5425
  - [net-next,V6,02/15] net/mlx5: SD, Introduce SD lib
    https://git.kernel.org/netdev/net-next/c/75a543962ecb
  - [net-next,V6,03/15] net/mlx5: SD, Implement basic query and instantiation
    https://git.kernel.org/netdev/net-next/c/678eb448055a
  - [net-next,V6,04/15] net/mlx5: SD, Implement devcom communication and primary election
    https://git.kernel.org/netdev/net-next/c/d3d057666090
  - [net-next,V6,05/15] net/mlx5: SD, Implement steering for primary and secondaries
    https://git.kernel.org/netdev/net-next/c/f218179b78f5
  - [net-next,V6,06/15] net/mlx5: SD, Add informative prints in kernel log
    https://git.kernel.org/netdev/net-next/c/ae40550e3a8a
  - [net-next,V6,07/15] net/mlx5: SD, Add debugfs
    https://git.kernel.org/netdev/net-next/c/4375130bf527
  - [net-next,V6,08/15] net/mlx5e: Create single netdev per SD group
    https://git.kernel.org/netdev/net-next/c/381978d28317
  - [net-next,V6,09/15] net/mlx5e: Create EN core HW resources for all secondary devices
    https://git.kernel.org/netdev/net-next/c/846122b126f8
  - [net-next,V6,10/15] net/mlx5e: Let channels be SD-aware
    https://git.kernel.org/netdev/net-next/c/67936e138586
  - [net-next,V6,11/15] net/mlx5e: Support cross-vhca RSS
    https://git.kernel.org/netdev/net-next/c/40e6ad9182b4
  - [net-next,V6,12/15] net/mlx5e: Support per-mdev queue counter
    https://git.kernel.org/netdev/net-next/c/7f525acbccdf
  - [net-next,V6,13/15] net/mlx5e: Block TLS device offload on combined SD netdev
    https://git.kernel.org/netdev/net-next/c/d1a8b2c3e434
  - [net-next,V6,14/15] net/mlx5: Enable SD feature
    https://git.kernel.org/netdev/net-next/c/ed29705e4ed1
  - [net-next,V6,15/15] Documentation: networking: Add description for multi-pf netdev
    https://git.kernel.org/netdev/net-next/c/77d9ec3f6c8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




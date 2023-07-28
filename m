Return-Path: <netdev+bounces-22137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79876626F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979272825C1
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3A3D8C;
	Fri, 28 Jul 2023 03:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AD17F9
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7938EC433CD;
	Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515023;
	bh=s9O2m3S+QwNP06yArPXVr+Ps4Szjjfxchb5oRMpBRAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W9E7FrRmJma0jq8/dK8t4ry4P9eRWrY4WLBwq/IvIALR3ASmmvXS9KxcboyWWSjOx
	 xp+ZPl+uIOSyn42vJ5bYqLLyEA+vFNRWWx5dPQfjvSAkEn2na4je+zqMVLpQ1EYTWG
	 j7+zFGQKfKvRwzPuDX9HMorFSGBkWM3vk1ViKcd7Ev9rPgTknqNbrEj9wf0F7mjaCI
	 UEhFZrc89RK9jZ3TXWfFMW6ERKADH9eJlHy26K4yPTlwxm+nDiT61xy9BO4NXFbeEy
	 iUdqHc0hrEmFInLfGR86dOqlLOGo/F+q7varFb1XkMi1ZqqBPjlCihl6hn/JSNLJG6
	 2gh5m83eYBNew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D6FBC3959F;
	Fri, 28 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 01/15] net/mlx5e: fix double free in
 macsec_fs_tx_create_crypto_table_groups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051502337.18144.3385123075811330874.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:30:23 +0000
References: <20230726213206.47022-2-saeed@kernel.org>
In-Reply-To: <20230726213206.47022-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, shaozhengchao@huawei.com, simon.horman@corigine.com,
 leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed, 26 Jul 2023 14:31:52 -0700 you wrote:
> From: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> In function macsec_fs_tx_create_crypto_table_groups(), when the ft->g
> memory is successfully allocated but the 'in' memory fails to be
> allocated, the memory pointed to by ft->g is released once. And in function
> macsec_fs_tx_create(), macsec_fs_tx_destroy() is called to release the
> memory pointed to by ft->g again. This will cause double free problem.
> 
> [...]

Here is the summary with links:
  - [net,01/15] net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups
    https://git.kernel.org/netdev/net/c/aeb660171b06
  - [net,02/15] net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
    https://git.kernel.org/netdev/net/c/5dd77585dd9d
  - [net,03/15] net/mlx5: fix potential memory leak in mlx5e_init_rep_rx
    https://git.kernel.org/netdev/net/c/c6cf0b6097bf
  - [net,04/15] net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
    https://git.kernel.org/netdev/net/c/e5bcb7564d3b
  - [net,05/15] net/mlx5: Honor user input for migratable port fn attr
    https://git.kernel.org/netdev/net/c/0507f2c8be0d
  - [net,06/15] net/mlx5e: Don't hold encap tbl lock if there is no encap action
    https://git.kernel.org/netdev/net/c/93a331939d1d
  - [net,07/15] net/mlx5e: Fix crash moving to switchdev mode when ntuple offload is set
    https://git.kernel.org/netdev/net/c/3ec43c1b082a
  - [net,08/15] net/mlx5e: Move representor neigh cleanup to profile cleanup_tx
    https://git.kernel.org/netdev/net/c/d03b6e6f3182
  - [net,09/15] net/mlx5e: xsk: Fix invalid buffer access for legacy rq
    https://git.kernel.org/netdev/net/c/e0f52298fee4
  - [net,10/15] net/mlx5e: xsk: Fix crash on regular rq reactivation
    https://git.kernel.org/netdev/net/c/39646d9bcd1a
  - [net,11/15] net/mlx5: Bridge, set debugfs access right to root-only
    https://git.kernel.org/netdev/net/c/eb02b93aad95
  - [net,12/15] net/mlx5e: kTLS, Fix protection domain in use syndrome when devlink reload
    https://git.kernel.org/netdev/net/c/3e4cf1dd2ce4
  - [net,13/15] net/mlx5: fs_chains: Fix ft prio if ignore_flow_level is not supported
    https://git.kernel.org/netdev/net/c/61eab651f6e9
  - [net,14/15] net/mlx5: DR, Fix peer domain namespace setting
    https://git.kernel.org/netdev/net/c/62752c0bc67f
  - [net,15/15] net/mlx5: Unregister devlink params in case interface is down
    https://git.kernel.org/netdev/net/c/53d737dfd3d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




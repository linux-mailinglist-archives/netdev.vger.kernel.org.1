Return-Path: <netdev+bounces-57754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EEC814074
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4420EB21A95
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C05698;
	Fri, 15 Dec 2023 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcU+emHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AE568C
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAE46C433CA;
	Fri, 15 Dec 2023 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702609826;
	bh=oNIAG+5ECxDzTL9dD2IJfrvxCEGcs6jOR3Cx2HndIkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jcU+emHrTkpTH1iMYeKykeFyaX9K9I3jA9kzo4EvLZmhFTiFcx2syQttxKso5XpC4
	 J4HehZoXdiTW5d/Hq0Ny5CDKihk/U0f+y11GP95A/HK16onGcV2T1C+2JUj+xSKFNT
	 V3johBAIc5blQ10RyMzwHwlrKj3XZzV5BWXfdqooLWskEB1UaEQxYhGYATBk+t7Zuw
	 0E2RdNdGrSD46RVaGVHLJGbT0zwpkfHPpySyG9owFMOUfxwZVIhJ3/fagoYPTOg4QT
	 SvKw50ssPjM9ezXsmVeL3x8skAIOpXgSUVXvi4lQ8p/8fS69DC4pyucHNgZLQcyfrt
	 pdbmXwHnMKS+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 913DCDD4EF9;
	Fri, 15 Dec 2023 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 01/15] Revert "net/mlx5e: fix double free of encap_header in
 update funcs"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260982659.2748.4641517002710423283.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 03:10:26 +0000
References: <20231214012505.42666-2-saeed@kernel.org>
In-Reply-To: <20231214012505.42666-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, vladbu@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed, 13 Dec 2023 17:24:51 -0800 you wrote:
> From: Vlad Buslov <vladbu@nvidia.com>
> 
> This reverts commit 3a4aa3cb83563df942be49d145ee3b7ddf17d6bb.
> 
> This patch is causing a null ptr issue, the proper fix is in the next
> patch.
> 
> [...]

Here is the summary with links:
  - [net,01/15] Revert "net/mlx5e: fix double free of encap_header in update funcs"
    https://git.kernel.org/netdev/net/c/66ca8d4deca0
  - [net,02/15] Revert "net/mlx5e: fix double free of encap_header"
    https://git.kernel.org/netdev/net/c/5d089684dc43
  - [net,03/15] net/mlx5e: fix double free of encap_header
    https://git.kernel.org/netdev/net/c/8e13cd737cb4
  - [net,04/15] net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
    https://git.kernel.org/netdev/net/c/ddb38ddff9c7
  - [net,05/15] net/mlx5e: Fix a race in command alloc flow
    https://git.kernel.org/netdev/net/c/8f5100da56b3
  - [net,06/15] net/mlx5e: fix a potential double-free in fs_udp_create_groups
    https://git.kernel.org/netdev/net/c/e75efc6466ae
  - [net,07/15] net/mlx5e: Fix overrun reported by coverity
    https://git.kernel.org/netdev/net/c/da75fa542873
  - [net,08/15] net/mlx5e: Decrease num_block_tc when unblock tc offload
    https://git.kernel.org/netdev/net/c/be86106fd74a
  - [net,09/15] net/mlx5e: XDP, Drop fragmented packets larger than MTU size
    https://git.kernel.org/netdev/net/c/bcaf109f7947
  - [net,10/15] net/mlx5: Fix fw tracer first block check
    https://git.kernel.org/netdev/net/c/4261edf11cb7
  - [net,11/15] net/mlx5: Refactor mlx5_flow_destination->rep pointer to vport num
    https://git.kernel.org/netdev/net/c/04ad04e4fdd1
  - [net,12/15] net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()
    https://git.kernel.org/netdev/net/c/86d5922679f3
  - [net,13/15] net/mlx5e: Fix error codes in alloc_branch_attr()
    https://git.kernel.org/netdev/net/c/d792e5f7f19b
  - [net,14/15] net/mlx5e: Correct snprintf truncation handling for fw_version buffer
    https://git.kernel.org/netdev/net/c/ad436b9c1270
  - [net,15/15] net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors
    https://git.kernel.org/netdev/net/c/b13559b76157

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




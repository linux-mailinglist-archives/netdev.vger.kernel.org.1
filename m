Return-Path: <netdev+bounces-40934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F78C7C9207
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602721C209F1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF051112;
	Sat, 14 Oct 2023 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQPGRSUS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F461104
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB57FC433CA;
	Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697245826;
	bh=t+m63q8LCD3bWTakqKWcQMf9mBnxYup+xnSt+BSo2eU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NQPGRSUSp6aCM93MSbC30T7THVbfJ12YWObymUBGAetAXbV6PHUMlTO6FHhuU4k/T
	 XJh44S5PKwvyT3IZYj5nZj7TzqDwEMBaD3OztprI4RNq2blxaAfX9VoebGZayij/CI
	 DAxfjZ5gTL1pVhe6B8mJ5U5s8AyQuNie6DggjXGcYNfSEgw8vg88uR1N2uQX6r2CrI
	 s3MYJg7uMPNZx2HxPASJvv0OXbOOOeDBSrWH0+0TMPo9yZ4jeTUCN82sO46aikkudI
	 BBqrpphrZa5qrgpVKpovBF74m9swF6welOYBRtafJczW0EhHhapTmQYKkr+6sVrwaz
	 InyduAfXkrBXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B778E1F666;
	Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 01/10] net/mlx5: Perform DMA operations in the right locations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724582663.12217.6955533588008550906.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 01:10:26 +0000
References: <20231012195127.129585-2-saeed@kernel.org>
In-Reply-To: <20231012195127.129585-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, shayd@nvidia.com, moshe@nvidia.com, leonro@nvidia.com,
 schnelle@linux.ibm.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Thu, 12 Oct 2023 12:51:18 -0700 you wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> The cited patch change mlx5 driver so that during probe DMA
> operations were performed before pci_enable_device(), and during
> teardown DMA operations were performed after pci_disable_device().
> DMA operations require PCI to be enabled. Hence, The above leads to
> the following oops in PPC systems[1].
> 
> [...]

Here is the summary with links:
  - [net,01/10] net/mlx5: Perform DMA operations in the right locations
    https://git.kernel.org/netdev/net/c/8698cb92eeec
  - [net,02/10] net/mlx5: E-switch, register event handler before arming the event
    https://git.kernel.org/netdev/net/c/7624e58a8b3a
  - [net,03/10] net/mlx5: Bridge, fix peer entry ageing in LAG mode
    https://git.kernel.org/netdev/net/c/7a3ce8074878
  - [net,04/10] net/mlx5: Handle fw tracer change ownership event based on MTRC
    https://git.kernel.org/netdev/net/c/92fd39634541
  - [net,05/10] net/mlx5e: RX, Fix page_pool allocation failure recovery for striding rq
    https://git.kernel.org/netdev/net/c/be43b7489a3c
  - [net,06/10] net/mlx5e: RX, Fix page_pool allocation failure recovery for legacy rq
    https://git.kernel.org/netdev/net/c/ef9369e9c308
  - [net,07/10] net/mlx5e: XDP, Fix XDP_REDIRECT mpwqe page fragment leaks on shutdown
    https://git.kernel.org/netdev/net/c/aaab619ccd07
  - [net,08/10] net/mlx5e: Take RTNL lock before triggering netdev notifiers
    https://git.kernel.org/netdev/net/c/c51c673462a2
  - [net,09/10] net/mlx5e: Don't offload internal port if filter device is out device
    https://git.kernel.org/netdev/net/c/06b4eac9c4be
  - [net,10/10] net/mlx5e: Fix VF representors reporting zero counters to "ip -s" command
    https://git.kernel.org/netdev/net/c/80f1241484dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-25634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9F774F74
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DEE1C21085
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84511C9FB;
	Tue,  8 Aug 2023 23:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB731641C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54D23C433C8;
	Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691538024;
	bh=nQmOBrD84frNPGyWD2GA6HbI9IPsHy4wrd5gvZ5wjpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qI+4OSfykhP4g877pDR34Rqhqijq8qaoSdi4mOsxxRjALPp5qupE+l6CqyAdavRpo
	 VvmcIi60906l/u+b1LiOUyDzElx9Yd5ttdC0LBb/WZjNQrM5EJWYnts7TAQtoGO7eD
	 V7ublFfEeZmAg4/lUiTjTYsO6bmAUSX5rahSRQhXftgtIqF7/3dwqHTl4Ztkz+1jWB
	 POMPgvMHiXAWRQjT0WyEJpD0AACNfmLlgFpwpn7Ur49u6CEZLiIcbnIeRo3t7LmMon
	 Ni2OcxuPmiMNsGrH536mnQ9doh5i9wlqlBt2Cphjn6Lmdbl/+XyjpVYiUUP856bBn/
	 pK8hva2i27R7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33D12C64459;
	Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 01/11] net/mlx5e: Take RTNL lock when needed before calling
 xdp_set_features()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153802420.28457.8659491437285599556.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:40:24 +0000
References: <20230807212607.50883-2-saeed@kernel.org>
In-Reply-To: <20230807212607.50883-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Mon,  7 Aug 2023 14:25:57 -0700 you wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Hold RTNL lock when calling xdp_set_features() with a registered netdev,
> as the call triggers the netdev notifiers. This could happen when
> switching from uplink rep to nic profile for example.
> 
> This resolves the following call trace:
> 
> [...]

Here is the summary with links:
  - [net,01/11] net/mlx5e: Take RTNL lock when needed before calling xdp_set_features()
    https://git.kernel.org/netdev/net/c/72cc65497065
  - [net,02/11] net/mlx5e: TC, Fix internal port memory leak
    https://git.kernel.org/netdev/net/c/ac5da544a3c2
  - [net,03/11] net/mlx5: DR, Fix wrong allocation of modify hdr pattern
    https://git.kernel.org/netdev/net/c/8bfe1e19fb96
  - [net,04/11] net/mlx5: Return correct EC_VF function ID
    https://git.kernel.org/netdev/net/c/06c868fde61f
  - [net,05/11] net/mlx5: Allow 0 for total host VFs
    https://git.kernel.org/netdev/net/c/2dc2b3922d3c
  - [net,06/11] net/mlx5: Fix devlink controller number for ECVF
    https://git.kernel.org/netdev/net/c/2d691c90f45a
  - [net,07/11] net/mlx5e: Unoffload post act rule when handling FIB events
    https://git.kernel.org/netdev/net/c/6b5926eb1c03
  - [net,08/11] net/mlx5: LAG, Check correct bucket when modifying LAG
    https://git.kernel.org/netdev/net/c/86ed7b773c01
  - [net,09/11] net/mlx5: Skip clock update work when device is in error state
    https://git.kernel.org/netdev/net/c/d00620762565
  - [net,10/11] net/mlx5: Reload auxiliary devices in pci error handlers
    https://git.kernel.org/netdev/net/c/aab8e1a200b9
  - [net,11/11] net/mlx5e: Add capability check for vnic counters
    https://git.kernel.org/netdev/net/c/548ee049b19f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




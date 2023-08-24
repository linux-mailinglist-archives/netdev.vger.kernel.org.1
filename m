Return-Path: <netdev+bounces-30373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0446787087
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10001C20DB6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940A2891F;
	Thu, 24 Aug 2023 13:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CA288E8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83416C433CA;
	Thu, 24 Aug 2023 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692884426;
	bh=bqvGJZmFfdK8pXTbE4S3pBY1d/oCTP7QNa5jsagT9/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tnAXvGs+o8VxEKH7kFL6BNJF4ng17QfV6WaVkLyYaxUeJYbd0frmiYsBZ7le+sr1G
	 rOSsAuxVeFUfzcKUCWeAvoFA5sLcOEgu636qHbJPMGfXTl0gKEwpb0qd7NOdoKzpr7
	 SyCYLlYeGb6xmEFuSaz6f+rXgrT2ysdVqGsggNgzaA7YxSqvnGPws4g+gBXWXwnObG
	 yRL7ltAdpFPrmSXmqaV7uhqJN3H2n+MRlAxcRXglyS+z/zhgqzykKJXIwqY0q2NAaa
	 CO16MOo4KXNTNPRSl064h+SZHpX8FKNA5OJ/7BXpKYDzGKlkRaPoX1CVdoZNJUDjRL
	 A5HkvEt4gZs+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 671E0E33095;
	Thu, 24 Aug 2023 13:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next 01/15] net/mlx5: Rework devlink port alloc/free into
 init/cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169288442641.14572.15853901676178071093.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 13:40:26 +0000
References: <20230823051012.162483-2-saeed@kernel.org>
In-Reply-To: <20230823051012.162483-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, jiri@nvidia.com, shayd@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Tue, 22 Aug 2023 22:09:58 -0700 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In order to prepare the devlink port registration function to be common
> for PFs/VFs and SFs, change the existing devlink port allocation and
> free functions into PF/VF init and cleanup, so similar helpers could be
> later on introduced for SFs. Make the init/cleanup helpers responsible
> for setting/clearing the vport->dl_port pointer.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net/mlx5: Rework devlink port alloc/free into init/cleanup
    https://git.kernel.org/netdev/net-next/c/4c0dac1ef8ab
  - [net-next,02/15] net/mlx5: Push out SF devlink port init and cleanup code to separate helpers
    https://git.kernel.org/netdev/net-next/c/638002252544
  - [net-next,03/15] net/mlx5: Push devlink port PF/VF init/cleanup calls out of devlink_port_register/unregister()
    https://git.kernel.org/netdev/net-next/c/d9833bcfe840
  - [net-next,04/15] net/mlx5: Allow mlx5_esw_offloads_devlink_port_register() to register SFs
    https://git.kernel.org/netdev/net-next/c/382fe5747b8a
  - [net-next,05/15] net/mlx5: Introduce mlx5_eswitch_load/unload_sf_vport() and use it from SF code
    https://git.kernel.org/netdev/net-next/c/e855afd71565
  - [net-next,06/15] net/mlx5: Remove no longer used mlx5_esw_offloads_sf_vport_enable/disable()
    https://git.kernel.org/netdev/net-next/c/b940ec4b25be
  - [net-next,07/15] net/mlx5: Don't register ops for non-PF/VF/SF port and avoid checks in ops
    https://git.kernel.org/netdev/net-next/c/13f878a22c20
  - [net-next,08/15] net/mlx5: Embed struct devlink_port into driver structure
    https://git.kernel.org/netdev/net-next/c/2c5f33f6b940
  - [net-next,09/15] net/mlx5: Reduce number of vport lookups passing vport pointer instead of index
    https://git.kernel.org/netdev/net-next/c/2caa2a39116f
  - [net-next,10/15] net/mlx5: Return -EOPNOTSUPP in mlx5_devlink_port_fn_migratable_set() directly
    https://git.kernel.org/netdev/net-next/c/c0ae00929272
  - [net-next,11/15] net/mlx5: Relax mlx5_devlink_eswitch_get() return value checking
    https://git.kernel.org/netdev/net-next/c/5c632cc352e1
  - [net-next,12/15] net/mlx5: Check vhca_resource_manager capability in each op and add extack msg
    https://git.kernel.org/netdev/net-next/c/eb555e34f084
  - [net-next,13/15] net/mlx5: Store vport in struct mlx5_devlink_port and use it in port ops
    https://git.kernel.org/netdev/net-next/c/7d8335200c94
  - [net-next,14/15] net/mlx5e: Support IPsec upper protocol selector field offload for RX
    https://git.kernel.org/netdev/net-next/c/c338325f7a18
  - [net-next,15/15] net/mlx5e: Support IPsec upper TCP protocol selector
    https://git.kernel.org/netdev/net-next/c/b8c697e177bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




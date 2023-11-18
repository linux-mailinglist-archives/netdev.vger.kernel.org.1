Return-Path: <netdev+bounces-48944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895497F01B8
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A32B280EFC
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0D2199BE;
	Sat, 18 Nov 2023 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng01MV/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E11094A
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 17:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7FEFC433C9;
	Sat, 18 Nov 2023 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700329833;
	bh=BUkKpfwP3U829uXrHi0pczunyTlJuf7ZJ76p9yv1z5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ng01MV/zMOwQc9U4vi0LyVlxsrpnfwd/Yycd/0XtUVSiUfqE9lo2f+Lh7ur0qP/MF
	 sWm953nQjzV56O0ISjOYuRnP4wG2y7H7d4NcfKiu4wLBAu9aK9lc5sS9m/a8XijRwQ
	 0simuw4iu2tTRIOol8L3nGnfwk9NdTPITKNBr1aKTqWFYk3nOiOFYbYVfU3ZxCToRj
	 aZsGUq690nr2q6b6DaFDiCNJLGmWIHz/IYYdobGuTgXCEYG+ZNBMUIMZ9NQH1vL6rT
	 oUEn9yD2Y2xNMp44J2IwRaC3C81Ewhf1nG/cKZ+B+161Uybi0y/9UgcKgWuUKLIrL7
	 1ncsBSZzWsrzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC8A0EA6306;
	Sat, 18 Nov 2023 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V2 01/13] net/mlx5: print change on SW reset semaphore
 returns busy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170032983376.21361.7003048114243635000.git-patchwork-notify@kernel.org>
Date: Sat, 18 Nov 2023 17:50:33 +0000
References: <20231115193649.8756-2-saeed@kernel.org>
In-Reply-To: <20231115193649.8756-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, moshe@nvidia.com, shayd@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed, 15 Nov 2023 11:36:37 -0800 you wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> While collecting crdump as part of fw_fatal health reporter dump the PF
> may fail to lock the SW reset semaphore. Change the print to indicate if
> it was due to another PF locked the semaphore already and so trying to
> lock the semaphore returned -EBUSY.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/13] net/mlx5: print change on SW reset semaphore returns busy
    https://git.kernel.org/netdev/net-next/c/7b2bfd4ebf79
  - [net-next,V2,02/13] net/mlx5: Allow sync reset flow when BF MGT interface device is present
    https://git.kernel.org/netdev/net-next/c/cecf44ea1a1f
  - [net-next,V2,03/13] net/mlx5e: Some cleanup in mlx5e_tc_stats_matchall()
    https://git.kernel.org/netdev/net-next/c/312eb3fd6244
  - [net-next,V2,04/13] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
    https://git.kernel.org/netdev/net-next/c/0f452a862a9f
  - [net-next,V2,05/13] net/mlx5: Annotate struct mlx5_flow_handle with __counted_by
    https://git.kernel.org/netdev/net-next/c/9454e5643392
  - [net-next,V2,06/13] net/mlx5: simplify mlx5_set_driver_version string assignments
    https://git.kernel.org/netdev/net-next/c/10b49d0e7651
  - [net-next,V2,07/13] net/mlx5e: Access array with enum values instead of magic numbers
    https://git.kernel.org/netdev/net-next/c/88e928b22930
  - [net-next,V2,08/13] net/mlx5: Refactor real time clock operation checks for PHC
    https://git.kernel.org/netdev/net-next/c/330af90c4b43
  - [net-next,V2,09/13] net/mlx5: Initialize clock->ptp_info inside mlx5_init_timer_clock
    https://git.kernel.org/netdev/net-next/c/4395d9de4e21
  - [net-next,V2,10/13] net/mlx5: Convert scaled ppm values outside the s32 range for PHC frequency adjustments
    https://git.kernel.org/netdev/net-next/c/78c1b26754d9
  - [net-next,V2,11/13] net/mlx5: Query maximum frequency adjustment of the PTP hardware clock
    https://git.kernel.org/netdev/net-next/c/4aea6a6d61cd
  - [net-next,V2,12/13] net/mlx5e: Add local loopback counter to vport rep stats
    https://git.kernel.org/netdev/net-next/c/b2a62e56b173
  - [net-next,V2,13/13] net/mlx5e: Remove early assignment to netdev->features
    https://git.kernel.org/netdev/net-next/c/23ec6972865b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-134181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 832029984CD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9FFB21AB3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9661BDA9C;
	Thu, 10 Oct 2024 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIDlh302"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2E33CD2
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559237; cv=none; b=ZiyxaeQUejVAugEuICWe77B8J2evh/IwU+08ykKZrqWa67x15nt6vZJypQBd3UzzIvllUXO2LqCA0NBMDQIfDx2xp3+PthsWmyc0iBjROdBJC1SUxUu22A3HwHQIZdvQ76dzH/Z9FvrkYlUSVD+JgGUK6VzKmmywvRXCCGS0as4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559237; c=relaxed/simple;
	bh=Wfx89f/2GnLAyz2Y6WT3tqmWILb+qRc5IL/zvB6kPew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dLPA9cEe8dB9+N3hD1bfs4WRqCnVkI21Zye1HCKyE8UHwXnZkBveSLa6ondOq5bz35KyMQNT7hlVAOyMce+sxjz4kOaXx2nvTl39aapZusCReRBhzIVF3juwoW/e70s0IdWbUkXgls+J4IBkP6hfu/gWa4aMuKATfJnFVFWUHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIDlh302; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3965C4CEC5;
	Thu, 10 Oct 2024 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728559236;
	bh=Wfx89f/2GnLAyz2Y6WT3tqmWILb+qRc5IL/zvB6kPew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QIDlh302NdcCQ47qdk7RK+ZYdG68xICju7SbKOyTgyqi5NeAuHN2YK6r80Hhhp3Jh
	 kTZH4Kx6qT/LuWI0XzOOQDi+vCijNRmyKgsR50rZb1ELWq8MS3sFFO/BhbPT4ULcMi
	 g2pOorgKRuh1Z3KB7j+ogsmXL/i3cyIJky5Dinfa6Cv0zPtpDUcOPJ633atLtPMiyD
	 0az36PE4L82g07YS/MK7STXhs/Y8pbHzfC2sDL62r+a3EU8Gqb2lWfB90o7IfGCXod
	 8Z+dx3gJ7Ycn9L9q+IXvprpAMhtlTBHImit92byo74iwpO6HNqGhEt3lapB7kZODWk
	 VOxFmd1sCRxCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E5E3803263;
	Thu, 10 Oct 2024 11:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] net/mlx5: qos: Refactor esw qos to support new
 features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172855924123.1984107.8570590080883453248.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 11:20:41 +0000
References: <20241008183222.137702-1-tariqt@nvidia.com>
In-Reply-To: <20241008183222.137702-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, cjubran@nvidia.com, cratiu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 8 Oct 2024 21:32:08 +0300 you wrote:
> Hi,
> 
> This patch series by Cosmin and Carolina prepares the mlx5 qos infra for
> the upcoming feature of cross E-Switch scheduling.
> 
> Noop cleanups:
> net/mlx5: qos: Flesh out element_attributes in mlx5_ifc.h
> net/mlx5: qos: Rename vport 'tsar' into 'sched_elem'.
> net/mlx5: qos: Consistently name vport vars as 'vport'
> net/mlx5: qos: Refactor and document bw_share calculation
> net/mlx5: qos: Rename rate group 'list' as 'parent_entry'
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net/mlx5: qos: Flesh out element_attributes in mlx5_ifc.h
    https://git.kernel.org/netdev/net-next/c/016f426a14f0
  - [net-next,02/14] net/mlx5: qos: Rename vport 'tsar' into 'sched_elem'.
    https://git.kernel.org/netdev/net-next/c/158205ca4baf
  - [net-next,03/14] net/mlx5: qos: Consistently name vport vars as 'vport'
    https://git.kernel.org/netdev/net-next/c/16efefde21f5
  - [net-next,04/14] net/mlx5: qos: Refactor and document bw_share calculation
    https://git.kernel.org/netdev/net-next/c/8746eeb7f808
  - [net-next,05/14] net/mlx5: qos: Maintain rate group vport members in a list
    https://git.kernel.org/netdev/net-next/c/d3a3b0765e18
  - [net-next,06/14] net/mlx5: qos: Always create group0
    https://git.kernel.org/netdev/net-next/c/a87a561b802a
  - [net-next,07/14] net/mlx5: qos: Drop 'esw' param from vport qos functions
    https://git.kernel.org/netdev/net-next/c/e9fa32f11086
  - [net-next,08/14] net/mlx5: qos: Store the eswitch in a mlx5_esw_rate_group
    https://git.kernel.org/netdev/net-next/c/b9cfe193eb8f
  - [net-next,09/14] net/mlx5: qos: Add an explicit 'dev' to vport trace calls
    https://git.kernel.org/netdev/net-next/c/0c4cf09eca83
  - [net-next,10/14] net/mlx5: qos: Rename rate group 'list' as 'parent_entry'
    https://git.kernel.org/netdev/net-next/c/43f9011a3d7a
  - [net-next,11/14] net/mlx5: qos: Store rate groups in a qos domain
    https://git.kernel.org/netdev/net-next/c/107a034d5c1e
  - [net-next,12/14] net/mlx5: qos: Refactor locking to a qos domain mutex
    https://git.kernel.org/netdev/net-next/c/40efb0b7c755
  - [net-next,13/14] net/mlx5: Unify QoS element type checks across NIC and E-Switch
    https://git.kernel.org/netdev/net-next/c/f91c69f43c54
  - [net-next,14/14] net/mlx5: Add support check for TSAR types in QoS scheduling
    https://git.kernel.org/netdev/net-next/c/e1013c792960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




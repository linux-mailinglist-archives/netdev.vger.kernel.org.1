Return-Path: <netdev+bounces-22425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18476773B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9793828263E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76731CA0D;
	Fri, 28 Jul 2023 20:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6911DA32
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 20:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1DE3C433CC;
	Fri, 28 Jul 2023 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690577426;
	bh=MF9PeBuyn1uGMNFSO5BejaDPba+zWwt7xQbqXs7/+mY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G9lDIUCAsh60fXnoIS974kYoxiiJAHlqtWoC9jX9puWDJb9R5Tm1V9say+sVer3ke
	 3mPF+hASh9jjLEyxrTnZFRdUS9WHQxWC1etrmaQDahx2P/7ScAzu6t8tV4x59xDanx
	 8XHIynxyS1uXTafLPtb4taYFHB76T2EMQF/e7xck45S66owx1Vepgz1QUeyOqCa6ns
	 HTjTF9olGkYPEyjAIKHrJWNduRXoC06CoLg9YzqlLf1Sl1J/sLz/oGph9uJY3K2V5B
	 95YBsrLmvPSKcvJWKzi6hGsJoA2VEJ0comyKwvKcNhnPAU/eAmZPAbU51fTXWDYBi7
	 tdLjd7MVgqSMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF41FC39562;
	Fri, 28 Jul 2023 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V2 01/15] net/mlx5: Use shared code for checking lag is
 supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169057742584.24995.10154359323357807978.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 20:50:25 +0000
References: <20230727183914.69229-2-saeed@kernel.org>
In-Reply-To: <20230727183914.69229-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, roid@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Thu, 27 Jul 2023 11:39:00 -0700 you wrote:
> From: Roi Dayan <roid@nvidia.com>
> 
> Move shared function to check lag is supported to lag header file.
> 
> Signed-off-by: Roi Dayan <roid@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/15] net/mlx5: Use shared code for checking lag is supported
    https://git.kernel.org/netdev/net-next/c/02ceda65f014
  - [net-next,V2,02/15] net/mlx5: Devcom, Infrastructure changes
    https://git.kernel.org/netdev/net-next/c/88d162b47981
  - [net-next,V2,03/15] net/mlx5e: E-Switch, Register devcom device with switch id key
    https://git.kernel.org/netdev/net-next/c/1161d22ded07
  - [net-next,V2,04/15] net/mlx5e: E-Switch, Allow devcom initialization on more vports
    https://git.kernel.org/netdev/net-next/c/e2bb7984719b
  - [net-next,V2,05/15] net/mlx5: Re-organize mlx5_cmd struct
    https://git.kernel.org/netdev/net-next/c/58db72869a9f
  - [net-next,V2,06/15] net/mlx5: Remove redundant cmdif revision check
    https://git.kernel.org/netdev/net-next/c/0714ec9ea1f2
  - [net-next,V2,07/15] net/mlx5: split mlx5_cmd_init() to probe and reload routines
    https://git.kernel.org/netdev/net-next/c/06cd555f73ca
  - [net-next,V2,08/15] net/mlx5: Allocate command stats with xarray
    https://git.kernel.org/netdev/net-next/c/b90ebfc018b0
  - [net-next,V2,09/15] net/mlx5e: Remove duplicate code for user flow
    https://git.kernel.org/netdev/net-next/c/9ec85cc9c90e
  - [net-next,V2,10/15] net/mlx5e: Make flow classification filters static
    https://git.kernel.org/netdev/net-next/c/b9335a757232
  - [net-next,V2,11/15] net/mlx5: Don't check vport->enabled in port ops
    https://git.kernel.org/netdev/net-next/c/550449d8e389
  - [net-next,V2,12/15] net/mlx5: Remove pointless devlink_rate checks
    https://git.kernel.org/netdev/net-next/c/3e82a9cf579e
  - [net-next,V2,13/15] net/mlx5: Make mlx5_esw_offloads_rep_load/unload() static
    https://git.kernel.org/netdev/net-next/c/b71863876f84
  - [net-next,V2,14/15] net/mlx5: Make mlx5_eswitch_load/unload_vport() static
    https://git.kernel.org/netdev/net-next/c/329980d05d8c
  - [net-next,V2,15/15] net/mlx5: Give esw_offloads_load/unload_rep() "mlx5_" prefix
    https://git.kernel.org/netdev/net-next/c/9eca8bb8da43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




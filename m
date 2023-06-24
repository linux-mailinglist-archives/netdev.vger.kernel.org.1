Return-Path: <netdev+bounces-13767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA573CD56
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA0281117
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5411C86;
	Sat, 24 Jun 2023 22:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72919111AE
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 433AFC433C0;
	Sat, 24 Jun 2023 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687647027;
	bh=XMG95hgaLy0ylSIdfwz55P0uPZDMFVJENfw2lTV8q48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WjKkH67teB+UwoWtwd3yjlntMEFECPMUd5RdcAJfvIux2CqMQzq9kcHPp8m/bsUBA
	 pr3cL8yOEf7aUia67xvnFmrRo/CMwiowb8tkRbjneVPhFQCrYLNecekW0NIvHdYfEL
	 R3Xzwkpvy5ow7kRQ7j+oQN6QLGm9iDiO0wIn2t45tqoQa8WePcNbVa/m6AoHupIlZ3
	 nQ0D8EtDNED9QlbH0wkY6hs2DQMY4ZpFWNrz+OkIj2QgWj3iNE/2/0xD6N2BRtwaX7
	 Y5RYuSpeTmP+EdyXIY++BlGZ+vfAVGKXspGcP1VeRPF7ixtPxy7SOa08Sq1LkMISqK
	 akigLRuxUis8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E069C395C7;
	Sat, 24 Jun 2023 22:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V2 01/15] net/mlx5: Fix UAF in mlx5_eswitch_cleanup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764702718.4822.7507748328691183944.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:50:27 +0000
References: <20230623192907.39033-2-saeed@kernel.org>
In-Reply-To: <20230623192907.39033-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, shayd@nvidia.com, dan.carpenter@linaro.org,
 verifier@nvidia.com, gal@nvidia.com, moshe@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Fri, 23 Jun 2023 12:28:53 -0700 you wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> mlx5_eswitch_cleanup() is using esw right after freeing it for
> releasing devlink_param.
> Fix it by releasing the devlink_param before freeing the esw, and
> adjust the create function accordingly.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/15] net/mlx5: Fix UAF in mlx5_eswitch_cleanup()
    https://git.kernel.org/netdev/net-next/c/da744fd1362c
  - [net-next,V2,02/15] net/mlx5: Fix SFs kernel documentation error
    https://git.kernel.org/netdev/net-next/c/25c24801d7da
  - [net-next,V2,03/15] net/mlx5: Fix reserved at offset in hca_cap register
    https://git.kernel.org/netdev/net-next/c/9ee473c259de
  - [net-next,V2,04/15] net/mlx5: Fix error code in mlx5_is_reset_now_capable()
    https://git.kernel.org/netdev/net-next/c/690ad62fc6e4
  - [net-next,V2,05/15] net/mlx5: Lag, Remove duplicate code checking lag is supported
    https://git.kernel.org/netdev/net-next/c/8ec91f5d077c
  - [net-next,V2,06/15] net/mlx5e: Use vhca_id for device index in vport rx rules
    https://git.kernel.org/netdev/net-next/c/1da9f36252d4
  - [net-next,V2,07/15] net/mlx5e: E-Switch, Add peer fdb miss rules for vport manager or ecpf
    https://git.kernel.org/netdev/net-next/c/1552e9b51810
  - [net-next,V2,08/15] net/mlx5e: E-Switch, Use xarray for devcom paired device index
    https://git.kernel.org/netdev/net-next/c/70c364383935
  - [net-next,V2,09/15] net/mlx5e: E-Switch, Pass other_vport flag if vport is not 0
    https://git.kernel.org/netdev/net-next/c/4575ab3b7de0
  - [net-next,V2,10/15] net/mlx5e: Remove redundant comment
    https://git.kernel.org/netdev/net-next/c/ae4de894931d
  - [net-next,V2,11/15] net/mlx5e: E-Switch, Fix shared fdb error flow
    https://git.kernel.org/netdev/net-next/c/15ddd72ee323
  - [net-next,V2,12/15] net/mlx5: Remove redundant MLX5_ESWITCH_MANAGER() check from is_ib_rep_supported()
    https://git.kernel.org/netdev/net-next/c/61955da523d9
  - [net-next,V2,13/15] net/mlx5: Remove redundant is_mdev_switchdev_mode() check from is_ib_rep_supported()
    https://git.kernel.org/netdev/net-next/c/0d0946d6488e
  - [net-next,V2,14/15] net/mlx5: Remove redundant check from mlx5_esw_query_vport_vhca_id()
    https://git.kernel.org/netdev/net-next/c/899862b653d7
  - [net-next,V2,15/15] net/mlx5: Remove pointless vport lookup from mlx5_esw_check_port_type()
    https://git.kernel.org/netdev/net-next/c/29e4c95faee5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




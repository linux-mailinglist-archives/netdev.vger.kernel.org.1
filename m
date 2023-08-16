Return-Path: <netdev+bounces-27893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C377D881
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356291C20F18
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6817F7;
	Wed, 16 Aug 2023 02:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139D361
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D43EC433C9;
	Wed, 16 Aug 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692153625;
	bh=WccexzMEdR6xhTldlrjPROKHEcM4qSHGZt6G/tQ+SlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dM1VrSbIXBvmT+eaz64b+iPvHnznULmNwaIZdWTSSZBwT9bhfxwHjUpm7CAavIkSq
	 c1akUbTtk3VMYwppW6E8UgTWgixCwVIOTeJENH52YO2uE5Dar6vdAv3ibO/exWA67J
	 C620u5OvqKVClV0UlCI7TZXKqfVIxN9CarnC3H7fLLil6z6jGzw9L+XoZekZeW8U2d
	 MbDmax8l43IB7NHGa6ODMQKZRZTnM26G6j9wFEfIwliasxQNg2buLlkTpuXte2gIEV
	 4L2RGvQn3w/AEK4cBw3WjMjYo2CaZjONYJrnnB2ER1edwY+9z1ElmeMFneyC5bbVX/
	 UTfom52dQf/9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33D6EC39562;
	Wed, 16 Aug 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next 01/14] net/mlx5: Consolidate devlink documentation in
 devlink/mlx5.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215362520.5089.13536736279401930023.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:40:25 +0000
References: <20230814214144.159464-2-saeed@kernel.org>
In-Reply-To: <20230814214144.159464-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, rrameshbabu@nvidia.com, jiri@nvidia.com, gal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Mon, 14 Aug 2023 14:41:31 -0700 you wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> De-duplicate documentation by removing mellanox/mlx5/devlink.rst. Instead,
> only use the generic devlink documentation directory to document mlx5
> devlink parameters. Avoid providing general devlink tool usage information
> in mlx5-specific documentation.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net/mlx5: Consolidate devlink documentation in devlink/mlx5.rst
    https://git.kernel.org/netdev/net-next/c/b608dd670bb6
  - [net-next,02/14] net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs
    https://git.kernel.org/netdev/net-next/c/3178308ad4ca
  - [net-next,03/14] net/mlx5e: Add recovery flow for tx devlink health reporter for unhealthy PTP SQ
    https://git.kernel.org/netdev/net-next/c/53b836a44db4
  - [net-next,04/14] net/mlx5: Expose max possible SFs via devlink resource
    https://git.kernel.org/netdev/net-next/c/6486c0f44ed8
  - [net-next,05/14] net/mlx5: Check with FW that sync reset completed successfully
    https://git.kernel.org/netdev/net-next/c/a9f168e4c6e1
  - [net-next,06/14] net/mlx5: E-switch, Add checking for flow rule destinations
    https://git.kernel.org/netdev/net-next/c/e0e22d59b47a
  - [net-next,07/14] net/mlx5: Use auxiliary_device_uninit() instead of device_put()
    https://git.kernel.org/netdev/net-next/c/2ad0160c02be
  - [net-next,08/14] net/mlx5: Remove redundant SF supported check from mlx5_sf_hw_table_init()
    https://git.kernel.org/netdev/net-next/c/ae80d7a06fdb
  - [net-next,09/14] net/mlx5: Use mlx5_sf_start_function_id() helper instead of directly calling MLX5_CAP_GEN()
    https://git.kernel.org/netdev/net-next/c/88074d81e5fe
  - [net-next,10/14] net/mlx5: Remove redundant check of mlx5_vhca_event_supported()
    https://git.kernel.org/netdev/net-next/c/b63f8bde2fba
  - [net-next,11/14] net/mlx5: Fix error message in mlx5_sf_dev_state_change_handler()
    https://git.kernel.org/netdev/net-next/c/36e5a0efc810
  - [net-next,12/14] net/mlx5: Remove unused CAPs
    https://git.kernel.org/netdev/net-next/c/0b4eb603d635
  - [net-next,13/14] net/mlx5: Remove unused MAX HCA capabilities
    https://git.kernel.org/netdev/net-next/c/a41cb59117fa
  - [net-next,14/14] net/mlx5: Don't query MAX caps twice
    https://git.kernel.org/netdev/net-next/c/bd3a2f77809b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




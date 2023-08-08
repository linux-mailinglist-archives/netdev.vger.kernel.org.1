Return-Path: <netdev+bounces-25636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A61774F76
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56631C21039
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7A1C9F1;
	Tue,  8 Aug 2023 23:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9C1CA0A
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5348BC43397;
	Tue,  8 Aug 2023 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691538027;
	bh=V6jAz9jXA5hXAa8UIO7xvz4O0gGGH4+aI6cBh3UUfes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIU1xNzN+9kGqv0wgLEnJTv4b2P889qAeYV051H548+pnGU2x6pRD5mdvE4yXsd8U
	 V0WvtsA33Yl6ilFyRII8rLyW6bSbFfFhyMX/UPQSXHBNxItlcmqjyMe/RuBlsXmt8z
	 1TjBJUWf/kNZX835ot8xLMxPAXMysISKzZp5WD2Z+MBKO9C33rrG8o5nb6nr9uZrr/
	 eL8M/buqPdhcCLpri4n+PT3Lgzs0FTrUmrdmzdXYA55xNTPpuNZVn4vkG4dKFsL/NS
	 P6T49ozFVyB7L54m5K2SP5KNzYmXFcquqaGEWRW5qmi3UKLjN0l5ZnbsnguN9MRqte
	 J9Gk6pe6PtUgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F762C395C5;
	Tue,  8 Aug 2023 23:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next 01/15] net/mlx5: Track the current number of completion EQs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153802718.28457.2520043547071157048.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:40:27 +0000
References: <20230807175642.20834-2-saeed@kernel.org>
In-Reply-To: <20230807175642.20834-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, msanalla@nvidia.com, shayd@nvidia.com, moshe@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Mon,  7 Aug 2023 10:56:28 -0700 you wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> In preparation to allocate completion EQs, add a counter to track the
> number of completion EQs currently allocated. Store the maximum number
> of EQs in max_comp_eqs variable.
> 
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net/mlx5: Track the current number of completion EQs
    https://git.kernel.org/netdev/net-next/c/18cf3d31f829
  - [net-next,02/15] net/mlx5: Refactor completion IRQ request/release API
    https://git.kernel.org/netdev/net-next/c/a1772de78d73
  - [net-next,03/15] net/mlx5: Use xarray to store and manage completion IRQs
    https://git.kernel.org/netdev/net-next/c/c8a0245c3937
  - [net-next,04/15] net/mlx5: Refactor completion IRQ request/release handlers in EQ layer
    https://git.kernel.org/netdev/net-next/c/54b2cf41b853
  - [net-next,05/15] net/mlx5: Use xarray to store and manage completion EQs
    https://git.kernel.org/netdev/net-next/c/273c697fdedc
  - [net-next,06/15] net/mlx5: Implement single completion EQ create/destroy methods
    https://git.kernel.org/netdev/net-next/c/e3e56775e913
  - [net-next,07/15] net/mlx5: Introduce mlx5_cpumask_default_spread
    https://git.kernel.org/netdev/net-next/c/ddd2c79da020
  - [net-next,08/15] net/mlx5: Add IRQ vector to CPU lookup function
    https://git.kernel.org/netdev/net-next/c/f3147015fa07
  - [net-next,09/15] net/mlx5: Rename mlx5_comp_vectors_count() to mlx5_comp_vectors_max()
    https://git.kernel.org/netdev/net-next/c/674dd4e2e04e
  - [net-next,10/15] net/mlx5: Handle SF IRQ request in the absence of SF IRQ pool
    https://git.kernel.org/netdev/net-next/c/54c5297801f3
  - [net-next,11/15] net/mlx5: Allocate completion EQs dynamically
    https://git.kernel.org/netdev/net-next/c/f14c1a14e632
  - [net-next,12/15] net/mlx5: remove many unnecessary NULL values
    https://git.kernel.org/netdev/net-next/c/a0ae00e71e3e
  - [net-next,13/15] net/mlx5: Fix typo reminder -> remainder
    https://git.kernel.org/netdev/net-next/c/58f6d9d04489
  - [net-next,14/15] net/mlx5: E-Switch, Remove redundant arg ignore_flow_lvl
    https://git.kernel.org/netdev/net-next/c/d602be220cf9
  - [net-next,15/15] net/mlx5: Bridge, Only handle registered netdev bridge events
    https://git.kernel.org/netdev/net-next/c/b56fb19c3379

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




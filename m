Return-Path: <netdev+bounces-114764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E88943FDA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 03:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCB61F214B7
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961B140E38;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxNywN8t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5913FD97
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474637; cv=none; b=Rgz4m2cLwAX6RlUVFFgVzUzV5FVKheAyeMsDaQfyFjLrb3HxkWUI5UWJIk4Uh9p15fVSe8l/hyEYHNgeQqKSzL4eClYyIEJR916OPYr+XsweNqp1mTsLlvWhKYEv9qgYyMp+8ap1mT5gdDekG99oOwW2BF5XhonSefUMsma2LF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474637; c=relaxed/simple;
	bh=oTUQyDl2Ur5Qw6PzBT5LE7TUE+kJUnFcPG/aR2n1gzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QqNkgdIJc+aP+mxaZIaZt2dmJH94aYmV5PLdUEjIGU7U+LKRHJjgFu3ELPgQrzDqQ2mAwZLPn0c0Pa2eINV6HOkaNdrJGG6OelFxMyTMMtjbrdcYdXY6YQsT1ptiR39oBKAeRaPP8ImQxcYz9yFty+uALdlDYbBHydgiQPH2ddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxNywN8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D4BC4AF0E;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474637;
	bh=oTUQyDl2Ur5Qw6PzBT5LE7TUE+kJUnFcPG/aR2n1gzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lxNywN8t98Lo1O0Ga84/VwrMxhsz3z5y4BOm4Mhp3JYvQjaVD2ySX46BPUN33FALU
	 IOgnwKxZlyeehq1J/1pDlInD2F8Xu6IT7ZwPJOYHpFK5YWM+NYgqxE6hxdqOMapOfJ
	 9s9zp8gbalFvcj429kryCPzHGbyZ0OqN0q9hkYDe8L/XoYI2tzCpCX3e9MEyESe9iH
	 W4veOa0RYnwtENATxgsi5RvPE/DLW8VE1edCFlkKQ4NixcVHqhohofw7FsO1nImT97
	 IsmyVB7Zv1tm+p17HVrJCKXKX83s+bzO7gNbHa1S1US2g/MlHW7Jx2PSVhxtmEdZLs
	 0dKmzRU03UEiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37449C43140;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] mlx5 misc fixes 2024-07-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247463722.20901.3075314276833555628.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 01:10:37 +0000
References: <20240730061638.1831002-1-tariqt@nvidia.com>
In-Reply-To: <20240730061638.1831002-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 09:16:29 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Series generated against:
> commit 301927d2d2eb ("Merge tag 'for-net-2024-07-26' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth")
> 
> [...]

Here is the summary with links:
  - [net,1/8] net/mlx5: Always drain health in shutdown callback
    https://git.kernel.org/netdev/net/c/1b75da22ed1e
  - [net,2/8] net/mlx5: Fix error handling in irq_pool_request_irq
    https://git.kernel.org/netdev/net/c/a4557b0b57c4
  - [net,3/8] net/mlx5: DR, Fix 'stack guard page was hit' error in dr_rule
    https://git.kernel.org/netdev/net/c/94a3ad6c0813
  - [net,4/8] net/mlx5: Lag, don't use the hardcoded value of the first port
    https://git.kernel.org/netdev/net/c/3fda84dc0903
  - [net,5/8] net/mlx5: Fix missing lock on sync reset reload
    https://git.kernel.org/netdev/net/c/572f9caa9e72
  - [net,6/8] net/mlx5e: Require mlx5 tc classifier action support for IPsec prio capability
    https://git.kernel.org/netdev/net/c/06827e27fdcd
  - [net,7/8] net/mlx5e: Fix CT entry update leaks of modify header context
    https://git.kernel.org/netdev/net/c/025f2b85a5e5
  - [net,8/8] net/mlx5e: Add a check for the return value from mlx5_port_set_eth_ptys
    https://git.kernel.org/netdev/net/c/3f8e82a020a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




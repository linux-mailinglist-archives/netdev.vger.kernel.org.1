Return-Path: <netdev+bounces-137445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36039A66CE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5672B1F20FD9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D313A1E573D;
	Mon, 21 Oct 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krz3+XtH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE65946C
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510827; cv=none; b=Knbr3tYIrPOTWbw1bl6snMPLZ2FtrkeUHAqWIIptXzaNggyjDbHJ6pR7sC8CRNGln1B/B4+K4yzzhyYar6HYvkTy+M17r/ntHZbXba6Jf3sRf7B3YrZmWC/fn0qKPO5TUEHELB4jnZiAswGNNJAz9bVv4Qf9wzwJETDHWTxm/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510827; c=relaxed/simple;
	bh=vVXBLxkgZyd7Z0vP1IDBYt5ljH396jGE5scFQj6+2BM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sno2/XcCOgwjx80GTncQAXOovJQOYrFzR6E71dT0qXY8gYGeLgezV0L6YXPu4y4sC1+MP/8DIWnZZc2vdT83Ir4bScBYSO4FxBT9T65TNmtnWB1a6EdBjWJuUSKHY6Mm9KV0lVrKmAZkBR937njun5/FSSUlJMr/Qn1xTcCgiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krz3+XtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444EBC4CEC3;
	Mon, 21 Oct 2024 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729510827;
	bh=vVXBLxkgZyd7Z0vP1IDBYt5ljH396jGE5scFQj6+2BM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=krz3+XtHcncjjGJcqwfXLtwr0McSl6dVdZEwEF8p0SOpBnhcxkdf1bEWI7jKYgTjU
	 Pe0PlvOFe3jnCKcVmxTlvN1gwMmz8lDaGOhrcvkT2shhmAmDpKor9v8be7zmVh58Gt
	 13ghrjmzbk9KTJdeqPLPmM0RmnVu1NeOTXJyOT8z/4HnRSNfsYY+P+T3wK/cY+waC2
	 h1DDL+bKlYhZ0QABnoRuIVd67mVeZc4yppGoYPLwKKNM42xIJ359BUDMq2i30mOC1C
	 5y5eEVI4ipSTMJR/8VRRcrdybtWlcEJnT9Sy045cLxhUBFiIODa1GcIuIoMN54K9d9
	 L0cSa8M8acoFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB53809A8A;
	Mon, 21 Oct 2024 11:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 00/15] net/mlx5: Refactor esw QoS to support
 generalized operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172951083326.225670.2525365154552729942.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 11:40:33 +0000
References: <20241016173617.217736-1-tariqt@nvidia.com>
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, cjubran@nvidia.com, cratiu@nvidia.com,
 horms@kernel.org, daniel.machon@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 16 Oct 2024 20:36:02 +0300 you wrote:
> Hi,
> 
> This patch series from the team to mlx5 core driver consists of one main
> QoS part followed by small misc patches.
> 
> This main part (patches 1 to 11) by Carolina refactors the QoS handling
> to generalize operations on scheduling groups and vports. These changes
> are necessary to support new features that will extend group
> functionality, introduce new group types, and support deeper
> hierarchies.
> 
> [...]

Here is the summary with links:
  - [net-next,V3,01/15] net/mlx5: Refactor QoS group scheduling element creation
    https://git.kernel.org/netdev/net-next/c/700814fa41ce
  - [net-next,V3,02/15] net/mlx5: Introduce node type to rate group structure
    https://git.kernel.org/netdev/net-next/c/4235fe2cb8e9
  - [net-next,V3,03/15] net/mlx5: Add parent group support in rate group structure
    https://git.kernel.org/netdev/net-next/c/54200dbc685c
  - [net-next,V3,04/15] net/mlx5: Restrict domain list insertion to root TSAR ancestors
    https://git.kernel.org/netdev/net-next/c/24e54e870d11
  - [net-next,V3,05/15] net/mlx5: Rename vport QoS group reference to parent
    https://git.kernel.org/netdev/net-next/c/72a1d121fa6b
  - [net-next,V3,06/15] net/mlx5: Introduce node struct and rename group terminology to node
    https://git.kernel.org/netdev/net-next/c/1c25d4388ba6
  - [net-next,V3,07/15] net/mlx5: Refactor vport scheduling element creation function
    https://git.kernel.org/netdev/net-next/c/88d5fbcb7ba0
  - [net-next,V3,08/15] net/mlx5: Refactor vport QoS to use scheduling node structure
    https://git.kernel.org/netdev/net-next/c/045815fe329a
  - [net-next,V3,09/15] net/mlx5: Remove vport QoS enabled flag
    https://git.kernel.org/netdev/net-next/c/ebecc37befb1
  - [net-next,V3,10/15] net/mlx5: Simplify QoS scheduling element configuration
    https://git.kernel.org/netdev/net-next/c/70744a46aabf
  - [net-next,V3,11/15] net/mlx5: Generalize QoS operations for nodes and vports
    https://git.kernel.org/netdev/net-next/c/a1903bf50f2e
  - [net-next,V3,12/15] net/mlx5: Add sync reset drop mode support
    https://git.kernel.org/netdev/net-next/c/b37f3f2be0f4
  - [net-next,V3,13/15] net/mlx5: Only create VEPA flow table when in VEPA mode
    https://git.kernel.org/netdev/net-next/c/f0ac6209460e
  - [net-next,V3,14/15] net/mlx5: fs, rename packet reformat struct member action
    https://git.kernel.org/netdev/net-next/c/1715f0a73233
  - [net-next,V3,15/15] net/mlx5: fs, rename modify header struct member action
    https://git.kernel.org/netdev/net-next/c/7b919caaeb18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




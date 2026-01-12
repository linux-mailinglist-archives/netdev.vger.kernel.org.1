Return-Path: <netdev+bounces-249178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D53D15592
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5FD3017EE4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C726056A;
	Mon, 12 Jan 2026 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn3KQZfq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90D13D51E
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251618; cv=none; b=u2tC9FhnAG2u1RmcQoiYtDBEMDqjFTbF0GdJ4t6xJ9JiYPaXnsDe4+J6FVAXV5t4TAN3kZMETzfD9XR7Kr9AJtrr/JpIsxOpboLwFclyLTcZtx5QJhXI1ixwY51cNnkXmgcWy+VBouXW0N42EiUa3SHIIaJ1rWX97oRvNe4U5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251618; c=relaxed/simple;
	bh=bq3qGwJTUPRIW/PtwDyUPATzASoIrUqN5LuQI+os4ik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDxZDg+ZtnI1bVzr3ggDlbJxaQeYO5MnrfsaFORoZAir1uy/SXBvChMvZ7MBgxvL7emY5YsqlYJEDBR/jg0ja3XTczsdARcN8D/PvC3HslV/iXuMSU/+gv3NlKh/VSx0w9YT6JRupEk7F2u/2LI8yxrUK7ZP15gU0xXa2KeX9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn3KQZfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C69C116D0;
	Mon, 12 Jan 2026 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251618;
	bh=bq3qGwJTUPRIW/PtwDyUPATzASoIrUqN5LuQI+os4ik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kn3KQZfq6Azj7QZ5Dj8NdwbE1FOrjVAqkNaZ4nV7wPy6JdAQ9bLCJk5Sg9/mC+Y3K
	 OSKpFH5h3cU/iEobhWiS8t3/+0V6GhbjgYzJoJg1UwBltI8TlDG4kNdaWsGdc3fLf2
	 +1lY1Lb9vg8sgYi3U1irwFmTd7icylg+bxQ4cdbNuO1gWnhbpdXt1/oybEIvP5GA4y
	 2LgSxymb+u2BGC31z2semhZidvdlI2ZSf1pYCjrOU67U3Yh0XaIll5GyEwF3FJ+m7B
	 VmP+c92pd4IJXLIYEglnMAZW6rQGS1ypAscSqzvZy/JelMleO3MufLtVNRb68toHru
	 6etBLS/98amuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5979380CFD5;
	Mon, 12 Jan 2026 20:56:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mlx5e profile change fix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825141227.1092878.6815738602596514119.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:56:52 +0000
References: <20260108212657.25090-1-saeed@kernel.org>
In-Reply-To: <20260108212657.25090-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 13:26:53 -0800 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> This series fixes a crash in mlx5e due to profile change error flow.
> 
> Saeed Mahameed (4):
>   net/mlx5e: Fix crash on profile change rollback failure
>   net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv
>   net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv
>   net/mlx5e: Restore destroying state bit after profile cleanup
> 
> [...]

Here is the summary with links:
  - [net,1/4] net/mlx5e: Fix crash on profile change rollback failure
    https://git.kernel.org/netdev/net/c/4dadc4077e3f
  - [net,2/4] net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv
    https://git.kernel.org/netdev/net/c/123eda2e5b16
  - [net,3/4] net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv
    https://git.kernel.org/netdev/net/c/4ef8512e1427
  - [net,4/4] net/mlx5e: Restore destroying state bit after profile cleanup
    https://git.kernel.org/netdev/net/c/5629f8859dca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




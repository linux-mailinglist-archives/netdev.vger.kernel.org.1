Return-Path: <netdev+bounces-95633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E08C2E6C
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8CF1F2358D
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB314F98;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4/lEmyD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942C12E68;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391030; cv=none; b=hpA/mOWODgPJ2Y8Z9dxOeJSTFDF+AYZYi3o9a5dA3m6ZHjZJiUw6fSMSAjDKraelV/G4vB0mUPbD/BMavK0DhR+QT8wf0kdFJSwSdzlLN1SYBzl1kJCUsAl3b2pqrptflbTkvC78NEW7lnAyERfGH85uPclUBnXVZ9I6H5dGi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391030; c=relaxed/simple;
	bh=1OHzTnDAFehCLp0FJwQukTc+4pNjunRPFFhzwohoQKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iueLC7jypntg0Y1cNxVptm9VoCBq/L16t7Lia5zpUiwvBZmWnltuUyA5DzaVgL1HQ14qm+X1WtUx2YhGWKhE8udXUk5rrnl/hz4WJGKvO0t8xLWgSwJS2tZ7EjHgAsHdWBF7/+SM+J8/kowXYI1TuWKXyVvNTOucM9ttjBNQ8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4/lEmyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D39AC4AF68;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391030;
	bh=1OHzTnDAFehCLp0FJwQukTc+4pNjunRPFFhzwohoQKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N4/lEmyDeW5eiX4KT5hwXZWS4JdHXbOgHexmKNBJq8rJC41ltGbrSL7T8nREAtM5i
	 NrwJkXFx3vSAfPmY8y2UXQsXbs3zRLkW3PgBW+gh8KcO2EkdyZTtipAo1vWQCKCLS8
	 ivt2zs1apc9Wz7MTX+q8iB8qVupffObDepqoLKM4Q37VDUW1VVG7EIGUSZUYzFSrm4
	 6WP0S9NvLtt7mVrk7vBfEYWEQ3Cyebe2L4J3LkbH8nlCY8ARezxbWIOTczEsQ3mATB
	 piGkm6kLlv8r8+qPpjGyLe+RjI9+3nAUS6yDL5RUsS8b6UWSxcZgYlB5DghFY4/1ye
	 cVMOCa1/ubQZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0361AC54BA1;
	Sat, 11 May 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] virtio_net: Fix memory leak in virtnet_rx_mod_work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539103001.31003.4130867851366024064.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 01:30:30 +0000
References: <20240509183634.143273-1-danielj@nvidia.com>
In-Reply-To: <20240509183634.143273-1-danielj@nvidia.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiri@nvidia.com, axboe@kernel.dk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 May 2024 13:36:34 -0500 you wrote:
> The pointer delcaration was missing the __free(kfree).
> 
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Closes: https://lore.kernel.org/netdev/0674ca1b-020f-4f93-94d0-104964566e3f@kernel.dk/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> 
> [...]

Here is the summary with links:
  - virtio_net: Fix memory leak in virtnet_rx_mod_work
    https://git.kernel.org/netdev/net-next/c/b49bd37f0bfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




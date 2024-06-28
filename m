Return-Path: <netdev+bounces-107666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6991BE01
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301F4B234BF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E872A15689A;
	Fri, 28 Jun 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR2VJyfO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E1155C98
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576031; cv=none; b=fQeCorgbKLfZPjgDtDgO/tRB4EYGOKFtQmW28YHe+q5RpmkM6rKBSf6Zxh1kjSFJz+m56dswNjQO5gtMXu0u8DunlNQqYbG2xQjE25d44HRHZr+QsTfxYKfFYSXKm87YdSpg8YmSRd6MuedNRDfvNjsdJDAlRYHuTM+QUVR4m+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576031; c=relaxed/simple;
	bh=PvIxufEEVp4tVXn8c5hetzfM8PvGnNhte2EAyBAXXgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jFvONsLhcbY2ixbUcnkyFs7QCzZk+5oDeqnoB9SDAoIHfnt3KZXAc+TuS/b8t7y1eYI4uOKx0K1xFkNiLNvSw0kQCmGV9rEXgfzCvITwul1AokL0XOGkwV2IWpmlYatmnscxCJ/vCiAP2Wt/ZAtHelJdxAv1XTlTu77ZnPZ+420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR2VJyfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0FAC116B1;
	Fri, 28 Jun 2024 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719576031;
	bh=PvIxufEEVp4tVXn8c5hetzfM8PvGnNhte2EAyBAXXgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TR2VJyfOxzyFX+9RYg2kOAR8RJEPyTkgdDqF0ISqvVmGpHOWrA73fSQMxRqrFPnYq
	 drI136kMgdgDYUUXvh3wp+0cm2FJsGeu7iQjlyxG55SezFA3TAkGCiDfaegDLErtUA
	 e/RYIPWSi8kFUG9E2kRzH5GY1V6u6IDeUMGv6iy3CFoW0jJW4oDegapehyFVnCSLOh
	 Y9cBZlWN5h1m4ekTqYxus/5UvtJGbwIQtvS2r/IzFtXv1yiGcX43HoHtUCXy+m39z6
	 /Tco8oXLt8iKfcWMIYJs+aUGMfKp4Bhq54gQJv5CSiVgamlxTAgs2ZEGJnyVSXZj/6
	 VlJeWEEeW8b3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2716BC43336;
	Fri, 28 Jun 2024 12:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 0/7] mlx5 fixes 2024-06-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171957603115.1526.3340270114816004864.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 12:00:31 +0000
References: <20240627180240.1224975-1-tariqt@nvidia.com>
In-Reply-To: <20240627180240.1224975-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jun 2024 21:02:33 +0300 you wrote:
> Hi,
> 
> This patchset provides fixes from the team to the mlx5 core and EN
> drivers.
> 
> The first 3 patches by Daniel replace a buggy cap field with a newly
> introduced one.
> 
> [...]

Here is the summary with links:
  - [net,V2,1/7] net/mlx5: IFC updates for changing max EQs
    https://git.kernel.org/netdev/net/c/048a403648fc
  - [net,V2,2/7] net/mlx5: Use max_num_eqs_24b capability if set
    https://git.kernel.org/netdev/net/c/29c6a562bf53
  - [net,V2,3/7] net/mlx5: Use max_num_eqs_24b when setting max_io_eqs
    https://git.kernel.org/netdev/net/c/5dbf647367e8
  - [net,V2,4/7] net/mlx5: E-switch, Create ingress ACL when needed
    https://git.kernel.org/netdev/net/c/b20c2fb45470
  - [net,V2,5/7] net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()
    https://git.kernel.org/netdev/net/c/1da839eab6db
  - [net,V2,6/7] net/mlx5e: Present succeeded IPsec SA bytes and packet
    https://git.kernel.org/netdev/net/c/2d9dac5559f8
  - [net,V2,7/7] net/mlx5e: Approximate IPsec per-SA payload data bytes count
    https://git.kernel.org/netdev/net/c/e562f2d46d27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




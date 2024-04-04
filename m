Return-Path: <netdev+bounces-84696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4433F897E0D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 05:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7258F1C2167A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24C8208A3;
	Thu,  4 Apr 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmqc4Bq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4481CFBD
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712202633; cv=none; b=fWYcJwGGXYn5vfM/b8LebpNYmOMWEgDoGue5hPqwX7yFXtz/N0BWEpRhSw9eeNvfNO03Rd7lBZ9FxIqSNZ/5OgQquRTmGUp7vNuOtnCbox2IO9rfCnT3ZakOoJt2zLfp0U9CFXiiEcAvG2wT2lcGeRFRmcKHF2lpxk4jqrJT5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712202633; c=relaxed/simple;
	bh=rjCcBTBSUrwwKAtjCVqArsNWAHV1RZrrYXzMgMJ1rlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CtYFjG7t4IFoF5/YNsd2LWzHF68bWODzJwyN/gM+fWLc9VK04o5pPVRy2ltJeLH5nfJXPK4Amlb9FsaPCQPi9p7ubBebyOyxO/cmqj7l0mHiU0EJvrG+Sc8gbEgZ8WqEWvHzxQ6I09pUJAep1Fdbtx1HXk5L5PHd5gAk9W3Qbj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmqc4Bq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 159E0C433F1;
	Thu,  4 Apr 2024 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712202633;
	bh=rjCcBTBSUrwwKAtjCVqArsNWAHV1RZrrYXzMgMJ1rlA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hmqc4Bq1+285O6jmvfFZCwXmHXwmhLOAvU0LmOu910oNsur4AY99OYUqYY0ibygXu
	 DI4+oGvRI1wVVrIEBBh1sygp7RfORQiWEm8M9p5SZwpsENMtnbPbVAcGKHMoJnSK6/
	 jg2RZCNiMu6+abJ3iJ5hmxiEFS1+Clk49A6iaE1ZjGmnCsVNr0tHU5gIiInZnZ74pT
	 /x7SNiimuuQ+mEgXO0AifMGwaNDZJSjmYb9/Rppf0mrociAIJu6+7wIumTMPPpx6FL
	 KcZgLfoRJ7hYly0iqy9gzK/T/VwsAqKbBxeZYrlHr3haj+XvVnaI7smKA7Y3BR+00P
	 YU4oUNjYOhcxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02545D9A150;
	Thu,  4 Apr 2024 03:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/11] mlx5 misc patches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171220263300.6004.1069158143431151147.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 03:50:33 +0000
References: <20240402133043.56322-1-tariqt@nvidia.com>
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Apr 2024 16:30:32 +0300 you wrote:
> Hi,
> 
> This patchset includes small features and misc code enhancements for the
> mlx5 core and EN drivers.
> 
> Patches 1-4 by Gal improves the mlx5e ethtool stats implementation, for
> example by using standard helpers ethtool_sprintf/puts.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/11] net/mlx5e: Use ethtool_sprintf/puts() to fill priv flags strings
    https://git.kernel.org/netdev/net-next/c/e2d515eb8fcd
  - [net-next,V2,02/11] net/mlx5e: Use ethtool_sprintf/puts() to fill selftests strings
    https://git.kernel.org/netdev/net-next/c/9ac9299d41f6
  - [net-next,V2,03/11] net/mlx5e: Use ethtool_sprintf/puts() to fill stats strings
    https://git.kernel.org/netdev/net-next/c/89b34322d293
  - [net-next,V2,04/11] net/mlx5e: Make stats group fill_stats callbacks consistent with the API
    https://git.kernel.org/netdev/net-next/c/27ea84ab35f5
  - [net-next,V2,05/11] net/mlx5e: debugfs, Add reset option for command interface stats
    https://git.kernel.org/netdev/net-next/c/19b85f1b37ce
  - [net-next,V2,06/11] net/mlx5e: XDP, Fix an inconsistent comment
    https://git.kernel.org/netdev/net-next/c/595f41608dba
  - [net-next,V2,07/11] net/mlx5: Convert uintX_t to uX
    https://git.kernel.org/netdev/net-next/c/30f8d23814ea
  - [net-next,V2,08/11] net/mlx5e: Add support for 800Gbps link modes
    https://git.kernel.org/netdev/net-next/c/8c54c89ad45a
  - [net-next,V2,09/11] net/mlx5: Support matching on l4_type for ttc_table
    https://git.kernel.org/netdev/net-next/c/137f3d50ad2a
  - [net-next,V2,10/11] net/mlx5: Skip pages EQ creation for non-page supplier function
    https://git.kernel.org/netdev/net-next/c/c788d79cfa6b
  - [net-next,V2,11/11] net/mlx5: Don't call give_pages() if request 0 page
    https://git.kernel.org/netdev/net-next/c/07e1bc785a91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




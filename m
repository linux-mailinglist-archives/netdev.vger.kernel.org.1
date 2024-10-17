Return-Path: <netdev+bounces-136519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4C79A1F9D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B6285F3E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23E1D9682;
	Thu, 17 Oct 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWuZ5SVY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F11D935A
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160425; cv=none; b=HQ8ibRWk609ALT90f2IkvB1wMw0VDdAhdZ1Li9tWNSA8C2dO3VIz+L2dZxJ8NNvWw4qSDnaiFHE0hbVNPQxfJA+jBeQmQn9VROdjIzg5W+FUbV4eiid0Evvp4oN+H+56LkYzByHqbBFAfbokfxxSJ3YHR7nC92Jd9pgwzWSVitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160425; c=relaxed/simple;
	bh=LMk8VOXfUMsjL/JV8cjqPaxqwNrbYpZpZj8fyOgVaTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XV0U10kClnfifQgdpuQCRzqgdJikCJU+f/wsZ5Of7gh5D5mA51MAO3EXaSqMJiBQOLSv5KMtwsO6st247wGukz1aQY2PPKOsxyt3Grna3IM3PsJ+bx8/QutzEqfeVSsI/yRJRqcAxob/7NzUVqbvlxRVyjMSnxu7bT6qZgfoBMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWuZ5SVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1578C4CEC3;
	Thu, 17 Oct 2024 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729160424;
	bh=LMk8VOXfUMsjL/JV8cjqPaxqwNrbYpZpZj8fyOgVaTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YWuZ5SVYCZDYzulX4OTX3HtxFzZoR269Hl21E248Bic2ItczC9DDTfSC8O8yxYhN5
	 73MzswVxxF1B7Obyukf/U6at87sajw7Xjxw0xcExW8iVI24GvtsN+MePPQLck2apjG
	 JIgxITDdURNkO6dugms8dDVKCcJnaHX+g0LqTZiPU0iWB0zFqsqu31Jxe2fx7Kjb3l
	 nYnburfiYZyBykpMNGz6UojQStppqADIaA7DzdcsET/Lf8xKxSMuUMS5U/c5sT0uwi
	 WKDKhYEsr8iYpjGnSHpDXJuHUFFAkJ6jFRTYURX0dd5CTpRbG6P6CJCLkh3tR3T2Ur
	 ukeSbcOYn0kEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2B3805CC0;
	Thu, 17 Oct 2024 10:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] mlx5 misc fixes 2024-10-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172916043027.2424677.2114021477349898921.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 10:20:30 +0000
References: <20241015093208.197603-1-tariqt@nvidia.com>
In-Reply-To: <20241015093208.197603-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 12:32:00 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Series generated against:
> commit 174714f0e505 ("selftests: drivers: net: fix name not defined")
> 
> [...]

Here is the summary with links:
  - [net,1/8] net/mlx5: HWS, removed wrong access to a number of rules variable
    https://git.kernel.org/netdev/net/c/65b4eb9f3d1e
  - [net,2/8] net/mlx5: HWS, fixed double free in error flow of definer layout
    https://git.kernel.org/netdev/net/c/5aa2184e2908
  - [net,3/8] net/mlx5: HWS, don't destroy more bwc queue locks than allocated
    https://git.kernel.org/netdev/net/c/45bcbd49224a
  - [net,4/8] net/mlx5: HWS, use lock classes for bwc locks
    https://git.kernel.org/netdev/net/c/9addffa34359
  - [net,5/8] net/mlx5: Check for invalid vector index on EQ creation
    https://git.kernel.org/netdev/net/c/d4f25be27e3e
  - [net,6/8] net/mlx5: Fix command bitmask initialization
    https://git.kernel.org/netdev/net/c/d62b14045c65
  - [net,7/8] net/mlx5: Unregister notifier on eswitch init failure
    https://git.kernel.org/netdev/net/c/1da9cfd6c41c
  - [net,8/8] net/mlx5e: Don't call cleanup on profile rollback failure
    https://git.kernel.org/netdev/net/c/4dbc1d1a9f39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




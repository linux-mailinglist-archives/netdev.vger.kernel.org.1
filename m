Return-Path: <netdev+bounces-184904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB2BA97AAC
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834D47A3309
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB52C2AD7;
	Tue, 22 Apr 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFn5y/l8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495C2C2AB4
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362196; cv=none; b=V3w2uWv85SINDaBk/akhPmfGIcUj03HaySUSO6BjAkYEhW22im9L6WMoJin2Rd8PGbedG3dH6M13rvnLgmZQGHifVisvdD2mKHGer03JjRgn9MU1j2wdqUwmMlFWMnZtnWIta+EP8BX8KnACzA5WRHvQnH4zBZX+ki4upxNPBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362196; c=relaxed/simple;
	bh=gK02uRtbIPfT0wi8eklMvtcyFjPFLGNwxr2+qteMrnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X+qc6oUwB+Phv964Eoa7C/yDyOVpbPaAgvmgwMxCRpMPLt0HNJdQwNNgNSJWOqpPJ2DoYD5qzsv16B4KlL1VkD6h0wTEAciZyHIbkr8DcArIMqnswu+6540gX1nMxAZ9iL+p08yHeFSds4tXc0hW8JSYQkeJ6FQ7aj6N85GlG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFn5y/l8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71A2C4CEEC;
	Tue, 22 Apr 2025 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745362195;
	bh=gK02uRtbIPfT0wi8eklMvtcyFjPFLGNwxr2+qteMrnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BFn5y/l8E2U2vjMF4Ao0SOlj0cvksEMNuehxjcTYbeqNyrTcsRK72/jyCzQZJhkKB
	 uWiFcyaRlQfGC2HiAmsz5yIzo4uw7/11RTH2HkGsrWMIk+SHj3MI3At28k+PU4jZOp
	 Hwn7Ig1KZLcsHc3VaPvqrKGu2U9eJlpAUDdAVIPyvWtkdqda8klhgKBx/pgnIzxLRg
	 I7L2tcSRhNd6m7EDCNCfvpNw3Ps0M8nujulMay541+00y45B1Rs71GEeZ4XAZ/W3Zu
	 r2oLOWKTuxTgWUzRMsVpqufT1Cd3IO/2I2kXXkWyhwovqj1UXaxSudDTxRncbcs5aQ
	 MiLLXVutc9XKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7146E380CEF4;
	Tue, 22 Apr 2025 22:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch v4 iproute2-next 0/2] Add mdb offload failure notification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174536223428.2078978.18421801962462859445.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 22:50:34 +0000
References: <20250415144306.908154-1-Joseph.Huang@garmin.com>
In-Reply-To: <20250415144306.908154-1-Joseph.Huang@garmin.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 bridge@lists.linux-foundation.org, joseph.huang.2024@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 15 Apr 2025 10:43:04 -0400 you wrote:
> Add support to handle mdb offload failure notifications.
> 
> Kernel commits:
> e846fb5e7c52 ("net: bridge: mcast: Add offload failed mdb flag")
> 9fbe1e3e61c2 ("net: bridge: Add offload_fail_notification bopt")
> 
> The link to kernel changes:
> https://lore.kernel.org/netdev/20250411150323.1117797-1-Joseph.Huang@garmin.com/
> 
> [...]

Here is the summary with links:
  - [v4,iproute2-next,1/2] bridge: mdb: Support offload failed flag
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=7e24631ccf31
  - [v4,iproute2-next,2/2] iplink_bridge: Add mdb_offload_fail_notification
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=4f4e3bb5c3d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




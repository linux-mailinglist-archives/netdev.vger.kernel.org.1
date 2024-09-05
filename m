Return-Path: <netdev+bounces-125304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DE596CB7F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAF71F23AD9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D63E46B5;
	Thu,  5 Sep 2024 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjxJSWQ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D91C27
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494440; cv=none; b=TNmfpdednngDm4WEgnVOz5PJyj+7DvmUTKvYCqmGT4d/AJoOH0KxqavTDdhi3STxJlMGkNHgFTQPWETseFkMXUwMwoqmp/CzhSq8GEStYJseGU6GtZ5SqjlNmbd+a7ftggL43IoM3Yp+zKccuyMeFiVTI2ys7a+qErMvtDTalKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494440; c=relaxed/simple;
	bh=G4v53UYgF1zvKzvpgA2Pkl/i5EPzMVatQg6QOvnbvZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TX/HSmpi4bkhnxIspK2wEA6ieb79LMEA5z7bz4J8QwCGFokp7BJc4Fn9lcriFOVMn8RiS5yBMwuf2ASZr3xQVAzB4ZUoGHCl7YfH1f650KJBHaXa2k+7Ioyf7pjNlUGdkk55JB7sBaQHVDpTV91HpuPUZ9lKpDJSFK8uR/qK4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjxJSWQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB753C4CEC2;
	Thu,  5 Sep 2024 00:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725494439;
	bh=G4v53UYgF1zvKzvpgA2Pkl/i5EPzMVatQg6QOvnbvZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CjxJSWQ/FeRNER++KhmsgeJXlwADtp+ziYf52KLLQsORjcBUF17Q16EM5Q7m3yVnW
	 QFEOKAjjBMwRKmbBzL+VcNZRxQ73ZqEmouqVDnmqOMp8UZTqQwJxj8q4HL/Pry6KbI
	 6G/iw/NLdDez8pYQiebZBWUjCGYUKJnGGaksyurHtS1JRdJT0i+UzTw8BTAf9rOFao
	 zfXBW885W+BD3WNlzEf++ZVfPXTTFLnlsO1155mRgXkpr9vx08OY2/Zscq0Dhoiq1x
	 rsNjU0k2f49oXBHaMuqAZgFVB9nEKggLIpIrB9q/0vyd3OAvsQolq1en0VJ6RBWrfJ
	 NxCkVTXemeh/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF83822D30;
	Thu,  5 Sep 2024 00:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] Unmask upper DSCP bits - part 3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549444051.1204284.6459673528302921410.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:00:40 +0000
References: <20240903135327.2810535-1-idosch@nvidia.com>
In-Reply-To: <20240903135327.2810535-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, gnault@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Sep 2024 16:53:23 +0300 you wrote:
> tl;dr - This patchset continues to unmask the upper DSCP bits in the
> IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> DSCP. No functional changes are expected.
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] ipv4: Unmask upper DSCP bits in __ip_queue_xmit()
    https://git.kernel.org/netdev/net-next/c/71f1fea4f65d
  - [net-next,2/4] ipv4: ipmr: Unmask upper DSCP bits in ipmr_queue_xmit()
    https://git.kernel.org/netdev/net-next/c/97edbbaad303
  - [net-next,3/4] ip6_tunnel: Unmask upper DSCP bits in ip4ip6_err()
    https://git.kernel.org/netdev/net-next/c/de1fb3e8b053
  - [net-next,4/4] ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_bind_dev()
    https://git.kernel.org/netdev/net-next/c/c9a1e2629d10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




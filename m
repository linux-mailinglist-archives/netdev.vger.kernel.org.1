Return-Path: <netdev+bounces-170530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B01A48E7F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2D57A8CA8
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB283CC7;
	Fri, 28 Feb 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ1rpMXK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575D3D3B3
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709203; cv=none; b=Y0ATvbwFhdWLrzBVyftdG4qaCNhpuZhi1aDm1ehMmHCmwpz7M4FLAZFNmcHBgiHnPJcwEBi9iAR1p/KJr38JYVenb0FjZS5AnlzPIe/+mNwQfT7ClYM3fZaardYoJYyNqpSx14WwzjKRd6jxxoYB71DWbiz2KYpKC5op0Xj26YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709203; c=relaxed/simple;
	bh=nFFvzj1TOdI8LBnOW67B6U2lYEJ0+FkYwKOzEBa+8Ik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JyZHv7pKxGnCcfk/WY+Fyx/hcKMyaCwei/moLO+uBXHTSPc3fgwFHkrwesH06bb+OpOQy/r623Uue9q5YDb3Ex+rLZQzEUHOYdq3b0CHRlnyhi04mq6nFe6h/2MhaUYeKYdKFrcmJj/csCGvqFYzKfS8qvVbbQXZihgpkvswJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ1rpMXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A26C4CEDD;
	Fri, 28 Feb 2025 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709203;
	bh=nFFvzj1TOdI8LBnOW67B6U2lYEJ0+FkYwKOzEBa+8Ik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NQ1rpMXKYaRr71QbMWirTpNEgjyJNC7p7poZ72i1j2EuuWEs3H7ZiQ4Ac/PG71+Qd
	 Ex+LFtPzBZNCMonIsqxj9YXV+ge5k7EZxD47b1eLY5Vs5HjH9oAXgiBfvm1YXw6IGf
	 9gAb6oNEhayoZte7+ktluArL70+BakdO7eVyecP81TBV5fHzYxme5Hlr/JdaH7r4oq
	 MH2juQ3k21mg55GUO3yFEUXz3Nm5bt1A+wKkHfPiqu0yKDjduiEsfNEGYAI7AT0qU3
	 Bx4VPbP16ZRQgwlc85Nn5UeAh+ByWAKfvKbzTSL9b/5f/yEY8mk6aKmKLAK13TgUDN
	 asbczrijEjPrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD05380AACB;
	Fri, 28 Feb 2025 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] Add missing netlink error message macros to
 coccinelle test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174070923551.1657442.10782071468323686145.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 02:20:35 +0000
References: <20250226093904.6632-1-gal@nvidia.com>
In-Reply-To: <20250226093904.6632-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, tariqt@nvidia.com,
 ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, horms@kernel.org,
 Julia.Lawall@inria.fr, nicolas.palix@imag.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 11:38:59 +0200 you wrote:
> The newline_in_nl_msg.cocci test is missing some variants in the list of
> checked macros, add them and fix all reported issues.
> 
> Thanks,
> Gal
> 
> Gal Pressman (5):
>   coccinelle: Add missing (GE)NL_SET_ERR_MSG_* to strings ending with
>     newline test
>   net/mlx5: Remove newline at the end of a netlink error message
>   sfc: Remove newline at the end of a netlink error message
>   net: sched: Remove newline at the end of a netlink error message
>   ice: dpll: Remove newline at the end of a netlink error message
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] coccinelle: Add missing (GE)NL_SET_ERR_MSG_* to strings ending with newline test
    https://git.kernel.org/netdev/net-next/c/5ace19bd8395
  - [net-next,2/5] net/mlx5: Remove newline at the end of a netlink error message
    https://git.kernel.org/netdev/net-next/c/3a2295ff3f00
  - [net-next,3/5] sfc: Remove newline at the end of a netlink error message
    https://git.kernel.org/netdev/net-next/c/79d89fab225e
  - [net-next,4/5] net: sched: Remove newline at the end of a netlink error message
    https://git.kernel.org/netdev/net-next/c/c94fae5f1ccf
  - [net-next,5/5] ice: dpll: Remove newline at the end of a netlink error message
    https://git.kernel.org/netdev/net-next/c/e0c032d26dab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




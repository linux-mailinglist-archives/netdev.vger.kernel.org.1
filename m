Return-Path: <netdev+bounces-226823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA6BA56B6
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 02:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6631C070B1
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6E181CFA;
	Sat, 27 Sep 2025 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS66Wh6i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0114BFA2
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758933018; cv=none; b=GTiLpGOriuhER5DFMvF8ZdseQUp82bHzV/B16xGCZJH6Bg0SacrzzW61YBV0thgTPPMOpXuAai69f6yH3r5synB0ws3oNdordKBgrLQTOiJ/pnQfuY+h/oWNUUcLR8TZsgK5fnBRA1eY8W/WmTAdBa9p0wdLXseXd2h2jvmK+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758933018; c=relaxed/simple;
	bh=6EiJYD1fzmZHH30HLXdNxSDvlWGhXwaTFNLrNBgc5qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JTv85A4Lc7s64HLGhf+qMO+DvfEwXoxEOSMG6k1LDur/8MChehvMw/Qz9CrhULd9pxM6DwaFPgSffBKHX3+p/8oiSgU4QefN7ywisxKNSIUiRDthxIJ/sLxhjdNV3DTCqnntMcLAr8kJzsjNfqj7+9rMaNRbQHlUiuAazEawwOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS66Wh6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1512DC4CEF4;
	Sat, 27 Sep 2025 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758933018;
	bh=6EiJYD1fzmZHH30HLXdNxSDvlWGhXwaTFNLrNBgc5qc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hS66Wh6i90h4B72SausFbqs1e/hVEJEpJBQvtnDWbOO2VfUSwznLfrWGbCfzOPBLu
	 Q4JSYHaSSLItMWxBJuiW0Xk48vE5ngicvzmtS+Ai2rUTcYTr5XM+W4S2BY9eaaEVap
	 /0VsurqLY1pwZTpAI7MLHteEcnt/ok/1zLJC24OrmthowpYOmCYRJ8fHWCXJYcG1xW
	 3pzo8GtPCWZm2vbV19+anj+gcCcjQy+2rMJTjTgh5IFym1FQkA6D8UKKMuUCdGSmEH
	 HgL6S7gUQAZDv++XobNczHkJw4LhqOUZc4NZHPSqxqbFJTTYGr3hIUzon7bEycNBgV
	 NDKgQyggNclDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E1939D0C3F;
	Sat, 27 Sep 2025 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] add FEC bins histogram report via ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893301325.104870.1559335505983005241.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 00:30:13 +0000
References: <20250924124037.1508846-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20250924124037.1508846-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, andrew@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, tariqt@nvidia.com, gal@nvidia.com,
 intel-wired-lan@lists.osuosl.org, donald.hunter@gmail.com,
 cjubran@nvidia.com, aleksandr.loktionov@intel.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 12:40:32 +0000 you wrote:
> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
> clarifies it a bit further. Implement reporting interface through as
> addition to FEC stats available in ethtool. NetDevSim driver has simple
> implementation as an example while mlx5 has much more complex solution.
> 
> The example query is the same as usual FEC statistics while the answer
> is a bit more verbose:
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] ethtool: add FEC bins histogram report
    https://git.kernel.org/netdev/net-next/c/cc2f08129925
  - [net-next,v6,2/5] net/mlx5e: Don't query FEC statistics when FEC is disabled
    https://git.kernel.org/netdev/net-next/c/6b81b8a0b197
  - [net-next,v6,3/5] net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR
    https://git.kernel.org/netdev/net-next/c/44907e7c8fd0
  - [net-next,v6,4/5] net/mlx5e: Report RS-FEC histogram statistics via ethtool
    https://git.kernel.org/netdev/net-next/c/ca80036839eb
  - [net-next,v6,5/5] selftests: net-drv: stats: sanity check FEC histogram
    https://git.kernel.org/netdev/net-next/c/ed3d74a75411

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




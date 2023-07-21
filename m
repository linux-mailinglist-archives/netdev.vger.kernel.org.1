Return-Path: <netdev+bounces-19711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3109B75BCCD
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 05:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78D6282141
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B253801;
	Fri, 21 Jul 2023 03:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3317F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 03:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84A23C433CA;
	Fri, 21 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689910223;
	bh=UAskOFtaZ+TaZ2/xO+ZiGvJ2EWkR0CxM8zJi0SrkADU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=agwpxmdPttVsCQyM7MND/000TMAOFOo7V5oRqxEaVolkfsLcPH4CnRf7z1bCSk2kC
	 Qfe1cngTCpiH+Y0Pr/IHoktM6seCA7KPLjTrbaD+m9gi7m9AiPOnVOIoyNab3HpMHv
	 IrkGK3xz9riRF5qffNGkuUGFvCuj3QHDBn8c4jEGc/j3E0aR0OftNk3SwsKf7uhGfe
	 KSEE1BlbK/kTzRSsZHXJ1vuDdXcJK6LDBwLxy/7/WJ/ZjEUH+MMpHbIjATWmjQJur3
	 ER9ND27Ow3EJET4FqRTNNbpYv89AuGO7iLVVzmZCrqmJnmxK0qCGJ+YtWyYx6zffkJ
	 e9uHa6uhdUUng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65A00C595C5;
	Fri, 21 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] nexthop: Refactor and fix nexthop selection
 for multipath routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168991022341.12176.7087140976082292516.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jul 2023 03:30:23 +0000
References: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
In-Reply-To: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 idosch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jul 2023 13:57:06 +0000 you wrote:
> In order to select a nexthop for multipath routes, fib_select_multipath()
> is used with legacy nexthops and nexthop_select_path_hthr() is used with
> nexthop objects. Those two functions perform a validity test on the
> neighbor related to each nexthop but their logic is structured differently.
> This causes a divergence in behavior and nexthop_select_path_hthr() may
> return a nexthop that failed the neighbor validity test even if there was
> one that passed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] nexthop: Factor out hash threshold fdb nexthop selection
    https://git.kernel.org/netdev/net-next/c/eedd47a6ec9f
  - [net-next,v2,2/4] nexthop: Factor out neighbor validity check
    https://git.kernel.org/netdev/net-next/c/4bb5239b4334
  - [net-next,v2,3/4] nexthop: Do not return invalid nexthop object during multipath selection
    https://git.kernel.org/netdev/net-next/c/75f5f04c7bd2
  - [net-next,v2,4/4] selftests: net: Add test cases for nexthop groups with invalid neighbors
    https://git.kernel.org/netdev/net-next/c/c7e95bbda822

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




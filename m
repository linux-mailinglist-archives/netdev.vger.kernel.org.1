Return-Path: <netdev+bounces-37582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAC67B626D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BBEA4281720
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA9AD27C;
	Tue,  3 Oct 2023 07:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F3CA65
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 07:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C93A2C433CC;
	Tue,  3 Oct 2023 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696317628;
	bh=JvTWIW1lBa7Ubc6OUbJnmCY8Q7dY/FBTBf81eMVFmLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=drjx1LyErf7tS8ZIBZB3Hp1DwRJBUWKbWg5qBVe10Y966VGcG8gTdFPl7/Px2tPWq
	 gikP1Z+fzCz14/E4bAU/reFKzzfCwzhvNn/M7gfkJORE3akpXp5GbJD02vi2N9LhVT
	 vHu/CuNoy49y4Lj2tEOQIpxpx3AkOt4dIq8xOBPrS7LJypyJqVErp+56VfIDWZrPqm
	 tqdiev8P9rmPQtyzQl5Wm/ghIIKtfFlCvR2oqi8WlHMK45ushI3+PR+CFwii9t0tQ/
	 iwXcl8yYXhoXIM4woSsgsJ8aT9RvnF8Pm5A2vT71iFZTqUcfjq/yFZDER5PAB4wdTl
	 uyAd641nQIbcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD69FE632D2;
	Tue,  3 Oct 2023 07:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net] ipv4/fib: send notify when delete source address routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169631762870.26010.10456343851721710656.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 07:20:28 +0000
References: <20230922075508.848925-1-liuhangbin@gmail.com>
In-Reply-To: <20230922075508.848925-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, dsahern@kernel.org,
 bpoirier@nvidia.com, thaller@redhat.com, stephen@networkplumber.org,
 edumazet@google.com, nicolas.dichtel@6wind.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Sep 2023 15:55:08 +0800 you wrote:
> After deleting an interface address in fib_del_ifaddr(), the function
> scans the fib_info list for stray entries and calls fib_flush() and
> fib_table_flush(). Then the stray entries will be deleted silently and no
> RTM_DELROUTE notification will be sent.
> 
> This lack of notification can make routing daemons, or monitor like
> `ip monitor route` miss the routing changes. e.g.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net] ipv4/fib: send notify when delete source address routes
    https://git.kernel.org/netdev/net/c/4b2b606075e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




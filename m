Return-Path: <netdev+bounces-35032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2497A68E1
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 18:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B15281789
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0336AEF;
	Tue, 19 Sep 2023 16:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2D3AC12
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 16:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C56FFC433C9;
	Tue, 19 Sep 2023 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695141022;
	bh=e2084YiH6+ZcBm1G1WTEy5OtYeoUP7awfupxWhljzO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TK0rOddYbis8VwBEJGsqMQdOwxGHsEfNzvZjxy58zAgocW54jr/8CCOyQn6onTuTO
	 1UvNExj4EIaMKfwvR5Pr3pnl8xLbG3xeJpnBtDO7ag1nCjdEvgbM+TUPtsAXm7q28i
	 FJ5wHWULRnTl/0CvRUl00uTeKQJhLcLmGhmW0MLlakdi4YKBMRya4MgXsdQu1BgOh/
	 k/fPQTLbvIK3cS6MOlLpFz071Rhuas/Dpmc+OamUw/OAkDGN+J1zPLgDliv4OhUJ/W
	 tgFyhLHiXIoZfYrB3fmWqQpmrT4HDxe6r0uP3T9ESDYxZLwpS9TEdQs633gBOXGGG6
	 n3ug9wutTyhUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB561E11F4C;
	Tue, 19 Sep 2023 16:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: lockless IPV6_ADDR_PREFERENCES implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169514102269.32533.7232800814721141366.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 16:30:22 +0000
References: <20230918142321.1794107-1-edumazet@google.com>
In-Reply-To: <20230918142321.1794107-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, dsahern@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 14:23:21 +0000 you wrote:
> We have data-races while reading np->srcprefs
> 
> Switch the field to a plain byte, add READ_ONCE()
> and WRITE_ONCE() annotations where needed,
> and IPV6_ADDR_PREFERENCES setsockopt() can now be lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: lockless IPV6_ADDR_PREFERENCES implementation
    https://git.kernel.org/netdev/net-next/c/fa17a6d8a5bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-70922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B778510DD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27C01F21AD2
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB691AAD7;
	Mon, 12 Feb 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKgUrL5f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B68464
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733827; cv=none; b=N7pMA+t0elHoopSsxR8fnMkp9vF5u2g3Ii+PO7qzYgS2F7ge69KXNKJuKSlmtcSupYnmBFMapInepkXNu96QG8CX+xT0IfGXFX/+o6Zisl/LOyrr5Oh0Wecqm0pCMzp/L7ruUNbjRtAQEKAK8qM4SKlBMrP1JJOoRV3eb0/8jdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733827; c=relaxed/simple;
	bh=ahWw2uBC4q4BrClqu6S/g8dcuVQ8S0DabrlhlLE06s4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CLKCThRO/Sj18qI9eJNT2PahYq6SEvXRC9Uh+RyJeXEiBG/q0Nk+d/QDmAvKDD17+DbFi9SvvvDaSmiDrzY7NJ8E8QgTVT4hi18mylUBIH65DUzBN9+UmUhlxnmp4crSWnMmmIvK980/p482EQWoZmXPQQgsGSG/Q+Q2U1llbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKgUrL5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E2FFC43390;
	Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707733826;
	bh=ahWw2uBC4q4BrClqu6S/g8dcuVQ8S0DabrlhlLE06s4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cKgUrL5f1dOUpsx2vwjUmvCEFg+xdLxxX7rnh3mO3G2SfQyffEJTXNHjJM7x9kXuo
	 mzyNT+t2/fzG5QICv8KqkhkRi+8HiE5gctbrbDEcoviHfOA/eLzkXi4/dMPZKeYiNC
	 NsaJ+WkMEc2fT2WCGC/n4oEb/1IzZlhG20vM5GwXE7uwabX0PlOt0p8YnizCpkkudS
	 am+NrSRl7l7v0wp6Gbe0OHeOxGbkMCoSkm6YLWmgEHIuR0Wc30rxfaq0gsu9jKmbnL
	 mnOlKjWyaWuM9z0L53QCS7hIgSR/LOkxKqPMgTsii9msLh39G2eyLg9j6I3Ur8ICgK
	 7vDPLYSVGlJUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DE87C595CE;
	Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] Remove expired routes with a separated list
 of routes.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170773382644.15535.7179528602502011207.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 10:30:26 +0000
References: <20240208220653.374773-1-thinker.li@gmail.com>
In-Reply-To: <20240208220653.374773-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 liuhangbin@gmail.com, sinquersw@gmail.com, kuifeng@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Feb 2024 14:06:48 -0800 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> This patchset is resent due to previous reverting. [1]
> 
> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
> can be expensive if the number of routes in a table is big, even if most of
> them are permanent. Checking routes in a separated list of routes having
> expiration will avoid this potential issue.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] net/ipv6: set expires in rt6_add_dflt_router().
    https://git.kernel.org/netdev/net-next/c/129e406e1811
  - [net-next,v6,2/5] net/ipv6: Remove unnecessary clean.
    https://git.kernel.org/netdev/net-next/c/60df43d3a72c
  - [net-next,v6,3/5] net/ipv6: Remove expired routes with a separated list of routes.
    https://git.kernel.org/netdev/net-next/c/5eb902b8e719
  - [net-next,v6,4/5] net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
    https://git.kernel.org/netdev/net-next/c/768e06a8bcab
  - [net-next,v6,5/5] selftests/net: Adding test cases of replacing routes and route advertisements.
    https://git.kernel.org/netdev/net-next/c/3407df8dc2de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




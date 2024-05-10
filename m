Return-Path: <netdev+bounces-95293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC28C1D30
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3055B2248E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56A149DE1;
	Fri, 10 May 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn2EWoOj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69D149C6A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715313029; cv=none; b=ukzs9SwEQpEH4pDc97dyoJNXH1PKjKxnrcwsDhDlBDXrloSHPr5k4d6tAEr2V9JmHCcmrt7dXbd6N2zx15y8/CaEEU8M3n1Msaesmk1b1uCVfzOUpvXde5saFzHU99rliF1ndR0kT7m2aIaWoAtgJk9Ne0PhJ4JtKDAwuI8ii40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715313029; c=relaxed/simple;
	bh=LDfyIWC+LXwNIItX18eKF5YGspzXfGJ1U10IjDSEYOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WxDqhBFOvUA8G0KzuQail09XaYI9hFTtpLBdSzC4LUUj0VDIJ3KV9oUGOYSAt92s0Me2IGug/fHl/bX5AiAEfc5T4Y85mKGJBQ7wN7R1NjukjhEzwhj+3eC4U9TmLGfIsctdTtbIzDXWxglh7JW44hmXtJT4h7mGuMig/MQsLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn2EWoOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31E93C4AF08;
	Fri, 10 May 2024 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715313029;
	bh=LDfyIWC+LXwNIItX18eKF5YGspzXfGJ1U10IjDSEYOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zn2EWoOjlUlmjB+VpE0rVNwN9KjpeuW7orIhNBk+lMlI5SiqSa1dv0t9PL6aZEe3E
	 4DSx/ntMbLr1UPiji+lVpSnojnc2ctI7UbH3ky0e3GH+nPvrmR0cRC3Ij/aoWM/82S
	 AzRqeaBcp7oFupIi319l4ndSfE0BdqPjUqJvwwTRJQHU/yB805K7PjIrpZjrm//PXT
	 Hhk67usezpWiT/H/KiuoTnAgkkhYy9IYG0nHVY5x/awMxvq5aW+oKhH0dk4fM+uBul
	 ra0HitNtT8DMNRdkp6AbuqTXBVfrRagHf/u3l6HiQOEplunbmYQnISjhBUkDpMXyLG
	 QkBIRUmvEpTVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20709E7C0E4;
	Fri, 10 May 2024 03:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: get rid of twsk_unique()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171531302912.29493.11188418951927253981.git-patchwork-notify@kernel.org>
Date: Fri, 10 May 2024 03:50:29 +0000
References: <20240507164140.940547-1-edumazet@google.com>
In-Reply-To: <20240507164140.940547-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@amazon.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 16:41:40 +0000 you wrote:
> DCCP is going away soon, and had no twsk_unique() method.
> 
> We can directly call tcp_twsk_unique() for TCP sockets.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/timewait_sock.h | 9 ---------
>  net/ipv4/inet_hashtables.c  | 3 ++-
>  net/ipv4/tcp_ipv4.c         | 1 -
>  net/ipv6/inet6_hashtables.c | 4 +++-
>  net/ipv6/tcp_ipv6.c         | 1 -
>  5 files changed, 5 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [net-next] tcp: get rid of twsk_unique()
    https://git.kernel.org/netdev/net-next/c/383eed2de529

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




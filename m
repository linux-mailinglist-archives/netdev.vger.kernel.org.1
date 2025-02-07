Return-Path: <netdev+bounces-164217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C299A2D033
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 23:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4779D3A18B6
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 22:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467C1B6D12;
	Fri,  7 Feb 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF9oYpLA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C901B4151
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965609; cv=none; b=sC9p6Jy0TM+FFxah5wKXJ8CVYwNErtpr+9T2rKwUxvlthHfMwtyS74FNcL781T22Di5wlxlEUacfkO+JFCLmYMgSIYtMPi2UOSSf+7RCt4w8LZjy6fzq8ySta8TgCQfUQtK7uFM7xxvjun+XNVVTzFY+R8+nuMP0dPZdhjB8j5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965609; c=relaxed/simple;
	bh=kXtR6o5gQ/5eERfIuAdnm/3FHgCQVyQHYCv42BkZ8Iw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bf5p5vXiDvn17n6UKxSKaopxr3SCNI0G9tGFCs6TxHGavMad5RgVqKf3Kw9/xsKMV5d8Fh3axAn1ur6gXdF9+puGHNX+TSteg+Jr2scS8LiJMoJaeb7a5k+eXJ0GPFnm5RMVwTjWLJrUmgPsiMQ4ipiTRn8oP/Yo+1NF+qyegzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF9oYpLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485EFC4CED1;
	Fri,  7 Feb 2025 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965608;
	bh=kXtR6o5gQ/5eERfIuAdnm/3FHgCQVyQHYCv42BkZ8Iw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qF9oYpLA3mdXXzF1nFKId8NzA3LyGb3TEZZiV5brfT5P7wK4n+tigboBCenl3ukNP
	 b4X/Z+zr6Ejn6jleJ6LTJG0NL0MCDh7ft0t6Y2gb37pV5y089tGuRhBz9LFQd/BJpY
	 FQWzlmREVRWe//FthxUVt6Vw1TJBExt2E05soYj1MCIw0yC/eOjKXZBumoWrnbCHhQ
	 QW22oYF22Ejjy00FJ6jIW6miF/zVgUZJbTnzTrQzKZfg/q7ZjoHHJuXaKAi3wSEloZ
	 ysY0T4t0Jzf3O4JLbpeXSvL8ItE4z029+lwrnWIKMJjA2anb1UNpN0vl6l0+0oRm0y
	 9m+qV9gMooWwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710EC380AAEB;
	Fri,  7 Feb 2025 22:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fib_rules: annotate data-races around
 rule->[io]ifindex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173896563628.2397958.2621974164398738009.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 22:00:36 +0000
References: <20250206083051.2494877-1-edumazet@google.com>
In-Reply-To: <20250206083051.2494877-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, dsahern@kernel.org, horms@kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 08:30:51 +0000 you wrote:
> rule->iifindex and rule->oifindex can be read without holding RTNL.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations where needed.
> 
> Fixes: 32affa5578f0 ("fib: rules: no longer hold RTNL in fib_nl_dumprule()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] net: fib_rules: annotate data-races around rule->[io]ifindex
    https://git.kernel.org/netdev/net/c/cb827db50a88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




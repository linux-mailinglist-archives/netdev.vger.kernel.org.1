Return-Path: <netdev+bounces-119069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B11953F5F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3321F24E2B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530501EB31;
	Fri, 16 Aug 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErewVv7h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CA7F9
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774232; cv=none; b=In7d4dScdbKKoQalcfuJEMXePzGhoRe7q3edMBh4I0eN/2K2XcaR6pX1vy4IWOPQYMy5INqcbTNbfNZqcScHqxDvkgYb4guHM8SVR58yI3CnyH+V+3+epYxGqEl0+zb2hdfbN7C4L38juCTyiWQQl/UklTyivApbtoawLTzfGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774232; c=relaxed/simple;
	bh=8SQ+CpPM/C6cIPIU0c+joIHk6aJlbgr8gv080yu88ZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W4Rpeedm8wQ0f1nxaxPh4B0ShguPiujT1qkKJSInVaHjvwgLsasP/2LCLBEI3U+FvL79zT0WcCk/drKfI5DqsuujieJCrhxXqtZuygf+MDI5QFVV8zziDCD8OWWw5xgLO0eJHwJl6T5CXQT+toV2AJIihcTjTwpVcudtTzagHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErewVv7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0142C32786;
	Fri, 16 Aug 2024 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774231;
	bh=8SQ+CpPM/C6cIPIU0c+joIHk6aJlbgr8gv080yu88ZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ErewVv7hnEgIqbc+dCQfbLvJSlHkvSrLL+KR7YNbVcxeG/UK6ivgF8y6o/LBFwtMI
	 UYRcDFJFw9u3xmuoBB4Vc30Ekb7lRp/UNAvAF46WIn849mDAIBGIi622o2xv4/ma5o
	 rxyEa/nV0Ek8MVHP06k1AvfzKwIe/jSU1hVzXgHWOPgW29hdSWc8y36sJbri4/rkD6
	 C5/675J/zjNLZQGUkvHKM1Bs/R6CXD1+qLfPl0R9tnJMaMNZX1zV/dXesIfscc22Pp
	 I4Yq+rjet76VkgXS57FfdYRJjDwL3edempdTMd7ULg1iLlo8wSlb0a5uekXyLfPmxQ
	 mdTc27w00NsTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3417E382327A;
	Fri, 16 Aug 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/5] ip: Random cleanup for devinet.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377423100.3091787.6364320239963750179.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:10:31 +0000
References: <20240809235406.50187-1-kuniyu@amazon.com>
In-Reply-To: <20240809235406.50187-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 9 Aug 2024 16:54:01 -0700 you wrote:
> patch 1 ~ 3 remove defensive !ifa->ifa_dev tests.
> patch 4 & 5 deduplicate common code.
> 
> 
> Kuniyuki Iwashima (5):
>   ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
>   ipv4: Set ifa->ifa_dev in inet_alloc_ifa().
>   ipv4: Remove redundant !ifa->ifa_dev check.
>   ipv4: Initialise ifa->hash in inet_alloc_ifa().
>   ip: Move INFINITY_LIFE_TIME to addrconf.h.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/5] ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
    https://git.kernel.org/netdev/net-next/c/e3af3d3c5b26
  - [v1,net-next,2/5] ipv4: Set ifa->ifa_dev in inet_alloc_ifa().
    https://git.kernel.org/netdev/net-next/c/6e701eb91412
  - [v1,net-next,3/5] ipv4: Remove redundant !ifa->ifa_dev check.
    https://git.kernel.org/netdev/net-next/c/ecdae5168460
  - [v1,net-next,4/5] ipv4: Initialise ifa->hash in inet_alloc_ifa().
    https://git.kernel.org/netdev/net-next/c/100465a91a90
  - [v1,net-next,5/5] ip: Move INFINITY_LIFE_TIME to addrconf.h.
    https://git.kernel.org/netdev/net-next/c/de67763cbdbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




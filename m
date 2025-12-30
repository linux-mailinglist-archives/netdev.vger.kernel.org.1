Return-Path: <netdev+bounces-246323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B47CE950E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A5A300E798
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B048A284880;
	Tue, 30 Dec 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLCkUFpv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC973A1E8C
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089605; cv=none; b=u5zwTA6Xa5k5cyyE+RwLpQNtiZy2S4Y+tp2Git4v5cEcuW+5Nw6pv9LqiSvEBb8vR7w4hoC4p5wNN2RF0NfZQR1jpG3dYady7D5zDszeVGWqqtkcod74Aoe4blEoPz1atNU71l/VzThMfPs+AXs100WT1lkvrmXHdBr6R54vzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089605; c=relaxed/simple;
	bh=gW5+0ZXsba7XCFTZGxLFxUCtC/8uctMGJ8nIJG9xxCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H5Zwb4kPI0qtxo7knugT90aVyBghsK6y6IFlf+pzM80Rj+nf4Yz9TcCjfq5D2uoX9YToWj9kPDLoGV3WXfvbX4JXbfNIQNvhxGMdQv01xdVVK+7g3a8qenygd0oq+Z/0lf2dzdNzLipKM+dfDizsPHuV7KzygyWvq9XlELyK3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLCkUFpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194ABC4CEFB;
	Tue, 30 Dec 2025 10:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767089605;
	bh=gW5+0ZXsba7XCFTZGxLFxUCtC/8uctMGJ8nIJG9xxCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TLCkUFpv3AKWFkLo/BzIJL1u2+w+oFlS1Lzr02hTn3vrdZ8VxXz8SeJguziFH5/lS
	 BzzQeiLbYle/8A4JzAoiqo4EXGjFyGcmk0Zlq0gcyzP19D0/hTPrj2JTV5j0YunIwe
	 tqz7yYo3Dw3N+y9dYxK4fLw9MGJNG8aj3iAa5BZDpNhADnGHoWZxSCqnipKTVrPDMc
	 8rRPhyR1GBboOp00Y9PS118pFhY6WvqZleQRWTaohZJnDwcNRhsPpkTnOyB4Tsrd+7
	 /dnFNSLn0uEhXtMQFzIXZMSM15WkNCxgukg+ICJHDOOCBUGyc3Mbo5a5LWx/ilhYyv
	 kbHqulWtGkpLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7888B3808205;
	Tue, 30 Dec 2025 10:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net: fib: restore ECMP balance from loopback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176708940729.3199412.7975751649095514081.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 10:10:07 +0000
References: <20251221192639.3911901-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251221192639.3911901-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuba@kernel.org,
 shuah@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 21 Dec 2025 19:26:38 +0000 you wrote:
> Preference of nexthop with source address broke ECMP for packets with
> source addresses which are not in the broadcast domain, but rather added
> to loopback/dummy interfaces. Original behaviour was to balance over
> nexthops while now it uses the latest nexthop from the group. To fix the
> issue introduce next hop scoring system where next hops with source
> address equal to requested will always have higher priority.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: fib: restore ECMP balance from loopback
    https://git.kernel.org/netdev/net/c/6e17474aa9fe
  - [net,v3,2/2] selftests: fib_test: Add test case for ipv4 multi nexthops
    https://git.kernel.org/netdev/net/c/3be42c3b3d43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




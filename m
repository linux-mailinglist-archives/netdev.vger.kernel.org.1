Return-Path: <netdev+bounces-31690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06A78F905
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 09:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856DC281844
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A37847F;
	Fri,  1 Sep 2023 07:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B88467
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 07:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E952C433CA;
	Fri,  1 Sep 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693552826;
	bh=DApnd1I1M7tPP3FQYmwz1hqYKhai3MSeYwUhC2rhgy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zu52ILoNar8ikR3tqWfK5BarfPmqJubjMqwAJiy/nETCUAAS41OrNLPuqtqo9ax3F
	 EFeBoDV19D4AYGLACZmTLDHlTbSheHCclikpWdpk1mZX6XTpFr2lNNoGNAZqlMH7jL
	 WrKYDGeO/UZWBaph6/JOt042WKof/eTlkjkAAmHFJHeDDhoEvK9HOLCwupGt1d3hEI
	 0fSDZz9TlC3NJOi/X1OUUe5rYT2aCoTkbmbbSmqo5sg78doVBjNO5GYTVrQtxnnqPa
	 uGZNSomhCtuPzh3HUBoiCgMFWCBlM1hIgiY8cjdI/YB2ToVcsig8UG1d3NxGL5gsws
	 nYvEH+3RPofYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71348E29F3C;
	Fri,  1 Sep 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/3] Avoid TCP resets when using ECMP for
 load-balancing between multiple servers.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169355282645.26042.10042992881944886575.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 07:20:26 +0000
References: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
In-Reply-To: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, shuah@kernel.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 10:03:29 +0200 you wrote:
> All packets in the same flow (L3/L4 depending on multipath hash policy)
> should be directed to the same target, but after [0]/[1] we see stray
> packets directed towards other targets. This, for instance, causes RST
> to be sent on TCP connections.
> 
> The first two patches solve the problem by ignoring route hints for
> destinations that are part of multipath group, by using new SKB flags
> for IPv4 and IPv6. The third patch is a selftest that tests the
> scenario.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] ipv4: ignore dst hint for multipath routes
    https://git.kernel.org/netdev/net/c/6ac66cb03ae3
  - [net,v5,2/3] ipv6: ignore dst hint for multipath routes
    https://git.kernel.org/netdev/net/c/8423be8926aa
  - [net,v5,3/3] selftests: fib_tests: Add multipath list receive tests
    https://git.kernel.org/netdev/net/c/8ae9efb859c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-37297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296DA7B4924
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5307E2819CD
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D265119452;
	Sun,  1 Oct 2023 18:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4B1944B
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20969C433C8;
	Sun,  1 Oct 2023 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696184428;
	bh=G17dZ+jm80HKGtDdVz249jHeXKGuKh5PGgmbwXblgJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IigQZKD0n7ofNlXJXHDIbAi5dOxY0QUA0go5LNwXY+42CA1dJV8ECJXdY3w3PKGdv
	 jy+v81/uE/XS28C4kyfbf7jOczPRfBRE808GY7pJ97l4PKhbKuQKpJqhTQwms+sahj
	 ZED6uRQ1cGpIoYd1aKyONbyPxMtXYszNYRwPu4HoZKj7eRW5Dj4M92m3Eob7KUgTJI
	 Wf38c6FuTO3Pp87ZbnG32aZCb3RqgBVCZmF0t712iehDdEvIpS4yZ+mp3PRCYIOjU4
	 KsMokGGBLVwN1mceGyel8kZtbiez3vz5ioBwv5vZAQ025huB9AuuAKB0EyOeWz7ugs
	 yspV1tlYZgyGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B633C395C5;
	Sun,  1 Oct 2023 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net: more data-races fixes and lockless socket
 options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169618442804.11668.11075268862798548415.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 18:20:28 +0000
References: <20230921202818.2356959-1-edumazet@google.com>
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 20:28:10 +0000 you wrote:
> This is yet another round of data-races fixes,
> and lockless socket options.
> 
> Eric Dumazet (8):
>   net: implement lockless SO_PRIORITY
>   net: lockless SO_PASSCRED, SO_PASSPIDFD and SO_PASSSEC
>   net: lockless SO_{TYPE|PROTOCOL|DOMAIN|ERROR } setsockopt()
>   net: lockless implementation of SO_BUSY_POLL, SO_PREFER_BUSY_POLL,
>     SO_BUSY_POLL_BUDGET
>   net: implement lockless SO_MAX_PACING_RATE
>   net: lockless implementation of SO_TXREHASH
>   net: annotate data-races around sk->sk_tx_queue_mapping
>   net: annotate data-races around sk->sk_dst_pending_confirm
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net: implement lockless SO_PRIORITY
    https://git.kernel.org/netdev/net-next/c/10bbf1652c1c
  - [net-next,2/8] net: lockless SO_PASSCRED, SO_PASSPIDFD and SO_PASSSEC
    https://git.kernel.org/netdev/net-next/c/8ebfb6db5a01
  - [net-next,3/8] net: lockless SO_{TYPE|PROTOCOL|DOMAIN|ERROR } setsockopt()
    https://git.kernel.org/netdev/net-next/c/b120251590a9
  - [net-next,4/8] net: lockless implementation of SO_BUSY_POLL, SO_PREFER_BUSY_POLL, SO_BUSY_POLL_BUDGET
    https://git.kernel.org/netdev/net-next/c/2a4319cf3c83
  - [net-next,5/8] net: implement lockless SO_MAX_PACING_RATE
    https://git.kernel.org/netdev/net-next/c/28b24f90020f
  - [net-next,6/8] net: lockless implementation of SO_TXREHASH
    https://git.kernel.org/netdev/net-next/c/5eef0b8de1be
  - [net-next,7/8] net: annotate data-races around sk->sk_tx_queue_mapping
    https://git.kernel.org/netdev/net-next/c/0bb4d124d340
  - [net-next,8/8] net: annotate data-races around sk->sk_dst_pending_confirm
    https://git.kernel.org/netdev/net-next/c/eb44ad4e6351

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




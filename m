Return-Path: <netdev+bounces-34025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA87A1AD8
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF2A1C20F72
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118BFDDDC;
	Fri, 15 Sep 2023 09:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40FDDC3
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CE0FC433C8;
	Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694770829;
	bh=TOVoAVga0nVSuXUnv+XUVXS1mfZD+cpqBtJ53/BZ9n4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a4grug9znH9QPG/BT0NNxTOMakDCrUhLdGTbw05O7sGdSGct5geTgImC1SqyZi67m
	 vm7Mfu+DugRiSOw38xbgj7aQY/cOkKB/p8EVrxcJXJKJsVToXQEuSFIR5Zji/kssYX
	 Xp5KiiwzYzt7xjPSuWjYjbFbYRqJ8YEMasCf0wn8JMjevkZohuhJ4fzH244zE7NLNi
	 6V8oEW3b63TUXH8eofV7yhHshZ4VewsKWYX0NA/IYNAptjGootJiH4nBQq27x4+vcY
	 1t2m1sHPbjQsIYkNqPvHBj7rgZjioZTKVeHC7OvDGDPYBoAQaS+1WTI4cUune05Le1
	 A1ncyqXqXcEQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44811C04DD9;
	Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] ipv6: round of data-races fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169477082927.23365.2345477309457750514.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 09:40:29 +0000
References: <20230912160212.3467976-1-edumazet@google.com>
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Sep 2023 16:01:58 +0000 you wrote:
> This series is inspired by one related syzbot report.
> 
> Many inet6_sk(sk) fields reads or writes are racy.
> 
> Move 1-bit fields to inet->inet_flags to provide
> atomic safety. inet6_{test|set|clear|assign}_bit() helpers
> could be changed later if we need to make room in inet_flags.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] ipv6: lockless IPV6_UNICAST_HOPS implementation
    https://git.kernel.org/netdev/net-next/c/b0adfba7ee77
  - [net-next,02/14] ipv6: lockless IPV6_MULTICAST_LOOP implementation
    https://git.kernel.org/netdev/net-next/c/d986f52124e0
  - [net-next,03/14] ipv6: lockless IPV6_MULTICAST_HOPS implementation
    https://git.kernel.org/netdev/net-next/c/2da23eb07c91
  - [net-next,04/14] ipv6: lockless IPV6_MTU implementation
    https://git.kernel.org/netdev/net-next/c/15f926c4457a
  - [net-next,05/14] ipv6: lockless IPV6_MINHOPCOUNT implementation
    https://git.kernel.org/netdev/net-next/c/273784d3c574
  - [net-next,06/14] ipv6: lockless IPV6_RECVERR_RFC4884 implementation
    https://git.kernel.org/netdev/net-next/c/dcae74622c05
  - [net-next,07/14] ipv6: lockless IPV6_MULTICAST_ALL implementation
    https://git.kernel.org/netdev/net-next/c/6559c0ff3bc2
  - [net-next,08/14] ipv6: lockless IPV6_AUTOFLOWLABEL implementation
    https://git.kernel.org/netdev/net-next/c/5121516b0c47
  - [net-next,09/14] ipv6: lockless IPV6_DONTFRAG implementation
    https://git.kernel.org/netdev/net-next/c/1086ca7cce29
  - [net-next,10/14] ipv6: lockless IPV6_RECVERR implemetation
    https://git.kernel.org/netdev/net-next/c/3fa29971c695
  - [net-next,11/14] ipv6: move np->repflow to atomic flags
    https://git.kernel.org/netdev/net-next/c/3cccda8db2cf
  - [net-next,12/14] ipv6: lockless IPV6_ROUTER_ALERT_ISOLATE implementation
    https://git.kernel.org/netdev/net-next/c/83cd5eb654b3
  - [net-next,13/14] ipv6: lockless IPV6_MTU_DISCOVER implementation
    https://git.kernel.org/netdev/net-next/c/6b724bc4300b
  - [net-next,14/14] ipv6: lockless IPV6_FLOWINFO_SEND implementation
    https://git.kernel.org/netdev/net-next/c/859f8b265fc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




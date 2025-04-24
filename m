Return-Path: <netdev+bounces-185423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4620FA9A4C4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D23B6748
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C531E5219;
	Thu, 24 Apr 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAeJDrlg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7D8C11
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481009; cv=none; b=i73YL42Q1D+QHfKMLDz8UyWSSuXCECnkAksMXrbbMDuHItyLRuXNIChSbIPmVfQwPB2P3HaUT98x2D4C1msPqwOQBVGC0QmW4V1LodR7+JfuQT8Y05Y3wXYwxsK4J13NUdkx4RMeDnRqSJLJCR51AzUarAKO48mitUTGKUQ9jkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481009; c=relaxed/simple;
	bh=rOpxxm+9KW6szQxQ0KqgxfWTa6IVtYN+ONDUkutwY0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FVvyDH6hbvEmrxjRLU2fW5zwgsk+XrKXbtEJ71TMzcwwhKoc6c2A/KyzAJRu/HQdPwL/PGvJvPuAAQDi0eihQUEyad92lTWPTR9yYJ3WRIuONFiinTTn64Gb2sEJfvzRjhgrwNre21v/pkML1FauaVo8CBiEXbC9zkA7FHomHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAeJDrlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2793EC4CEE3;
	Thu, 24 Apr 2025 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745481009;
	bh=rOpxxm+9KW6szQxQ0KqgxfWTa6IVtYN+ONDUkutwY0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KAeJDrlgSjjrczJnJf/Mq/b6tZpirZUSxduzwbFqEX33y6G4psEp+5BbruR3priMX
	 BLnSbJ/NCoJVcgQeQwakSZJ7zlNm2DK19ivzx4xGY4Mi08vwyYnhG8/t69pgb/EGJG
	 0ExDYCfFTR2f5DW4tgFLx0Su/uhpKX5pQpyfDBCalwY1ZLbGqqoPEHeZVbVgbtAcLQ
	 RoIbQ+Iov/sI1YvKjxvmWG+ENTD+qev/+kNLc1el372E0o7aoYg0ifvJAxqov3rZXg
	 WW0Hz8HqubDdYCfsxfBLcBQR37jzcEYVfwtD9rc7hAY6hT9ps3Dq8bTyGfIjxO0OJe
	 dQHUWWNCq+sZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE42380CFD9;
	Thu, 24 Apr 2025 07:50:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/15] ipv6: No RTNL for IPv6 routing table.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174548104775.3247136.12623057523963360588.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 07:50:47 +0000
References: <20250418000443.43734-1-kuniyu@amazon.com>
In-Reply-To: <20250418000443.43734-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Apr 2025 17:03:41 -0700 you wrote:
> IPv6 routing tables are protected by each table's lock and work in
> the interrupt context, which means we basically don't need RTNL to
> modify an IPv6 routing table itself.
> 
> Currently, the control paths require RTNL because we may need to
> perform device and nexthop lookups; we must prevent dev/nexthop from
> going away from the netns.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/15] ipv6: Validate RTA_GATEWAY of RTA_MULTIPATH in rtm_to_fib6_config().
    https://git.kernel.org/netdev/net-next/c/4cb4861d8c3b
  - [v3,net-next,02/15] ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.
    https://git.kernel.org/netdev/net-next/c/bd11ff421d36
  - [v3,net-next,03/15] ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
    https://git.kernel.org/netdev/net-next/c/fa76c1674f2e
  - [v3,net-next,04/15] ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
    https://git.kernel.org/netdev/net-next/c/e6f497955fb6
  - [v3,net-next,05/15] ipv6: Move nexthop_find_by_id() after fib6_info_alloc().
    https://git.kernel.org/netdev/net-next/c/c9cabe05e450
  - [v3,net-next,06/15] ipv6: Split ip6_route_info_create().
    https://git.kernel.org/netdev/net-next/c/c4837b9853e5
  - [v3,net-next,07/15] ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
    https://git.kernel.org/netdev/net-next/c/5720a328c3e9
  - [v3,net-next,08/15] ipv6: Preallocate nhc_pcpu_rth_output in ip6_route_info_create().
    https://git.kernel.org/netdev/net-next/c/d27b9c40dbd6
  - [v3,net-next,09/15] ipv6: Don't pass net to ip6_route_info_append().
    https://git.kernel.org/netdev/net-next/c/87d5d921eaf2
  - [v3,net-next,10/15] ipv6: Rename rt6_nh.next to rt6_nh.list.
    https://git.kernel.org/netdev/net-next/c/5a1ccff5c65a
  - [v3,net-next,11/15] ipv6: Factorise ip6_route_multipath_add().
    https://git.kernel.org/netdev/net-next/c/71c0efb6d12f
  - [v3,net-next,12/15] ipv6: Protect fib6_link_table() with spinlock.
    https://git.kernel.org/netdev/net-next/c/834d97843e3b
  - [v3,net-next,13/15] ipv6: Defer fib6_purge_rt() in fib6_add_rt2node() to fib6_add().
    https://git.kernel.org/netdev/net-next/c/accb46b56bc3
  - [v3,net-next,14/15] ipv6: Protect nh->f6i_list with spinlock and flag.
    https://git.kernel.org/netdev/net-next/c/081efd18326e
  - [v3,net-next,15/15] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
    https://git.kernel.org/netdev/net-next/c/169fd62799e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




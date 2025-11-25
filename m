Return-Path: <netdev+bounces-241396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4158C8358E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593E83AF3C3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F427F749;
	Tue, 25 Nov 2025 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6LcBvj0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9534288D6;
	Tue, 25 Nov 2025 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764045660; cv=none; b=BXbLhYhvb7lm8OAJgCbhlxjqFCAiqAXhpckal0BxCKAsqlmTkwVU83cQh3OM2zClDL+hLKvJM3qSV5zp4K4PgMcPAZkT5jm4vjpeyL3elxz19pZnwU9kF2zmS+/2KQ0aLQnAvyk2xVA9I8Y0qnXvo3u4MzJElB/vprYPGN4Z07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764045660; c=relaxed/simple;
	bh=QYR4hjfoqH52yadclOSEYGCayQv9/Ag6fW1jB4kKIcA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=meg9sYnSbOlMF4qm34SK3YyBvK9jmkXiwBdLtVIQwEXRsTo5PWK/yVXPOc0XsbH4kiH/1beVu5nAnfzQjB/nMSJhtN3UKsoD9TjGYNm0G2zMG1Oj0MpSs/6C7JBhlgI6R+qUpUw8aMJ6BhEg1ujLPDxTawZ0IGi21/7n6uuEfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6LcBvj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B79C4CEF1;
	Tue, 25 Nov 2025 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764045660;
	bh=QYR4hjfoqH52yadclOSEYGCayQv9/Ag6fW1jB4kKIcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e6LcBvj0yOCj/VknX2c9F7F2Cta6bW7aS4T/hDuEZ5EzgZJBl/DeTUAcXjLOiTVN1
	 QSyBBRD8ZRJsc/LtNxZ5Ivi8x0IE2swWR7GJAEhQJr8LTajLMi8Ks99vIYs1x495Rv
	 cq+qrLvA2SBx0Xc0N2xLpZx2FIKXE2/sGLH0sIQB96wpNSh8Qp+C5FSailLzY6YMzx
	 tHH15kQ6wC/zXiM3rwuZ+UdmYwFM86xLQUp4u8fVlPSa+TMZs4mfKR6Mqr8zBTisZ6
	 FTE0cmyYa9bQ0d7EcXhVThwXEVt/vwjg6vf5dVaVSSTKDrVfurpGUjdME8Z5UZS+uY
	 uI6A/Ys3Regag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340673A8A3CC;
	Tue, 25 Nov 2025 04:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] mptcp: memcg accounting for passive
 sockets
 & backlog processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404562300.189804.16757204264695752077.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 04:40:23 +0000
References: 
 <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: 
 <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 dsahern@kernel.org, martineau@kernel.org, geliang@kernel.org,
 peter.krystad@linux.intel.com, fw@strlen.de, cpaasch@apple.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dcaratti@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 18:01:59 +0100 you wrote:
> This series is split in two: the 4 first patches are linked to memcg
> accounting for passive sockets, and the rest introduce the backlog
> processing. They are sent together, because the first one appeared to be
> needed to get the second one fully working.
> 
> The second part includes RX path improvement built around backlog
> processing. The main goals are improving the RX performances _and_
> increase the long term maintainability.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net: factor-out _sk_charge() helper
    https://git.kernel.org/netdev/net-next/c/075b19c211df
  - [net-next,02/14] mptcp: factor-out cgroup data inherit helper
    https://git.kernel.org/netdev/net-next/c/bd92dd8e03d9
  - [net-next,03/14] mptcp: grafting MPJ subflow earlier
    https://git.kernel.org/netdev/net-next/c/e777a7fb06b1
  - [net-next,04/14] mptcp: fix memcg accounting for passive sockets
    https://git.kernel.org/netdev/net-next/c/68c7c3867145
  - [net-next,05/14] mptcp: cleanup fallback data fin reception
    https://git.kernel.org/netdev/net-next/c/85f22b8e1e9d
  - [net-next,06/14] mptcp: cleanup fallback dummy mapping generation
    https://git.kernel.org/netdev/net-next/c/2834f8edd74d
  - [net-next,07/14] mptcp: ensure the kernel PM does not take action too late
    https://git.kernel.org/netdev/net-next/c/2ca1b8926fda
  - [net-next,08/14] mptcp: do not miss early first subflow close event notification
    https://git.kernel.org/netdev/net-next/c/48a395605e08
  - [net-next,09/14] mptcp: make mptcp_destroy_common() static
    https://git.kernel.org/netdev/net-next/c/9d8295960300
  - [net-next,10/14] mptcp: drop the __mptcp_data_ready() helper
    https://git.kernel.org/netdev/net-next/c/38a4a469c850
  - [net-next,11/14] mptcp: handle first subflow closing consistently
    https://git.kernel.org/netdev/net-next/c/0eeb372deebc
  - [net-next,12/14] mptcp: borrow forward memory from subflow
    https://git.kernel.org/netdev/net-next/c/9db5b3cec4ec
  - [net-next,13/14] mptcp: introduce mptcp-level backlog
    https://git.kernel.org/netdev/net-next/c/ee458a3f314e
  - [net-next,14/14] mptcp: leverage the backlog for RX packet processing
    https://git.kernel.org/netdev/net-next/c/6228efe0cc01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-187620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0BAA82D0
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 22:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734343BE288
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0A2797BB;
	Sat,  3 May 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQKA8JBS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E6149E17
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746305988; cv=none; b=iTX1ByS+aVS2AfcfpiDSGQ0OXE3NHofrXirYcKnnLs48XMNmgqOnBHY9odtNkytyP5HBeUpoaGY+T9hhLW9NZoLQbeHT3oyK8ilRh4/t8MpIXGiVTMXgO2SWs+g70iRMsG55OYXu4vq1Eb58OngoGrNnwVqGdN3DeyrmH3RF8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746305988; c=relaxed/simple;
	bh=lNOSa+BiNy68IDrkses3VidGbbTA1YC+SXAKXj7x9Jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TnfTtbuNd+T6X4prOS+XvVtwoOPDx5qDK06kCAHmrZ2DTR47rXBWPRCblZ+vvVyJST3wM3Jo12asdPhn/l3egOvGVpa/OrluwLXlA1RcflS/en2Vc5l5dB8KbFR/j7T6b58R2PRWXeaEJS/tPgNsc1t6LANtndm27Q0ZCXLQBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQKA8JBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EB7C4CEE3;
	Sat,  3 May 2025 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746305988;
	bh=lNOSa+BiNy68IDrkses3VidGbbTA1YC+SXAKXj7x9Jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EQKA8JBSlYdjpqZdXJSSzLQhj+nqawV6P1dj7p2LFO5VX0ZJWtPJEVHgu2IOOB0Cn
	 Fp56fnTXXyqp9/GcrGVmGeAyLxN8BVwu45vVpZmKHxyH7n4YofaCARogrijlGUYRDC
	 SKhwM2zUtXDrXlEvQtWXfI+Kb6qgNQZ5XvX+zimMAHswPz6utt+2oJG7dNepl8bReO
	 XEWRBBC3Fi8vxFdyPmhhFgvOMWrFKMp30nM+pvueN1izy9G55GIHURbPDF2qqdBcJ2
	 y5mVcjX4kmmxJQYN8WU+WJJSzX0hI9ZiKHGQNBKRBK1xOOy3UEBLJgFYBzuKSB+sa6
	 jBvfFEmQcM9kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF7380DBE9;
	Sat,  3 May 2025 21:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: Honor "ignore_routes_with_linkdown" sysctl in
 nexthop selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174630602726.3923569.14228022387754510869.git-patchwork-notify@kernel.org>
Date: Sat, 03 May 2025 21:00:27 +0000
References: <20250430100240.484636-1-idosch@nvidia.com>
In-Reply-To: <20250430100240.484636-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 30 Apr 2025 13:02:40 +0300 you wrote:
> Commit 32607a332cfe ("ipv4: prefer multipath nexthop that matches source
> address") changed IPv4 nexthop selection to prefer a nexthop whose
> nexthop device is assigned the specified source address for locally
> generated traffic.
> 
> While the selection honors the "fib_multipath_use_neigh" sysctl and will
> not choose a nexthop with an invalid neighbour, it does not honor the
> "ignore_routes_with_linkdown" sysctl and can choose a nexthop without a
> carrier:
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: Honor "ignore_routes_with_linkdown" sysctl in nexthop selection
    https://git.kernel.org/netdev/net-next/c/836b313a14a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




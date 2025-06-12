Return-Path: <netdev+bounces-197020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7CBAD7608
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A48616F985
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7112DCC09;
	Thu, 12 Jun 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsJUNOls"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4629B8EA
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741620; cv=none; b=bLCyHJU2FJg6F7a2utrLrIPD6R8AWaprjibq9/jA4R/Bug5eQtCD7DOz8bZDiM4wYlEfOzAGVqeB+MD5vlrc5z0Tu+VvTjFhO+k9BKrIffFWADgMVklhbW8kf9902nYvt0CKJ5JYcNGajPEm5wCObdYf7oO6VsrCJnK0EHjhR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741620; c=relaxed/simple;
	bh=/K7zS/yOnYtHkAlyz3kuFX1TH0+jGbHwA3YDzBq43RA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ggT1FBhkThSpfMvPITnUoTiCB4ZFr4+9Ntf3HCWDDfiP10ojGebzGsoThtnhzMBerBZYRmao36DI8ARKaGXwdUHCQV50ZH5wM0SNT2kd/rY3L+aWJ2tsh2xKnEHrhEU/7FFKRh2wHHW0FW02kHONNUxVxgZHmsjb4FEtAeiuv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsJUNOls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6EDC4CEEA;
	Thu, 12 Jun 2025 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741618;
	bh=/K7zS/yOnYtHkAlyz3kuFX1TH0+jGbHwA3YDzBq43RA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AsJUNOlsT3aN768mqe9rnTM+SHY8V3lZLfS4j3I4x98wEksjKBR8IlMsvb+SGYQDg
	 gP2Iq/g1BfaZBhoJxCYadaKVyZBzVWuV3aolEDvXpuP7qEaNPiXFgh8W5/VU3AE3Fr
	 SPB29PgnQLppfyc+TV4Vbdmq2KkorCXysVV+1ZyWrCw7InDdxZgEgc3x2IjFtPdxme
	 T2BXSULrMKWdo9gmH6D7FK+tPnpqaCOTIBUyP1zqOSiOn+/GhWM27Wtg09cFuPV/mQ
	 nqwM360NaaizAIISH+ZQz4Gb4oZoJJa5p+Z4S7ATXHqmrdxvXJqmkqDRHFirdio6ak
	 Sw7y+qMGjjwKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C0639EFFCF;
	Thu, 12 Jun 2025 15:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] net_sched: no longer use
 qdisc_tree_flush_backlog()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974164823.4177214.9827119720924150067.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:20:48 +0000
References: <20250611111515.1983366-1-edumazet@google.com>
In-Reply-To: <20250611111515.1983366-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 11:15:10 +0000 you wrote:
> This series is based on a report from Gerrard Tai.
> 
> Essentially, all users of qdisc_tree_flush_backlog() are racy.
> 
> We must instead use qdisc_purge_queue().
> 
> Eric Dumazet (5):
>   net_sched: prio: fix a race in prio_tune()
>   net_sched: red: fix a race in __red_change()
>   net_sched: tbf: fix a race in tbf_change()
>   net_sched: ets: fix a race in ets_qdisc_change()
>   net_sched: remove qdisc_tree_flush_backlog()
> 
> [...]

Here is the summary with links:
  - [net,1/5] net_sched: prio: fix a race in prio_tune()
    https://git.kernel.org/netdev/net/c/d35acc1be348
  - [net,2/5] net_sched: red: fix a race in __red_change()
    https://git.kernel.org/netdev/net/c/85a3e0ede384
  - [net,3/5] net_sched: tbf: fix a race in tbf_change()
    https://git.kernel.org/netdev/net/c/43eb46604121
  - [net,4/5] net_sched: ets: fix a race in ets_qdisc_change()
    https://git.kernel.org/netdev/net/c/d92adacdd8c2
  - [net,5/5] net_sched: remove qdisc_tree_flush_backlog()
    https://git.kernel.org/netdev/net/c/adcaa890c7a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




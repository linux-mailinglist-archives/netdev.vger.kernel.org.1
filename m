Return-Path: <netdev+bounces-249419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A98D186D8
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6916A30402CD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055FB38757F;
	Tue, 13 Jan 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMEeg2L5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70653815F2
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302821; cv=none; b=Q5migAlLcnsSIGRLC4b7oyibuGlkkRR1gQ8W8oNE6hlpyQmPM+aGtrUVUhQ4OgmMViWjWz1UHz6Pm6RcV79FXU8jUT55ux7mvRf2YXWDXq+58Il83aVLWg3S1epQLqnBeh0QDfMKshAff8hlvDoQ8Q91d4d6LRxoV1+je8uMfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302821; c=relaxed/simple;
	bh=BxztyO1qh8uJ0l014evsMbIgkb5z5aHF5gYrPz92OK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zz1gRA0s2/dACT4uCYAixVNIZ2AoJ5WxfB6y4DinIAIze93/bFxR16IEFtfUTsp5ljJ/dwtAa6yyF/QR1iApPkO21hBeFTYNgZm4ufbBmDBIweIw8Rp2cHOTIQgJNoGzo88T0ipU38TLb5r/XJFsxEOpUDfLm0Vsd/Ua3FSeh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMEeg2L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E12C116C6;
	Tue, 13 Jan 2026 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768302821;
	bh=BxztyO1qh8uJ0l014evsMbIgkb5z5aHF5gYrPz92OK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mMEeg2L5elUQikae0HZtxF6U1ue5XMgLz09+8EEgcYmtrkmxtDqZs9CW3nbjayzWz
	 g3WvK3auVhDVUZSUsfoulWJ/3zKj9SxMrGZgMuGSZXQf5BHeoOOnyXzKPRLtV/0QEu
	 T6XhWnhZrQ1+mzNApa5Jacx8Cwt4boCgZp3HSxwveP4PiyamewHvjp2IGjv9CEf0Rn
	 bk8jjVzqOJA6ZNt0LP7gaVb7mmXw1BVsqgUNCd4Q9NLVjQyHL8/vjE1mi5P4mgMYhl
	 jWbtu7RdXz8VkcPnE2WEY1oZn1D0+TqaC40TugoPYOzn/JrjN609LxLPrc1vMQpSRQ
	 /3Cu5CZmNBnjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8813808200;
	Tue, 13 Jan 2026 11:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/6] Multi-queue aware sch_cake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176830261504.2192300.2198008591862995733.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 11:10:15 +0000
References: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
In-Reply-To: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, j.koeppeler@tu-berlin.de,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, willemb@google.com,
 victor@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 09 Jan 2026 14:15:29 +0100 you wrote:
> This series adds a multi-queue aware variant of the sch_cake scheduler,
> called 'cake_mq'. Using this makes it possible to scale the rate shaper
> of sch_cake across multiple CPUs, while still enforcing a single global
> rate on the interface.
> 
> The approach taken in this patch series is to implement a separate qdisc
> called 'cake_mq', which is based on the existing 'mq' qdisc, but differs
> in a couple of aspects:
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/6] net/sched: Export mq functions for reuse
    https://git.kernel.org/netdev/net-next/c/8b27fd66f519
  - [net-next,v8,2/6] net/sched: sch_cake: Factor out config variables into separate struct
    https://git.kernel.org/netdev/net-next/c/bc0ce2bad36c
  - [net-next,v8,3/6] net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
    https://git.kernel.org/netdev/net-next/c/ebc65a873eff
  - [net-next,v8,4/6] net/sched: sch_cake: Share config across cake_mq sub-qdiscs
    https://git.kernel.org/netdev/net-next/c/87826c01837c
  - [net-next,v8,5/6] net/sched: sch_cake: share shaper state across sub-instances of cake_mq
    https://git.kernel.org/netdev/net-next/c/1bddd758bac2
  - [net-next,v8,6/6] selftests/tc-testing: add selftests for cake_mq qdisc
    https://git.kernel.org/netdev/net-next/c/8d61f1a9f254

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




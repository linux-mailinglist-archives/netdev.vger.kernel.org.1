Return-Path: <netdev+bounces-89594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44A8AACFA
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697282824FB
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41AC7EEEC;
	Fri, 19 Apr 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xsr5QERq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C922085
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523231; cv=none; b=NM3S0Ywl6LRVjgBszA5T7HUwfRFtdu4TZpYQLo/pbZXXmw+vlLbbw0pziR1V3YT+doJSR7bZadt9+PJN1bTHVf6eahffUSTYWEujDa27+gpa4wwOnXHCi5pjSZzJvqoM5QcL7JvntMCImbWQA3QOrpN7kKpLGZJi60ubqxZF/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523231; c=relaxed/simple;
	bh=3lCgZldIfwOJ/lRCXlsTG8P/LDyhYh1Pxjb/3fDRIVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FE9gSHtvgxdsaUCHWFYnP3G3RxKNQDSG0e1TZ0hv3mBaCuR4ebg9LpOZ4B60gmqLa/S+n/ODUTPaNTjAbCTG6zmDKl8eEpaCbyjWPy8igxq84KaMfXO/gz479EKT0yCdcBGPUEq1KiH7jsDv5SIoASa7V60cni9oXGrObGkQ82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xsr5QERq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B088C3277B;
	Fri, 19 Apr 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713523230;
	bh=3lCgZldIfwOJ/lRCXlsTG8P/LDyhYh1Pxjb/3fDRIVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xsr5QERqqZFRToDnZGBBhM5GSBiDYK19M4Yh0+RAaVC42jT4vArkUnKzDwiHZnbvK
	 611hdg28CfPq5Rtq9tA1GjxVXJtHFRi8h7wLF6eSZ/LAkKWVpzd5r6NdB+uRogkkg3
	 lD2MY+irZwPPIkkGceBBpZjXGn5nKpjfwQlVfGi041r+KogdYbTl+Av4C7iuNYzvWr
	 Dqn1V9981uSg0dD9g174KaPgfXCSkeohWJDBlnXalm311LhxTIqO6VF3L3qswpVzvs
	 H52d3eHztiF4kiCVDDtzgXjMwBo8fD0rVVO3/bFsdnZKQh/rTOjOrWjMT/eQdjz4ec
	 9rrYXhsD6/kXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B970C43618;
	Fri, 19 Apr 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/14] net_sched: first series for RTNL-less qdisc
 dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171352323050.9279.12566820433428815367.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 10:40:30 +0000
References: <20240418073248.2952954-1-edumazet@google.com>
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 horms@kernel.org, toke@redhat.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Apr 2024 07:32:34 +0000 you wrote:
> Medium term goal is to implement "tc qdisc show" without needing
> to acquire RTNL.
> 
> This first series makes the requested changes in 14 qdisc.
> 
> Notes :
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/14] net_sched: sch_fq: implement lockless fq_dump()
    https://git.kernel.org/netdev/net-next/c/24bcc3076790
  - [v2,net-next,02/14] net_sched: cake: implement lockless cake_dump()
    https://git.kernel.org/netdev/net-next/c/9263650102bb
  - [v2,net-next,03/14] net_sched: sch_cbs: implement lockless cbs_dump()
    https://git.kernel.org/netdev/net-next/c/8eb54a421a62
  - [v2,net-next,04/14] net_sched: sch_choke: implement lockless choke_dump()
    https://git.kernel.org/netdev/net-next/c/7253c1d1e7a5
  - [v2,net-next,05/14] net_sched: sch_codel: implement lockless codel_dump()
    https://git.kernel.org/netdev/net-next/c/c45bd26c829e
  - [v2,net-next,06/14] net_sched: sch_tfs: implement lockless etf_dump()
    https://git.kernel.org/netdev/net-next/c/a1ac3a7c3d1e
  - [v2,net-next,07/14] net_sched: sch_ets: implement lockless ets_dump()
    https://git.kernel.org/netdev/net-next/c/c5f1dde7f731
  - [v2,net-next,08/14] net_sched: sch_fifo: implement lockless __fifo_dump()
    https://git.kernel.org/netdev/net-next/c/01daf66b791e
  - [v2,net-next,09/14] net_sched: sch_fq_codel: implement lockless fq_codel_dump()
    https://git.kernel.org/netdev/net-next/c/396a0038508a
  - [v2,net-next,10/14] net_sched: sch_fq_pie: implement lockless fq_pie_dump()
    https://git.kernel.org/netdev/net-next/c/13a9965de324
  - [v2,net-next,11/14] net_sched: sch_hfsc: implement lockless accesses to q->defcls
    https://git.kernel.org/netdev/net-next/c/49e8ae537002
  - [v2,net-next,12/14] net_sched: sch_hhf: implement lockless hhf_dump()
    https://git.kernel.org/netdev/net-next/c/293c7e2b3e2f
  - [v2,net-next,13/14] net_sched: sch_pie: implement lockless pie_dump()
    https://git.kernel.org/netdev/net-next/c/6c00dc4fdb40
  - [v2,net-next,14/14] net_sched: sch_skbprio: implement lockless skbprio_dump()
    https://git.kernel.org/netdev/net-next/c/c85cedb38f41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




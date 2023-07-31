Return-Path: <netdev+bounces-22733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80599768FE9
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6BD1C20B53
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4BB11C9D;
	Mon, 31 Jul 2023 08:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9811C85
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BF83C433CD;
	Mon, 31 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690791622;
	bh=QO930ajgSTZ9hHK7J2XcO/RXLuiTJzv+s9N/oNplEMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dy56DRjkSHZeGbhuwG1uiX0Z4hqN7ZA7TtbLFyVrXfIk06UpRhwsYIGbLGtAu60F/
	 jt++Zm9irZBNVx30lxwd7yuicFLI9Gb+IzXFuB0fHULz0NWwLcqLz34TGhEXzYv90W
	 YVx7mKbXFeBCxtSw+olwItc/XjCVRIMtE3mGFzCzOgcMKPVk6MlvhFw4iak1sptDPN
	 aSDcAH4PbuWb6vrsjwmuXH9tBx3KnaB8Tqd7HHqjrzh1nOLXii8FWMtk5rjP/7OJzH
	 qn+PGpi3ZLaRXkV+g/EgbpSMIaeNqHxNM7x69z6nzA9pju/sCpjEAfTd0eI3Knyo4Q
	 m6jJpKdvmK19A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AEC5C595C0;
	Mon, 31 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net/sched: taprio: Limit
 TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169079162223.10005.12445736305010223466.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 08:20:22 +0000
References: <20230729000705.36746-1-kuniyu@amazon.com>
In-Reply-To: <20230729000705.36746-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vinicius.gomes@intel.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, vedang.patel@intel.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com,
 pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Jul 2023 17:07:05 -0700 you wrote:
> syzkaller found zero division error [0] in div_s64_rem() called from
> get_cycle_time_elapsed(), where sched->cycle_time is the divisor.
> 
> We have tests in parse_taprio_schedule() so that cycle_time will never
> be 0, and actually cycle_time is not 0 in get_cycle_time_elapsed().
> 
> The problem is that the types of divisor are different; cycle_time is
> s64, but the argument of div_s64_rem() is s32.
> 
> [...]

Here is the summary with links:
  - [v3,net] net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
    https://git.kernel.org/netdev/net/c/e739718444f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




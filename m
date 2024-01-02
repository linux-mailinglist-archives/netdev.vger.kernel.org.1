Return-Path: <netdev+bounces-60878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A3821C0A
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 13:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E561C21E88
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B90BF517;
	Tue,  2 Jan 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfjRdeyy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F6F4F7
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 12:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDC81C433C9;
	Tue,  2 Jan 2024 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704199832;
	bh=Wj0hy3o1jNtlYIFLOvWrpYkfAWFywFNRUU3e+vCKads=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FfjRdeyyOpvkGLZv+w9XTYZp5wSzK7wxfZTSfmbcRBpUB0dsdAif0oGut51amVhpA
	 IvXe1vVlKgN90Tq/kaK+hzZHVN+yBdxKxiugQoxvLcjhEVFgrrqq77CHaz7vfdN2oh
	 pGFCOEB1Bx7P6x3SdsYZwAOvcqzKafQvwBO3Vz4Al42o2XITAof5OSRPKr5mSHuTVd
	 0xmWatIqeEZ9BH+2lq3sSYB6NJ83u/7xmAI7tsfxJQLMYHVxzdv+v2BoIR6Ymv8bXe
	 5I+FlspHDjDZhDGJZiE5dXbYFs5GT6dQa74iQOKTncZcJPINRC8EzhDbC8yO0fWf1L
	 xdRUe9cQlTfZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFAEFC395F8;
	Tue,  2 Jan 2024 12:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/sched: retire tc ipt action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170419983184.27874.10299234443783061890.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 12:50:31 +0000
References: <20231221213105.476630-1-jhs@mojatatu.com>
In-Reply-To: <20231221213105.476630-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, jiri@resnulli.us,
 xiyou.wangcong@gmail.com, stephen@networkplumber.org, dsahern@gmail.com,
 fw@strlen.de, pctammela@mojatatu.com, victor@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 16:31:02 -0500 you wrote:
> In keeping up with my status as a hero who removes code: another one bites the
> dust.
> The tc ipt action was intended to run all netfilter/iptables target.
> Unfortunately it has not benefitted over the years from proper updates when
> netfilter changes, and for that reason it has remained rudimentary.
> Pinging a bunch of people that i was aware were using this indicates that
> removing it wont affect them.
> Retire it to reduce maintenance efforts.
> So Long, ipt, and Thanks for all the Fish.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/sched: Retire ipt action
    https://git.kernel.org/netdev/net-next/c/ba24ea129126
  - [net-next,2/2] net/sched: Remove CONFIG_NET_ACT_IPT from default configs
    https://git.kernel.org/netdev/net-next/c/6d6d80e4f6bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




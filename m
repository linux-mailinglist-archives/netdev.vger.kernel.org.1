Return-Path: <netdev+bounces-37264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2907B476F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 7F67CB2096D
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B817754;
	Sun,  1 Oct 2023 12:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305217753
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 12:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78672C433C7;
	Sun,  1 Oct 2023 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696163425;
	bh=p+ChMF0gZVCMqe4kBBzE+Zzu6Sm2U0JmlhHJQS+ZlN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PFTfboZkd38vCGGCYFDX228t77mSRJp4O20F9QHuX9Wijk9Clmk2rPcBUh06jAyxU
	 s+5uU4W8ZP7POeS1x7Nw6szRaimgWK0BA9mQuNGkpWz/I2wsX8oNVpznJ3pDN/W0vO
	 zAFdBgsQnOb6PzfurWwqT2GE/9Z4LhTj4SiMaXsh05i+AS7hm0i9Id4XmzoElFOUjZ
	 qTunnTmfIjxLVDnrLa5ZqTUrLLI75W02zKYIX1K/xsA47sy7a2aesdzOrBzIP6Nylf
	 RnUmN55yXC1z1ZzYCdR29U9nXCC82Qt2yzIiyMDOM/UT5UVn0RdKFwD8owA7fh+Y/8
	 KUDkvouw2xZdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60684C691EF;
	Sun,  1 Oct 2023 12:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/5] net_sched: sch_fq: round of improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169616342538.16897.2555401624233593537.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 12:30:25 +0000
References: <20230920201715.418491-1-edumazet@google.com>
In-Reply-To: <20230920201715.418491-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, soheil@google.com, ncardwell@google.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Sep 2023 20:17:10 +0000 you wrote:
> For FQ tenth anniversary, it was time for making it faster.
> 
> The FQ part (as in Fair Queue) is rather expensive, because
> we have to classify packets and store them in a per-flow structure,
> and add this per-flow structure in a hash table. Then the RR lists
> also add cache line misses.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/5] net_sched: constify qdisc_priv()
    https://git.kernel.org/netdev/net-next/c/1add90738cf5
  - [v2,net-next,2/5] net_sched: sch_fq: struct sched_data reorg
    https://git.kernel.org/netdev/net-next/c/54ff8ad69c6e
  - [v2,net-next,3/5] net_sched: sch_fq: change how @inactive is tracked
    https://git.kernel.org/netdev/net-next/c/ee9af4e14d16
  - [v2,net-next,4/5] net_sched: sch_fq: add fast path for mostly idle qdisc
    https://git.kernel.org/netdev/net-next/c/076433bd78d7
  - [v2,net-next,5/5] net_sched: sch_fq: always garbage collect
    https://git.kernel.org/netdev/net-next/c/8f6c4ff9e052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




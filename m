Return-Path: <netdev+bounces-18197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B8755BE6
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4281C20A56
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 06:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CFE63AC;
	Mon, 17 Jul 2023 06:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B35257
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79D5AC433CD;
	Mon, 17 Jul 2023 06:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689576020;
	bh=PFrUgUnOrIdL8aGCtJE946FVuH7oU37XkSgCcuK3bXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yh8yXPcb3+7Q03U92Woss0tmdKnHh7pLx0UXEgtSMKuzEB22bCjq1RMH1JIVPNEOP
	 T7HkzLgFYuAfN7JGBEpcaJZeMaYatennLsyTzkUBim/8jU5rTJ1m2NaW75Yrs6RQdx
	 /QBLWTdeIu1jWUEeZNVSZB2w6kzAWsdfIP/DQbkCm04hKw1A25KMyZgHcQuA8o5AXK
	 VRjJS3I9HSYtrNDSXwy6o51x/1EFTcCtICGqu+69CUbF04v7oeUU8mMKBtojul5Otw
	 NYhCLA9cK5DY1AIkw6fu8zTbNXj1Lpp8cLXZ5KYHsu7vlOJxtBqAjxmCavp+31zfrB
	 LnyBi3Zdltgjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FC66E270F6;
	Mon, 17 Jul 2023 06:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/5] net: sched: Fixes for classifiers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168957602038.23010.16088414283465350985.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 06:40:20 +0000
References: <20230713180514.592812-1-victor@mojatatu.com>
In-Reply-To: <20230713180514.592812-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, pctammela@mojatatu.com, simon.horman@corigine.com,
 kernel@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 15:05:09 -0300 you wrote:
> Four different classifiers (bpf, u32, matchall, and flower) are
> calling tcf_bind_filter in their callbacks, but arent't undoing it by
> calling tcf_unbind_filter if their was an error after binding.
> 
> This patch set fixes all this by calling tcf_unbind_filter in such
> cases.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/5] net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
    https://git.kernel.org/netdev/net/c/b3d0e0489430
  - [net,v5,2/5] net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
    https://git.kernel.org/netdev/net/c/9cb36faedeaf
  - [net,v5,3/5] net: sched: cls_u32: Undo refcount decrement in case update failed
    https://git.kernel.org/netdev/net/c/e8d3d78c19be
  - [net,v5,4/5] net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
    https://git.kernel.org/netdev/net/c/26a22194927e
  - [net,v5,5/5] net: sched: cls_flower: Undo tcf_bind_filter in case of an error
    https://git.kernel.org/netdev/net/c/ac177a330077

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




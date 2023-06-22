Return-Path: <netdev+bounces-13011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3585739C87
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 11:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA9A1C20FBE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CF280C;
	Thu, 22 Jun 2023 09:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D21FDF
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC75C433C0;
	Thu, 22 Jun 2023 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687425621;
	bh=mvjP+yi/+cJL9XucgVcxXqllTe6acnPF19TTxhjTeYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AOGdELPdDmcwZoR5UUZ3OjJY1Kuoc6EMEbEHDDqk3NaBjcNjwMCZoD1GBSvU7xs3l
	 yDNLF6VW7UPblxduV8KvKwGhegjka38vgSXd+EOovugzpRxGY+G9WsNrvcNSyQo1hq
	 Me4r3cGoNBn/CRb9Jh/OLBh0o9yquHetlF25ru2ufDxiPxgz3VuMM0Os2Q4AQ4gF/b
	 krYDzBxkX3zt3/ZfVxX1pA5bNM7sCzCT6BemaXVE9p3H7uSuItxGA/K536oJBKhwNJ
	 jW9BldT51l4F0rqOBtAzoFn4OKsB+0zKZjWfiZQu04SBgdBNNc1wYYEqy0gJWVMDO9
	 u3TDJHkNknlmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0239C395FF;
	Thu, 22 Jun 2023 09:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sch_netem: acquire qdisc lock in netem_change()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168742562084.21100.5779776053254524891.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 09:20:20 +0000
References: <20230620184425.1179809-1-edumazet@google.com>
In-Reply-To: <20230620184425.1179809-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 stephen@networkplumber.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Jun 2023 18:44:25 +0000 you wrote:
> syzbot managed to trigger a divide error [1] in netem.
> 
> It could happen if q->rate changes while netem_enqueue()
> is running, since q->rate is read twice.
> 
> It turns out netem_change() always lacked proper synchronization.
> 
> [...]

Here is the summary with links:
  - [net] sch_netem: acquire qdisc lock in netem_change()
    https://git.kernel.org/netdev/net/c/2174a08db80d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




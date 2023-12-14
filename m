Return-Path: <netdev+bounces-57170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392648124E1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE7282B21
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B37FD;
	Thu, 14 Dec 2023 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUgQL5Y+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E17ED
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF317C433C8;
	Thu, 14 Dec 2023 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519224;
	bh=Iu+/7j6EqbYO3jz5KHlW/uX6rI68f+zFSk5YBHnNy7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EUgQL5Y++8sg0aR/iKpIdtPvF3JxVTv8q/vriZFY+znGV/KNLrx0E0c57WPGlF/I0
	 92+GHMzVu5ARwTD2YbJFRxu929G/a+TVwBHow2R9ie8/jxPHscJJBGgAI85PT440fg
	 9yNK/js/YFXsDHqu9MHG6GzzT4fztsRIsgkkiXnPKZQ0O1FslY1CrKlHP+ES2a7LHS
	 /THpuVO6acb+lA8JLk6eJpTydYZa6jiYPf1h7npLXQUFyZj3pog/Wj09A5vozXRk22
	 PcF9Oy2MNr3cGjJnjsWYq2IAF/8W4/OVdJTAAWUbSHKEBezxAYShcSz3vSI28m7zF6
	 x1/7hYsvF5Sng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF1BFDD4EFE;
	Thu, 14 Dec 2023 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net/sched: optimizations around action
 binding and init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170251922477.13218.16639636232634302572.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 02:00:24 +0000
References: <20231211181807.96028-1-pctammela@mojatatu.com>
In-Reply-To: <20231211181807.96028-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, marcelo.leitner@gmail.com,
 vladbu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Dec 2023 15:18:05 -0300 you wrote:
> Scaling optimizations for action binding in rtnl-less filters.
> We saw a noticeable lock contention around idrinfo->lock when
> testing in a 56 core system, which disappeared after the patches.
> 
> v1->v2:
> - Address comments from Vlad
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net/sched: act_api: rely on rcu in tcf_idr_check_alloc
    https://git.kernel.org/netdev/net-next/c/4b55e86736d5
  - [net-next,v2,2/2] net/sched: act_api: skip idr replace on bound actions
    https://git.kernel.org/netdev/net-next/c/1dd7f18fc0ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-206282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F62B02776
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FBF58785B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730E2236F3;
	Fri, 11 Jul 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfyfBJr+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362C223339
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275407; cv=none; b=cFfR/zyCDwY+xOaBwgrmsXeHCtk5rSK15TQkfrKF/wcOUqndijJuVe97yAOtv+/SYwLWdGI3/0b1lBWU/ZnUGwqKAyPqdb0u2z2Pdah1ZOS+x8R8Uj4WAaca+PdjP3zd0UYWSeNcWKFtxwHWNyDVfV4E5Z9U0Q4tHsM199DtFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275407; c=relaxed/simple;
	bh=yM68eyvJzl452FsdG0ERHq8WbGAwFrlHzMkYYrjN0Sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TWdDkPOUZ0xdoiLoIe2sZJla88e0dNLZ8rgZO8k/XSlE7w2SAL7RD64XXjRRKPP93yePaEqW7vreimuIG0wY3CO2LajfggfUwlu61zxf/Y+Kjba/nNFtZ8EQS6Qh59iZruZmfpbW3R0X1UVudWoUVW+HUGvkIdz7xme7ICFfUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfyfBJr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DD3C4CEED;
	Fri, 11 Jul 2025 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752275407;
	bh=yM68eyvJzl452FsdG0ERHq8WbGAwFrlHzMkYYrjN0Sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rfyfBJr+EH7quibrlnk3F+QNb/ChbxYmNyr4J24wirDmd1o2GNnp9ID93LjNEr2R3
	 q+EZZ9TFP2oq0S8CC8gSkHO1c5n/IHjexr/RxKphU2IsnEr15p+Urp/pDpRqdOQZQT
	 Fkl99RtvGpPpRgbnUl2VnKKHf7aa1t5IImcu4E5VZ7yDYBilIIrJ3+9TqDOa2M9oc1
	 eUY6Zh4X+Qu6vyuqs3g91H0smR0+D/R2Qx3gnPayVWUc6v4iYIvAKDts37rvS602IK
	 fEPf72d/nQh73SIQjuhd+/KM1h7tNR3P9kD7+HXHNXZmjgD5q+7mCWh3RxJacWjWli
	 oqEYTFbMjEZBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C43383B275;
	Fri, 11 Jul 2025 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/11] net_sched: act: extend RCU use in
 dump()
 methods
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175227542824.2429127.7588285429935574544.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 23:10:28 +0000
References: <20250709090204.797558-1-edumazet@google.com>
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 09:01:52 +0000 you wrote:
> We are trying to get away from central RTNL in favor of fine-grained
> mutexes. While looking at net/sched, I found that act already uses
> RCU in the fast path for the most cases, and could also be used
> in dump() methods.
> 
> This series is not complete and will be followed by a second one.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/11] net_sched: act: annotate data-races in tcf_lastuse_update() and tcf_tm_dump()
    https://git.kernel.org/netdev/net-next/c/30dbb2d0e16f
  - [v2,net-next,02/11] net_sched: act_connmark: use RCU in tcf_connmark_dump()
    https://git.kernel.org/netdev/net-next/c/0d752877705c
  - [v2,net-next,03/11] net_sched: act_csum: use RCU in tcf_csum_dump()
    https://git.kernel.org/netdev/net-next/c/ba9dc9c14038
  - [v2,net-next,04/11] net_sched: act_ct: use RCU in tcf_ct_dump()
    https://git.kernel.org/netdev/net-next/c/554e66bad84c
  - [v2,net-next,05/11] net_sched: act_ctinfo: use atomic64_t for three counters
    https://git.kernel.org/netdev/net-next/c/d300335b4e18
  - [v2,net-next,06/11] net_sched: act_ctinfo: use RCU in tcf_ctinfo_dump()
    https://git.kernel.org/netdev/net-next/c/799c94178cf9
  - [v2,net-next,07/11] net_sched: act_mpls: use RCU in tcf_mpls_dump()
    https://git.kernel.org/netdev/net-next/c/8151684e3399
  - [v2,net-next,08/11] net_sched: act_nat: use RCU in tcf_nat_dump()
    https://git.kernel.org/netdev/net-next/c/5d28928668a2
  - [v2,net-next,09/11] net_sched: act_pedit: use RCU in tcf_pedit_dump()
    https://git.kernel.org/netdev/net-next/c/9d0967465726
  - [v2,net-next,10/11] net_sched: act_police: use RCU in tcf_police_dump()
    https://git.kernel.org/netdev/net-next/c/cec7a5c6c695
  - [v2,net-next,11/11] net_sched: act_skbedit: use RCU in tcf_skbedit_dump()
    https://git.kernel.org/netdev/net-next/c/1f376373bd22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




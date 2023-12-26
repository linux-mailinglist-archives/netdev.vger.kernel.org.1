Return-Path: <netdev+bounces-60330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F081EA2C
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 22:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1DECB21079
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1584C8B;
	Tue, 26 Dec 2023 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwR2gGeh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A174C87
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 21:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88585C433CA;
	Tue, 26 Dec 2023 21:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703626224;
	bh=oDLvuR28QQuAuuZ4nQHbot089roHuSQpnq+USYKmH3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qwR2gGehkIdaD0rKxpFbJz6yu6fHMoz/oZtqv8OKfv1rCa5q/fiGHpEoClEFg7Oav
	 Fpa68PBTrh6EaTxSO3EmaaXfv4MrpdIkVNcmIEm2WaBhoVKv2X31VYDLsCXRxLgDIa
	 29prZL71GpOIquXVc/1jaGKsUsxNBCs30duyVRSsXDEh8N6YrZyHrTTPldleBtxudQ
	 Yvyg1TJlEU+auP1e0B+NqoSlnmE2S2c+M/k+bFmjgTgQFAtKkoFEK4Xu0XzIyZmoK3
	 WMPPcFLLzNJg7fZQkS/6U8P1Slp5mF20WCHGj22dw1VXUsZZvF4CkdtVb59M1GF0Lg
	 2fZ+V9Hst0ZcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6554FE333D7;
	Tue, 26 Dec 2023 21:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/5] net/sched: Introduce tc block ports tracking
 and use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170362622441.9388.9107098884966655363.git-patchwork-notify@kernel.org>
Date: Tue, 26 Dec 2023 21:30:24 +0000
References: <20231219181623.3845083-1-victor@mojatatu.com>
In-Reply-To: <20231219181623.3845083-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
 pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 15:16:18 -0300 you wrote:
> __context__
> The "tc block" is a collection of netdevs/ports which allow qdiscs to share
> match-action block instances (as opposed to the traditional tc filter per
> netdev/port)[1].
> 
> Up to this point in the implementation, the block is unaware of its ports.
> This patch makes the tc block ports available to the datapath.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/5] net/sched: Introduce tc block netdev tracking infra
    https://git.kernel.org/netdev/net-next/c/913b47d3424e
  - [net-next,v8,2/5] net/sched: cls_api: Expose tc block to the datapath
    https://git.kernel.org/netdev/net-next/c/a7042cf8f231
  - [net-next,v8,3/5] net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability
    https://git.kernel.org/netdev/net-next/c/16085e48cb48
  - [net-next,v8,4/5] net/sched: act_mirred: Add helper function tcf_mirred_replace_dev
    https://git.kernel.org/netdev/net-next/c/415e38bf1d8d
  - [net-next,v8,5/5] net/sched: act_mirred: Allow mirred to block
    https://git.kernel.org/netdev/net-next/c/42f39036cda8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




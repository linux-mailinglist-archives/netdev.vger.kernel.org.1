Return-Path: <netdev+bounces-63426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D5982CD98
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221201C21244
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469451FB3;
	Sat, 13 Jan 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1ROya6p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE181FA1
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 15:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF376C433F1;
	Sat, 13 Jan 2024 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705161025;
	bh=Midn0nfRjNRVd39VbG4ZNG1ITp1w5Id7NNSkotVUT7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n1ROya6psSw/DFPzhtoxFps6YurtxXLf0o3zFpfeMeAfmBFivX5NZUp8PFtVCfcoD
	 mK8JNJx2EN15W8CtbNLIbsGMNkhf0PPyhYkbeHYc8aBbMFf5VtJkcp7gRVPQhaH+it
	 RnQeFnBYwl4tCAAznjClRXjJ60rh5+46/dzb1lFG1UmV93SdpbbzylBE3F1yaAKvEX
	 XgrNgKRDSYx4Nd9GCByhiGSq1/JOkHXaozuvdJMqcBFTrPUDABlphTsgkr6XqSF42y
	 s5W+aVTEm3nDplYKv0qUHMWiZNYrnMl470ETV3tLYq9Zm1OYcFnKROCev+Bsm1ybwn
	 AJJgc4DFo9Liw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C54ABD8C987;
	Sat, 13 Jan 2024 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] net: sched: track device in tcf_block_get/put_ext() only
 for clsact binder types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170516102580.25764.16175588702923724162.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 15:50:25 +0000
References: <20240112113930.1647666-1-jiri@resnulli.us>
In-Reply-To: <20240112113930.1647666-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com,
 idosch@idosch.org, mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Jan 2024 12:39:30 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Clsact/ingress qdisc is not the only one using shared block,
> red is also using it. The device tracking was originally introduced
> by commit 913b47d3424e ("net/sched: Introduce tc block netdev
> tracking infra") for clsact/ingress only. Commit 94e2557d086a ("net:
> sched: move block device tracking into tcf_block_get/put_ext()")
> mistakenly enabled that for red as well.
> 
> [...]

Here is the summary with links:
  - [net] net: sched: track device in tcf_block_get/put_ext() only for clsact binder types
    https://git.kernel.org/netdev/net/c/e18405d0be80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




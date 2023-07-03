Return-Path: <netdev+bounces-15239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC11746445
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 22:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587B6280EC9
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E281094B;
	Mon,  3 Jul 2023 20:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292710788
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 20:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ABEDC433CA;
	Mon,  3 Jul 2023 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688416821;
	bh=a/WFLQXH/cv3+fruGQcAKSvSqa+ZGYpp9BtzzN48c/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u0cxCr7tFWkzj7eGIRVzTNOUKv9gyTJjVseB9qs3Gk1mhul26GVwXljdwBp7RXa53
	 FIVZwFTonFzkzq+ke0uENxC3D3usM9aE8MzJjhn/QN/bcdrG9Z3pCMLquBZbfflZxY
	 +CcQEzowkiidMVFINL8wwph6oyonLW/4f6YztNhxi7I8l+5OTdaOUQNiPnD30lSfiM
	 JNODE6e9M45BlP8DHW9npBFivhqwBspTYs+6CdDpS7XjnGLgV7+5/K1DMyra/yPs73
	 SqxwJ++HYYZv3niYodC71ox5JMJHiS4quy4oG+ds4Mbjr6JCof2j4yROQS1sPHJO54
	 oSJDwyE2+2WHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CB85C04E32;
	Mon,  3 Jul 2023 20:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device attribute
 invisible when not supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168841682144.15554.860228703846635745.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 20:40:21 +0000
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, pabeni@redhat.com,
 kuba@kernel.org, saeed@kernel.org, gal@nvidia.com, davem@davemloft.net,
 lkft-triage@lists.linaro.org, ltp@lists.linux.it, nathan@kernel.org,
 naresh.kamboju@linaro.org, lkft@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 16:21:39 -0700 you wrote:
> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.
> 
> Fixes: c3b60ab7a4df ("ptp: Add .getmaxphase callback to ptp_clock_info")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/netdev/20230627162146.GA114473@dev-arch.thelio-3990X/
> Link: https://lore.kernel.org/all/CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com/
> 
> [...]

Here is the summary with links:
  - [net,v1] ptp: Make max_phase_adjustment sysfs device attribute invisible when not supported
    https://git.kernel.org/netdev/net/c/2c5d234d7f55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




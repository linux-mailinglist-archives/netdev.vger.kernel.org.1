Return-Path: <netdev+bounces-58939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970E818A74
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C72B1C20ED1
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2A1BDFD;
	Tue, 19 Dec 2023 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4EIuC53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9131BDEC
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6538EC433C7;
	Tue, 19 Dec 2023 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702997427;
	bh=SjMjQdiT4/xcZh8wAQF4vA9n8J09Ld8bKKA6tgiiAYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j4EIuC53rV70qTkxl880XdFEespess0M6d5XGcZlUJ+GEdSTEclciBFC/EtILuDFR
	 TAomlEbyhbVzPlSnMh/Rg6mDa/TEy9oa3Lp8poxI0BxR7IwuBZoUmKNJxNGZz7kjw3
	 JGOdENCvbSt5c8WSHjGSpCV9j4iAjcLjOJ0No+ymdEbeuZMJ+CUdpsUAOZ1I90tQqY
	 V+7v8dlC2rvwhF4iJYcgDrCxZfta5Dl2WeDX9xnfOL310zzZ633cl6o2vkMcSFJ3pB
	 U4WvWlIyU7tjq6dST+8dt7OLZLL/EghBt35tWqeEo5HeC9Yl4X59KA5Buyk+AuaHMG
	 OrbvQq4Y1Y0bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C889C561EE;
	Tue, 19 Dec 2023 14:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v8 0/9] devlink: introduce notifications filtering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170299742730.24056.16690489398114445428.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 14:50:27 +0000
References: <20231216123001.1293639-1-jiri@resnulli.us>
In-Reply-To: <20231216123001.1293639-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
 jhs@mojatatu.com, johannes@sipsolutions.net,
 andriy.shevchenko@linux.intel.com, amritha.nambiar@intel.com, sdf@google.com,
 horms@kernel.org, przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 16 Dec 2023 13:29:52 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently the user listening on a socket for devlink notifications
> gets always all messages for all existing devlink instances and objects,
> even if he is interested only in one of those. That may cause
> unnecessary overhead on setups with thousands of instances present.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/9] devlink: use devl_is_registered() helper instead xa_get_mark()
    https://git.kernel.org/netdev/net-next/c/337ad364c48a
  - [net-next,v8,2/9] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
    https://git.kernel.org/netdev/net-next/c/11280ddeae23
  - [net-next,v8,3/9] devlink: send notifications only if there are listeners
    https://git.kernel.org/netdev/net-next/c/cddbff470e33
  - [net-next,v8,4/9] devlink: introduce a helper for netlink multicast send
    https://git.kernel.org/netdev/net-next/c/5648de0b1f2b
  - [net-next,v8,5/9] genetlink: introduce per-sock family private storage
    https://git.kernel.org/netdev/net-next/c/a731132424ad
  - [net-next,v8,6/9] netlink: introduce typedef for filter function
    https://git.kernel.org/netdev/net-next/c/403863e985e8
  - [net-next,v8,7/9] genetlink: introduce helpers to do filtered multicast
    https://git.kernel.org/netdev/net-next/c/971b4ad88293
  - [net-next,v8,8/9] devlink: add a command to set notification filter and use it for multicasts
    https://git.kernel.org/netdev/net-next/c/13b127d25784
  - [net-next,v8,9/9] devlink: extend multicast filtering by port index
    https://git.kernel.org/netdev/net-next/c/ded6f77c05b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




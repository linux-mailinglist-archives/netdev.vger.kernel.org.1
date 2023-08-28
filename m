Return-Path: <netdev+bounces-31077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5978B413
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF031C20942
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFE112B9B;
	Mon, 28 Aug 2023 15:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CF46AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87D7BC433C9;
	Mon, 28 Aug 2023 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693235426;
	bh=1huhoU3egi185unJwEIKOx+anulzH0a80bAypmmlKqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mUnVEMioRK1IcYFsOAYy2Ig28q8VEgdfIY3zKPnTA3+L7C583EwAQLXLPAYohE/e0
	 lJ6BCTzT5dumvZK0C/zqrx+c5es104paR/ODVzWUw+TTvkY6aN4Vw3yYSUvN+dlK0p
	 yLcGZCOMB8NPveHQdGvSKDLNKMOvdqzBAI6Bo2jnTvyYakTWJW+XXM+sX1w1hq+qOc
	 DvSE7tPsYHOIxxkRmN8zI2LlR7sZ/vGE+YBQV63Z69wcJVVbNw05yzjxC+IO3ktczF
	 uTdITP0eCGuwTdRsnYdoXGsKfhQ6Dj90VCTUGRhpbxrSULzcDPe11dnbQn4rTQNCNx
	 aXMdiOKzKAwLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BA8FC3274C;
	Mon, 28 Aug 2023 15:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v2 00/15] devlink: finish file split and get retire
 leftover.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169323542643.23917.7003415325979671600.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 15:10:26 +0000
References: <20230828061657.300667-1-jiri@resnulli.us>
In-Reply-To: <20230828061657.300667-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, moshe@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Aug 2023 08:16:42 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset finishes a move Jakub started and Moshe continued in the
> past. I was planning to do this for a long time, so here it is, finally.
> 
> This patchset does not change any behaviour. It just splits leftover.c
> into per-object files and do necessary changes, like declaring functions
> used from other code, on the way.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] devlink: push object register/unregister notifications into separate helpers
    https://git.kernel.org/netdev/net-next/c/56e65312830e
  - [net-next,v2,02/15] devlink: push port related code into separate file
    https://git.kernel.org/netdev/net-next/c/eec1e5ea1d71
  - [net-next,v2,03/15] devlink: push shared buffer related code into separate file
    https://git.kernel.org/netdev/net-next/c/2b4d8bb08889
  - [net-next,v2,04/15] devlink: move and rename devlink_dpipe_send_and_alloc_skb() helper
    https://git.kernel.org/netdev/net-next/c/2475ed158c47
  - [net-next,v2,05/15] devlink: push dpipe related code into separate file
    https://git.kernel.org/netdev/net-next/c/a9fd44b15fc5
  - [net-next,v2,06/15] devlink: push resource related code into separate file
    https://git.kernel.org/netdev/net-next/c/a9f960074ecd
  - [net-next,v2,07/15] devlink: push param related code into separate file
    https://git.kernel.org/netdev/net-next/c/830c41e1e987
  - [net-next,v2,08/15] devlink: push region related code into separate file
    https://git.kernel.org/netdev/net-next/c/1aa47ca1f52e
  - [net-next,v2,09/15] devlink: use tracepoint_enabled() helper
    https://git.kernel.org/netdev/net-next/c/85facf94fd80
  - [net-next,v2,10/15] devlink: push trap related code into separate file
    https://git.kernel.org/netdev/net-next/c/4bbdec80ff27
  - [net-next,v2,11/15] devlink: push rate related code into separate file
    https://git.kernel.org/netdev/net-next/c/7cc7194e85ca
  - [net-next,v2,12/15] devlink: push linecard related code into separate file
    https://git.kernel.org/netdev/net-next/c/9edbe6f36c5f
  - [net-next,v2,13/15] devlink: move tracepoint definitions into core.c
    https://git.kernel.org/netdev/net-next/c/890c55667437
  - [net-next,v2,14/15] devlink: move small_ops definition into netlink.c
    https://git.kernel.org/netdev/net-next/c/29a390d17748
  - [net-next,v2,15/15] devlink: move devlink_notify_register/unregister() to dev.c
    https://git.kernel.org/netdev/net-next/c/71179ac5c211

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




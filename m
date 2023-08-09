Return-Path: <netdev+bounces-26030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145DA776990
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D2128156A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16924530;
	Wed,  9 Aug 2023 20:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C224533
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8F55C433CD;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691611825;
	bh=C3Oii1qH5qaf2VSboIsTMSNBzs6AXpfkNLrc4/5E21c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lDRIvZ765kUr+qrpsMvvenWiedrTY167XxXYTBQ2DzaW7khRZqD0rAxK+8HQQzmuI
	 LmZ6jZ75RQvK3hYJhBpwpaHa8lWNag7ym/Y0gvVY3CyjZl14CS9zqDJviIPs8tMuYf
	 s54kn5+p5udoIyZpXyUiLJMGvgZkC5v1WuBMQvnJK7BwF25b7l4j2YHypkb/Ri5LLE
	 KeVbRz43uMR5xR5OHjm5Res6oPQipDXyhqKzniH6LrIKYDNG5uWy1nPp3QF9i0Px0u
	 +jdcIS8bx78R72hcjKojPnfZ8Fr0a4EsteHi1RerzL87R0zyGz/Wk0UZbQbLhM+uzR
	 6bL6R3liz0lEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD23DE33093;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] devlink: clear flag on port register error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161182583.10541.10907530961152248811.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:10:25 +0000
References: <20230808082020.1363497-1-jiri@resnulli.us>
In-Reply-To: <20230808082020.1363497-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Aug 2023 10:20:20 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> When xarray insertion fails, clear the flag.
> 
> Fixes: 47b438cc2725 ("net: devlink: convert port_list into xarray")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] devlink: clear flag on port register error path
    https://git.kernel.org/netdev/net-next/c/832140804e3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




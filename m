Return-Path: <netdev+bounces-29012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D4E781673
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7749281D81
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C26653;
	Sat, 19 Aug 2023 01:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD12652
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 01:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D69CC433C9;
	Sat, 19 Aug 2023 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692409220;
	bh=n6VpUZ0yop5FNlnLsjuWCgvAWIAZNAkHwCHVpYkdzi0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZzN03a56IZXipMx9r8Y378Oss4uRwNBk6teLUYwvY1cShcrr+OV+NFp5U8WvIlCnx
	 PxWAORuRrDS1aaydOF63azUQnh0tsCipw/1cfLH4OpxtYeHfiSDwwlB/9ZA0TMn9B6
	 +lZqDFurJIoK+fIpZYE5vPF+BtZGerSqSuX55i1gOht30lDNLpBjQ3VNcm054H/hGO
	 irOEqqaYTVK5aKSuoKbKPudeFA3Bdksn67JogKV6wDpOsNuuA4WdIPpMyCM62zDQCi
	 4lW7A9cnz1npTrw9Uopg6h939MZfqhuPgmJtilSlZXzUg5Mtmd0w8USmOkosWX6/uA
	 j5+U70dFGTxwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DD1AE93B34;
	Sat, 19 Aug 2023 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] devlink: add missing unregister linecard
 notification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169240922024.22025.15630794111562365776.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 01:40:20 +0000
References: <20230817125240.2144794-1-jiri@resnulli.us>
In-Reply-To: <20230817125240.2144794-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, idosch@nvidia.com, petrm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 14:52:40 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Cited fixes commit introduced linecard notifications for register,
> however it didn't add them for unregister. Fix that by adding them.
> 
> Fixes: c246f9b5fd61 ("devlink: add support to create line card and expose to user")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] devlink: add missing unregister linecard notification
    https://git.kernel.org/netdev/net/c/2ebbc9752d06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




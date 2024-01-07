Return-Path: <netdev+bounces-62223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE94826493
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3152281D24
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8AC134B9;
	Sun,  7 Jan 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FS9YAPeT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5E134A7
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 15:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C628C433C9;
	Sun,  7 Jan 2024 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704639623;
	bh=j6Nxiqnj2ukHCiOzhaXXjcMQc7n1Pb060PTjE9okPOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FS9YAPeT4oDX6pYQNTgfnkDN9BQb6WK8QMNm7XBBNg81GHjPpgMuEwJSBXCpYBCKO
	 /uOJ5jVmCnizQVPrRmls/5SRofazypdy/FozRddLlLOADXPibeVg3i/UsNOphkGTCC
	 TKNzvUy1g4FWpMV6kePILgwyBdWOmqJSosDhwB9wBn1UmwCfjLkZNWP8c2foyo4Lz8
	 TSQKeW7IYA0xMLPnbZg8FV/yI93t/27z8X+m0lUMSrI7CVBLu10fmO/Lv43QNCxG4m
	 sC/zdzYW+Eu703GSMenfwZHZEDby1gnbLCyGLdP8zygqV3YdJOhWj/ikZo2wL680nk
	 ALinLmVxRk5Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 035E3C4167F;
	Sun,  7 Jan 2024 15:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/sched: simplify tc_action_load_ops parameters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170463962300.2084.8551283300595601952.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 15:00:23 +0000
References: <20240105003810.2056224-1-pctammela@mojatatu.com>
In-Reply-To: <20240105003810.2056224-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, jiri@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Jan 2024 21:38:10 -0300 you wrote:
> Instead of using two bools derived from a flags passed as arguments to
> the parent function of tc_action_load_ops, just pass the flags itself
> to tc_action_load_ops to simplify its parameters.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/sched: simplify tc_action_load_ops parameters
    https://git.kernel.org/netdev/net-next/c/405cd9fc6f44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




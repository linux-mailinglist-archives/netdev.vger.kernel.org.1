Return-Path: <netdev+bounces-48495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB57EE964
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 23:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B88AB20A09
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB38FBE8;
	Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+oyA/+K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271011717
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71210C433C8;
	Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700174426;
	bh=XsfiM2G17MPZ9iXmhDRPJcDN2JsUBSBT+NoL7nLysXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t+oyA/+K6eDJYFry0w9LkBUiSa2mk0iABZQSpa54UMBPf29y0dJhA3zTTdC9psvmp
	 anhItQH5+0LNEabck/qMRvpaQxeQqXgc99EIwSXUVBfaiaIzqIDQXokwzATulCQP6K
	 4kKh01joOoNTf3u2MClkJytD7RBifGS6ACfqNBcghZqLSeDICb4Vx9OH66Z0+pTRpx
	 /ggXPMN9P/N5y07Sk8V66QBgrWhn2r1PiyDHEREcNB1rZ3aKVRiWfyfB/gK+b/7UZt
	 9uUsRONtWTz4owTFLil5yUDsu0G6KmStlCNID9uMoMGpuvX1zUlXfDNrLNVIQW8XIj
	 sCXnq5+Pz56Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FB2EC395F0;
	Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] selftests: tc-testing: updates to tdc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170017442632.21715.647751781868559907.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 22:40:26 +0000
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
In-Reply-To: <20231114160442.1023815-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 13:04:38 -0300 you wrote:
> - Patch 1 removes an obscure feature from tdc
> - Patch 2 reworks the namespace and devices setup giving a nice speed
> boost
> - Patch 3 preloads all tc modules when running kselftests
> - Patch 4 turns on parallel testing in kselftests
> 
> Pedro Tammela (4):
>   selftests: tc-testing: drop '-N' argument from nsPlugin
>   selftests: tc-testing: rework namespaces and devices setup
>   selftests: tc-testing: preload all modules in kselftests
>   selftests: tc-testing: use parallel tdc in kselftests
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests: tc-testing: drop '-N' argument from nsPlugin
    https://git.kernel.org/netdev/net-next/c/9ffa01cab069
  - [net-next,2/4] selftests: tc-testing: rework namespaces and devices setup
    https://git.kernel.org/netdev/net-next/c/fa63d353ddfb
  - [net-next,3/4] selftests: tc-testing: preload all modules in kselftests
    https://git.kernel.org/netdev/net-next/c/bb9623c337f5
  - [net-next,4/4] selftests: tc-testing: use parallel tdc in kselftests
    https://git.kernel.org/netdev/net-next/c/04fd47bf70f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




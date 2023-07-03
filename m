Return-Path: <netdev+bounces-15059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD974573C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA831C204F0
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360E440E;
	Mon,  3 Jul 2023 08:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DDC1C08
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0F15C433BD;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688372422;
	bh=srJPRWMRNrhN7YZBUsB92axNpYSklojC0gn01qIJrmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QxJUcip0A87b7bz6WFNxon3cN1V4hDMzgrbfR+ZCSGdokK1vsrBXaOpGhxgdfwbYH
	 CjS2tmUY6Ib21C/bLkeP3Ium9eQXHscn35XMnKBaopaqGAQImR7gjbrfCJikEXNOoq
	 aVVAYKsDhET8qVN9SQT+lfQp2N+HG88C6VKNcNJOUHUPyEynHcsRKt7xSMwG6FTkNL
	 kva3+GJCRCYuXm1txi0Vh0pzLKEM5b4dwbLZY1irwRUbUpb3/Z2bYaKZTilaq7Wryl
	 XoO2238lt1ZTYpGrb40391jPvEusoPn3b8rpBMM3voFaO2WCc3DucHaquAg7JsGN+W
	 KbWy75qhWpWDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D853C691EF;
	Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: Add xt_policy config for xfrm_policy test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168837242251.9798.901827370226067728.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:20:22 +0000
References: <20230701044103.1096039-1-daniel.diaz@linaro.org>
In-Reply-To: <20230701044103.1096039-1-daniel.diaz@linaro.org>
To: =?utf-8?q?Daniel_D=C3=ADaz_=3Cdaniel=2Ediaz=40linaro=2Eorg=3E?=@codeaurora.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 22:41:03 -0600 you wrote:
> When running Kselftests with the current selftests/net/config
> the following problem can be seen with the net:xfrm_policy.sh
> selftest:
> 
>   # selftests: net: xfrm_policy.sh
>   [   41.076721] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>   [   41.094787] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>   [   41.107635] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>   # modprobe: FATAL: Module ip_tables not found in directory /lib/modules/6.1.36
>   # iptables v1.8.7 (legacy): can't initialize iptables table `filter': Table does not exist (do you need to insmod?)
>   # Perhaps iptables or your kernel needs to be upgraded.
>   # modprobe: FATAL: Module ip_tables not found in directory /lib/modules/6.1.36
>   # iptables v1.8.7 (legacy): can't initialize iptables table `filter': Table does not exist (do you need to insmod?)
>   # Perhaps iptables or your kernel needs to be upgraded.
>   # SKIP: Could not insert iptables rule
>   ok 1 selftests: net: xfrm_policy.sh # SKIP
> 
> [...]

Here is the summary with links:
  - selftests/net: Add xt_policy config for xfrm_policy test
    https://git.kernel.org/netdev/net/c/f56d1eeaeabf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




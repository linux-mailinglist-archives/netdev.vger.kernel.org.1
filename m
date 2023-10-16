Return-Path: <netdev+bounces-41180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75407CA1A3
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 10:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67847B20CCB
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003A18B08;
	Mon, 16 Oct 2023 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFoPYwtU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155CD14AA4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 08:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84196C43395;
	Mon, 16 Oct 2023 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697445049;
	bh=DOh/Dn4riXMOxmCe1w4Jo11cFO7dxLPkLHjXE2zEcCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kFoPYwtUaMVqquLQ5hGcK1A+5tmvYUnKmXKP1eMBgsgPz5w5kD8Xokxi6r0PsGMcf
	 yTTMCf/X3lx1V6Uhx4t4DEo2vH1FVAAdEUsmBef08Oo8Gl2/mPhXIxWyfxpjrSz3I0
	 6EApIC4rJqC/6ZrhrhbX8BlSuxPbMxuQdGkYs+O6UU2loEuxeTj7gN4e6290PyDE39
	 AYgKT20u93b+XlRzr0yDLHJ5M7ZKaP54ta8qkGJy98NsVvdolvAvW3EUYAUxJym0Ju
	 zINUGoP/6rofMNwDEGf4cN+RMlQo82RtzVLq5kmE6PrACMxpYW/AXCbZGQ9ThCs7tb
	 7yiJljvVP1QXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E695C43170;
	Mon, 16 Oct 2023 08:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: net: remove unused variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169744504944.19592.15378403408237334163.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 08:30:49 +0000
References: <20231016063039.3771-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20231016063039.3771-1-zhujun2@cmss.chinamobile.com>
To: zhujun2 <zhujun2@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 15 Oct 2023 23:30:39 -0700 you wrote:
> These variables are never referenced in the code, just remove them
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/af_unix/scm_pidfd.c     | 1 -
>  tools/testing/selftests/net/af_unix/test_unix_oob.c | 2 --
>  tools/testing/selftests/net/nettest.c               | 5 +++--
>  3 files changed, 3 insertions(+), 5 deletions(-)

Here is the summary with links:
  - selftests: net: remove unused variables
    https://git.kernel.org/netdev/net-next/c/3c4fe89878fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




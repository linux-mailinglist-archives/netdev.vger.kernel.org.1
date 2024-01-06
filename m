Return-Path: <netdev+bounces-62141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF6825E07
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 04:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00220284F3B
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 03:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594771396;
	Sat,  6 Jan 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9O4wYk2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85515B1
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 03:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1C4EC433CA;
	Sat,  6 Jan 2024 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704510624;
	bh=7dyq80MEV8mmyqq6ZJoZBLnre4YvBxVgXm4bgVO47VQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A9O4wYk2Oj/pJuJKDm/zH3aQMeH5+xgzLFjlw1ZLSsR0sySkXuxYrO7ccz9OZwGbn
	 5XeD6CAkbfX6XtF6TerRHLo74ysYzs45PKPlDO357p6gLrbIyp0nlNbUX7bTYBjs9U
	 8yyFjOO4FBVyy5YdyJJGxGa+yKWfP0RaBjiUbWIEa2OHGBVFLMacyaAMd8X9+nqvHp
	 SCfWuAaClrHwrxh7whHfiwKH0JV9OkvdzhIiFHgrYI1YYjt/bqDZUKVcuUh8dfECkv
	 TSWuNkSC01/Qjt0Z6YvxR1qofVyRI/npicaENM/3I8M1PqCjL0iaS4jyx6ltkK9OD8
	 ce/klEq9Ni8Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98C20C41606;
	Sat,  6 Jan 2024 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] geneve: use DEV_STATS_INC()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170451062461.13331.4152922396524392194.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jan 2024 03:10:24 +0000
References: <20240104163633.2070538-1-edumazet@google.com>
In-Reply-To: <20240104163633.2070538-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 16:36:33 +0000 you wrote:
> geneve updates dev->stats fields locklessly.
> 
> Adopt DEV_STATS_INC() to avoid races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/geneve.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] geneve: use DEV_STATS_INC()
    https://git.kernel.org/netdev/net-next/c/c72a657b5cca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




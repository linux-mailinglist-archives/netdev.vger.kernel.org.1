Return-Path: <netdev+bounces-23773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A512E76D79C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D6C1C20B31
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E014107B2;
	Wed,  2 Aug 2023 19:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2319470
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42443C433D9;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691004023;
	bh=NiJBLlyQ3IYsd12PmTpY0f/Eh6LZC7NxYf5i++or9Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X/PeMr0Zg8RmnkfY1Gvwz/x1GHDN8gnTJC+AUTYYFXNUYkYONarumThMIsv7hgEAp
	 +RxrsJBt7SxHWnu+/lMZ3+1+36Y5Naj114mexQDeOeyTUZQNMF5fwuRezmTtk7uWU0
	 9p6ShPVW/o8b2qj/RQdNAQvivSqG46ydmz/63I3uT0SliTHTkOq76XPrZ1X0nADs+J
	 T20+6KK2eiGgx9uo1BEsu6DD6HYs2RyrVCxJjG0zN+R6emZA5u7qxtvIZzf87jAgRO
	 Wtzx3E8Tq1y0+Oqi9hxArAEyEaChlC43XvRsRGHDAF27s/I96UmNmsrpTHuNsHBl3F
	 T7UZ1Cda27JdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2618BE270DD;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnx2x: Remove unnecessary ternary operators
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100402315.28133.15015770894477543473.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:20:23 +0000
References: <20230801111928.300231-1-ruanjinjie@huawei.com>
In-Reply-To: <20230801111928.300231-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: aelior@marvell.com, skalluru@marvell.com, manishc@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Aug 2023 19:19:28 +0800 you wrote:
> There are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2:
> - Fix the subject prefix and commit message issue.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnx2x: Remove unnecessary ternary operators
    https://git.kernel.org/netdev/net-next/c/ae336f30d513

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




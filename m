Return-Path: <netdev+bounces-29912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C407852DE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DDE281288
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851549461;
	Wed, 23 Aug 2023 08:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453679D8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 738E0C433C8;
	Wed, 23 Aug 2023 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692780023;
	bh=71Ib7dKBnuBJNw6OcCJVQxErbOXXcRFXV7RHAmc/jJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hR5+jUcMPSUsH3evefI6CZdrc5ZpGRBJawUwJuYy2cn2Rhs3Nwi8HYyn8W/6GMt9Q
	 IdXlx4yUX63la8pRKa6uxk5V7igJknyjvwnyhMUy7YJVjHmP3Hgg4jFoDenbEJ2mHE
	 C5dldVtPhYxkDag/vhas3sjglj1/YRPJRIQQh6R/G8xc6El4vL67nRHCSyRrViVd2T
	 UE0skGqCEVAewKZeIds1aU6VwcO3ZkaUVPEBhU8PeQUwboru/nauwdDfm3uphpPWj1
	 Cewh0wAyCqDy46Icv8/BDx21nJ0g4FuGPxUGVdkoXx3AnOBE2WoqRCnPZqRsmb/6OA
	 0pb7rJ5wEnO5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DEF9E4EAF6;
	Wed, 23 Aug 2023 08:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dp83640: Use list_for_each_entry() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169278002331.8188.8920718192775693100.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 08:40:23 +0000
References: <20230821133528.3131786-1-ruanjinjie@huawei.com>
In-Reply-To: <20230821133528.3131786-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Aug 2023 21:35:28 +0800 you wrote:
> Convert list_for_each() to list_for_each_entry() where applicable.
> 
> No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/phy/dp83640.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net-next] dp83640: Use list_for_each_entry() helper
    https://git.kernel.org/netdev/net-next/c/45f9cb6bd971

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




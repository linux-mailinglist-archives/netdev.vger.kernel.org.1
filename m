Return-Path: <netdev+bounces-15981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47D074AC86
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53921C20E45
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015658477;
	Fri,  7 Jul 2023 08:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7279C6
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 234D0C433C9;
	Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688717422;
	bh=g5lsoS1kcycjXztjR1PJ/Oy1gkd8iXLWN9aRuubkuOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=osop7ms9amrh3cjHNWpekVSmBG+3PeOZ024h5TKwSziY82hrS1JjyDdvG3ptOoC1X
	 glvUqDY0q+PoMrcU/iJTNFwHeR38YiVgiC7hxAiHIwe0pfE6YvbYVafKpCCLrVA9SW
	 tlObNagE7fK7dFfSDWMVt6WzoY5KEjcKzb1CRLXj9RHcixTmXqn4tavydDXJ+zISie
	 QgV3gtd83mtFNGc8mAhW+YiahApQREWa0NvsmVpX5Qq5rz6BYKsO5VwVIpTy0R4dVf
	 PwOIzgZ5KVMiQoyfqhXKemeasxU5c+CxFoY/TsFL1ksJADKRhzoBhv5XOYbM3qrKlj
	 xwjGwrKFBdpKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 087B1E53801;
	Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v3] octeontx2-af: Move validation of ptp pointer before
 its usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168871742203.16578.3372513027335067632.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 08:10:22 +0000
References: <20230706082936.1945653-1-saikrishnag@marvell.com>
In-Reply-To: <20230706082936.1945653-1-saikrishnag@marvell.com>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, dan.carpenter@linaro.org, maciej.fijalkowski@intel.com,
 naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 6 Jul 2023 13:59:36 +0530 you wrote:
> Moved PTP pointer validation before its use to avoid smatch warning.
> Also used kzalloc/kfree instead of devm_kzalloc/devm_kfree.
> 
> Fixes: 2ef4e45d99b1 ("octeontx2-af: Add PTP PPS Errata workaround on CN10K silicon")
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-af: Move validation of ptp pointer before its usage
    https://git.kernel.org/netdev/net/c/7709fbd4922c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




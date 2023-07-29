Return-Path: <netdev+bounces-22495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86557767B5C
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 03:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326F61C2193F
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858DB80F;
	Sat, 29 Jul 2023 01:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CE81A
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 225F0C433CA;
	Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690595421;
	bh=mZ+rxgX8J26nByC+aaxIC5h1VkY6KCU4LCkd0DN6hQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xj0Q2I7DE8MqrhsAP8S5DpkKhzXWnqhw7iJz+BGWg1vYt/QiJuHRGcNc52z6p+82/
	 u4oHwHjFiGU52HJE63TIE9KCtjKktxiHvwa7EmhNmu+R2zqZ+Mx9gOfwXVHvgV8sjl
	 rqIKG5250VCDcN/fOwV3OAcAxOiD7RBaVX5lpQcpC3kE8fFsPcd9RtqdK4DBwmJvEs
	 I68ojWje+W48xzoHE4zSf//XuDWdCqsT9+TwY0WdwFObZhJtNiVyzzvTwCrl5aZhL7
	 c+ktHtc6izqUsHBcxKOMqacVN6/MY+lG7ZuPb3SHXmK55pP7QJyD5pMcSm8v8KMDls
	 Xmm+UKo7U1/tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CDC3C39562;
	Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: enable page_pool support
 for MT7988 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169059542104.13127.1082963853637832076.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 01:50:21 +0000
References: <fd4e8693980e47385a543e7b002eec0b88bd09df.1690440675.git.lorenzo@kernel.org>
In-Reply-To: <fd4e8693980e47385a543e7b002eec0b88bd09df.1690440675.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 09:02:26 +0200 you wrote:
> In order to recycle pages, enable page_pool allocator for MT7988 SoC.
> 
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_eth_soc: enable page_pool support for MT7988 SoC
    https://git.kernel.org/netdev/net-next/c/58ea461b690c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




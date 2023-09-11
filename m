Return-Path: <netdev+bounces-32783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8B79A6CC
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C890F2811AC
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152BC120;
	Mon, 11 Sep 2023 09:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B83BE5C
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2922C433C9;
	Mon, 11 Sep 2023 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694425226;
	bh=VexeRoFIErq8J/8XR03dPblD5jykwUeFBd2AKAgeJqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iD8Gs+/zUl7AJMEAIqzv4fLwwsC/hjuq+KuN7Yjv3QLFuQmkjZLawgQUGB/P6UAnC
	 GlsV01t+ReHoEO5R23c4od0MQA4mS58cI7Mio6nU++NieWhV3xKLAMHUN2hfgQbDBM
	 5fM8ghU0AMeSNGQcvkkCfjo56KwB994dDDJXRoLrzIEy9Fa2Z42+7svf+CT/5cV5bV
	 PsEtAOqX8+5elt/qZxW/PTIxSG2zNL4UZy/b1tG/W6fakeDbh9UYCRl42oaZ3r624z
	 63oNifE/zTko5AqRQIPfAJyXDluxsx6KYcn/lsNKRZQ2GybM0oA2h1ygKVnbJBtcLD
	 zGsGnsAj4DIsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6F1BC00446;
	Mon, 11 Sep 2023 09:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix uninitialized variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169442522587.29871.12263337568524186830.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 09:40:25 +0000
References: <30044cf16ff83f73e5ef852c25682e9fde63af51.1694376191.git.daniel@makrotopia.org>
In-Reply-To: <30044cf16ff83f73e5ef852c25682e9fde63af51.1694376191.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: dan.carpenter@linaro.org, nbd@nbd.name, john@phrozen.org,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 10 Sep 2023 22:40:30 +0100 you wrote:
> Variable dma_addr in function mtk_poll_rx can be uninitialized on
> some of the error paths. In practise this doesn't matter, even random
> data present in uninitialized stack memory can safely be used in the
> way it happens in the error path.
> 
> However, in order to make Smatch happy make sure the variable is
> always initialized.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mtk_eth_soc: fix uninitialized variable
    https://git.kernel.org/netdev/net/c/e10a35abb3da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




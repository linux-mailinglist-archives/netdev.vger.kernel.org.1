Return-Path: <netdev+bounces-29752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD79D784940
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD6281191
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDF51DDCD;
	Tue, 22 Aug 2023 18:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544851DA46
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C06C6C433C9;
	Tue, 22 Aug 2023 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727826;
	bh=U+cSFv8/1fknASccAAc5oGRY0vemVLI+IykDasqvQiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eBSLngf2UJwYSxajRyiPc43wZS0Upcrex2n3c3ruWYzoh7E+npKodwtj7yMmJVCTC
	 o5lIFbTSDMrb/k9NrSRJDObGF9p+Um/e90sa9K76NDPQLveIcLZ562tkMtD6YSc6hn
	 csPGyqNlz0kw0ONgLFaI/PBiKG7+GlLkYxv5Y1uA1lzvlXJ8kYiWpGjq7+BY8dyhOE
	 RznQbRlLJejUqWvRkATfirnLFqLnbutZifEOVjngz6Gx3Yl/0rZ0eThCwpQ1S4qvDP
	 Nn3sxrrEnfM9VaEhUkenX0KzDfr7DW6AxQesGE6T465oKcLLUpHvbNmS/ER440JxsM
	 +Cgh8+EAR5vlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0A24E4EAF6;
	Tue, 22 Aug 2023 18:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix NULL pointer on hw
 reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272782665.18530.10943324313439520312.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:10:26 +0000
References: <5465c1609b464cc7407ae1530c40821dcdf9d3e6.1692634266.git.daniel@makrotopia.org>
In-Reply-To: <5465c1609b464cc7407ae1530c40821dcdf9d3e6.1692634266.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 17:12:44 +0100 you wrote:
> When a hardware reset is triggered on devices not initializing WED the
> calls to mtk_wed_fe_reset and mtk_wed_fe_reset_complete dereference a
> pointer on uninitialized stack memory.
> Break out of both functions in case a hw_list entry is 0.
> 
> Fixes: 08a764a7c51b ("net: ethernet: mtk_wed: add reset/reset_complete callbacks")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mtk_eth_soc: fix NULL pointer on hw reset
    https://git.kernel.org/netdev/net/c/604204fcb321

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-137302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E02C9A54FC
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CD51F21D86
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DC1957FC;
	Sun, 20 Oct 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5hxtTMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A91957E4
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440633; cv=none; b=PjLculBKNpC1aRo3IEuetyPPjuL0wI6TSRT9pSGv/NyMLg8UmyIcPmrZtCu54BJNiu4xvM6NpIbUUn8vXGINb0qhddUsZ8YfAwGCfX2C3zmtRpWZ3ydc1i5htdxQb623dXe+QKO0UsYL1ePaV33clB5rKfgAFjopppBxHaNmid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440633; c=relaxed/simple;
	bh=UUabHuMBj6T5Mw4+gO7s2Bb8IsFaQraBLWnCpJUJ2bk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dAimajCn77a/2qTXEpENBIZbRHXnZRkp2YvIC3Tqtvt3DhnWfiReK9hMe2CN4MI0JbTOJOjQhoC1PaY5MRFdxJICcXqsttfFftNDwzMgBYh4uLPtK5LB80ejUBJ0IBqVJAZMvaEYjgltEeerqEs+1Ndvu+z7GX/D7zAhgvE1Uqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5hxtTMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF0C4CEE5;
	Sun, 20 Oct 2024 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440633;
	bh=UUabHuMBj6T5Mw4+gO7s2Bb8IsFaQraBLWnCpJUJ2bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d5hxtTMNP+Sl0JKcs0vDqDEEtY2wPvgy+1OE6BNPOZCWVzY2iml4L0//pDJOPi/QR
	 S2WMmM226Z8ruDnUb90Ujk7l4JAEBMuH5tcZ6uHRVs1FiMoVAbskf7P45pMCP1gofm
	 c4w1YAj1UCBgmg/R1+bvOBj+RwBxXu1xR3pt+pfzFj1jGmi67/9qCYc9GgJ5/+SOzL
	 Vz5wAegMhp7JOnhxCN6vrS6LCN4c1RQd5TNTPejNRbhkUiw2ZJ/aKRb5RtKlbt9mYa
	 Rw82xy4ULmMa6JIqi0LTwg+7OPadgb8XMZVLyTRJ+sx1STKegvgNaFxNuigyr1JZW4
	 y8OxiYo+SC8gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE01B3805CC0;
	Sun, 20 Oct 2024 16:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Reset BQL stopping the netdevice
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944063949.3604255.311498943475544885.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:39 +0000
References: <20241017-airoha-en7581-reset-bql-v1-1-08c0c9888de5@kernel.org>
In-Reply-To: <20241017-airoha-en7581-reset-bql-v1-1-08c0c9888de5@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Thu, 17 Oct 2024 16:01:41 +0200 you wrote:
> Run airoha_qdma_cleanup_tx_queue() in ndo_stop callback in order to
> unmap pending skbs. Moreover, reset BQL txq state stopping the netdevice,
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Reset BQL stopping the netdevice
    https://git.kernel.org/netdev/net-next/c/c9f947769b77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




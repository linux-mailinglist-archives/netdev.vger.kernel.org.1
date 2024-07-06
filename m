Return-Path: <netdev+bounces-109587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E71928FCB
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 02:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADEC1C22166
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E253A9;
	Sat,  6 Jul 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ13BSAy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F621256D;
	Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227032; cv=none; b=Iue5i9oQecoBJ3HC1hDFtU4lNmcmk+1hEsH/TPpt7yxBv6N0hJYQmwvqmMiE4k3tp1kwx3oglPdLzgdO6F5gokFj22gQeLByCcYwmHBF1b1U9vkX5pHxUAcYoFgyHKgiiTisy9FyUlNF+ZOug0NQsprJptN967AOaMOnXQkS17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227032; c=relaxed/simple;
	bh=HXI9F2ozN47lIoalS26/JYpw58LCH3Ts4N8MhjcGSRg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gA3JxgudhZUqznxM4Ry8YgKPWLXqPN4lxQaH0nT4DlafLbExLTEUnlrRYvCDZLZVIuBJq8LNLnhcxZUfboz89jAxdxVyiIH3E2QB+V9j9L1V2qX7/bzuBtw5b+sqo/P4aW7QZs/hR0RxDAY6XxmB5R039qCCJByD+pNtSuKY/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ13BSAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A540C4AF0A;
	Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720227031;
	bh=HXI9F2ozN47lIoalS26/JYpw58LCH3Ts4N8MhjcGSRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JQ13BSAyJAcj+HqE4VITbXvGp5bh5LKDp0SuXKBPhAf5zMn3jB4K8neJAnSfnLNL8
	 q/7kb5fa/dDSTHVTt6WuUGDKJyDL2MR6OIZCX8McdSDURcnFx4hnAxA6m1KoU26uaa
	 /hrHcuwPq13uD7NxXVUdDLJfzqLrJa+8dddVPNpcMdYRkxXAa3iV29eJ/CRtnUN8C8
	 TK94jp6AvNt6dVUIXdQgR04W+cgg34bR1ie9XmNlP0ZZr7hLulTiyCLHQskDIN9+rO
	 14grHr/lJ8AalelomHQfBOchspgmY4Z3FJJSse0x6mvLR4kduK8zf2Kg/dMgLZwYMX
	 NXjkoBZcTzWYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E7E3C433A2;
	Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: implement
 .{get,set}_pauseparam ethtool ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022703158.32390.5319141379722143709.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 00:50:31 +0000
References: <e3ece47323444631d6cb479f32af0dfd6d145be0.1720088047.git.daniel@makrotopia.org>
In-Reply-To: <e3ece47323444631d6cb479f32af0dfd6d145be0.1720088047.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: john@phrozen.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Jul 2024 11:14:55 +0100 you wrote:
> Implement operations to get and set flow-control link parameters.
> Both is done by simply calling phylink_ethtool_{get,set}_pauseparam().
> Fix whitespace in mtk_ethtool_ops while at it.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_eth_soc: implement .{get,set}_pauseparam ethtool ops
    https://git.kernel.org/netdev/net-next/c/064fbc4e9b5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-27875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8677D80E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47277281578
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017311C01;
	Wed, 16 Aug 2023 02:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD017E8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 888A8C433CC;
	Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151223;
	bh=/SivyJg8L6IR/Depj/t+YI1jAL7OVWimX+0Y3ciOitI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HoHHqUSN72uGtTeAaxsXXiAJnXHu18/C1a7kcmlmGPJvkOM1eo+FGYfN1R1Qs0dnB
	 N3rvXM8HvY+vmHAOJMa2U9bFsWRWmZbQTrW0W4kz5IGNIx+l2vDEQJgqAEjNmjrCQR
	 UM1bGxm+6W7ttums0RPEiqtLIwvfmWe1pjnZX3lm8Vf357FYnrKkQJODV7IdZegDr5
	 PrNiM3GZqeVPTV8C4ny0u+jZVsb+feD1Thdvo+t8Qnn21GaFVIS1NvscTunEyztQz5
	 ga0nvTbV2kH8AYgTgqn7R7DYNnUEe53Ub4a9pApc5DwMRLajDXUUpNXhqlbUwrTKFC
	 G5S7F7hNxsKGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B29EC395C5;
	Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: mediatek-ge-soc: support PHY LEDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215122343.15326.15132582167017916301.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:00:23 +0000
References: <dc324d48c00cd7350f3a506eaa785324cae97372.1691977904.git.daniel@makrotopia.org>
In-Reply-To: <dc324d48c00cd7350f3a506eaa785324cae97372.1691977904.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: dqfext@gmail.com, SkyLake.Huang@mediatek.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 02:58:14 +0100 you wrote:
> Implement netdev trigger and primitive bliking offloading as well as
> simple set_brigthness function for both PHY LEDs of the in-SoC PHYs
> found in MT7981 and MT7988.
> 
> For MT7988, read boottrap register and apply LED polarities accordingly
> to get uniform behavior from all LEDs on MT7988.
> This requires syscon phandle 'mediatek,pio' present in parenting MDIO bus
> which should point to the syscon holding the boottrap register.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: mediatek-ge-soc: support PHY LEDs
    https://git.kernel.org/netdev/net-next/c/c66937b0f8db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




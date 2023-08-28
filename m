Return-Path: <netdev+bounces-31123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1678B8E7
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 22:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2211C2097C
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 20:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8814AA0;
	Mon, 28 Aug 2023 20:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6514287;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6BE7C433CB;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693252823;
	bh=t/0EA6ZpRKGsKfKE0cId3rR1RxU96iAzwfiOXjNwhKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sLu6b+wOEiJXRq5H7w1dng1+8KdD3nFqEGycifPNB3t5OWlQvzEC8Hyodp0xr8fD9
	 aJ7wi1Wkqk5w7aErb0P4eFLMC8GT8PVfQOSWv1h2O5Tgm6PrhRjxJGqlnI++FLiGfy
	 vxOeAKZGcWszjHf4ZE+y9fF8EWI0ShJoZ5z0VwLWvh49UAbrInvy3FZfGR626iaREq
	 BpIKfy45Ez4ySH6KprHBpG1GY7n7sJJ6UcB0qTz8BA/LAEQ9ESJ+AunoumJ9km7rSR
	 o4xAOji2ioDx6bsuTNOQTzqHLsxXS20+tmsExwLIpO3fCf8hp+LKwzbI+gLQAP7PTI
	 o4xAnc3Jpn+Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C2D4E21EDF;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: clarify difference between "interface"
 and "phy_interface"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169325282356.23387.6771304913662801847.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 20:00:23 +0000
References: <E1qZq83-005tts-6K@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qZq83-005tts-6K@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, chenfeiyang@loongson.cn,
 hkallweit1@gmail.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, vz@mleia.com, kernel@esmil.dk, samin.guo@starfivetech.com,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Aug 2023 11:02:51 +0100 you wrote:
> Clarify the difference between "interface" and "phy_interface" in
> struct plat_stmmacenet_data, both by adding a comment, and also
> renaming "interface" to be "mac_interface". The difference between
> these are:
> 
>  MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
>        ^                               ^
>  mac_interface                   phy_interface
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: clarify difference between "interface" and "phy_interface"
    https://git.kernel.org/netdev/net-next/c/a014c35556b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




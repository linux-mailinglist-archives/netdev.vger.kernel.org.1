Return-Path: <netdev+bounces-30844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1987789338
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD70281995
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF07FE;
	Sat, 26 Aug 2023 02:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B17FB
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9FECC433CD;
	Sat, 26 Aug 2023 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015228;
	bh=mBlqZKRX75iObqBjHmpEw+uziOh4bWzEZufO9Teq5zM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u+N6197q4ce8zTDxWx+tZn7XBioEtnTbVw5Fughq7Lj76iY/SgzK0AOF8K0eakbqk
	 XYU6jRAMdM15GNv4UmBa5jdHPBPDWhzPf/A/LQk2hp9RHBGegQXi7JmBwiC8RRgTXA
	 TGkIu/XPijP4kXZADOCpZI5wufr5sahRQ9b+pXIeyAUyAq5cTs/cuVKpR2+egW8aQ4
	 fQWbhCBj/wmkmBmmHkrH8zzZg4AqjvhIg4RZ3TgftE/4zT/wwkuKkFJOa1h4iKiMXZ
	 b0AlFxILnbELbgDDqOpswxlWIT/Vufw6XnOe22Pis8eadojsoR+JbJgjA3YTLbkkBf
	 nvAhosFgrtf4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB4DBE33083;
	Sat, 26 Aug 2023 02:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/10] stmmac cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301522782.10076.5815529392176754957.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:00:27 +0000
References: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
In-Reply-To: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, chenfeiyang@loongson.cn,
 hkallweit1@gmail.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 14:37:24 +0100 you wrote:
> Hi,
> 
> One of the comments I had on Feiyang Chen's series was concerning the
> initialisation of phylink... and so I've decided to do something about
> it, cleaning it up a bit.
> 
> This series:
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: phylink: add phylink_limit_mac_speed()
    https://git.kernel.org/netdev/net-next/c/70934c7c99ad
  - [net-next,02/10] net: stmmac: convert plat->phylink_node to fwnode
    https://git.kernel.org/netdev/net-next/c/e80af2acdef7
  - [net-next,03/10] net: stmmac: clean up passing fwnode to phylink
    https://git.kernel.org/netdev/net-next/c/1a37c1c19832
  - [net-next,04/10] net: stmmac: use "mdio_bus_data" local variable
    https://git.kernel.org/netdev/net-next/c/2b070cdd3afd
  - [net-next,05/10] net: stmmac: use phylink_limit_mac_speed()
    https://git.kernel.org/netdev/net-next/c/a4ac612bd345
  - [net-next,06/10] net: stmmac: provide stmmac_mac_phylink_get_caps()
    https://git.kernel.org/netdev/net-next/c/d42ca04e0448
  - [net-next,07/10] net: stmmac: move gmac4 specific phylink capabilities to gmac4
    https://git.kernel.org/netdev/net-next/c/f1dae3d222c6
  - [net-next,08/10] net: stmmac: move xgmac specific phylink caps to dwxgmac2 core
    https://git.kernel.org/netdev/net-next/c/bedf9b81233d
  - [net-next,09/10] net: stmmac: move priv->phylink_config.mac_managed_pm
    https://git.kernel.org/netdev/net-next/c/64961f1b8ca1
  - [net-next,10/10] net: stmmac: convert half-duplex support to positive logic
    https://git.kernel.org/netdev/net-next/c/76649fc93f09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




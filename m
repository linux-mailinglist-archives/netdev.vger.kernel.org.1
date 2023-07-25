Return-Path: <netdev+bounces-20857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE5076196F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7371C20DC8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A91F189;
	Tue, 25 Jul 2023 13:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A971F16B
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A8D2C433C7;
	Tue, 25 Jul 2023 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690290622;
	bh=qMzggPT3twoGjwJ/BKYGaRiJYeGvR8ele0FPF405ljQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hDtO2dyOy9fCjJ3qTn2MLgiOA6ry1q6EoJglfOH6QXfqSpz/DS8U+faBxB+83cHRL
	 aIubAgQ7JWEv/8ExC/5V791UjpQMZ98c/bu6TtPV729ZXuXHucQRZ7o0U8uGHrxf4y
	 4ZNzfMh2msexGBXhoZW9xi8sPzvmOjQ75NRbbmAvCZ5D3ZH/bIxews7iD++Bz6t0EN
	 D9QwvfELI7VnOV43QK6V9DD/rqKN+ETAQxDpPdF2jvrhgGn6gc0UiraN0HZnDRJG3G
	 STnia2WTIXV83GyJvDvweUFhS9o/QTTszIjk/3UapfNbvzNHQDIfuZzhEoT14JokCX
	 vNsgJJDQmg6eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37CE5C4166D;
	Tue, 25 Jul 2023 13:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] Remove legacy phylink behaviour
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169029062222.12684.2359979941607233325.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 13:10:22 +0000
References: <ZLw8DoRskRXLQK37@shell.armlinux.org.uk>
In-Reply-To: <ZLw8DoRskRXLQK37@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, daniel@makrotopia.org,
 arinc.unal@arinc9.com, frank-w@public-files.de, dwmw@amazon.co.uk,
 angelogioacchino.delregno@collabora.com, davem@davemloft.net,
 edumazet@google.com, nbd@nbd.name, kuba@kernel.org, john@phrozen.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lorenzo@kernel.org, Mark-MC.Lee@mediatek.com, matthias.bgg@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sean.wang@mediatek.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 22 Jul 2023 21:29:02 +0100 you wrote:
> Hi,
> 
> This series removes the - as far as I can tell - unreachable code in
> mtk_eth_soc that relies upon legacy phylink behaviour, and then removes
> the support in phylink for this legacy behaviour.
> 
> Patch 1 removes the clocking configuration from mtk_eth_soc for non-
> TRGMII, non-serdes based interface modes, and disables those interface
> modes prior to phylink configuration.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: ethernet: mtk_eth_soc: remove incorrect PLL configuration
    https://git.kernel.org/netdev/net-next/c/76a4cb755cf9
  - [net-next,v2,2/4] net: ethernet: mtk_eth_soc: remove mac_pcs_get_state and modernise
    https://git.kernel.org/netdev/net-next/c/28e1737d2544
  - [net-next,v2,3/4] net: phylink: strip out pre-March 2020 legacy code
    https://git.kernel.org/netdev/net-next/c/4d72c3bb60dd
  - [net-next,v2,4/4] net: phylink: explicitly invalidate link_state members in mac_config
    https://git.kernel.org/netdev/net-next/c/c5714f68a76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




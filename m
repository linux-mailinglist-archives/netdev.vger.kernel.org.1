Return-Path: <netdev+bounces-240614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0451C76F84
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAE823640D0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295382E0917;
	Fri, 21 Nov 2025 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpA/sSIj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021982E041D
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690454; cv=none; b=HAbq0QxEdf/xs6kAQPFLmMsmJFyXpt4hK+zHsitoNIA7uGXjENNKqo+z3xsxDPzGZHwufWWcRAJX9oNuCh8bo/OVuWAWmvYVrRZ4fChRSWPKmV3jJGBLhEspVMgdGZyqBnb5yPbPd9OgjtCba0qXGUvt7gDLK3vTH7ZOTgZyudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690454; c=relaxed/simple;
	bh=hUYp9odp8LoH/NylHXpnLHdk7Xwiaj3w0z4IGhqyrPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U3DPrJPHCBXfi4HanM9uHT4DGmk2zR2SQVDYZC2brbVhrC23QjTjTWe/H0/5lkXKomX3UJuLELGZso8kd7igRyJt6zpDQ5DQPUj2b0mBkhI6+5gb+cNWOcukB4rTKG39gcqTfU9mezwsiC+n72mqXmydAmtPH8P1x5iezkGByr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpA/sSIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F45C116B1;
	Fri, 21 Nov 2025 02:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763690453;
	bh=hUYp9odp8LoH/NylHXpnLHdk7Xwiaj3w0z4IGhqyrPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PpA/sSIjvKeThEpQIhCsUR2N4PjbMwx6f8VlOYvBqqY/Whhx81eabU0qVtr44yf2d
	 ss2k65SjW38/zWZQZO/lP/QEUmeYUUr4d+tezl4HeimJ8JiUZK1jwqmFfDjOkgAYhk
	 PI3CmJaCu0z2odMbDQVApUYMYabS7TEMGhUROchEufoZKV84m6Te+VaTq8xVwwYHoV
	 BWcEbpWar42vIOnF+NAT6P0RIkYLSUqmoBGyhzXhfT6lSocbkMgfXIg4gTrpp1GytL
	 G1CClY2fVJF5p6X2f1gPMqbfCNEG6IcKZEmUwwmC0zZCbmVDej9BRDld3udcPy8z69
	 Wf2Kf2/49lFPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEC4D3A41003;
	Fri, 21 Nov 2025 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: rk: use phylink's interface mode
 for
 set_clk_tx_rate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369041825.1856901.6474170870442345383.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:00:18 +0000
References: <E1vLgNA-0000000FMjN-0DSS@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vLgNA-0000000FMjN-0DSS@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 heiko@sntech.de, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 11:29:16 +0000 you wrote:
> rk_set_clk_tx_rate() is passed the interface mode from phylink which
> will be the same as bsp_priv->phy_iface. Use the passed-in interface
> mode rather than bsp_priv->phy_iface.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: rk: use phylink's interface mode for set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/f15bcd071913

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




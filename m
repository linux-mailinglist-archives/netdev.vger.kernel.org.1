Return-Path: <netdev+bounces-239360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFCC6733F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C8DAC2982B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA938F9C;
	Tue, 18 Nov 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVj55Qex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E635CBA5;
	Tue, 18 Nov 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438458; cv=none; b=JPRhqoF63a9c9O/8GnKsKk7mMYPgNMNdA3nVBPlMi25s2rppkKH/d1G6BlmO7dKe9lZqkqZnfkU3M/DhYWE35GE6zFXG5ZlOz9myGkn6RxzR7tBVOS9XM46enGdKlTUDhgwcCguM270QcohJGocN+62vjJ7fAJHWKWdmoLPay9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438458; c=relaxed/simple;
	bh=F4b0uEqOqFj1s5GHGqft9QBk76aJhOT/4bbfeDN+fD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ut/x6fGwk7jAkjsztbEowCCTR26ENRLc52+EKRqpYIQ3pUb+TiMAZK04mylwV2VItruHvyUmi4F+X8mhoAhMCcUNqRNA0lfCfDTQ4DFSNtvMp+IuVZrEn7ctQQV5rr0JwwHEI3W6aslPIhP72G7rnGCY6wi3JS3fGc5Suyyhn6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVj55Qex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9026EC116D0;
	Tue, 18 Nov 2025 04:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438457;
	bh=F4b0uEqOqFj1s5GHGqft9QBk76aJhOT/4bbfeDN+fD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EVj55QexA1j6BraMVP2dlwMLN2CRv/d0/XGEpHooJ1Yep11lNKf3yEUw+fd74fQb0
	 0PUhZI/fW2p0yuHqQd3q+NUU3+AdT3QojoSXQprU7AWQSoI0r45Wt+HIOFqI0L5awv
	 Su4ZfcZEn6yptm61rjpMFZ9FlapiYRmCE/EuReG8l62zx9vGMT9SfNPeIK8mPd83+2
	 wPtLT1zFknOTZxQ/bPuO1EjtB9r41MWNVGQYLyTiKPtPqKMakQvowEA13SUjkzthic
	 2N/xdmvS2WmI4SzYmVNqDO2bgV8nFV0j56D5T2DF4w09WXfsSiZdzl+SZpc10DAP3U
	 sWTwPiVgRZEPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FE93809A1C;
	Tue, 18 Nov 2025 04:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] net: stmmac: clean up plat_dat
 allocation/initialisation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176343842426.3578356.2997761543219536696.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 04:00:24 +0000
References: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
In-Reply-To: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, unicorn_wang@outlook.com, davem@davemloft.net,
 edumazet@google.com, inochiama@gmail.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sophgo@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Nov 2025 15:27:16 +0000 you wrote:
> This series cleans up the plat_dat allocation and initialisation,
> moving common themes into the allocator.
> 
> This results in a nice saving:
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  | 43 +---------------
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 22 +-------
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c |  1 -
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 34 ++++++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 39 +-------------
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 60 ++++------------------
>  7 files changed, 53 insertions(+), 148 deletions(-)

Here is the summary with links:
  - [net-next,01/11] net: stmmac: add stmmac_plat_dat_alloc()
    https://git.kernel.org/netdev/net-next/c/511171e47f8b
  - [net-next,02/11] net: stmmac: move initialisation of phy_addr to stmmac_plat_dat_alloc()
    https://git.kernel.org/netdev/net-next/c/99e6ddaabdb4
  - [net-next,03/11] net: stmmac: move initialisation of clk_csr to stmmac_plat_dat_alloc()
    https://git.kernel.org/netdev/net-next/c/ae4f29712bf3
  - [net-next,04/11] net: stmmac: move initialisation of maxmtu to stmmac_plat_dat_alloc()
    https://git.kernel.org/netdev/net-next/c/528478a746a5
  - [net-next,05/11] net: stmmac: move initialisation of multicast_filter_bins to stmmac_plat_dat_alloc()
    https://git.kernel.org/netdev/net-next/c/07cedb9eed41
  - [net-next,06/11] net: stmmac: move initialisation of unicast_filter_entries to stmmac_plat_dat_alloc()
    https://git.kernel.org/netdev/net-next/c/bcb145c69690
  - [net-next,07/11] net: stmmac: move initialisation of queues_to_use to stmmac_plat_dat_alloc()
    https://git.kernel.org/netdev/net-next/c/d5e788e86fe3
  - [net-next,08/11] net: stmmac: setup default RX channel map in stmmac_plat_dat_alloc()
    https://git.kernel.org/netdev/net-next/c/b6d013b3260b
  - [net-next,09/11] net: stmmac: remove unnecessary .use_prio queue initialisation
    https://git.kernel.org/netdev/net-next/c/c03101cb1bf0
  - [net-next,10/11] net: stmmac: remove unnecessary .prio queue initialisation
    https://git.kernel.org/netdev/net-next/c/0a20999ed452
  - [net-next,11/11] net: stmmac: remove unnecessary .pkt_route queue initialisation
    https://git.kernel.org/netdev/net-next/c/6409249ccc15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




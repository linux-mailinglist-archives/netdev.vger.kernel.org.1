Return-Path: <netdev+bounces-126764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7797265B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D1E1F24EE3
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B986E2AE;
	Tue, 10 Sep 2024 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb3XBNO5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD916BFA5
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929437; cv=none; b=RE88veB5bz6O8s7VxYgU0wJumlN3y2It7509uk38an2K/phdyi9bj2Z6SmRymBmwQRwdNH/8KiLIf/trVvXThiZThOIS0Ewhy02cAhT1aPrTq6OvpnGTClLrAMVolC8vEbht5YSgRRSqJ4dTdra9liIJXAT5/3B5vT/EBxo1d/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929437; c=relaxed/simple;
	bh=RWr7W9FvKXkTlixB1Pkha+UzrV5u/efVLD0LfzFSQqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OrwljKucXNlFWpUO8ZkX+doLZf+ZLeAWTOx+K1mjl5dys6tk6FTXc0rg6vz0ttYrs9CqUEap5TzwkirZxuOZlfI6NDU2p3P98OJ7OsJVDFnK02cEBAATZVGPTlSOB4Ls6DNtuDYFMbcIKf1uqpvEGKtgm1hFqyLXJgbRoy3lvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb3XBNO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2B8C4CEC5;
	Tue, 10 Sep 2024 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725929436;
	bh=RWr7W9FvKXkTlixB1Pkha+UzrV5u/efVLD0LfzFSQqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sb3XBNO5rcMyVUmdDxKSnLYjvXMJxomtjt3xIp3bljXmOkaMfBLJy63jbfTJI/rRD
	 Q7ibOIYp8BSe47+DZp6Am9qyknfqAapfQxFl2qGkargNm9ta7uo2ZM2phIwXBKLGwV
	 Q3y/N/l8xFnFmxRZnT9AX98iIOeBw2TamWaCa2hiTwOUvRL78+cb+eFaDUwMjVpxDm
	 /YyOyWfirzZ8cjfu8oLduTvmrqytES9umyH4BwLtACSE0YMuvpDpaBUy5ERAZ4dCaW
	 rtwTqJVddl+C7KoxOOSM9Lo+7UQnb9TaO4Jl9z0hnYcEWeHzMmdNwo1fU+kxpoNwM4
	 1GRNQSmMVlcrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A43806654;
	Tue, 10 Sep 2024 00:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/16] RX software timestamp for all - round 3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592943750.3971140.14564404354512599487.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:50:37 +0000
References: <20240906144632.404651-1-gal@nvidia.com>
In-Reply-To: <20240906144632.404651-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 jv@jvosburgh.net, andy@greyhouse.net, mkl@pengutronix.de,
 mailhol.vincent@wanadoo.fr, Shyam-sundar.S-k@amd.com, skalluru@marvell.com,
 manishc@marvell.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, sgoutham@marvell.com,
 bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, dmichail@fungible.com,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, idosch@nvidia.com, petrm@nvidia.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 alexandre.belloni@bootlin.com, shannon.nelson@amd.com, brett.creeley@amd.com,
 s.shtylyov@omp.ru, yoshihiro.shimoda.uh@renesas.com,
 niklas.soderlund@ragnatech.se, ecree.xilinx@gmail.com,
 habetsm.xilinx@gmail.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, s-vadapalli@ti.com, rogerq@kernel.org,
 danishanwar@ti.com, linusw@kernel.org, kaloz@openwrt.org,
 richardcochran@gmail.com, willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Sep 2024 17:46:16 +0300 you wrote:
> Rounds 1 & 2 of drivers conversion were merged [1][2], this round will
> complete the work.
> I know the series is more than 15 patches, but I didn't want to have a
> 4th round for a single patch.
> 
> [1] https://lore.kernel.org/netdev/20240901112803.212753-1-gal@nvidia.com/
> [2] https://lore.kernel.org/netdev/20240904074922.256275-1-gal@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net-next,01/16] bnxt_en: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/3fc85527b08c
  - [net-next,02/16] tg3: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/0644646d91b2
  - [net-next,03/16] bonding: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/1db368a04066
  - [net-next,04/16] amd-xgbe: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/18eb4d0440d8
  - [net-next,05/16] net: macb: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/a8fe0c07f56c
  - [net-next,06/16] liquidio: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/441d0a79c950
  - [net-next,07/16] net: thunderx: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/fedc2e795fd5
  - [net-next,08/16] enic: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/e4e0145ac5ac
  - [net-next,09/16] net/funeth: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/6cba6812a335
  - [net-next,10/16] net: mscc: ocelot: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/0de3c713e9b8
  - [net-next,11/16] qede: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/36d84998da9f
  - [net-next,12/16] sfc: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/9d02e6c95139
  - [net-next,13/16] sfc/siena: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/4c00bb4c519b
  - [net-next,14/16] net: stmmac: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/9364fa7fcf12
  - [net-next,15/16] ixp4xx_eth: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/d25e9e178c2a
  - [net-next,16/16] ptp: ptp_ines: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/f8e82440d959

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




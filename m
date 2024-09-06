Return-Path: <netdev+bounces-125839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED50E96EE60
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6A71C222AE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481091581EA;
	Fri,  6 Sep 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAw3apM/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A0156887
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612032; cv=none; b=Hb34CPOeBqASH4ZoKNHzn6Jbktyhz2nG+KKmPu+ZUXZrxE2okOXE95JSOugPcTaqf/Nw8RAD3+RjMC3TDx/g7o7NtUvMmf0Z09HHrkZhuib7Mkva0S9g/fdX4s4SkUPZ3b4eK7w8wuUwkyUqdr7i84Z4qyfCrKFnyLzp2mRjKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612032; c=relaxed/simple;
	bh=Uxm7PSBgH9OV8X2gb1b9mZtr6aINCyetZvyPN7lafB0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aako8aTKPRzBssVK+haqq5DU1yWRU5bwH3d82MQtRMD2CtlTS+KMxAtaV//NjCZoZbnovK9ATscuxrVwz1Lbw45117ixJHyTCOAWOfycGHqNNTMnuFUJdzOBrY/HAgFwBPsqUSKSMK6+N/XnhbS3Xb1c9euC2tcUPaD597Mt6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAw3apM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7011C4CEC5;
	Fri,  6 Sep 2024 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725612031;
	bh=Uxm7PSBgH9OV8X2gb1b9mZtr6aINCyetZvyPN7lafB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QAw3apM/9u2950Fo4LHQe+4o8yAyHeHTqqHjs8SZvEXviTvG15nmrDceqeHuo3Sx/
	 56KzPM4KyfJ2XAFUOkL6sqrvdcqJjOsOH11TvdSZm3d63usygr+8xZtqwLdZAnIddk
	 PThgKvWPf4mzGOY+96El/p3Yoc4TKEJBf8i4441SOB1zq9Kp/IqLLFQYjMpEG1Z3WY
	 veV/tGDXYcmM13WFvmKFZXqYORxJK9fQUvAka9FtVdgoTbD9ZAllqEoac7vrfGFhUQ
	 iuNcfv5MPFWRUOfeAt/gVysUQz9H63pPYWot29cMus30GYJBRX5y1VXpp9dHSxP5z9
	 qrKWYpVjOKUuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBA3806654;
	Fri,  6 Sep 2024 08:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] RX software timestamp for all - round 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172561203251.2028302.15757209227467883993.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 08:40:32 +0000
References: <20240904074922.256275-1-gal@nvidia.com>
In-Reply-To: <20240904074922.256275-1-gal@nvidia.com>
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
by David S. Miller <davem@davemloft.net>:

On Wed, 4 Sep 2024 10:49:07 +0300 you wrote:
> Round 1 of drivers conversion was merged [1], this is round 2, more
> drivers to follow.
> 
> [1] https://lore.kernel.org/netdev/20240901112803.212753-1-gal@nvidia.com/
> 
> Thanks,
> Gal
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] lan743x: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/b9c4d16e2a47
  - [net-next,02/15] net: lan966x: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/f592435d132c
  - [net-next,03/15] net: sparx5: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/35461b6d5802
  - [net-next,04/15] mlxsw: spectrum: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/8a26d9471766
  - [net-next,05/15] net: ethernet: ti: am65-cpsw-ethtool: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/f40a3712ef1b
  - [net-next,06/15] net: ethernet: ti: cpsw_ethtool: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/c76e2f40b7d9
  - [net-next,07/15] net: ti: icssg-prueth: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/c5dbb6aeefbd
  - [net-next,08/15] net: netcp: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/f9b74d602ee3
  - [net-next,09/15] i40e: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/5df20ce03ef4
  - [net-next,10/15] ice: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/6aebd824f45a
  - [net-next,11/15] igb: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/638effa35d68
  - [net-next,12/15] igc: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/29d2e49a62c1
  - [net-next,13/15] ixgbe: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/12283fad6d2e
  - [net-next,14/15] cxgb4: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/4c6d910e0254
  - [net-next,15/15] bnx2x: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/26f74155df44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




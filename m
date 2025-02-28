Return-Path: <netdev+bounces-170827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11737A4A19B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CB73BCF2F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537F627602F;
	Fri, 28 Feb 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qko06JpB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27836280A3F;
	Fri, 28 Feb 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767402; cv=none; b=tbAPvVoupwpkAXR9ij4uOXzuJy46EwaDRMoU2c97Ub9mvEglC3Osqceh2u1DHZEkved0KK0Y1AGZWx+AZ+/5fFDh+k/XiG0JI32BRi6mWFSHAnlWMbTg7eUv4YXrswQ513de0ibXvRDM3CKhvXAymsQmg7A6LNie4NkqLSH4OlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767402; c=relaxed/simple;
	bh=OilwAZ5RXV38zTb+M44/89NDdAfBWpMVpgBj9F3ie5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o8DkMOm/cDyLpI+hZgVZ7plkfi+zHIHZZgZnU8DHnp5mnhNd5LIesA2YPiRQbEBD9xXyVk2uh9rUIpJ1KjwFmQot4jHTZTviB+r8OK/KOQR7Ct0Whk6xiQQ4r6nKR9bj5NYRBx35NYzlvvI0anuW/FPY/yhhTaIizESEKl/EyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qko06JpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917B1C4CEED;
	Fri, 28 Feb 2025 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740767401;
	bh=OilwAZ5RXV38zTb+M44/89NDdAfBWpMVpgBj9F3ie5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qko06JpBaB0Mhqay9/mFCbAZRqjBKioIFBIjsaLX69CFiooIOK6cQTIib8VidkwDa
	 6920EKQBFWvPxU/KaDSCCQeUmtMyIhUFxJ4SaiAw+TBD9dSJ0sDdr0AIc+oDoyea1u
	 Cc0CV4QGr2nGWBKrENwhuXlvL4dMSg7D60RJwDn6Ay2EiIGoH5Re4bbPE/fUduBWAl
	 ED/lJ4r/dxbL76l1rHW5blvs99gEzk0NkQhN1AmHpo1/2Viw687dTXHMY1839QATdA
	 CihdYAaDCONwhLA+EZWj70TPPMYxNRubEUWc1r8VX0g5dC2CXgcB4OQ0nXMhkcf+XD
	 ym4ylURLCwE1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9B4380CFF1;
	Fri, 28 Feb 2025 18:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] net: stmmac: cleanup transmit clock setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174076743376.2237263.14950662798271470831.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 18:30:33 +0000
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, drew@pdp7.com, kernel@esmil.dk,
 edumazet@google.com, festevam@gmail.com, wefu@redhat.com, guoren@kernel.org,
 imx@lists.linux.dev, kuba@kernel.org, jan.petrous@oss.nxp.com,
 jbrunet@baylibre.com, khilman@baylibre.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 martin.blumenstingl@googlemail.com, mcoquelin.stm32@gmail.com,
 minda.chen@starfivetech.com, neil.armstrong@linaro.org,
 netdev@vger.kernel.org, pabeni@redhat.com, kernel@pengutronix.de,
 s.hauer@pengutronix.de, shawnguo@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 09:16:15 +0000 you wrote:
> Hi,
> 
> A lot of stmmac platform code which sets the transmit clock is very
> similar - they decode the speed to the clock rate (125, 25 or 2.5 MHz)
> and then set a clock to that rate.
> 
> The DWMAC core appears to have a clock input for the transmit section
> called clk_tx_i which requires this rate.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: stmmac: provide set_clk_tx_rate() hook
    https://git.kernel.org/netdev/net-next/c/dea5c8ec20be
  - [net-next,02/11] net: stmmac: provide generic implementation for set_clk_tx_rate method
    https://git.kernel.org/netdev/net-next/c/12bce6d5404e
  - [net-next,03/11] net: stmmac: dwc-qos: use generic stmmac_set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/17c24f6dc641
  - [net-next,04/11] net: stmmac: starfive: use generic stmmac_set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/c81eb3da0be8
  - [net-next,05/11] net: stmmac: s32: use generic stmmac_set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/36fa8c960720
  - [net-next,06/11] net: stmmac: intel: use generic stmmac_set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/61356fb1b0d6
  - [net-next,07/11] net: stmmac: imx: use generic stmmac_set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/b693ce4f2704
  - [net-next,08/11] net: stmmac: rk: switch to use set_clk_tx_rate() hook
    https://git.kernel.org/netdev/net-next/c/c8caf6100f6d
  - [net-next,09/11] net: stmmac: ipq806x: switch to use set_clk_tx_rate() hook
    https://git.kernel.org/netdev/net-next/c/ca723519c28b
  - [net-next,10/11] net: stmmac: meson: switch to use set_clk_tx_rate() hook
    https://git.kernel.org/netdev/net-next/c/2a7d55f901a5
  - [net-next,11/11] net: stmmac: thead: switch to use set_clk_tx_rate() hook
    https://git.kernel.org/netdev/net-next/c/945db208fbe7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




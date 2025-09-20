Return-Path: <netdev+bounces-224949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA69B8BB16
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C45C5858A6
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F020B7ED;
	Sat, 20 Sep 2025 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlSAb8P8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D1200BA1;
	Sat, 20 Sep 2025 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758328221; cv=none; b=EeIVVpd4nhyl+6nsThObhA75oM9j5HdwV/qd+U/rl6Zg7txGlMSn5zB8hgYOnEvO8ADv1N8pY27Omk6HSqQYRjcxfnt2RZt0EbkxlgXad/xOgVnXsR7nok3+yj3rKIia0Sld170LtgyCPd1KsFg5ftjWq93cbhjbeLccTt7A1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758328221; c=relaxed/simple;
	bh=Yes7uCAJIf1OW9O4lN6N9kWrrNuylVquEJn5lf44T44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HyN3Qkrs5ov9NiaJ3BYtA72WfuiISNBYZjWbTHU3f9HgtaG95EglQ4W8bMBXqxkANincqG7yVMGjP576nzwiS5kKWork5Ek9ELr88Yo2vJsaHBox7LwUDTWFvmAbI1Eh3tg478MBzRlr/oHIn0eDa/cpBVHRlZAcMLuOlHrVgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlSAb8P8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A72C4CEF0;
	Sat, 20 Sep 2025 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758328219;
	bh=Yes7uCAJIf1OW9O4lN6N9kWrrNuylVquEJn5lf44T44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LlSAb8P8UrBmrtodlL0ShRrL0RB/FGZLzl+svKgxt3WY1vou6qUJwz7D00B/ZXSle
	 dmmeHMKIrCaZPNQYJ+hbARFCLF3BeG7+mz+dA8iu16BHLxtWaMVYHn18eynY59S/H9
	 /yJYfv6NkCmIc8bZBwewQOWosl+jp9OATHySy4BBchEKejpLe42R6GnT0ArMrcZcQl
	 7KvspaiqADgBilZFJk9CxI1SLjT2ttZ6NdGhUs5mUL1c8a84R8T5jqZSj0cStOifYd
	 T2cP/YDSwrwUsiYhSxYdupE+K5NMm8whtP8u94NItPIpXVKTOcTvlB1gTfV4WKbTHf
	 PN2u2DiCDEE6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF439D0C20;
	Sat, 20 Sep 2025 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] net: stmmac: remove mac_interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832821850.3748897.10411784128279455244.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:30:18 +0000
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
In-Reply-To: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, wens@csie.org, davem@davemloft.net,
 fustini@kernel.org, kernel@esmil.dk, edumazet@google.com, festevam@gmail.com,
 wefu@redhat.com, guoren@kernel.org, imx@lists.linux.dev, kuba@kernel.org,
 jernej.skrabec@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-sunxi@lists.linux.dev, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, minda.chen@starfivetech.com,
 mohd.anwar@oss.qualcomm.com, netdev@vger.kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, samuel@sholland.org, s.hauer@pengutronix.de,
 shawnguo@kernel.org, vz@mleia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 16:11:33 +0100 you wrote:
> The dwmac core supports a range of interfaces, but when it comes to
> SerDes interfaces, the core itself does not include the SerDes block.
> Consequently, it has to provide an interface suitable to interface such
> a block to, and uses TBI for this.
> 
> The driver also uses "PCS" for RGMII, even though the dwmac PCS block
> is not present for this interface type - it was a convenice for the
> code structure as RGMII includes inband signalling of the PHY state,
> much like Cisco SGMII does at a high level.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: stmmac: rework mac_interface and phy_interface documentation
    https://git.kernel.org/netdev/net-next/c/32a8d2a197c1
  - [net-next,02/10] net: stmmac: use phy_interface in stmmac_check_pcs_mode()
    https://git.kernel.org/netdev/net-next/c/0522f152a2c9
  - [net-next,03/10] net: stmmac: imx: convert to use phy_interface
    https://git.kernel.org/netdev/net-next/c/db1948da6860
  - [net-next,04/10] net: stmmac: ingenic: convert to use phy_interface
    https://git.kernel.org/netdev/net-next/c/9ff682b4a28f
  - [net-next,05/10] net: stmmac: socfpga: convert to use phy_interface
    https://git.kernel.org/netdev/net-next/c/de696c63c1dc
  - [net-next,06/10] net: stmmac: starfive: convert to use phy_interface
    https://git.kernel.org/netdev/net-next/c/6cb2b69c3419
  - [net-next,07/10] net: stmmac: stm32: convert to use phy_interface
    https://git.kernel.org/netdev/net-next/c/0ca60c26f655
  - [net-next,08/10] net: stmmac: sun8i: convert to use phy_interface
    https://git.kernel.org/netdev/net-next/c/0fe080fa884e
  - [net-next,09/10] net: stmmac: thead: convert to use phy_interface
    https://git.kernel.org/netdev/net-next/c/3a94ecdf1afb
  - [net-next,10/10] net: stmmac: remove mac_interface
    https://git.kernel.org/netdev/net-next/c/6b0ed6a3a89c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




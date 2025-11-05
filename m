Return-Path: <netdev+bounces-235646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B169C3376D
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 01:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3852C34E502
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0326224B01;
	Wed,  5 Nov 2025 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INojycZy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D72EEAB;
	Wed,  5 Nov 2025 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302049; cv=none; b=sgRbJw9wn8IhysxE6lGtBd8JKqf3pWmrGzPrYLWi/ByHUcAbqSj1BiYeIu4tEv50KG6KDbFcl5QGSLLS/AGBiXXEoiArhKRnQ9eqlfsUbWrr8hb1d+Vv3zvAUZyKobjvDXumVBrjs4gJSMcxyYVWRRg4b8wDtlfziUw5tvcz0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302049; c=relaxed/simple;
	bh=3MKFuCG76JthLJcZE3T3Op7stJ2k8Ttv8bqnfs9tWiE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T97Rh9wrCVvt4jTugOrKVZIU6btRhSD64m0ad0XuoCamYIJ0vCjerJVRih/9DXpvhwJsKQ0WJIL1rFY0MZrohaQJEP5qqlA7JYajZUkJLOB7LP+YurUm7408fpOwDRQs5afjfioD27+FzbJennKACScLBRFHst6JS07M2fBQgMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INojycZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C497C116B1;
	Wed,  5 Nov 2025 00:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302049;
	bh=3MKFuCG76JthLJcZE3T3Op7stJ2k8Ttv8bqnfs9tWiE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=INojycZy/a78lhVsLvVbeiECZLvsgpUyNONTu4veLZSMfi2e3lJyk0lhbjUy3QZHZ
	 NGDkYI9wKuMd+GNF8uaYyfmeV5vBqYG0eNH75xE9lfqkLTr6by2JUbcU2MxPGWLMNY
	 wjqIqv4bXs0DnB0y1BJG5h7QYMVEH01j69TJfwp9D1CNtZ1GKdR3YLFkYEgU89DU9H
	 3qJgmPG4RulqybvIwgtHGcVoUQR9GI0YGS1eP6mJzlwxLW39Q+Ha8g3OunNUZMxdz+
	 mYWN4bT+tNgUNH9kDvYI8/YyHC9cMX7rIZ2X0P+YdUkW7agsF7NY7onfZo5qshndfO
	 CmVHFirNLCsOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB2380AA54;
	Wed,  5 Nov 2025 00:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] net: stmmac: multi-interface stmmac
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230202300.3035250.17732707564655810857.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 00:20:23 +0000
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
In-Reply-To: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 festevam@gmail.com, imx@lists.linux.dev, kuba@kernel.org,
 jan.petrous@oss.nxp.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, kernel@pengutronix.de,
 s32@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 11:49:35 +0000 you wrote:
> Hi,
> 
> This series adds a callback for platform glue to configure the stmmac
> core interface mode depending on the PHY interface mode that is being
> used. This is currently only called justbefore the dwmac core is reset
> since these signals are latched on reset.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: stmmac: imx: use phylink's interface mode for set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/42190a188fdb
  - [net-next,02/11] net: stmmac: s32: move PHY_INTF_SEL_x definitions out of the way
    https://git.kernel.org/netdev/net-next/c/d8df08b0df02
  - [net-next,03/11] net: stmmac: add phy_intf_sel and ACTPHYIF definitions
    https://git.kernel.org/netdev/net-next/c/38e8c0fb0fc3
  - [net-next,04/11] net: stmmac: add stmmac_get_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/2f2a7b907446
  - [net-next,05/11] net: stmmac: add support for configuring the phy_intf_sel inputs
    https://git.kernel.org/netdev/net-next/c/15ade7dbf64f
  - [net-next,06/11] net: stmmac: imx: convert to PHY_INTF_SEL_xxx
    https://git.kernel.org/netdev/net-next/c/8088ca0d88f8
  - [net-next,07/11] net: stmmac: imx: use FIELD_PREP()/FIELD_GET() for PHY_INTF_SEL_x
    https://git.kernel.org/netdev/net-next/c/27db57875c08
  - [net-next,08/11] net: stmmac: imx: use stmmac_get_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/cb09d1b9582a
  - [net-next,09/11] net: stmmac: imx: simplify set_intf_mode() implementations
    https://git.kernel.org/netdev/net-next/c/8fc75fe5948d
  - [net-next,10/11] net: stmmac: imx: cleanup arguments for set_intf_mode() method
    https://git.kernel.org/netdev/net-next/c/fb526d0c16c1
  - [net-next,11/11] net: stmmac: imx: use ->set_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/da836959c78a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




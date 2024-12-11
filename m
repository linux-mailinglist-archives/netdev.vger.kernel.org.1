Return-Path: <netdev+bounces-150957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE29EC2A6
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200B51884CF3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CAD157E99;
	Wed, 11 Dec 2024 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpSRt729"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9836195;
	Wed, 11 Dec 2024 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886014; cv=none; b=gtYPt3g30B2JfRdUBrFmAJbhRfxQGAEdTQ7s/h8YeNGBtzlXuO9be6tVgBKPXTiF7qqEOubQFYu+l1SbV78ZMgpZ45BKgGbhX4wJk3Epykja1sBpD+KKurTI4DQ6AHISk5rnhnmNj9U+ykfrUJN80s8gp0UIhUL+qiiV1FJ6XCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886014; c=relaxed/simple;
	bh=ccgariIKgud8qBOY4SFxMd7+xVkxxbSh85oCKnzOnDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ci1lsnLrdWtzHC7FtxCQKzPT6ulUULQsaqdW9xmJJlQ7sCGaDpbJ/VZzmIVifmSEt03dVIVyafiubo1Tiy2GGe/gMGc26fhWLzzfdwajPvmDcpKuh//Rjjm9mg7WctoeSydimBeffRS4bFig/OeJJK3vf9l1gTt294LUVh41xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpSRt729; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652D0C4CED6;
	Wed, 11 Dec 2024 03:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886014;
	bh=ccgariIKgud8qBOY4SFxMd7+xVkxxbSh85oCKnzOnDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KpSRt729wE11MI5/pk6bt/0t/rAG9L1aln1/uk8gk0WmCfBIF52NtfTWvWyS6aUEL
	 riOJLFDC29F9sBpjdrNMq2UKUiKh/q2me+AzeVfdAUstFX2RILvmXFSmP7foU0ZaTT
	 tYw7qJRjudES9DDhy9vxFtKaYwGr12vJBQ0hdxTwTMOJ01WU9D6AZ4Y1j0SBZNGTVf
	 EdAg8Y6Y76zoudUg7L0im5QG9FURTiABBajZVueW9/qkYoX0JtqOG140z0MliGwrR0
	 nhLBr1mFnmzWS5zH2GUn5aFN2jmdx9k1fXkRu3wvqnih+qveKjtMs6zfixEK3gNjdT
	 LmmcztKzlq2Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710AF380A954;
	Wed, 11 Dec 2024 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 00/11] lan78xx: Preparations for PHYlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388603026.1099323.11274032337195932356.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 03:00:30 +0000
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
In-Reply-To: <20241209130751.703182-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Dec 2024 14:07:40 +0100 you wrote:
> This patch set is a second part of the preparatory work for migrating
> the lan78xx USB Ethernet driver to the PHYlink framework. During
> extensive testing, I observed that resetting the USB adapter can lead to
> various read/write errors. While the errors themselves are acceptable,
> they generate excessive log messages, resulting in significant log spam.
> This set improves error handling to reduce logging noise by addressing
> errors directly and returning early when necessary.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,01/11] net: usb: lan78xx: Add error handling to lan78xx_setup_irq_domain
    https://git.kernel.org/netdev/net-next/c/d354d008255f
  - [net-next,v1,02/11] net: usb: lan78xx: Add error handling to lan78xx_init_mac_address
    https://git.kernel.org/netdev/net-next/c/6f31135894ec
  - [net-next,v1,03/11] net: usb: lan78xx: Add error handling to lan78xx_set_mac_addr
    https://git.kernel.org/netdev/net-next/c/9a46956c72cb
  - [net-next,v1,04/11] net: usb: lan78xx: Add error handling to lan78xx_get_regs
    (no matching commit)
  - [net-next,v1,05/11] net: usb: lan78xx: Simplify lan78xx_update_reg
    https://git.kernel.org/netdev/net-next/c/41b774e4f327
  - [net-next,v1,06/11] net: usb: lan78xx: Fix return value handling in lan78xx_set_features
    https://git.kernel.org/netdev/net-next/c/bf361b18d91e
  - [net-next,v1,07/11] net: usb: lan78xx: Use ETIMEDOUT instead of ETIME in lan78xx_stop_hw
    (no matching commit)
  - [net-next,v1,08/11] net: usb: lan78xx: Use function-specific label in lan78xx_mac_reset
    (no matching commit)
  - [net-next,v1,09/11] net: usb: lan78xx: Improve error handling in lan78xx_phy_wait_not_busy
    https://git.kernel.org/netdev/net-next/c/21fff45a6cc1
  - [net-next,v1,10/11] net: usb: lan78xx: Rename lan78xx_phy_wait_not_busy to lan78xx_mdiobus_wait_not_busy
    (no matching commit)
  - [net-next,v1,11/11] net: usb: lan78xx: Improve error handling in WoL operations
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




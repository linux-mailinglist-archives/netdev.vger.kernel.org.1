Return-Path: <netdev+bounces-51523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7947FB00B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD391C20DFA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188F5693;
	Tue, 28 Nov 2023 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6oVgTWV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350A5685
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 139CCC433C7;
	Tue, 28 Nov 2023 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701138029;
	bh=gcJHZaf9yffzVy2sW5Fmhz3cepNwq3Vgcp3y/5YcaH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O6oVgTWVn8p/70489STir2e5nxtANC3If+1muc7aqYD5y2SdR3Sz/CmAczWA4Ifjc
	 Yg2kmBipm8jxKlMQeE4aEH94VAr8OkJRwDHhVs0vYiCmuqqtQhKka9JRROL4uh+AkM
	 qH+tEhXRxa/vNJ5RBqceT2IkaFnSz03NipaL44YxinzAVUaDGT9otuP+PJ3vvvq+br
	 Hzivf3ePz1UozdIdk8Mwj3UjOUNsQj6FY18a8PowLkqstrLdcAWEoOdB+K0M5qfhk4
	 p/pAt8SNZVR3e61LjOJBcpbXG5YRtr5PxSLaoft8iDkepbcfAaLEYBiXyG1zUj4xt7
	 Laj+6acmYPaMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E66C0E00092;
	Tue, 28 Nov 2023 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] net: phylink: improve PHY validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170113802894.29254.6950669144994725182.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 02:20:28 +0000
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
In-Reply-To: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, florian.fainelli@broadcom.com, kuba@kernel.org,
 kabel@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Nov 2023 12:27:11 +0000 you wrote:
> Hi,
> 
> One of the issues which has concerned me about the rate matching
> implenentation that we have is that phy_get_rate_matching() returns
> whether rate matching will be used for a particular interface, and we
> enquire only for one interface.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: phy: add possible interfaces
    https://git.kernel.org/netdev/net-next/c/243ad8df7a1b
  - [net-next,02/10] net: phy: marvell10g: table driven mactype decode
    https://git.kernel.org/netdev/net-next/c/2cb6d63b30c6
  - [net-next,03/10] net: phy: marvell10g: fill in possible_interfaces
    https://git.kernel.org/netdev/net-next/c/82f2e76b660a
  - [net-next,04/10] net: phy: bcm84881: fill in possible_interfaces
    https://git.kernel.org/netdev/net-next/c/a22583338e53
  - [net-next,05/10] net: phy: aquantia: fill in possible_interfaces for AQR113C
    https://git.kernel.org/netdev/net-next/c/01972fa9ab7d
  - [net-next,06/10] net: phylink: split out per-interface validation
    https://git.kernel.org/netdev/net-next/c/5f492a04506e
  - [net-next,07/10] net: phylink: pass PHY into phylink_validate_one()
    https://git.kernel.org/netdev/net-next/c/385e72b40034
  - [net-next,08/10] net: phylink: pass PHY into phylink_validate_mask()
    https://git.kernel.org/netdev/net-next/c/b7014f9ece50
  - [net-next,09/10] net: phylink: split out PHY validation from phylink_bringup_phy()
    https://git.kernel.org/netdev/net-next/c/2c62ff83ee14
  - [net-next,10/10] net: phylink: use the PHY's possible_interfaces if populated
    https://git.kernel.org/netdev/net-next/c/7a1f9a17ee99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




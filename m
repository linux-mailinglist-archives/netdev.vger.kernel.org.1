Return-Path: <netdev+bounces-199299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36320ADFB25
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43D73BDB54
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 02:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF82222D9;
	Thu, 19 Jun 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHYM8nK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489BC158874;
	Thu, 19 Jun 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750299607; cv=none; b=Lbrcah+NSPNtWPGkU/RI5eRLDy1qeMjKTBi+ZvsEWXcuyW8xhugMhhBVhDDi3jgK50vsChvfJVQM0/Q5KPW68tVNB3Grhdk9FGRahIIu4SlC5ExyST6Ou9fV9rI2t0Kquob71GTWBW/1M3Fk051xf5LiHD1aNSemFGxSPltPmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750299607; c=relaxed/simple;
	bh=b6tOmfClsJctcMlIsaHfCiyRWMAMSEq9SCWaOiSH1Nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jFpxAqWrfE5aKvR/O67rv8evIfJC0ICUJiI5m/9ApF0RdQ7enpOYUJP8t61Q9ovoCk+1qivS+6AzKixDHcd+eje4KyGVV3K3fy0eKQHBRgmzyqwuXv6d96Renljji/Odqyt2hY4p9GAxadMPku6irTCWc+7sTL4b7y9TrnK9YVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHYM8nK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD40C4CEE7;
	Thu, 19 Jun 2025 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750299606;
	bh=b6tOmfClsJctcMlIsaHfCiyRWMAMSEq9SCWaOiSH1Nk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iHYM8nK40Xp+Wcpz6pi12BLL2eo9yomm8FasKZ6BuegKbWsS3xgLBXKp1+LsSHWK+
	 G9Z45pP29KmkZUdBZMtIj2GTjfs5Blafsb2L7u8BKOP0w1ejyHWNwUzriL6MiVqiiM
	 bSeP9O4LCiNw95L67vLLTGRhFk7YMJq9V+lHNflc57cpfyvPhWgNxEhrBfl9Fk78GL
	 O4CMs4DJu2AknpLuJ6q1oyc98O6rOLmbrKSiOjTcQznbmwlVCGakj2nPB0Lqtv2WXe
	 O4C6mJWLT+Bst3zkmHqXI1wA6PQ2OUZ62fvWT92OKaQ3EqT089xJyXvd2xp7ezH4C6
	 M5m7FaTj7yKCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2A3806649;
	Thu, 19 Jun 2025 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 00/13] Add support for PSE budget evaluation
 strategy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175029963473.324281.8953472268017984557.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 02:20:34 +0000
References: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
In-Reply-To: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: andrew@lunn.ch, o.rempel@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 donald.hunter@gmail.com, robh@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 krzk+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, kyle.swenson@est.tech,
 dentproject@linuxfoundation.org, kernel@pengutronix.de,
 maxime.chevallier@bootlin.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 14:11:59 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This series brings support for budget evaluation strategy in the PSE
> subsystem. PSE controllers can set priorities to decide which ports should
> be turned off in case of special events like over-current.
> 
> This patch series adds support for two budget evaluation strategy.
> 1. Static Method:
> 
> [...]

Here is the summary with links:
  - [net-next,v14,01/13] net: pse-pd: Introduce attached_phydev to pse control
    https://git.kernel.org/netdev/net-next/c/fa2f0454174c
  - [net-next,v14,02/13] net: pse-pd: Add support for reporting events
    https://git.kernel.org/netdev/net-next/c/fc0e6db30941
  - [net-next,v14,03/13] net: pse-pd: tps23881: Add support for PSE events and interrupts
    https://git.kernel.org/netdev/net-next/c/f5e7aecaa4ef
  - [net-next,v14,04/13] net: pse-pd: Add support for PSE power domains
    https://git.kernel.org/netdev/net-next/c/50f8b341d268
  - [net-next,v14,05/13] net: ethtool: Add support for new power domains index description
    https://git.kernel.org/netdev/net-next/c/1176978ed851
  - [net-next,v14,06/13] net: pse-pd: Add helper to report hardware enable status of the PI
    https://git.kernel.org/netdev/net-next/c/c394e757dedd
  - [net-next,v14,07/13] net: pse-pd: Add support for budget evaluation strategies
    https://git.kernel.org/netdev/net-next/c/ffef61d6d273
  - [net-next,v14,08/13] net: ethtool: Add PSE port priority support feature
    https://git.kernel.org/netdev/net-next/c/eeb0c8f72f49
  - [net-next,v14,09/13] net: pse-pd: pd692x0: Add support for PSE PI priority feature
    https://git.kernel.org/netdev/net-next/c/359754013e6a
  - [net-next,v14,10/13] net: pse-pd: pd692x0: Add support for controller and manager power supplies
    https://git.kernel.org/netdev/net-next/c/24a4e3a05dd0
  - [net-next,v14,11/13] dt-bindings: net: pse-pd: microchip,pd692x0: Add manager regulator supply
    https://git.kernel.org/netdev/net-next/c/2903001ee3b4
  - [net-next,v14,12/13] net: pse-pd: tps23881: Add support for static port priority feature
    https://git.kernel.org/netdev/net-next/c/56cfc97635e9
  - [net-next,v14,13/13] dt-bindings: net: pse-pd: ti,tps23881: Add interrupt description
    https://git.kernel.org/netdev/net-next/c/82566eb4ea51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-119259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA54954FEE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A6D281CED
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0FB1C230B;
	Fri, 16 Aug 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OItPG6Eu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974221BC067;
	Fri, 16 Aug 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828829; cv=none; b=fXmUGH4Fg8U4wNQisJZun053ZX0EQDiCQTLFrvKnU0xOBPSndVvCYS7jz1zznCbSedxMfnqVhDyTNfzl4vUi7ahjK7lgbx4GHqs8/5vuyFac904ba64QqRPQjdx4ghXaTN1+sXLEERNoSC+QDFg9Ci7aIQHs5dZ5YpPY2cxNF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828829; c=relaxed/simple;
	bh=NgeD9K+2viO7KQbnL95/lv4jMPlBpse0VSH6VZ3Y5RI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GNGyZ0q4IqIdO63Z1yLyedBQFZkA+Bk5ayXtvcvXamnD0KbFT8FhL9FcVYvEeh4Sc/btorHDfLKCIu3JhmRfDcszMpA4ea7aM7oWBpltYR+VTAzK09NQqNjjB4ww2S55JpjxrDnb44HA7nLlVICmFpBD2F5dJ05i0drvjyVmVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OItPG6Eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1F4C32782;
	Fri, 16 Aug 2024 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828829;
	bh=NgeD9K+2viO7KQbnL95/lv4jMPlBpse0VSH6VZ3Y5RI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OItPG6Eu7SD1hm6KXc9Y0RYMiL5nx52lnoxN58cYID0sZX2e/kzyCN0pw36+2brFn
	 JYOHacRXAd1ItPy5Zbuzrzuwecg5+kxhDdWttkVpd+t7cQC6bYYhzbYNA3zVfaGr8k
	 EZDiejUFU789S51F+cF4WU1/X4bYT8NKMUZERle/N+Ah1kjFdjay8D80N0nzpDwZBf
	 3SKAg7d/N+u68EFGBJg/Luh5sQk8StLdz8IDw25OGpnX4bs0fTtKXm/kXRRV2GfI9Y
	 moXfmpHr6bbd73nac2EiiYhtcf2h7WmFvo/OScRZogwB3HUFnLS35Uf/7fFF4EZ+h/
	 pf7jJDr2if1Ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2C238231F8;
	Fri, 16 Aug 2024 17:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 1/3] ethtool: Add new result codes for TDR
 diagnostics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172382882852.3581432.14168373432882305680.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 17:20:28 +0000
References: <20240812073046.1728288-1-o.rempel@pengutronix.de>
In-Reply-To: <20240812073046.1728288-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 09:30:44 +0200 you wrote:
> Add new result codes to support TDR diagnostics in preparation for
> Open Alliance 1000BaseT1 TDR support:
> 
> - ETHTOOL_A_CABLE_RESULT_CODE_NOISE: TDR not possible due to high noise
>   level.
> - ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE: TDR resolution not
>   possible / out of distance.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] ethtool: Add new result codes for TDR diagnostics
    https://git.kernel.org/netdev/net-next/c/2140e63cd87f
  - [net-next,v5,2/3] phy: Add Open Alliance helpers for the PHY framework
    https://git.kernel.org/netdev/net-next/c/9e7c1a9b9033
  - [net-next,v5,3/3] net: phy: dp83tg720: Add cable testing support
    https://git.kernel.org/netdev/net-next/c/20f77dc72471

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




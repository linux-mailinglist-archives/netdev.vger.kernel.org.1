Return-Path: <netdev+bounces-230270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86559BE6100
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 729714E3778
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E5922A7E4;
	Fri, 17 Oct 2025 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbP+xyyS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B45194A44;
	Fri, 17 Oct 2025 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665846; cv=none; b=llCd4qCmXagzrwJsQdki9OZgPouOQV20PO3Q8SxFOmkOkegDWWQD8MWh14e/Ol0VxhPTiprAIvcVgPOWwSFY7dzuTQ0vsLqLNYa+dAvLaPclC0SkRTxUHwtjBbZ7eD++lVXkuDr+X2DhmirFrgGD9kNk4TufUFAb6EPn3l/uLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665846; c=relaxed/simple;
	bh=wo/VVRQO1QTP50LUNFBgOloYg9EtAaCEy/sNchUBPwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bSWAPvAWKJcvVCj+zP9LjtGFMfX4Ah9O40sO+bOEZzUuYNQ3WewY1q46GfWz6wKFSw/0jJ7JuE0fBddA+eSXa9Q+3HeL4ipChBWZ5kXH4f4DFbAnW3Li3tUB2WwmDHUpj8lWwW/tACBtkVXz1fyllrlLQT/neWCK7l3fgaMgqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbP+xyyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B636AC4CEF1;
	Fri, 17 Oct 2025 01:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760665845;
	bh=wo/VVRQO1QTP50LUNFBgOloYg9EtAaCEy/sNchUBPwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jbP+xyyS3dYMR4uB32jNdj9543RrFu2/ocJusiokIXytEfIjn0yYlWU2VpchjgvIs
	 BVk+2RKkAd/Vbb8Qa9qrVtHYCWmG9soIaVg3fFq6oPt1PBLp7SuAfLe91VUEWRYXE8
	 UvjslFhASFkt2z608VzeVafG5jvwNQI0lhwiiItBmKY0cFpCCijqxK+wlAJAR81Xcd
	 IfMotmcMUl24ZaZTvd9ZiW4X+maUPSW3pybcH+QP6tE3ZX6MfOocZFt2206o5oAYbe
	 zqC9hO66kUUWNxTDfYBbEKlpkpY+ZCxzSAfAzwUyHDXrW7Jvu4C6pbSj1BROLtTIb3
	 T1BjiHrqv/Q+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDC39D0C96;
	Fri, 17 Oct 2025 01:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] net: macb: various cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176066582948.1978978.752807229943547484.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 01:50:29 +0000
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 richardcochran@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 vladimir.kondratiev@mobileye.com, tawfik.bayouk@mobileye.com,
 thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
 benoit.monin@bootlin.com, maxime.chevallier@bootlin.com,
 krzysztof.kozlowski@linaro.org, andrew@lunn.ch, sean.anderson@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 17:25:01 +0200 you wrote:
> Fix many oddities inside the MACB driver. They accumulated in my
> work-in-progress branch while working on MACB/GEM EyeQ5 support.
> 
> Part of this series has been seen on the lkml in March then June.
> See below for a semblance of a changelog.
> 
> The initial goal was to post them alongside EyeQ5 support, but that
> makes for too big of a series. It'll come afterwards, with new
> features (interrupt coalescing, ethtool .set_channels() and XDP mostly).
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] dt-bindings: net: cdns,macb: sort compatibles
    https://git.kernel.org/netdev/net-next/c/f1150b779571
  - [net-next,02/15] net: macb: use BIT() macro for capability definitions
    https://git.kernel.org/netdev/net-next/c/a23b0b79e974
  - [net-next,03/15] net: macb: remove gap in MACB_CAPS_* flags
    https://git.kernel.org/netdev/net-next/c/bd0b35ec835a
  - [net-next,04/15] net: macb: Remove local variables clk_init and init in macb_probe()
    https://git.kernel.org/netdev/net-next/c/80cf78c59a1a
  - [net-next,05/15] net: macb: drop macb_config NULL checking
    https://git.kernel.org/netdev/net-next/c/d7a4a20abe25
  - [net-next,06/15] net: macb: simplify macb_dma_desc_get_size()
    https://git.kernel.org/netdev/net-next/c/94a164598d83
  - [net-next,07/15] net: macb: simplify macb_adj_dma_desc_idx()
    https://git.kernel.org/netdev/net-next/c/62e6c17463a7
  - [net-next,08/15] net: macb: move bp->hw_dma_cap flags to bp->caps
    https://git.kernel.org/netdev/net-next/c/731e991afb75
  - [net-next,09/15] net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
    https://git.kernel.org/netdev/net-next/c/02d11c610555
  - [net-next,10/15] net: macb: remove bp->queue_mask
    https://git.kernel.org/netdev/net-next/c/39a913db6a47
  - [net-next,11/15] net: macb: replace min() with umin() calls
    https://git.kernel.org/netdev/net-next/c/f26c6438a285
  - [net-next,12/15] net: macb: drop `entry` local variable in macb_tx_map()
    https://git.kernel.org/netdev/net-next/c/027202adf079
  - [net-next,13/15] net: macb: drop `count` local variable in macb_tx_map()
    https://git.kernel.org/netdev/net-next/c/b5fe4f3e5912
  - [net-next,14/15] net: macb: apply reverse christmas tree in macb_tx_map()
    https://git.kernel.org/netdev/net-next/c/1ce9662e31fd
  - [net-next,15/15] net: macb: sort #includes
    https://git.kernel.org/netdev/net-next/c/8ebeef3d01c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




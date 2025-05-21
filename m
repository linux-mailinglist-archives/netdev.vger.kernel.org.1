Return-Path: <netdev+bounces-192111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C8ABE8FB
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DAD3B4093
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8619994F;
	Wed, 21 May 2025 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB/bQrbg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1611991B8;
	Wed, 21 May 2025 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790423; cv=none; b=Os8MK4V5vQJr7SKHtQYiMr5SaiAvSEOEjp/ZpApr68CbLEzLZrBomiAGbmODY2tduv+2OyWfcU+S8ZmFmITuFjBnDhx7y4vWJ2JQUtGsfEzs7uKW6l/L2liTOSVqvC/BIkWYnOounfkJfWujMOD3BzMVbRzhpR8UgQsCHGmond4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790423; c=relaxed/simple;
	bh=6cw2AlYCWLjE+TSTj9Ic8Mp7D9kUTOyLV7ooRycjEfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hEnTaNBtcNHZS8tSiAYXvax1GYv11KwXGsDkRNs+wwQKfrAoYnXU8TkkiDaNx8KDB2ejqogNZP37jxYDHsnisCvT7M1enGIBmxEWYoN7rAzu/VBKq3mQviIxlL5yJJwi64Mw0GKMikh9nTzMlUZIHeSLlyrIwkcmQ5PCffjyuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB/bQrbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49F8C4CEE9;
	Wed, 21 May 2025 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790423;
	bh=6cw2AlYCWLjE+TSTj9Ic8Mp7D9kUTOyLV7ooRycjEfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mB/bQrbghUpWn2FzPAGn5pJtKx8CctWB0li00fGLDaHFFU964Qqxj7o15XlV7ZXjz
	 etwAz8hw5ndvhyitxudtAnuRuXnSIY4yZlJv/alZ0m/Wd9VIABw0bFhZkWb25ug2IE
	 /y6moZ4j872KG2nZAFDRHjzu+IsyFtkb1DfPOKn+XEixa/kk3775F/H/mbO5QhO4pb
	 1VX1neg102zea0tGXsJJWrgtnSji4X3t05fr3g+XXQnOrIO7gs63rs2k3Z4XhA8u2G
	 shE8jBF05ulUtW3DkDM78mnQ3I0PWdGTb2qQ7xunbg/7XfuVDj+Z1psNwZG/s8phjx
	 84pLjjzRS4o2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1E8380AAD0;
	Wed, 21 May 2025 01:20:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] Add built-in 2.5G ethernet phy support on
 MT7988
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779045848.1526198.6198912452247192673.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:20:58 +0000
References: <20250516102327.2014531-1-SkyLake.Huang@mediatek.com>
In-Reply-To: <20250516102327.2014531-1-SkyLake.Huang@mediatek.com>
To: Sky Huang <skylake.huang@mediatek.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Steven.Liu@mediatek.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 18:23:25 +0800 you wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> This patchset adds support for built-in 2.5Gphy on MT7988, sort file
> and config sequence in related Kconfig and Makefile.
> 
> ---
> Change in v2:
> - Add missing dt-bindings and dts node.
> - Remove mtk_phy_leds_state_init() temporarily. I'm going to add LED support
> later.
> - Remove "Firmware loading/trigger ok" log.
> - Add macro define for 0x800e & 0x800f
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: phy: mediatek: Sort config and file names in Kconfig and Makefile
    https://git.kernel.org/netdev/net-next/c/6d243c80fe91
  - [net-next,v4,2/2] net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on MT7988
    https://git.kernel.org/netdev/net-next/c/26948c243041

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




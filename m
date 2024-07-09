Return-Path: <netdev+bounces-110085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B716B92AED6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE08A1C20E2A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69B78C83;
	Tue,  9 Jul 2024 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLJuUeUV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5D537FF;
	Tue,  9 Jul 2024 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720496431; cv=none; b=isY5RYVj3SHCPaP/7PL9dr2v2fa4fpiNosNdYu1/5zdhT8jR2ZFvn2NneEMlyq40QhVvnHHankti1KCVuME5WEylUvtuqZLz6i90h0/15zD+2IrY0lbtpTPNHYuk6tLEIPFJ2ljFJ8LM3s9jZfFgXbv0wGy6Mxl9R5FT0LHZL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720496431; c=relaxed/simple;
	bh=sgw7LUC/0Mxq3RnwehNtFpg+TR172S5GMG1Pe2+FLo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hkY6zeJWB2VM7at9Li+UDoZk6sq4HwNlNf/MZAC3TIgNOxe/qYJqfRPFhNDCDp9lc0h+LmGe5NCOBax5//xTlWKltk3PJdAA3iTvs5lOi2e3eRcYqTF7+p+HWHgewXPkxGJmmNflcibIO4am6n6r3krHexXb8gdtiiZYaAhIkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLJuUeUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04285C4AF0A;
	Tue,  9 Jul 2024 03:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720496431;
	bh=sgw7LUC/0Mxq3RnwehNtFpg+TR172S5GMG1Pe2+FLo0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VLJuUeUVA9HpD5ORd0TEgvl5N9ijMO8/lQvlJOZ2yfHpqLkBKKbhqVGsLdTwL90PK
	 /vs6eAPZNSru2rHL6grba98JMtZUQBugmIe+ODWgeYAmc2WzhicCjh17pj9OrZN+kg
	 ITQ7dCJFD/BzsSsAf4n8HVhuEab9u4DXjQDck7mIHpSY2r0pDRt5r0VWoMbFRklKXr
	 BJGl6edeYCczzQiSBaf1RNwARxvfPRVpI6QF5Jj+xCZVWd3OPa4qZ2ESGByIF1uCmT
	 KDke5WP88Yqs81Wo0K+fPkb2T0z1Z1PBCyjDGIE+0OW/VUA2HX+fHyD896in9ZAzAn
	 mxi/luSb2WOpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECB55DF3714;
	Tue,  9 Jul 2024 03:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: qcom-ethqos: enable 2.5G
 ethernet on sa8775p-ride
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172049643096.15240.14162761125981219295.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 03:40:30 +0000
References: <20240703181500.28491-1-brgl@bgdev.pl>
In-Reply-To: <20240703181500.28491-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jul 2024 20:14:57 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Here are the changes required to enable 2.5G ethernet on sa8775p-ride.
> As advised by Andrew Lunn and Russell King, I am reusing the existing
> stmmac infrastructure to enable the SGMII loopback and so I dropped the
> patches adding new callbacks to the driver core. I also added more
> details to the commit message and made sure the workaround is only
> enabled on Rev 3 of the board (with AQR115C PHY). Also: dropped any
> mentions of the OCSGMII mode.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
    https://git.kernel.org/netdev/net-next/c/61e9be0efbe8
  - [net-next,v3,2/2] net: stmmac: qcom-ethqos: enable SGMII loopback during DMA reset on sa8775p-ride-r3
    https://git.kernel.org/netdev/net-next/c/3c466d6537b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




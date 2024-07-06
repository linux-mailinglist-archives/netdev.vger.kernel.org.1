Return-Path: <netdev+bounces-109596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D07928FFD
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B75CB223F0
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037AD5672;
	Sat,  6 Jul 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/tkkBqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85EB211C;
	Sat,  6 Jul 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720230632; cv=none; b=R5QGJRsn/5TlTy1LlxJ2FDBux2wFssf54o6omS0OfvMwdGMqgqtOMk/0/D3iMubZI6N3ZcwLe2kDa2yUjOZ4IbBPTfjvetcGNcCM9vqBLc1ihXoryjAoJP4W7/ug/2/5RbYusySMXDy2qN/1SMxmJZrCd4nHbvYBwqVTOTL1FvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720230632; c=relaxed/simple;
	bh=1Uynl4Wyo6bxPwItWLnZ1wF42xTY5ATumBq6UCjr0yA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dEBD/BwhQ8XjHF+1dSJG1YcVYVy5ssyw+HeXD2HT3/4Tk9ZPJzI8HDLYlvku/3wtrX2pO64GHCuBGu0jEVwxnKUAT3Xyxeafu4gupOpxnnGIuwcwENO7pbNEjq24vUPj4v4Y/XNrggMlTSp7S6R8svefL+OBKPWqqh3Dkbfq7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/tkkBqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3359EC32781;
	Sat,  6 Jul 2024 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720230631;
	bh=1Uynl4Wyo6bxPwItWLnZ1wF42xTY5ATumBq6UCjr0yA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K/tkkBqqgq5jNmwH4sFntT2G/1ztM8IX1gX1qVpqqQ1KGYeqUK3CmMQDPIPjuuK5Y
	 A+dPSsV45NzsSXq1V1SNHQZUoDmd+pCK9rLQ9nrxKLHwAnJKDXdS/tOyoEPKhS6/v0
	 R7QgUDE3yAHnR9egFZ90hAgfMrpQin5B2Cy5y9q7SkMRwwZQy2CPDneeUJ/pR0P5vR
	 4eQEjPIRCuWXCECv4zuaIFQCOjxO0omkg/u7o7MEnHwy4ojuvDTYs+MlwQ7gVVJ9Hr
	 nLy2lugrPOAa+moqTFfUAgLBDCG68VReHOInoP88vS9J0EMhmDbWPJ49nlV4KRP50U
	 t9aO1K0igbCHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 209D9C43446;
	Sat,  6 Jul 2024 01:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/7] net: pse-pd: Add new PSE c33 features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172023063113.28145.15061182082357066469.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 01:50:31 +0000
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
In-Reply-To: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, o.rempel@pengutronix.de,
 corbet@lwn.net, thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, dentproject@linuxfoundation.org,
 kernel@pengutronix.de, linux-doc@vger.kernel.org, saikrishnag@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 04 Jul 2024 10:11:55 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch series adds new c33 features to the PSE API.
> - Expand the PSE PI informations status with power, class and failure
>   reason
> - Add the possibility to get and set the PSE PIs power limit
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/7] net: ethtool: pse-pd: Expand C33 PSE status with class, power and extended state
    https://git.kernel.org/netdev/net-next/c/e46296002113
  - [net-next,v6,2/7] netlink: specs: Expand the PSE netlink command with C33 new features
    https://git.kernel.org/netdev/net-next/c/c8149739af86
  - [net-next,v6,3/7] net: pse-pd: pd692x0: Expand ethtool status message
    https://git.kernel.org/netdev/net-next/c/ae37dc574259
  - [net-next,v6,4/7] net: pse-pd: Add new power limit get and set c33 features
    https://git.kernel.org/netdev/net-next/c/4a83abcef5f4
  - [net-next,v6,5/7] net: ethtool: Add new power limit get and set features
    https://git.kernel.org/netdev/net-next/c/30d7b6727724
  - [net-next,v6,6/7] netlink: specs: Expand the PSE netlink command with C33 pw-limit attributes
    https://git.kernel.org/netdev/net-next/c/dac3de193095
  - [net-next,v6,7/7] net: pse-pd: pd692x0: Enhance with new current limit and voltage read callbacks
    https://git.kernel.org/netdev/net-next/c/a87e699c9d33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




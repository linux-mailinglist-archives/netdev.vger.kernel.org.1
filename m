Return-Path: <netdev+bounces-127320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66A974F66
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408D02821CD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3B1184523;
	Wed, 11 Sep 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biBE3PuQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4961183CCA;
	Wed, 11 Sep 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049431; cv=none; b=AUkIqnr3mxYIu4THVA4WNRNB63ZTHAZxClPkZdWD2+aPH8f0rQPQUGZ9piQ64auekOms5eIGZYyJ1D5g207ix+46vDG7nmpVhmmXAtvqIs9n55miVJ78NP1Ig9G00cfUPU9rOtOWgUKoXar5ItPaJSpo6HbYXs522xOiRR+zmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049431; c=relaxed/simple;
	bh=06fkwrLjY2/fniZWS4mcw4m1AubrB1trbnaxhYs/urc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7mBc2FDKOmh+na9tdFKthzIc7gTBT9RQ+JbGWOsg7EpZo2K3ie2OAHvMAZ0PMYnLyOagKD0qTv+JesNI+wxPKf5PXct120TM5/GRSyOCvjdzzLQADTXTshPAWN/nxzvrk0uASs+T6EMm+aM+HhK/aK/OXZP4c1KNn1sksy8icc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biBE3PuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4364C4CEC5;
	Wed, 11 Sep 2024 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726049430;
	bh=06fkwrLjY2/fniZWS4mcw4m1AubrB1trbnaxhYs/urc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=biBE3PuQYW45aHRIsJTV24neAqMcPn8D5bcP+xeKIVBNQBXyZdLa3CNUcMIhpRlMX
	 ZlONmDeD1tfWf/294g0qPOb0+vYvZWoFBJZXQ1yAlDV5EYFPhivYWg8xHaXUUJ7Hoo
	 z/rRHNUcr1eDfN42/dLPdzIXgwG6xY5LYmk3DqgmEhyrXTWUlgcz76Q5qaZW6yJnM/
	 m6K86OBREA4QwtZR1Mqqvz8xm8otYUAR9dLGwVZ3EemRylaAtlvpnf0qMMfkH8Ia/F
	 njGPvLmSCak0zLu2f//A4k14hwxH2CMydB1nU2yaB+ir99Y0cNgKkhtEwFb1Ubz/al
	 IorAU7q9JZ2Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB35A3822FA4;
	Wed, 11 Sep 2024 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V6 0/5] Add support to PHYLINK for LAN743x/PCI11x1x
 chips
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172604943175.568857.6737661563582328586.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 10:10:31 +0000
References: <20240906103511.28416-1-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20240906103511.28416-1-Raju.Lakkaraju@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk,
 kuba@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, rdunlap@infradead.org,
 bryan.whitehead@microchip.com, edumazet@google.com, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org,
 horms@kernel.org, UNGLinuxDriver@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 6 Sep 2024 16:05:06 +0530 you wrote:
> This is the follow-up patch series of
> https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html
> 
> Divide the PHYLINK adaptation and SFP modifications into two separate patch
> series.
> 
> The current patch series focuses on transitioning the LAN743x driver's PHY
> support from phylib to phylink.
> 
> [...]

Here is the summary with links:
  - [net-next,V6,1/5] net: phylink: Add phylink_set_fixed_link() to configure fixed link state in phylink
    https://git.kernel.org/netdev/net-next/c/4b3fc475c61f
  - [net-next,V6,2/5] net: lan743x: Create separate PCS power reset function
    https://git.kernel.org/netdev/net-next/c/ef0250456cc3
  - [net-next,V6,3/5] net: lan743x: Create separate Link Speed Duplex state function
    https://git.kernel.org/netdev/net-next/c/92b740a43fea
  - [net-next,V6,4/5] net: lan743x: Migrate phylib to phylink
    https://git.kernel.org/netdev/net-next/c/a5f199a8d8a0
  - [net-next,V6,5/5] net: lan743x: Add support to ethtool phylink get and set settings
    https://git.kernel.org/netdev/net-next/c/f95f28d794ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-48503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F07EEA1B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2489B1C2094B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265B3BB32;
	Thu, 16 Nov 2023 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTbUxBJp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA093381AD
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EF3DC433CC;
	Thu, 16 Nov 2023 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700178625;
	bh=neT8/KCi9ASEtsFtpZhRttWDtCrkaPoWd8+TageU/+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jTbUxBJplOxP2noF5ZeJm61iO6+br6NX1YE7FVAP16XTXSzPwwzTcl7rBCuyLRiO7
	 fsvTIMuO8WGDCEUYZNYlFZj+c9GvQ95aAIL/MVHNC1uNWcb0OfXmKW3wivmCWdccxs
	 VxNf3wPQNEztkvGmBnJq9qoh95QZUm42MF40cOMkBgyE87ZDsSaFyH8VagEKPEwai3
	 kExrFAnbJTE7dVlpeIApF1K+iK7aO94YJHX0IzMvBmR5io/bLN5Wrc26r5K1grII+F
	 MhhN62+Psc23eaDJRJv77xXPES9AwgAl0Wof4+Z0rXCimaRFY3C41qPH+vt3jMbuRV
	 j50QilNOdXTzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BAF2C4166E;
	Thu, 16 Nov 2023 23:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] Add linkmode_fill, use linkmode_*() in
 phylink/sfp code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170017862524.24110.4750382507758220557.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 23:50:25 +0000
References: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
In-Reply-To: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 11:39:05 +0000 you wrote:
> Hi,
> 
> This small series adds a linkmode_fill() op, and uses it in phylink.
> The SFP code is also converted to use linkmode_*() ops.
> 
>  drivers/net/phy/phylink.c | 4 ++--
>  drivers/net/phy/sfp-bus.c | 2 +-
>  include/linux/linkmode.h  | 5 +++++
>  3 files changed, 8 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next,1/3] net: linkmode: add linkmode_fill() helper
    https://git.kernel.org/netdev/net-next/c/96fa96e198f9
  - [net-next,2/3] net: phylink: use linkmode_fill()
    https://git.kernel.org/netdev/net-next/c/ba50a8d40258
  - [net-next,3/3] net: sfp: use linkmode_*() rather than open coding
    https://git.kernel.org/netdev/net-next/c/466b97b1871a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




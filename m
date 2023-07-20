Return-Path: <netdev+bounces-19461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA675AC5D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF62281D7C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269A171CC;
	Thu, 20 Jul 2023 10:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DD199ED
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DC98C433C9;
	Thu, 20 Jul 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689850222;
	bh=Pbu6PsThcCjtA11Eu9h2+NnVNrCz4HVqEbnnSDw7XJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pQcL4aC8dR2zJElQ39HdEW190q0o2uXxOVNQwPpwZoQOf+0LimQw8p77tb0lDD8V+
	 sMJX5xpwB8LujcMSbBiuG0xHS4PTKSEdwmojLSsF9k1qI58IbB6iNrDdkRIp/O9h/d
	 S72A7Gk0HUjwFh06agavciksJfx23nI9bddUbEL1juGRPQkq1PYVuyjPbSOBJZHn9X
	 no229O/7l+Uhv/RkcdyDv1dSKNMKK1Udq/dz05nYDwe6Kv/JgSG+ut8uArZ0s85URH
	 C+BNJUDbMpY8LKD9fbXV9VwhwrXZ9ADzxqrwkSD/pWnl9a0JgzeAY6JSsokoGz33XX
	 TnTSSm+u1RGMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2E01E21EF6;
	Thu, 20 Jul 2023 10:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/5] Add a driver for the Marvell 88Q2110 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168985022192.7083.10091007682016221915.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 10:50:21 +0000
References: <20230719064258.9746-1-eichest@gmail.com>
In-Reply-To: <20230719064258.9746-1-eichest@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, francesco.dolcini@toradex.com, kabel@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 19 Jul 2023 08:42:53 +0200 you wrote:
> Add support for 1000BASE-T1 to the phy-c45 helper and add a first
> 1000BASE-T1 driver for the Marvell 88Q2110 PHY.
> 
> v4:
>   - Move PHY id to include/linux/marvell_phy.h (Marek)
>   - Use PHY id ending with 0, gets masked (Andrew)
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/5] net: phy: add registers to support 1000BASE-T1
    https://git.kernel.org/netdev/net-next/c/6f1c646d88c5
  - [net-next,v4,2/5] net: phy: c45: add support for 1000BASE-T1 forced setup
    https://git.kernel.org/netdev/net-next/c/25108a834e14
  - [net-next,v4,3/5] net: phy: c45: add a separate function to read BASE-T1 abilities
    https://git.kernel.org/netdev/net-next/c/eba2e4c2faef
  - [net-next,v4,4/5] net: phy: c45: detect the BASE-T1 speed from the ability register
    https://git.kernel.org/netdev/net-next/c/a60eb72066af
  - [net-next,v4,5/5] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY
    https://git.kernel.org/netdev/net-next/c/00f11ac71708

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-186581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CABA9FD01
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83995466DD2
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AEE214237;
	Mon, 28 Apr 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr4FWUkF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347920E6EC;
	Mon, 28 Apr 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878800; cv=none; b=QEPBA61aINYlnZpIpdh6khThC490mFSfjhy3CPN3+EoIVjBFCSTc/ZFDixOmBqdzybhkUNksHYTpJnMPJdCXMCPWpFRWh9dUTIbOOEOPfD+I2p7QSdkT533sFtbae5ZG8RygvGuSzMAVThn5ZD7xL0WZmKHC4nI26f1I9zLgsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878800; c=relaxed/simple;
	bh=6pcse9wbskV004iMqoCcdC1PU1qixiW4k4E9ldYBJxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V5dlX8+aca9B/fuubvhtvx3BrtVgpqJLwGXn/nAWr9GH2x0w7OEB1+bl3+ZbwAUAtWoDVTBv7gIzy+G09YxRR8/nCazXMk7tMzuEHTeIJKS1nlKzHBWbNilvP+IYwOJRQV1KgBTf4+Vv1bMEMtfxxAv9UK+L6fPgBXJEr3oFGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr4FWUkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51911C4CEE4;
	Mon, 28 Apr 2025 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745878799;
	bh=6pcse9wbskV004iMqoCcdC1PU1qixiW4k4E9ldYBJxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rr4FWUkFYW3WnHWdUzvr68F09StbPoytD50/gmmVB6SOfCQSyK5yVEpOXQPM5e/R7
	 YQ1LU/PNdizypiKpoCNsXQuAqqoAP/QjNrvJs1SGnsR1Zb+8PymAINM9vb2VBfp7Bs
	 QG5OEuXFRKDhk+wtXspVzXe5DaEUc0ePCPo2wSC1+PhQa6+MwS3HqQGn3g+l3pkwQD
	 tIWnWmu6pC3oe1YgYnIiSUbyVc/HTq8M5fbxeqH2Ra00guMsMyhOwssUwOCq7tgzig
	 1meqGeeim+2s4ydqjIFvaup3gfyVPwc5Q3dzC6BCPudRYV2lAHlW2NslvbAOOICrJp
	 KcXtvuPamciYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB23822D43;
	Mon, 28 Apr 2025 22:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mdio: fix CONFIG_MDIO_DEVRES selects
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174587883799.1063939.6255098697937333955.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 22:20:37 +0000
References: <20250425112819.1645342-1-arnd@kernel.org>
In-Reply-To: <20250425112819.1645342-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 jacob.e.keller@intel.com, chris.packham@alliedtelesis.co.nz, arnd@arndb.de,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, linux@armlinux.org.uk, Frank.Li@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 13:27:56 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added rtl9300 driver needs MDIO_DEVRES:
> 
> x86_64-linux-ld: drivers/net/mdio/mdio-realtek-rtl9300.o: in function `rtl9300_mdiobus_probe':
> mdio-realtek-rtl9300.c:(.text+0x941): undefined reference to `devm_mdiobus_alloc_size'
> x86_64-linux-ld: mdio-realtek-rtl9300.c:(.text+0x9e2): undefined reference to `__devm_mdiobus_register'
> Since this is a hidden symbol, it needs to be selected by each user,
> rather than the usual 'depends on'. I see that there are a few other
> drivers that accidentally use 'depends on', so fix these as well for
> consistency and to avoid dependency loops.
> 
> [...]

Here is the summary with links:
  - mdio: fix CONFIG_MDIO_DEVRES selects
    https://git.kernel.org/netdev/net-next/c/ccc25158c22b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




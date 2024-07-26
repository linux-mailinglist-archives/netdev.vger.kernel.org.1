Return-Path: <netdev+bounces-113236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AB593D42E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CCD1C22999
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475011E517;
	Fri, 26 Jul 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktrj8l3I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47DE57E;
	Fri, 26 Jul 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000632; cv=none; b=LeiF43L+EN165eFEs7uF9vY/Pr02Je8zGrHLLt8r0c+chhHlUh9I1GC8mddSuKTGFTbBaEXsVUErKkN3QhFoIAYijf8LrNrEyu69FF3jvXCp7Sfe/pGp3aC5PH+ElZna44w5Xf6ejobXg6FAyOsFVt4TaQOIyrcrAJHytS+syRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000632; c=relaxed/simple;
	bh=uTbBoK37ylBykX+vr7rtacCO1SdI2RkHBIOWabeQEk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XYZkXXGmnl/y6rDbQ2px2/m+3RrfuG1OwfX8D8aKGitHDRM9bWhU5JCADLRpavbzL8WdzdgRmrygtEPoboAstcyKAk+2o/jJLhk30zUbISvP7+/boITGz23nlbKbU3e9KuR3A4DzJz7PtDDyyZNTtgydVD4ywkBYZOxH+FgckN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktrj8l3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B88AC32786;
	Fri, 26 Jul 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722000631;
	bh=uTbBoK37ylBykX+vr7rtacCO1SdI2RkHBIOWabeQEk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ktrj8l3I32Zu6m0MDN/Xo3NLkmzAp8M8nkQbUXmjcJrcG/R32DSSvTJPECLgoHf/a
	 D00UJVeWiEbyc3SYVu0oQPqLA9CbCcvoprsjRmvSxY2oE5yL+TG2LXY11L9gyjdt9G
	 W4I7g1n5xI1Ezb7VnJU2YWpKTAgMDCCZzP1HzUmx/U9e3+aO790KIl0x8S3NE6UOJY
	 nlfTvWaIxnAzSpStUHI39th9uM43s39Kmqn0cKLltAQ5r++PWCH+3VEnRwiqxBn3r8
	 DQ4YpLlxttPiYSjs32VjqfUBkhm2t+zSa8GEbVlaIqUCzs9mWNChEkW26rRg085sf7
	 FsZYjPnZ7VbZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AFD8C433E9;
	Fri, 26 Jul 2024 13:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: realtek: add support for RTL8366S Gigabit
 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172200063156.21287.9187549435807655006.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jul 2024 13:30:31 +0000
References: <20240725204147.69730-1-mark@mentovai.com>
In-Reply-To: <20240725204147.69730-1-mark@mentovai.com>
To: Mark Mentovai <mark@mentovai.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 o.rempel@pengutronix.de, jonas.gorski@gmail.com, russell@personaltelco.net,
 lorand.horvath82@gmail.com, namiltd@yahoo.com, yangshiji66@outlook.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jul 2024 16:41:44 -0400 you wrote:
> The PHY built in to the Realtek RTL8366S switch controller was
> previously supported by genphy_driver. This PHY does not implement MMD
> operations. Since commit 9b01c885be36 ("net: phy: c22: migrate to
> genphy_c45_write_eee_adv()"), MMD register reads have been made during
> phy_probe to determine EEE support. For genphy_driver, these reads are
> transformed into 802.3 annex 22D clause 45-over-clause 22
> mmd_phy_indirect operations that perform MII register writes to
> MII_MMD_CTRL and MII_MMD_DATA. This overwrites those two MII registers,
> which on this PHY are reserved and have another function, rendering the
> PHY unusable while so configured.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: realtek: add support for RTL8366S Gigabit PHY
    https://git.kernel.org/netdev/net/c/225990c487c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




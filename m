Return-Path: <netdev+bounces-182861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 445CDA8A310
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D58163426
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD029A3FE;
	Tue, 15 Apr 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib/1seQy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2623372C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731604; cv=none; b=Mau8AqfyOSgXVAcZbfJsI8Nb4xAg3eOHLgFrPqE5aZhik4JAJIDw4bYON6aHCpcJPj4CwRRIeJaWQtRN6V2xetjkYxs530oLqOe3+tpi31rUDkVwIAzwGMSMcW70borEIG8wSX896ISxGPeNvtbruqJrXeoDG9YskO9lzBqYNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731604; c=relaxed/simple;
	bh=7KBpmcvDBu/KzzwX4IoFm1q8sj2SXnAZYc6au3Szlxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y3AK1gHb1imCgxVwG6Sh18lp8xOXoQP0gAAG6H69bDVQ5/B7uJ+jn6haPIeH8sp/hPAX7HDkKttaezxQmDQ0hSYjN3tBhX07ngQXscR1mPGu6EE0mxvi9jFwtK88KgsBf9gt1MhJADDvHG+Rqa4n9lCP+FcRybJbVl9unKTdWDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib/1seQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A2AC4CEEB;
	Tue, 15 Apr 2025 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731604;
	bh=7KBpmcvDBu/KzzwX4IoFm1q8sj2SXnAZYc6au3Szlxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ib/1seQyBnL2lBlJq/wLpmIomb86PnfCSgDHWETSzyCFBuhBsvsETHcz3oOgavwgJ
	 1lUbsKbj5hipvX5b63bclfP3UcSruBOMiVIANaOcJeQtly43wUYehAWMHcAoFk5oKR
	 7UweC9mSmF1tp/++Xs+3HZoQPEQVkZwemhAJVAsPSvSfGqCR1OHTrlS+PAeao0+UDo
	 lFgTCdaksFBA2pW5GYxjU4W+pSFvb1I3czQQ9eEsf/I1Tq+0/ZlqEIB+A/S2iEs2ub
	 RFdJubthdtadfLdV4Y0HzX1mA/sGN2RmSFc6l2Pw3plhqteprwvqD+ZZ/HzzNjfver
	 ZW9z9fNT1n24g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF53822D55;
	Tue, 15 Apr 2025 15:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] net: stmmac: anarion: cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473164174.2680773.17904225005838619235.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 15:40:41 +0000
References: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
In-Reply-To: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 10:05:56 +0100 you wrote:
> A series of cleanups to the anarion glue driver.
> 
> Clean up anarion_config_dt() error handling, printing a human readable
> error rather than the numeric errno, and use ERR_CAST().
> 
> Using a switch statement with incorrect "fallthrough;" for RGMII vs
> non-RGMII is unnecessary when we have phy_interface_mode_is_rgmii().
> Convert to use the helper.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: stmmac: anarion: clean up anarion_config_dt() error handling
    https://git.kernel.org/netdev/net-next/c/c30a45a7e072
  - [net-next,v2,2/4] net: stmmac: anarion: clean up interface parsing
    https://git.kernel.org/netdev/net-next/c/a55ec9c811aa
  - [net-next,v2,3/4] net: stmmac: anarion: use stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/5956527e26ff
  - [net-next,v2,4/4] net: stmmac: anarion: use devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/a1afabef915c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




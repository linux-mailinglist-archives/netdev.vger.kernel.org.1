Return-Path: <netdev+bounces-126753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E6A972621
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C491C22DB5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5323B20DE8;
	Tue, 10 Sep 2024 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyCGMV8C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF01F956;
	Tue, 10 Sep 2024 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927644; cv=none; b=av2l8rhhl9RMnm9EUxu+BSBPw5U7V/THWKKVipIa8pOSMwCa4oIG+acYq4o8mfmLSLYM4Kj7GmVijCCCBmOVMZgvp+bJDPcXbkx6uNJQYKJAtp3DaKjFFeEbrHTmfp22oUA/KQFjWwJM3cwELJfd7vOmZqSmyM4oZ5xeNg/5ArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927644; c=relaxed/simple;
	bh=wM4DTXTczWncO9UOsaVjM6cDnXHniF5HLOavcoBGxJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oVCsUGls5LHZUp7sm3ZxoRB136/9ZP/+5UPvVB/3Ktv8VxswDX2hBnuWhT+YrCzlvNGyt2TqXHcsYRWh7rzn3E2jBQzGw+SzX1kxXc4cKstdx7lmtNPBYLtb6WMCq0Mye7FGLxpgmUHwsHHzQM+xqfdCv9ywOLl3ZGLSp5cteQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyCGMV8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFFFC4CEC5;
	Tue, 10 Sep 2024 00:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725927643;
	bh=wM4DTXTczWncO9UOsaVjM6cDnXHniF5HLOavcoBGxJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IyCGMV8CQbMXZlZhY+bHCMG4PrA7E9tsBaHg2NFzQuWGj3nOAEdi9i2S6jxoqq54m
	 DdDKrJuW4AzSKnLFtzsjK0weHzyP5LxjFUCT8rAoCZujkyVCJzdhuqd6v4NxROLDLP
	 nc1IpNQXgjEinE4fKTwOJ/ldVRc/cjBwUPKGkrGxBxan5MWx1iMUKrWdzdC+IuIywt
	 w8XpcK48e0ZVz/W9dWBZ8nJQjehzzV56pEKyZcSTSV9PVVO01OK3lABaRQmy5IDwAK
	 ethPgfiNQ0ionBe+POEeIDVJ4pSr5qn2aba/jWxyt8cN+rx1AZxAPYIRbmMEbbVidz
	 D9Wm9dMOsrY0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDE3806654;
	Tue, 10 Sep 2024 00:20:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next 0/7] various cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592764474.3964840.11886218788875824850.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:20:44 +0000
References: <20240905194938.8453-1-rosenp@gmail.com>
In-Reply-To: <20240905194938.8453-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Sep 2024 12:49:31 -0700 you wrote:
> Allow CI to build. Also a bugfix for dual GMAC devices.
> 
> v2: add MODULE_DESCRIPTION and move variable for mdio_reset.
> 
> Rosen Penev (6):
>   net: ag71xx: add COMPILE_TEST to test compilation
>   net: ag71xx: add MODULE_DESCRIPTION
>   net: ag71xx: update FIFO bits and descriptions
>   net: ag71xx: use ethtool_puts
>   net: ag71xx: get reset control using devm api
>   net: ag71xx: remove always true branch
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next,1/7] net: ag71xx: add COMPILE_TEST to test compilation
    https://git.kernel.org/netdev/net-next/c/969431d2b0df
  - [PATCHv2,net-next,2/7] net: ag71xx: add MODULE_DESCRIPTION
    https://git.kernel.org/netdev/net-next/c/7c3736a12938
  - [PATCHv2,net-next,3/7] net: ag71xx: update FIFO bits and descriptions
    https://git.kernel.org/netdev/net-next/c/28540850577b
  - [PATCHv2,net-next,4/7] net: ag71xx: use ethtool_puts
    https://git.kernel.org/netdev/net-next/c/441a2798623c
  - [PATCHv2,net-next,5/7] net: ag71xx: get reset control using devm api
    https://git.kernel.org/netdev/net-next/c/bfff5d8e2111
  - [PATCHv2,net-next,6/7] net: ag71xx: remove always true branch
    https://git.kernel.org/netdev/net-next/c/40f111cc6e1b
  - [PATCHv2,net-next,7/7] net: ag71xx: disable napi interrupts during probe
    https://git.kernel.org/netdev/net-next/c/8410adf2e38a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




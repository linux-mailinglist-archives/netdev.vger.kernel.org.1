Return-Path: <netdev+bounces-61482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A042182400E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521C61F2233A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022220DF6;
	Thu,  4 Jan 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhuhiOVC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD02136D
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5B18C433CD;
	Thu,  4 Jan 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704366028;
	bh=/ikCST/AR6KNhqEGzdxcYWDj3kT7ls5Y2BWoa8BZx4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PhuhiOVCbEdzv/1fDQXddNFYwK87HEc021XBrSAqIoilUA6rFv1pmze7Dl4DUiqXS
	 RpkdHQGO2cJLjHT18zpKb8Me80K6TE4LtuqYG1ygG6Eogtko1eTlXKC36Dq51HW1IL
	 DdUYZ8spdPDCqT3uOkLXMW6yLAwKfLW81T4T1XHUOLbgihX2jDJORue0lrA9fGt5YH
	 O6BoTXXuSR93yqBsGaUPekUr8f1m7uvwmtLtfHCFN09ob9+Qizr6VoOYorG8njTMh7
	 3VJepbzdk62qDnpPAN2bPLorLGhekPQElq1nQyoeglZhkb1NrvLPcOyKc4uuBFysT0
	 CSk+1/ZrBuhWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2F6CC4166F;
	Thu,  4 Jan 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/8] Implement more ethtool_ops for Wangxun
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436602866.13188.11364431731161025698.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 11:00:28 +0000
References: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
In-Reply-To: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Jan 2024 10:08:46 +0800 you wrote:
> Provide ethtool functions to operate pause param, ring param, coalesce
> channel number and msglevel, for driver txgbe/ngbe.
> 
> v6 -> v7:
> - Rebase on net-next.
> 
> v5 -> v6:
> - Minor fixes address on Jakub Kicinski's comments.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/8] net: libwx: add phylink to libwx
    https://git.kernel.org/netdev/net-next/c/e8e138cf7383
  - [net-next,v7,2/8] net: txgbe: use phylink bits added in libwx
    https://git.kernel.org/netdev/net-next/c/4491c602fe5f
  - [net-next,v7,3/8] net: ngbe: convert phylib to phylink
    https://git.kernel.org/netdev/net-next/c/bc2426d74aa3
  - [net-next,v7,4/8] net: wangxun: add flow control support
    https://git.kernel.org/netdev/net-next/c/2fe2ca09da95
  - [net-next,v7,5/8] net: wangxun: add ethtool_ops for ring parameters
    https://git.kernel.org/netdev/net-next/c/883b5984a5d2
  - [net-next,v7,6/8] net: wangxun: add coalesce options support
    https://git.kernel.org/netdev/net-next/c/4ac2d9dff4b0
  - [net-next,v7,7/8] net: wangxun: add ethtool_ops for channel number
    https://git.kernel.org/netdev/net-next/c/937d46ecc5f9
  - [net-next,v7,8/8] net: wangxun: add ethtool_ops for msglevel
    https://git.kernel.org/netdev/net-next/c/b746dc6bdde5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




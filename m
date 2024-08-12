Return-Path: <netdev+bounces-117665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F3D94EB76
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CDE1F222FF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4925170854;
	Mon, 12 Aug 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxfNMwh3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F716E866;
	Mon, 12 Aug 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459829; cv=none; b=O7X+b4bM5TeEU/4gt+Z4A1E9DpBU7r2TXQaYzb6wAr0ARL57lkLrfH/gb71l88AzDHt5LchBBrD351DIuF9DvRmjkSP9SLQxNq6SBuDuqJ7upXwUqMEIjFOCeAGPg4eRbDGbN7ze9ZDBjhTxTnlMGtsOakk/F2igCzqgg6tPtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459829; c=relaxed/simple;
	bh=chTj+jP0wy6W9bqLQZo870rZ+nHwTloxyw7wRsodaew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NLwLcetRA8Rz7Ofe50/jcJdQzVSlb76ivZJKZ2KCo5K7Bf7wgKmXkt4l+0Z1REPI7yL3FftE/ffZ3+e7XEYBSyBmUDFrUNV5YqBpcM+zXXlmdDHLsK0K1WfFQBfJU4j7S/aRAQTnqC1KZUgGtl+B8jQX8IH6XI3iupaEf2m7aCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxfNMwh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CB7C4AF0E;
	Mon, 12 Aug 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723459829;
	bh=chTj+jP0wy6W9bqLQZo870rZ+nHwTloxyw7wRsodaew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DxfNMwh3KMl3qdu1FaHbJ4hbNqh0gdB2AQGzx1ZKbFpe0ruHkR8aicFrMW9qlTVWB
	 oDGS0DM/8emM4XeKOj9MGmxb2J8bx9ZAjhj6I9Nu/luIhTZdVf6u1LIXtkp2sXlsn7
	 QvEpr080xSbK7LbHW8A5kR5x7HIQ2QvJYBadTA94fX2Um+b54iV4syHOS1r2llPwv9
	 9/tdyzqswgXf24Fh3pRafOoCp9k2IygAxRhYXneeENcs9W5cF05EvEKCjAA3hXkYHZ
	 BgRWNWT2fYRBM3yfPjgCzDOSWZCT6Cp9zKMqkCFhHuWQDW9Mm5EQ5iSkqMHG6W9Hi4
	 mR7ng6FPodbNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCF382332D;
	Mon, 12 Aug 2024 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/5] net: dsa: vsc73xx: fix MDIO bus access and PHY
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172345982827.985786.6202904232752741486.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 10:50:28 +0000
References: <20240809193807.2221897-1-paweldembicki@gmail.com>
In-Reply-To: <20240809193807.2221897-1-paweldembicki@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 linus.walleij@linaro.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Aug 2024 21:38:01 +0200 you wrote:
> This series are extracted patches from net-next series [0].
> 
> The VSC73xx driver has issues with PHY configuration. This patch series
> fixes most of them.
> 
> The first patch synchronizes the register configuration routine with the
> datasheet recommendations.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/5] net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
    https://git.kernel.org/netdev/net/c/63796bc2e97c
  - [net,v3,2/5] net: dsa: vsc73xx: pass value in phy_write operation
    https://git.kernel.org/netdev/net/c/5b9eebc2c7a5
  - [net,v3,3/5] net: dsa: vsc73xx: check busy flag in MDIO operations
    https://git.kernel.org/netdev/net/c/fa63c6434b6f
  - [net,v3,4/5] net: dsa: vsc73xx: allow phy resetting
    https://git.kernel.org/netdev/net/c/9f9a72654622
  - [net,v3,5/5] net: phy: vitesse: repair vsc73xx autonegotiation
    https://git.kernel.org/netdev/net/c/de7a670f8def

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




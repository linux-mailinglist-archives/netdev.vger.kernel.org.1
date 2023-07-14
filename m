Return-Path: <netdev+bounces-17841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5271753347
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC88F282032
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88BD7472;
	Fri, 14 Jul 2023 07:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B3746A
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6BB5C433C9;
	Fri, 14 Jul 2023 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689320421;
	bh=2Pu8AZKXPQyErrJn8SAB2LYoI0Xe1043MMv6vJSeFqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ho4jqT8XdIepn2AGe+YL6a2HyoWek41IKWkh6SVMqD4wGYZuRdUeacXXg/JODrWjx
	 lqZPucdCdk0jy0gKt8eyGYMRcd45zwov+DEnM8o8qUolLMDPWis6jSrSakqK1B1hHt
	 Ynur3C0l2kXz2ghHjda/ZZDuDAh1nmOjRTPv0xKfz5c6MNsus1i/WcrWrNEOk/B53h
	 h511Q2xgmCPP4hQGpSsa8ccQhiv04LZszp5dNcrNuZ3PZ0NSNxCBdsRAPNL1rYZpa3
	 TXo7wngFNL2MdvcqQp4q8ytm2LFzFjAtSfZbu1R/eS8Hc/UmEgZNP05Hejyl05xojy
	 rzpQ+DwASlxMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C555FE4508F;
	Fri, 14 Jul 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: ar9331: Use explict flags for regmap single
 read/write
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932042079.7517.10211211896014478722.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 07:40:20 +0000
References: <20230712-net-at9331-regmap-v1-1-ebe66e81ed83@kernel.org>
In-Reply-To: <20230712-net-at9331-regmap-v1-1-ebe66e81ed83@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 12 Jul 2023 12:16:16 +0100 you wrote:
> The at9331 is only able to read or write a single register at once.  The
> driver has a custom regmap bus and chooses to tell the regmap core about
> this by reporting the maximum transfer sizes rather than the explicit
> flags that exist at the regmap level.  Since there are a number of
> problems with the raw transfer limits and the regmap level flags are
> better integrated anyway convert the driver to use the flags.
> 
> [...]

Here is the summary with links:
  - net: dsa: ar9331: Use explict flags for regmap single read/write
    https://git.kernel.org/netdev/net/c/9845217d60d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




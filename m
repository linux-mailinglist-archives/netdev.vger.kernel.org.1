Return-Path: <netdev+bounces-52195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85F7FDDA2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF52AB20F5E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696AF3B78B;
	Wed, 29 Nov 2023 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLZU+Ybv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431083B786
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA8F7C433CA;
	Wed, 29 Nov 2023 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276628;
	bh=QbVMk2yZXzADl36dPyGkoug0MgugmBpHzfmlEiYqjzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SLZU+YbvnVxffL1w2LpApJpaVLtadIVFAPImSI9JwmzQM92uD/99yU0uieazUu1gR
	 NiT9guODT0AlqsUB52xmTyKqoZgKSUkpA4kvzZFu2NXipaNDJ9Co4uZ44duQo0ZROl
	 V/WilQaJEwcn02d9sAkYmWj+h3vk8DJyBZWIR5uZWKDF272AsAOYvriWQBZIaZRBgy
	 h5mSGrQ5BUxx5g+wv4YiLrXI7YnTKRX/vsVuI+1BhgoiDESdMWmzzH1FzRI5HyYseP
	 76GBDco0SKlNaGo+Yv3YeDJktBggrmCjAOf+r+OaPCkAJJJHPE0xRTSunt9t+RZqzU
	 /+wm7zWoZUusw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95EBEDFAA82;
	Wed, 29 Nov 2023 16:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/3] Fine-Tune Flow Control and Speed
 Configurations in Microchip KSZ8xxx DSA Driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170127662861.14566.16878537775861868899.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 16:50:28 +0000
References: <20231127145101.3039399-1-o.rempel@pengutronix.de>
In-Reply-To: <20231127145101.3039399-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 linux@armlinux.org.uk, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 15:50:58 +0100 you wrote:
> changes v7:
> - make pause configuration depend on MLO_PAUSE_AN
> - use duplex == DUPLEX_HALF
> 
> changes v6:
> - move pause controls out of duplex scope
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/3] net: dsa: microchip: ksz8: Make flow control, speed, and duplex on CPU port configurable
    https://git.kernel.org/netdev/net-next/c/87f062ed853c
  - [net-next,v7,2/3] net: dsa: microchip: ksz8: Add function to configure ports with integrated PHYs
    https://git.kernel.org/netdev/net-next/c/2f58148c41e2
  - [net-next,v7,3/3] net: dsa: microchip: make phylink_mac_link_up() not optional
    https://git.kernel.org/netdev/net-next/c/71cd5ce7e2f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




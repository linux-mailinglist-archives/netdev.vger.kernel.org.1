Return-Path: <netdev+bounces-61739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D4824C4A
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B1D1C22444
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC317CA;
	Fri,  5 Jan 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxtQVS02"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30D811
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 01:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D18E2C433C9;
	Fri,  5 Jan 2024 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704416425;
	bh=zGVYzD8eXplw4gb3WGzPEZCfgehAUrh6gaKQTeECQdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JxtQVS027fuKFbkBIqrrO1N4CAFibkt6D4QwJOVdNmN31P5C/YnEiuCcdbE6HP1EZ
	 /65sgMg0jkE5wtxtsyWAiVvhRSE/0WB5gucJ5URtCXTqWqnhSsdpwqcP6rllu6/80+
	 PqTVo3a+d5c0pZK7DIiQ9KvTkWHJ6Gv8023M5VihVF4Z9KGnjo1Ndq8k6aP5WQjNUq
	 Gs5UMXBh6sY2X0XA4102UslJ5s+zV86SZt8bV8c4yU46sqU2Y9fo9YifFVs4SSNdBc
	 ZEh0xdCplg0FDgwow8fHzMUVKVrsQo79mRoeGMIpuShbszuNmHZTt6rpRRP79S6xC7
	 8oYcdpOuvvIPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5864C3959F;
	Fri,  5 Jan 2024 01:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: fix building with CONFIG_LEDS_CLASS=m
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170441642573.24287.3221322138085351593.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 01:00:25 +0000
References: <d055aeb5-fe5c-4ccf-987f-5af93a17537b@gmail.com>
In-Reply-To: <d055aeb5-fe5c-4ccf-987f-5af93a17537b@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 arnd@arndb.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Jan 2024 16:52:04 +0100 you wrote:
> When r8169 is built-in but LED support is a loadable module, the new
> code to drive the LED causes a link failure:
> 
> ld: drivers/net/ethernet/realtek/r8169_leds.o: in function `rtl8168_init_leds':
> r8169_leds.c:(.text+0x36c): undefined reference to `devm_led_classdev_register_ext'
> 
> LED support is an optional feature, so fix this issue by adding a Kconfig
> symbol R8169_LEDS that is guaranteed to be false if r8169 is built-in
> and LED core support is a module. As a positive side effect of this change
> r8169_leds.o no longer is built under this configuration.
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: fix building with CONFIG_LEDS_CLASS=m
    https://git.kernel.org/netdev/net-next/c/a2634a5ffcaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-44867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBBE7DA2A0
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963751C21106
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E97F3FE46;
	Fri, 27 Oct 2023 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkJzA0yG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274D1772B;
	Fri, 27 Oct 2023 21:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88B06C433C7;
	Fri, 27 Oct 2023 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698443425;
	bh=C6esmH28G6+Pxzl/auTbMgA2kD5mlIUMcqw28xN246o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jkJzA0yGysFGiawXRze/PR9T8EgyNgxOTZ13if1m5q45WJgVAnaXH2F4glNawPcAI
	 /62SETWWvYvcNEAb0TtzhSowVwft2/lJNQ4m5WUi0m7rO83H9XmphBpNmsJxvLnd8I
	 0rlbs2rN5WNCGQqpDruFhd2lzz+YldDx4NCoYn3j+s9esVhrSq8Rv/uTlZx10P6VdN
	 icMadyQz2SngJeyf5CemKIM+/WFhknkQqHTjCWHdWSeVafbEBr0Vtsr5OJfD+mT5KC
	 E64e0bMJeembkTvn9hv0AL/CLEkGvfsicDz2CxRA05AWkb0vTLopAA09BQvnLyeDAl
	 eFeFx6b0I15Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A871C39563;
	Fri, 27 Oct 2023 21:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/5] net: dsa: microchip: provide Wake on LAN
 support (part 2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844342542.18340.14342380528191551889.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 21:50:25 +0000
References: <20231026051051.2316937-1-o.rempel@pengutronix.de>
In-Reply-To: <20231026051051.2316937-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
 devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Oct 2023 07:10:46 +0200 you wrote:
> This patch series introduces extensive Wake on LAN (WoL) support for the
> Microchip KSZ9477 family of switches, coupled with some code refactoring
> and error handling enhancements. The principal aim is to enable and
> manage Wake on Magic Packet and other PHY event triggers for waking up
> the system, whilst ensuring that the switch isn't reset during a
> shutdown if WoL is active.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/5] net: dsa: microchip: ksz9477: Add Wake on Magic Packet support
    https://git.kernel.org/netdev/net-next/c/3b454b6390c3
  - [net-next,v8,2/5] net: dsa: microchip: Refactor comment for ksz_switch_macaddr_get() function
    https://git.kernel.org/netdev/net-next/c/78c21fca0b39
  - [net-next,v8,3/5] net: dsa: microchip: Add error handling for ksz_switch_macaddr_get()
    https://git.kernel.org/netdev/net-next/c/818cdb0f4b38
  - [net-next,v8,4/5] net: dsa: microchip: Refactor switch shutdown routine for WoL preparation
    https://git.kernel.org/netdev/net-next/c/77c819cb493a
  - [net-next,v8,5/5] net: dsa: microchip: Ensure Stable PME Pin State for Wake-on-LAN
    https://git.kernel.org/netdev/net-next/c/8afb91acc4a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-149875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4239E7DEB
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 03:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642272878CA
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBAA199B9;
	Sat,  7 Dec 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPRJVnZA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CB323D;
	Sat,  7 Dec 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536827; cv=none; b=Z0sgbbgb9q3NApubNe3zHBtJ5PDeFHC71WWMFD+7KBwVNYn2pU4wLkTLlaZPUDGMZP9M1NUHDo3EzxPoiaZAa7kWcEkgn4sNZMcdhEI9X6Z5z0ws9+QewxlgZJsOnMEcdg5ou59klaEmO3T/uexR4yGzgaiik8MnnWso8Zfi/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536827; c=relaxed/simple;
	bh=of1Lhy0HRvfmZRqXyoQZSMSlYIrBpdpmqDnFTTTpypc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H+5QDi0T8MeButnTjesCC17MsQxdd0cDOG7l3gfUyR0FqZoBfPvz0yQhNAvcWqJLHATlu0VbJ9FFtkVPpuwSwHh0tWHl4ZK327l1M7xUNDAhgFkG5P7zShxN0w+50Bbls5z84Niji0WDwRW8oppQYcM3tYp6gYoLrSlP4619FmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPRJVnZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B73C4CED1;
	Sat,  7 Dec 2024 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536825;
	bh=of1Lhy0HRvfmZRqXyoQZSMSlYIrBpdpmqDnFTTTpypc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pPRJVnZAQ1QXm/xYNMQjTF11IrSBEWaLBOWJdZg9Fdszhb9cbPV5hENQb7bjIPBhe
	 yvUtaqQ3/ix6yEZY6/CSefVc4YwiyAJEPm6gO/G7cH2RejKPUZznS2Dtu4GMLZXpB5
	 zR+p+w2L7xx3EtrwhvP2tyBZS2B0JnDFzf4RiRUBokWqGBUeZOveDh71JIVhGj9VLs
	 Urd3hmjFQ/MONenrmGlHz2HwYKLXtprg7hzqN1ilnTWskCqxJpmMHjcJkzabilCbSP
	 g1kuFp9s3CH8uYXrx1YfWfs8DqNp+nSN918OO9fjissn1rsGNhJsKOenso3E3wQI0U
	 MIAZP76rBgALQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF17380A95C;
	Sat,  7 Dec 2024 02:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/21] lan78xx: Preparations for PHYlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353684057.2872036.10076013209434482151.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 02:00:40 +0000
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
In-Reply-To: <20241204084142.1152696-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 09:41:32 +0100 you wrote:
> changes v2:
> - split the patch set.
> 
> This patch set is part of the preparatory work for migrating the lan78xx
> USB Ethernet driver to the PHYlink framework. During extensive testing,
> I observed that resetting the USB adapter can lead to various read/write
> errors. While the errors themselves are acceptable, they generate
> excessive log messages, resulting in significant log spam. This set
> improves error handling to reduce logging noise by addressing errors
> directly and returning early when necessary.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] net: usb: lan78xx: Remove LAN8835 PHY fixup
    https://git.kernel.org/netdev/net-next/c/7b60c3bf93fa
  - [net-next,v2,02/10] net: usb: lan78xx: Remove KSZ9031 PHY fixup
    https://git.kernel.org/netdev/net-next/c/6782d06a47ad
  - [net-next,v2,03/10] net: usb: lan78xx: move functions to avoid forward definitions
    https://git.kernel.org/netdev/net-next/c/39aa1d620d10
  - [net-next,v2,04/10] net: usb: lan78xx: Improve error reporting with %pe specifier
    https://git.kernel.org/netdev/net-next/c/9bcdc610cfab
  - [net-next,v2,05/10] net: usb: lan78xx: Fix error handling in MII read/write functions
    https://git.kernel.org/netdev/net-next/c/32ee0dc76450
  - [net-next,v2,06/10] net: usb: lan78xx: Improve error handling in EEPROM and OTP operations
    https://git.kernel.org/netdev/net-next/c/8b1b2ca83b20
  - [net-next,v2,07/10] net: usb: lan78xx: Add error handling to lan78xx_init_ltm
    https://git.kernel.org/netdev/net-next/c/77586156b517
  - [net-next,v2,08/10] net: usb: lan78xx: Add error handling to set_rx_max_frame_length and set_mtu
    https://git.kernel.org/netdev/net-next/c/65520a70cb09
  - [net-next,v2,09/10] net: usb: lan78xx: Add error handling to lan78xx_irq_bus_sync_unlock
    https://git.kernel.org/netdev/net-next/c/0da202e6a56f
  - [net-next,v2,10/10] net: usb: lan78xx: Improve error handling in dataport and multicast writes
    https://git.kernel.org/netdev/net-next/c/48fb3d3c4be6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




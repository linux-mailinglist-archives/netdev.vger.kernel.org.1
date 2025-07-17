Return-Path: <netdev+bounces-207662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3432B0816F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446595802EC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139BC70825;
	Thu, 17 Jul 2025 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuElOaY7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A162E370C;
	Thu, 17 Jul 2025 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712792; cv=none; b=dTldThIU5Y91Jcq2A1/4tDwrFm8L0yg8/hx1AKoF2xI4p/pWGUWDdT3v+Rg+r+Qcji542SBWp4A3sMR6C1m8HKK3JWTtLX+8h+3m2SZc96CgC3n0mTgSnErAEP5jMKQpVJYqTjMeXe4Fc0FzxNNQngo+bSdhMC0Lak/eQq1eZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712792; c=relaxed/simple;
	bh=0oNS4QWWuAKBe/4MiGtK8XIFEH9xPGCkiqUULk4IQ3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=onCPUWPHXOIJ32IIl896DB6bsBe5kNEzVpa12sOJ3t00Fin3yolXjDeSpsBbbBabnqGRWoz+PD7u7Nu4S5WsBhIETU2C4NvSKzMqtgVDOwSGwzbK1MSewDExVfqABxeyBgQrio8WOhh/IsoTTIxQUtuV5RrZ7CbmR1Te9v0X/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuElOaY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D266C4CEE7;
	Thu, 17 Jul 2025 00:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752712791;
	bh=0oNS4QWWuAKBe/4MiGtK8XIFEH9xPGCkiqUULk4IQ3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DuElOaY7VElFjy6DeOABFGnHEXUoRPEzuSlyqZhb7Nt//JW4FhB+QYikCl3We5Vg4
	 49I5rwd8mO3MUSbKmY8yd7BcqQHMIVIqPc0AIlXNL5nT4VR8iv6lPM6lPiOn4x6aWr
	 xUmm3kyF03921beAkmmAxWyNkOF2OnXMKU6NnDwvGPWEntsN9mzQ9yJcVGpjt5AyC6
	 NIkUh3mtBZu5NQOdA6tgO0yE5ov5l4NrJO6wJ9jZvv9lmyi++1VPfScmnPsjdAvxxW
	 GH9lCkna8HANkef3CZh4NP1Q2uwT2UJ3rIKmTkKVBrMXYmjk8aQ/vho2D7IQk8U1jj
	 TycJ5dBxjweAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE150383BA38;
	Thu, 17 Jul 2025 00:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] Expose REFCLK for RMII and enable RMII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271281150.1376782.14178930908812628013.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 00:40:11 +0000
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
In-Reply-To: <cover.1752510727.git.Ryan.Wanner@microchip.com>
To: Ryan Wanner <Ryan.Wanner@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 09:36:58 -0700 you wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This set allows the REFCLK property to be exposed as a dt-property to
> properly reflect the correct RMII layout. RMII can take an external or
> internal provided REFCLK, since this is not SoC dependent but board
> dependent this must be exposed as a DT property for the macb driver.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] dt-bindings: net: cdns,macb: Add external REFCLK property
    https://git.kernel.org/netdev/net-next/c/1b7531c094c8
  - [v2,2/5] net: cadence: macb: Expose REFCLK as a device tree property
    https://git.kernel.org/netdev/net-next/c/dce32ece3bb8
  - [v2,3/5] net: cadence: macb: Enable RMII for SAMA7 gem
    https://git.kernel.org/netdev/net-next/c/eb4f50ddfdd3
  - [v2,4/5] net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag
    https://git.kernel.org/netdev/net-next/c/db400061b5e7
  - [v2,5/5] ARM: dts: microchip: sama7g5: Add RMII ext refclk flag
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




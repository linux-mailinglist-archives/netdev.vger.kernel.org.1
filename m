Return-Path: <netdev+bounces-205212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85FAFDCEF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E8F173BA6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15141624E9;
	Wed,  9 Jul 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoRVF4lZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711A153BD9;
	Wed,  9 Jul 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024589; cv=none; b=iX+Edyu4xOwEIbAe5QQYXiijxXKZG6h8da1vdcvErL4aV+H4cubiH/k7fKHUcVm7WhrN0DKOYdzmb2t2BtIZONgm3AoFeMUxYuHkAE6Saa50LUoiG/JD31MgCcnBKhjXnfmU+tO3dvjVjECMH5zyodYofO8GtBiYpYhlaogDjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024589; c=relaxed/simple;
	bh=eY8NWnVC7ALCgYzoeyG1zvtupOQiJPwW9JxtGjJHT5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jwSfz3DG7rxwn4aAXEXWQd606dZv6mcB7QLHfg3bDASCISISeScRRa10y8H+y2EndC5TmXlf/0uIan9McEI4FTr0CMa+EEdp21uYc0F7Rvp06wJohzrz6WVWVxBuP2BtPrwLdooQbBsQVRMi5NICgY9a7srZNBEdexFHl2cqw3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoRVF4lZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA2C4CEED;
	Wed,  9 Jul 2025 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752024589;
	bh=eY8NWnVC7ALCgYzoeyG1zvtupOQiJPwW9JxtGjJHT5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aoRVF4lZn3d3KjcGZm1armU+SQRv1yzzb6wOO19uudZYyrDn/usLW1RTHfy4a2MXv
	 mJucvUlht9vZAENOwHF0NjlTPDUXECPH01Mj2iXGh/4cqtUcgjWEEX6nxXTDofPThp
	 Ui7oaU8rb5rGXn5Otg9+2W/O0sEfWcv6J09XX/8jqmsP667vXmEBVRFDNO7893j3SI
	 o3VH3+bAiAhuDMapbnOmTVJ0NSt36COLibOgLSnN0yCPswoJqgGY8YhgBubKmrX0x4
	 ZBqeU868eT8dm3guAbcZAh+rx06pJxANK8LppX6STjQ0UvRRFoZaH5sjrkT19lV7xl
	 IaeP2/jTrED4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF65380DBEE;
	Wed,  9 Jul 2025 01:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] net: phy: smsc: robustness fixes for
 LAN87xx/LAN9500
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202461176.186229.18254755075950170255.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 01:30:11 +0000
References: <20250703114941.3243890-1-o.rempel@pengutronix.de>
In-Reply-To: <20250703114941.3243890-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, andre.edich@microchip.com, lukas@wunner.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Jul 2025 13:49:38 +0200 you wrote:
> changes v2:
> - drop IRQ patch.
> - no other changes are made
> 
> Hi all,
> 
> The SMSC 10/100 PHYs (LAN87xx family) found in smsc95xx (lan95xx)
> USB-Ethernet adapters show several quirks around the Auto-MDIX feature:
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
    https://git.kernel.org/netdev/net/c/a141af8eb227
  - [net,v2,2/3] net: phy: smsc: Force predictable MDI-X state on LAN87xx
    https://git.kernel.org/netdev/net/c/0713e55533c8
  - [net,v2,3/3] net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
    https://git.kernel.org/netdev/net/c/9dfe110cc0f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




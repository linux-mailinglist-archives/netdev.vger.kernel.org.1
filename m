Return-Path: <netdev+bounces-206006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0EEB010B9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E6765F00
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A5816E863;
	Fri, 11 Jul 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIN+1oRO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62256F073;
	Fri, 11 Jul 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196812; cv=none; b=MP62mODwRSros+8tBoU078E6METGO6z/N1xN9wCrTrhwMnjdcRL2KNNU4PsOX/KNb7Gq3X4vH2wR9whe/07tkQAE+aBfvkVuc3v1Qx+nGqdPXJ8eKP5pcJEua1RHr4vJlAsS/B3Sv7QV0NmD36HPHGjoh1IYAMgilytUyeFveoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196812; c=relaxed/simple;
	bh=IHx4h69R13Or67ZMOMaSeRoVxPzmcWG/NZh6P4Ei+UE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OflZsByfwsESZ36kqBGi9xujllqBX6OyTwRleXznvO6oCCDYrPJqex1rwsa2qo5TXjs8FfKWBdi9BT6OuW8G5FljT7bViRolOZkVSoIMqPH0Bl/O5zr/lclp8QDAbFEMGKvuTl/GPDthnkT4MUFtNcCQcfFKDqaOhG2VmmgQ8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIN+1oRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D8C4CEF4;
	Fri, 11 Jul 2025 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752196811;
	bh=IHx4h69R13Or67ZMOMaSeRoVxPzmcWG/NZh6P4Ei+UE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NIN+1oRO/ktlMLvxpr5oyhzKdiKGbY37jGX1lxWxCpJkzHZ++lY+dmePCONpYbsoU
	 1FTjG8FW1ThT69hHy4BW4BxdBeWnACSykXHqLKShlqHZGufGNYWZUjj2d63oOMUfEf
	 8sM+J+1Q47VeVnzSHkcdCnUgbRVHs74LbjCLjSSgGjM5HYykkNs/uj6OH3EiNb9ycg
	 ysjFsmQQbHC8pWtSlRE1Mh9btbyasQVJkb8fy2IfvB+6hC5D+fcg9JR5xFNxq4fTAn
	 0Ar+E8cdOe5XdB/SAXEi/WHWrbKwGpAtGZljUN1OsSe0o3kPLx7v+wjqX9FmawNXPL
	 ly+HdBmwlqvIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE060383B266;
	Fri, 11 Jul 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v4 0/4] net: ftgmac100: Add SoC reset support for RMII
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219683324.1724831.15355320324094175037.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:20:33 +0000
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 horms@kernel.org, jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com,
 hkallweit1@gmail.com, BMC-SW@aspeedtech.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Jul 2025 15:08:05 +0800 you wrote:
> This patch series adds support for an optional reset line to the
> ftgmac100 ethernet controller, as used on Aspeed SoCs. On these SoCs,
> the internal MAC reset is not sufficient to reset the RMII interface.
> By providing a SoC-level reset via the device tree "resets" property,
> the driver can properly reset both the MAC and RMII logic, ensuring
> correct operation in RMII mode.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] dt-bindings: net: ftgmac100: Add resets property
    https://git.kernel.org/netdev/net-next/c/fc6c8af6d784
  - [net-next,v4,2/4] dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
    https://git.kernel.org/netdev/net-next/c/4dc5f7b2c0cc
  - [net-next,v4,3/4] ARM: dts: aspeed-g6: Add resets property for MAC controllers
    (no matching commit)
  - [net-next,v4,4/4] net: ftgmac100: Add optional reset control for RMII mode on Aspeed SoCs
    https://git.kernel.org/netdev/net-next/c/af350ee72e9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




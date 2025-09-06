Return-Path: <netdev+bounces-220546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE8B46862
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F166C7A8ED5
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17AB202F9F;
	Sat,  6 Sep 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THn72tLW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982781FDA94;
	Sat,  6 Sep 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757125209; cv=none; b=r2HIdPRAFbGQpgcaig2l3hCnVTWCIYIGKUp3eSs7kDw6zbEefJpOH/QcDvK0+ZnkOrM9MS8+Q3ilcKjRYIUFRut3gmGCwcLlMbZIrnF01p2p5o3zKeL/qK0KTS5xK/ng4KvwMiyoGuHnRkAQQ0mAdnERosVcG1gSjsqFdH0gLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757125209; c=relaxed/simple;
	bh=ccdbqjJD9TxJvvVk9iwqDWWe5yHoYeZm/dbKjaO7OIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aJ6pkCZpv+UxgFwLo9CBCH30heRiETQRd6a1hqzW8wLEo8QuzZnLekY5uujC0lkGgVGtKx50e+TigHbIeqRmSa9xRi4hkA6W00CDImIoj8yNFOq+AqlnS4TDVzfQv75WUR+hGHfiiml2lcl+QnJxY9UCEutM0HeyeX3RTq71j3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THn72tLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE80C4CEF7;
	Sat,  6 Sep 2025 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757125209;
	bh=ccdbqjJD9TxJvvVk9iwqDWWe5yHoYeZm/dbKjaO7OIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=THn72tLWMa2ECtQv3Hre5Qh6Irt3R1VGUZNNupSmxl38z0fW5Ad+j53NRHRgk4OET
	 /e88oDAaiYlrksQc4dAYvbO7a11ZU0uFcmoLiMPp3+spUAFHjKi0z8JLtkdKcNPxZX
	 vtChjIWmwcpL1puP/y5Fagz7JAxriWHuZATOy1NoZZzjqK56dEl2fkc6auOb+zB0x0
	 1DndaGvomEUOq5lmu/QMONuVmjvCExLTorY/PNrAgtvGO5GFF/adT56qnzFmnqoLU9
	 pETiOkEYngF2Ewv4DTxPIjZXWt0bBw/CLoChNi8fxv4Iwpv/h6bbSN3e5nPRXFIq2a
	 VhBkFaVAPMWgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2D383BF69;
	Sat,  6 Sep 2025 02:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] 10G-QXGMII for AQR412C,
 Felix DSA and Lynx PCS driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175712521350.2748352.11613393248327426471.git-patchwork-notify@kernel.org>
Date: Sat, 06 Sep 2025 02:20:13 +0000
References: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ioana.ciornei@nxp.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 daniel@makrotopia.org, quic_luoj@quicinc.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 16:07:24 +0300 you wrote:
> Introduce the first user of the "10g-qxgmii" phy-mode, since its
> introduction from commit 5dfabcdd76b1 ("dt-bindings: net:
> ethernet-controller: add 10g-qxgmii mode").
> 
> The arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso already
> exists upstream, but has phy-mode = "usxgmii", which comes from the fact
> that the AQR412(C) PHY does not distinguish between the two modes.
> Yet, the distinction is crucial for the upcoming SerDes driver for the
> LS1028A platform.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: pcs: lynx: support phy-mode = "10g-qxgmii"
    https://git.kernel.org/netdev/net-next/c/76cd8a2ea98a
  - [net-next,2/6] net: dsa: felix: support phy-mode = "10g-qxgmii"
    https://git.kernel.org/netdev/net-next/c/6f616757dd30
  - [net-next,3/6] net: phy: aquantia: print global syscfg registers
    https://git.kernel.org/netdev/net-next/c/7b0376d0e063
  - [net-next,4/6] net: phy: aquantia: report and configure in-band autoneg capabilities
    https://git.kernel.org/netdev/net-next/c/5d59109d47c0
  - [net-next,5/6] net: phy: aquantia: create and store a 64-bit firmware image fingerprint
    https://git.kernel.org/netdev/net-next/c/dda916111e29
  - [net-next,6/6] net: phy: aquantia: support phy-mode = "10g-qxgmii" on NXP SPF-30841 (AQR412C)
    https://git.kernel.org/netdev/net-next/c/a76f26f7a81e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




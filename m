Return-Path: <netdev+bounces-184027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB40A92F8A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE0A462325
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1C25E83B;
	Fri, 18 Apr 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc1SNNT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2825E834;
	Fri, 18 Apr 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941024; cv=none; b=hfdVUamuQPpGIx1qt4FwJi5IxSAL0ZcNPye7PdDocY4AkMbvzBKSvE5jneHTdwW3ELYwGZSgnrMoRybU4KEmmB1OuBpdO3UESUi54Fef2DxOIUbk//7qeQ4WMcmTXk4fexK2j9N4aLBILW6IMzA0PfijplwbkADJknb0O6tEoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941024; c=relaxed/simple;
	bh=RWS3beSN0nf1LG/1NlhXEkDw2nBv4zaRnqOhm+10ccI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cdP32PTnq3Xsvo6W/aOA+ngM5u7mCTavpP5xF/mfg8retcCW8BY+XJaV8CRd18bnO0cwIbijM6kgBGN21usB9/KwmXzwpyAoaYUJiYkJBLA05XP9A8oDRZrDxED/0XltKaCE44aDmI13SmzpfBZHHhu+/5QBG2XQIyddj2fNJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc1SNNT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC52CC4CEEB;
	Fri, 18 Apr 2025 01:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744941023;
	bh=RWS3beSN0nf1LG/1NlhXEkDw2nBv4zaRnqOhm+10ccI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hc1SNNT+G7wWIDXsMbBYH6kqxhekJntqM19hxW+syQOW5t8laYO+5aKRzz8QYhMrX
	 bF1u0Ay9Qu1NTL3YoBDE+8lfoliQKhOT8/WUUoPQevnNmERTAxfNSoa3TEbQb02XhJ
	 d9yRTqlz9dSqkd7jUQA5hv2lXVeLZJZyGTAL66t/G5DznRDt3IagjzE+rcoVp37Mpc
	 SYbukbpLlYZAzPItqcVdVPleocnrFlsp+1NzZAGzsL5nMsfinvYvzBkxOk8OepL9Bx
	 krH5AR1X9D2i1Mct8gD4P+ODe0uaw+pvcDOpQFnk5uJh0lRroXyf/UFu5wd5JHMTgg
	 wstyBa+3h68Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B0B380AAEB;
	Fri, 18 Apr 2025 01:51:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: stmmac: sunxi cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494106174.75375.14390030556312826842.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 01:51:01 +0000
References: <Z_5WT_jOBgubjWQg@shell.armlinux.org.uk>
In-Reply-To: <Z_5WT_jOBgubjWQg@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, wens@csie.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jernej.skrabec@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 samuel@sholland.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 13:51:27 +0100 you wrote:
> Hi,
> 
> This series cleans up the sunxi (sun7i) code in two ways:
> 
> 1. it converts to use the new set_clk_tx_rate() method, even though
>    we don't use clk_tx_i. In doing so, I reformat the function to
>    read better, but with no changes to the code.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: stmmac: sunxi: convert to set_clk_tx_rate()
    https://git.kernel.org/netdev/net-next/c/a27d798fd83c
  - [net-next,2/3] net: stmmac: sunxi: use stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/dd2cdba4709f
  - [net-next,3/3] net: stmmac: sunxi: use devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/69b3e38e2fb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




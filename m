Return-Path: <netdev+bounces-226138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9577DB9CEBA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD97A1902
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003142D7DCD;
	Thu, 25 Sep 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqPSWHN/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A327D77A
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761430; cv=none; b=tOCBQL5bHRTRz9y/kYnLHNQN8EMtJCytCXcd6dFCMDOjGyXRhBNRszWSLWt9NH2e/1q7PV6iNWlmU3qSQmf2O8GM3AEjIlfxSBg6QT47vOdekkcaI1PRqIrqO0VORlG43eFgXGIwv6ti8X56hIvJb1d/fqEMelBDKjI/9VaSStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761430; c=relaxed/simple;
	bh=JOl8bvOaXKHP/plKSiwbXnFjVcEniK9Q1dE2r/E8ICA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CPFy0ua07XSUG2E23CPr5jf6/3lBCbQk90wkEcG98sp01ofyOiNZEeV2SYvRE+zdaLSMFZP2VkuZPLu88AP3M+26jLU9QnbWdj05fZGFVVajLKxPunsj41JChsD3eewYR1IhTR/AOR3FV7X6da6B1FiW9VfHm9vQ/uvLkJ9NdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqPSWHN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9B9C4CEE7;
	Thu, 25 Sep 2025 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758761430;
	bh=JOl8bvOaXKHP/plKSiwbXnFjVcEniK9Q1dE2r/E8ICA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LqPSWHN/3chhCOmy+6YDPFN6xr8NDxzNO998lF9/Ht+yNjj1+/ryFEXHvdi3MFwOF
	 YIO81ZOdsUqiOOBydKwfNk5kaHi1kgSOoCUrrckwpPePseATf+b88RMEnSfBL6wmor
	 i9MlFI2y9QiIMofu7E1nZJFpIDteI9gw5e1GcTj7tYisIrEsOFf9TdMcaoqx5EWCpE
	 foJyUvGBudfGMWJvxptNTuThOu2IP3THl246s1RUgZuqlwif8OXYPIa2JY9X1vjk1O
	 NKcXnEmEmqAg+5umPWUvoUpLKXMKFi8n+NgG9KjqEZ61Dh2nq/TyU6YrFpqrdSr8GZ
	 s5RrflQCldl4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE139D0C20;
	Thu, 25 Sep 2025 00:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: stmmac: yet more cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175876142648.2757835.630635315199558536.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 00:50:26 +0000
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Sep 2025 12:25:30 +0100 you wrote:
> Building on the previous cleanup series, this cleans up yet more stmmac
> code.
> 
> - Move stmmac_bus_clks_config() into stmmac_platform() which is where
>   its onlny user is.
> 
> - Move the xpcs Clause 73 test into stmmac_init_phy(), resulting in
>   simpler code in __stmmac_open().
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: stmmac: move stmmac_bus_clks_config() to stmmac_platform.c
    https://git.kernel.org/netdev/net-next/c/79d6e14e9cb3
  - [net-next,2/6] net: stmmac: move xpcs clause 73 test into stmmac_init_phy()
    https://git.kernel.org/netdev/net-next/c/f005ec4a3d6b
  - [net-next,3/6] net: stmmac: move PHY attachment error message into stmmac_init_phy()
    https://git.kernel.org/netdev/net-next/c/9641d727162d
  - [net-next,4/6] net: stmmac: move initialisation of priv->tx_lpi_timer to stmmac_open()
    https://git.kernel.org/netdev/net-next/c/bae62989a31b
  - [net-next,5/6] net: stmmac: move PHY handling out of __stmmac_open()/release()
    https://git.kernel.org/netdev/net-next/c/db299a0c09e9
  - [net-next,6/6] net: stmmac: simplify stmmac_init_phy()
    https://git.kernel.org/netdev/net-next/c/50acea3662bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




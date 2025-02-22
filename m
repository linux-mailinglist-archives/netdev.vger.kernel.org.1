Return-Path: <netdev+bounces-168722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29337A40451
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739E37AC6E1
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5448686358;
	Sat, 22 Feb 2025 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP5DaEZA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301EE46434
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184806; cv=none; b=a07Oz4GeNo2bgx4C2Z86iZNpzCCTc6REVDgSJdXtWGoiPhrh8z+yWoSjvvn8bNu+nf+VXsDxawdK3z/dzUHlRsBjSJ7qd58He63eVdD25iRYk0BNqcb86dfvA+T3pqGRmaVMbBY51iBOo0YNZTQ+SxzSiQEBabtrESya2RCxIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184806; c=relaxed/simple;
	bh=H48JW7AW173NYuh0XY8Bexb5wuYfEmHh77BrSrgAcTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z9dmN8EPe9oy2f/1UEaluhpmqbl94mdltbx0wq40agLjLThBnmgwHF8CLu1LrAB0bOwnRMdHiYuqrskH7UKldFAAzqgQyXpnPLEV+BLE3trfPA/hj0CCzfaqrlmcsXRqiOJ1S6clqLduOwsBlmsq56wiH3GNdBeZ0pGoVqzf7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP5DaEZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B6EC4CED6;
	Sat, 22 Feb 2025 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184806;
	bh=H48JW7AW173NYuh0XY8Bexb5wuYfEmHh77BrSrgAcTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IP5DaEZAGMCYAd7SYzf3poZOQnKpJUjp2s7WUISj87KW05YphO3WIX5+BCtPOifmp
	 5OqZCesEWqKAWvtfvysDZ8DFGoB6ZaXCq779oNeJzpH65QoX/Pr1Tn7ahvG/PL+tcZ
	 5GSDt+ih3RWfLL4ST7jozwiWLrkwejK/hy/0iQzDr0F20lxHSLJr6DI4WcbWEzuIUH
	 uNbKuCCd6G0iqwyIVeWMHKpH3oO9rPemjpv4wsZI40GhTIwbCDjKOEx++zSLSviNvb
	 OSicv/HEvr6pS0U0+PpfoJsjGzin9npFsiCNquWg8n5rjBxvsWaPF6y1OU0wPwkoJS
	 xwYqVbVL7wCcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34031380CEF6;
	Sat, 22 Feb 2025 00:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: print stmmac_init_dma_engine() errors
 using netdev_err()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018483699.2253519.16103743510022533749.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:40:36 +0000
References: <E1tl5y1-004UgG-8X@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tl5y1-004UgG-8X@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 12:47:49 +0000 you wrote:
> stmmac_init_dma_engine() uses dev_err() which leads to errors being
> reported as e.g:
> 
> dwc-eth-dwmac 2490000.ethernet: Failed to reset the dma
> dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
> 
> stmmac_init_dma_engine() is only called from stmmac_hw_setup() which
> itself uses netdev_err(), and we will have a net_device setup. So,
> change the dev_err() to netdev_err() to give consistent error
> messages.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: print stmmac_init_dma_engine() errors using netdev_err()
    https://git.kernel.org/netdev/net-next/c/3e401818c81b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




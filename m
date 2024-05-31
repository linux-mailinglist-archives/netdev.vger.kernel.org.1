Return-Path: <netdev+bounces-99621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36378D583B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47BD1C22190
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9FC8E9;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWEsa6Dk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7817545
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119633; cv=none; b=ZId5FE/BzzP+POYB3T8ITUkrniTazM+vyFawk9+tuh6D3cDbRxW6aMTmEBea+sIZRGwAoVI/b9bh0ZXjI9OPFZdoVPC920tjhX5rKY6FZQb4eeJvun/GTrM97SieUyRp9NyXrKUIg5yuZW6g1fKH/eGY1CaGc8kxgsLo6m4YpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119633; c=relaxed/simple;
	bh=CYHulmigE52cT3mZ/+i7wAv/vNOBtBcebTbzxOSEvx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IGuCvdog6EnkF1byd0OsB3LAzJhCeR86aL2x7X0jeEpI2EENytKr1XQsQ3WqPio/ZPPRX4tSQNXa8x1nPnCu998tGzpDCh/8efNtFSWMAINUG5eKu6loVHguVgWTpHCOqVV2s8g6QrdD4bcB7wXsbBCYyxroal2PGuzIVOsunT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWEsa6Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01A1EC32786;
	Fri, 31 May 2024 01:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119633;
	bh=CYHulmigE52cT3mZ/+i7wAv/vNOBtBcebTbzxOSEvx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oWEsa6Dk3JFB44WcgDCF7/M2VC8mYsqmNAUu5cYBGaVJcYpU3VWGUQ2of0DQI7s8A
	 vs2MKNhsQnGyYfTLVr8ilji8juZCKfv/xEktuBp2qCTDXfOmDS3CA2hpePMoEnlB0D
	 6CXKWKYYnBVjGiMaLztlCvWbkZGLeAPOsaO5WrrL44FHLQZXmEriBxqOaWPM/GmgXw
	 CuwIFQYOG4honZXVcZ9h2gGdznWDMmNJvfbXKuq2YYUj8R30DNZ9W4b1/L5kkVC/bO
	 T1qhpmHxgDVaQhz9wdkMVGEvhd68sbi3HeP+1mz+JhkNuUrfIf85GacH45d/uastHb
	 L2gCOE8TptwcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E186BC3276C;
	Fri, 31 May 2024 01:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] net: stmmac: cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711963292.18580.1918608353290496503.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:40:32 +0000
References: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
In-Reply-To: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: fancer.lancer@gmail.com, ahalaney@redhat.com,
 alexandre.torgue@foss.st.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, joabreu@synopsys.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vkoul@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 09:40:15 +0100 you wrote:
> Hi,
> 
> This series removes various redundant items in the stmmac driver:
> 
> - the unused TBI and RTBI PCS flags
> - the NULL pointer initialisations for PCS methods in dwxgmac2
> - the stmmac_pcs_rane() method which is never called, and it's
>   associated implementations
> - the redundant netif_carrier_off()s
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: stmmac: Drop TBI/RTBI PCS flags
    https://git.kernel.org/netdev/net-next/c/482b3c3ba757
  - [net-next,v2,2/6] net: stmmac: dwxgmac2: remove useless NULL pointer initialisations
    https://git.kernel.org/netdev/net-next/c/4af90c0f4844
  - [net-next,v2,3/6] net: stmmac: remove pcs_rane() method
    https://git.kernel.org/netdev/net-next/c/3277407e5e82
  - [net-next,v2,4/6] net: stmmac: remove unnecessary netif_carrier_off()
    https://git.kernel.org/netdev/net-next/c/aee04f4bb44d
  - [net-next,v2,5/6] net: stmmac: include linux/io.h rather than asm/io.h
    https://git.kernel.org/netdev/net-next/c/cd56ff75ccfc
  - [net-next,v2,6/6] net: stmmac: ethqos: clean up setting serdes speed
    https://git.kernel.org/netdev/net-next/c/7efc70657704

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




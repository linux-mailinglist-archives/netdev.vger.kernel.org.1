Return-Path: <netdev+bounces-218041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C616B3AEBF
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30DB582D32
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260FD2E06EA;
	Fri, 29 Aug 2025 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzJF0nHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F872DCC17;
	Fri, 29 Aug 2025 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425618; cv=none; b=GsDytjbVkWEzcGTsJP/usVf2CYEoRl5ubv421vbQoMPAqf/VU/DEEa/caG+zUUKAwRwyUHN5UbNfV5Ur3hq7rI/JKw/+lTdPld5ATOI2UWbFVLM0bDWRAhyCreYzM0h9CRV5Shm0wLdGVQTCS8xA5X1idqmEhtXVBg3KTBRyL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425618; c=relaxed/simple;
	bh=wGToxozqbazFFH0LvF7E6rK1PxvN4J76FMletJpx26k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PRKkn/fCNJdK/VYARX23wSl4MhyCFL5UNJLyHJ+ngT4UC5QV6wyiSO0GL0ljA4TQz1sBZT/ZHq4IonTtosLbhD64ephR6wf9YwzTkfRDWE6c/uRWFLsckNWl1GBEVX7+NyKTV6WIAmU8QH5UTqkqCAZG3ohOC/zDnciBewGNSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzJF0nHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D15AC4CEF4;
	Fri, 29 Aug 2025 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425617;
	bh=wGToxozqbazFFH0LvF7E6rK1PxvN4J76FMletJpx26k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AzJF0nHA6QWTQ+fqIlN0wvNV1pY0RW5bxF9OiSU5btQOxErb0yHcb57uALHw9nEGe
	 N/wRGgjaYG8E04rd9biTI8BqVXIe6GI5fu/rG+9IyhluAI0ZOn5JCgiMhu62lI+gXg
	 d3H0cs6M99dniymI1+aHiwHOqdHL6Hn3RhOpNnUS06AJlwVBSRW2LX4d4QmrK2pnSa
	 xfMRefwbUFatM9SASZ8kL2g75tiOjrGPlaKR7s6K8aevel7KQNw0ICeP1qTESS9pvb
	 ZWbCinfGjR26uARQfE7I8TpY9rWOpHPWYohQMnnnG5o8rVsdKQRIcfmGWKFEDyYlTQ
	 M/6qli/V58UCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD74383BF75;
	Fri, 29 Aug 2025 00:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] net: phy: mtk-2p5ge: Add LED support for
 MT7988
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175642562424.1653564.8322178452241904171.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 00:00:24 +0000
References: <20250827044755.3256991-1-SkyLake.Huang@mediatek.com>
In-Reply-To: <20250827044755.3256991-1-SkyLake.Huang@mediatek.com>
To: Sky Huang <skylake.huang@mediatek.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 12:47:55 +0800 you wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Add LED support for MT7988's built-in 2.5Gphy. LED hardware has almost
> the same design with MT7981's/MT7988's built-in GbE. So hook the same
> helper function here.
> 
> Before mtk_phy_leds_state_init(), set correct default values of LED0
> and LED1.
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] net: phy: mtk-2p5ge: Add LED support for MT7988
    https://git.kernel.org/netdev/net-next/c/5e3aae2d3271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




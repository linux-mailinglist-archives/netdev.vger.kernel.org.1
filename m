Return-Path: <netdev+bounces-183584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34E4A9114F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC635A2FA0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505D1D63C4;
	Thu, 17 Apr 2025 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4G3zqxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC01D5CE3;
	Thu, 17 Apr 2025 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854022; cv=none; b=W2GGXPNPXDfLg2Pc3enP3e6B1SC6U3wCNiz07WwXfeNwO1e2jkRsWyIwuFyX1eDs28iF1hHgbzTpVYV88A3FQ2lwuDtsPC/1p15ILK6BOW3E1c8KNBovTO0mWXnzLMmYfYR1wzaR0uOAC/Nm0Bv1AzkXnvuiwwsN/5TiyGKy2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854022; c=relaxed/simple;
	bh=P5rLUzHGp1rWd+br0EokVbj8xB3CmQiC8msnksIdyVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=burdXVZO4G50smpkVSvMkL8vIRWIa/iB8Wn0EaaVzHYAyn6IIUaCBu9DpcIJJegWbn4Wyclzzvezp8yS9k6NIMP9FsRNrA/+zAK00Zs9e29Lenw7Q6f6qCEqaI/IWgJBhkBbyz3lEvm+utfakOwML3OujFcEBGC0tdP+GLXfV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4G3zqxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3C9C4CEE2;
	Thu, 17 Apr 2025 01:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744854022;
	bh=P5rLUzHGp1rWd+br0EokVbj8xB3CmQiC8msnksIdyVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E4G3zqxfAjnNdrLBWc19LVvI7Ur7CsdbRnWLwG15rFRKmZlSNOktv6uQ/Lc8AJHZ+
	 tHM69NtMhZvaPvignyHIiUAu1iIO9yb+tcsvdw8jPJ5PBw8Hi3NDx3t3cSt0OlTvY+
	 LkljGDw+OEjihecaQmipsMpsddSlRD6kaAo+WYWWSJYmPEip/kiept/uwAPqJLM0if
	 sbbod1nqvXfF59hvjNwkyKTHJ7w2bwhENkjJ5srAYBh2fol8fqL0rk4hYxtZQ7760v
	 4CBZK7U+x8sfihSrYPO0O8Tl7LIj0krJnN50dUxeLT3Tsvw67oZN9p4Or96BSEYixs
	 bm/K8RYn57czg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2F3822D5A;
	Thu, 17 Apr 2025 01:41:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: sun8i: use stmmac_pltfr_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485406039.3559972.1647358182636817567.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:41:00 +0000
References: <E1u4dKb-000dV7-3B@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u4dKb-000dV7-3B@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, wens@csie.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jernej.skrabec@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 samuel@sholland.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 11:15:53 +0100 you wrote:
> Using stmmac_pltfr_probe() simplifies the probe function. This will not
> only call plat_dat->init (sun8i_dwmac_init), but also plat_dat->exit
> (sun8i_dwmac_exit) appropriately if stmmac_dvr_probe() fails. This
> results in an overall simplification of the glue driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: sun8i: use stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/4cc8b57753ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




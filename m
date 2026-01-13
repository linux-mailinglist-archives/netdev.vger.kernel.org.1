Return-Path: <netdev+bounces-249262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441ED16640
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490253031362
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C088301489;
	Tue, 13 Jan 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R//KIgJU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565E2EB847;
	Tue, 13 Jan 2026 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273428; cv=none; b=kQqAEaS8d2Nhjhp3kDHu7E9jh+LmMqq5gS5qhWcZ9OjeoYAeikSa9mvtkc2+L/AgcSxDGelAs5bw6xwuyHZvuXgwcjkBx6xKpLg/82AlkQYqkUT5atht4J5vVGBqntz4j33VZPk6rrGFqu/IcbIf17293TaYz0WVhHuLvDgtBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273428; c=relaxed/simple;
	bh=BubrrtXBvlbZz+2wzMK2ygPDqXGmm/Xt8TxJVAR3dJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CiIz70cIz4NQQGQbZ6NQq2kp5HqgKzHANQQB3mLPOyShsulb1JNDvm5g6DrqtRZA9RrR0t6d8YnhiZ3JHZ8ea5JezPRRJu6MAY7c2diRZy8ya36LJ3zH0mTd80GEZV+MQNkdCacDPqYkF0x+b88NgDZHQQFUKXUIJeYFpYDyLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R//KIgJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36B7C116D0;
	Tue, 13 Jan 2026 03:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768273423;
	bh=BubrrtXBvlbZz+2wzMK2ygPDqXGmm/Xt8TxJVAR3dJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R//KIgJUgTJHMxZy/iisMaQ/iwigm8dtMSGZ8Y9UoAB+LXhAcR63REHj3AcJF3UO2
	 SobH9khC+aBAO/M2oQy0wvQPdHPb3N4PQ5jdGiuKcCpNX7riXalRwm9ZcfxJm+vyuI
	 JTvN/HvnOElEXBq5U4q/E/ZwKAgOZmJdq86A7OBCY1hOu5a7gTz+p8lfBpfFckN8IU
	 sELNIme+8tk/iAj7LiIy/poz/OqiGX4Si30xLbaNekjw9K3EsXbceSK9t2j/Z2jDCx
	 9zTh5UoaPeOVT7OYvSpfAhg5sIK0cp3Nr4e5+tSCcCHui2qIhHkb/DYASmx3MNizKl
	 NEco8NLF2rNNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5800380CFE0;
	Tue, 13 Jan 2026 03:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: motorcomm: fix duplex setting error for phy
 leds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827321727.1651449.5452771654273163225.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:00:17 +0000
References: <20260108071409.2750607-1-shaojijie@huawei.com>
In-Reply-To: <20260108071409.2750607-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, salil.mehta@huawei.com, shiyongbang@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Jan 2026 15:14:09 +0800 you wrote:
> fix duplex setting error for phy leds
> 
> Fixes: 355b82c54c12 ("net: phy: motorcomm: Add support for PHY LEDs on YT8521")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/phy/motorcomm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net] net: phy: motorcomm: fix duplex setting error for phy leds
    https://git.kernel.org/netdev/net/c/e02f2a0f1f9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




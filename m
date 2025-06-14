Return-Path: <netdev+bounces-197693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D004AD9963
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF514A045D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA184CB5B;
	Sat, 14 Jun 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODu71QO3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3D3FB31;
	Sat, 14 Jun 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864005; cv=none; b=XZw6NpGvKveTLIEXfgyBvB/Vve44XjJtwZ/j4ZvA/mtL9iGC6muDUv7oloAXUR7uVKnHeYjGHPcNEOVYT8HF60LifpeYYLbQYuAI5hyU9LJyLKuIMtRy1HuCQ0JhCvbKHCIatebrWn6mQ8aeOzKzkESJutyZCV0GsAtYuszzBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864005; c=relaxed/simple;
	bh=UCCsPjeVlCnT6w3Gw++i6mvT/wiIv/GNt4lkvZVnfQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ec+bKTD9w6ew5fNzd4dhMC32nwbutWfsOWhpRHQZkUhuojVcbLpSZ0Zq5wWatIzFhTwi+mfRg7L9vxmi1srPyv+rWPvyLLLmuKe4n3uUf2hS1H6S9UUnx6NVI+QCYOp82meWftdwqGpnoLDqvP0P0Q4PDX+A4uWFmwZFuMPljgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODu71QO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685F2C4CEEF;
	Sat, 14 Jun 2025 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864005;
	bh=UCCsPjeVlCnT6w3Gw++i6mvT/wiIv/GNt4lkvZVnfQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ODu71QO3i9MYG9Vq9azit+yH34REmpBRW7dbnaD0rwWRBB0lqc7em983MA+8GAFTF
	 4mdMETYSNz6XcD2Hw/HJWb+UJK6hCbw1J7KnfFs05lLJe8QG40f7GVlYPyiQ/0nIVx
	 JRdtNIRLgY3zYxFaSfPhno/UfT9bW2qaXVxVwXOlS//ez5YadBMJSEe23gV5SOcWSU
	 voXjA+nYHQwvgNQlSDoxuDTIqchcE74tnrm/OcXcQSPe3K9xAKqJ/eHjiT6BQFoXlj
	 Jo2QeQI7E4QRP6EWbaz2Adb1pgbQDSoROxvG4zqWrOokkwbESBTsI2b/TSqkC80IJg
	 XFkHxXdZ6HoKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B41380AAD0;
	Sat, 14 Jun 2025 01:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] dp83tg720: Reduce link recovery
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174986403479.949218.2894499433224962476.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 01:20:34 +0000
References: <20250612104157.2262058-1-o.rempel@pengutronix.de>
In-Reply-To: <20250612104157.2262058-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 12:41:54 +0200 you wrote:
> This patch series improves the link recovery behavior of the TI
> DP83TG720 PHY driver.
> 
> Previously, we introduced randomized reset delay logic to avoid reset
> collisions in multi-PHY setups. While this approach was functional, it
> had notable drawbacks: unpredictable behavior, longer and more variable
> link recovery times, and overall higher complexity in link handling.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: phy: dp83tg720: implement soft reset with asymmetric delay
    https://git.kernel.org/netdev/net-next/c/5f6ec55777d5
  - [net-next,v2,2/3] net: phy: dp83tg720: remove redundant 600ms post-reset delay
    https://git.kernel.org/netdev/net-next/c/491e991f7816
  - [net-next,v2,3/3] net: phy: dp83tg720: switch to adaptive polling and remove random delays
    https://git.kernel.org/netdev/net-next/c/cc8aeb0f535f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




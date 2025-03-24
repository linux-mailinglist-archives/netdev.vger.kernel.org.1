Return-Path: <netdev+bounces-177219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F52EA6E4D8
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDBF3AE931
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161661DDC3B;
	Mon, 24 Mar 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h65ad5Yy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D518B464;
	Mon, 24 Mar 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849998; cv=none; b=Q/ONGnvhMtckejh+uKyCRoshfv0WgLZ89VEJz3FnAvcC2vfH5k2jr+dhX426kO2MlkouqGhyQsypRTYXQ41sSl4u1NYU4kw9wjS79NEUx4K0mm1Gt5ZNpRlBwWsCp9YghR0uq5BpIUsEK2R0jrxga+6EJUpVhGx+Oo1Mo7PDIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849998; c=relaxed/simple;
	bh=ng1DJb9BxxzC35KV3EHcbDjjgiEcK9HC4BR+Pi2/KXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B5jkiDeFWd8bwHgxwQGW0+ZOb4lgw6cJPj5RdFDY/14rK1C4+eHZ1G5EBJxC1zUn0IildRTl/uKWGwNqEu1jL+d95duoeq6edwH6No/AskBFCI6UuedYRPUnf+jODmzZeU6g30knN5uRnMgWjrAQjviv6IqHbwRgtt+ebc6Lr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h65ad5Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40172C4CEDD;
	Mon, 24 Mar 2025 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849997;
	bh=ng1DJb9BxxzC35KV3EHcbDjjgiEcK9HC4BR+Pi2/KXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h65ad5YyMT1GSTxd3szEpvEVi8Nx/SzWXISGnLxm0lOnB/VfZpmK7p8vdfb1sG9SA
	 z+1+jDi1dWYFeKv3txG1Vtar3RlnwyB/tHztvz+KNlilhEvxZfvU8P2BLfuZWKfwr1
	 FOYqohE0w6U6szPKTYaTD5I1Ro4KDdP0kmN1lm//NIqilq1w0vyixTu19Saknm/mT7
	 0+1MmyVuckWAvAiMxw5OqCt62yVi/hbsoZjKv6t1PAX1Kb3NSOKL6X8Rh+uCsWkq+H
	 2EfVQYGvOl0EdisWQXgwSCO7UKHbiLtmLtyRPhGMYwrg3cpaX9V+Rciwpa8MJQdSIL
	 pi5ubKgH6ZzAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFDC380664D;
	Mon, 24 Mar 2025 21:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: Drop unused of_gpio.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285003354.4171308.4171931189577511383.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 21:00:33 +0000
References: <20250320031542.3960381-1-peng.fan@oss.nxp.com>
In-Reply-To: <20250320031542.3960381-1-peng.fan@oss.nxp.com>
To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, steve.glendinning@shawell.net,
 richardcochran@gmail.com, marex@denx.de, horms@kernel.org,
 ronald.wahl@raritan.com, peng.fan@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 11:15:24 +0800 you wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> of_gpio.h is deprecated. Since there is no of_gpio_x API, drop
> unused of_gpio.h. While at here, drop gpio.h and gpio/consumer.h if
> no user in driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: Drop unused of_gpio.h
    https://git.kernel.org/netdev/net-next/c/b71f29272f5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




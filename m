Return-Path: <netdev+bounces-144682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE99C81AA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 05:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A99B1F23F2C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F71EBA1A;
	Thu, 14 Nov 2024 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDfaDJzA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3F1EBA10;
	Thu, 14 Nov 2024 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556820; cv=none; b=VAhnQ0pHwGOJE6FMy1vU2Tmf611vCxJ2z69jRZsOnjmBWtg1yQKtioO9tQ1cqb4IEiq0i6eyArcRun2zA9fWGgc1bSvusNDcvnw9G6yaEf+hQB4TZGOqiYuys2F025ItOeXVn4RHVq5lqDL66IlueeSen2dwlMGW/IKbkU4xBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556820; c=relaxed/simple;
	bh=PnNfyH7oj2zLbHLnS0rQSp9amgAB2vTxjz+mg5/8YQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UbML9ft/HDmK6KiVlF39dNydwLu2Bvz9fxF285JcD0nuA8hSDiqur0tqEpsG+C+l4sqQ+c9hvM07yZm9VgwTUikIA0jEUdQjBaLPvBFCtR/LZzSS7mAP0u7/X5ajl004cawogsNgCQnXSBphkvqGkHgRqNsRCzI23aZkNGEntR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDfaDJzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893A6C4CED6;
	Thu, 14 Nov 2024 04:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556818;
	bh=PnNfyH7oj2zLbHLnS0rQSp9amgAB2vTxjz+mg5/8YQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gDfaDJzAMh+THnR6WKVi24HDZx6aSgpYS9mtgYKufIKyrOA4B3kxpfeAhZ320BBmU
	 3meMYIw2AQy73alGMq1QN5PLrzzf9yzOr+DisUwlHqbY3spq4m+iyfEpnqcQQ1Z/Y6
	 kvxmPCULxZpTRi+86oYG0wtHAFEZaySUtS5cz+iVA13jv0TAARVx2h7DLmwsqe+7/n
	 9+IdKnHlaqVsOKrbqzrV5w+nrA5ZEsjT/AIGmZFW9FuDI/E1AYe8pu8H6M0CfmXoI0
	 n55gzKLKwhI5F9IqNqlStr7f68bjy8iyYerXA1DOc6eI8OFYM9CTVJQfH0mjtNqgoz
	 cVePidPqpyyvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346383809A80;
	Thu, 14 Nov 2024 04:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2]: stmmac: dwmac-intel-plat: fix call balance of tx_clk
 handling routines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155682899.1476954.2028843277597147808.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 04:00:28 +0000
References: <20241108173334.2973603-1-mordan@ispras.ru>
In-Reply-To: <20241108173334.2973603-1-mordan@ispras.ru>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, pchelkin@ispras.ru, khoroshilov@ispras.ru,
 mutilin@ispras.ru

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Nov 2024 20:33:34 +0300 you wrote:
> If the clock dwmac->tx_clk was not enabled in intel_eth_plat_probe,
> it should not be disabled in any path.
> 
> Conversely, if it was enabled in intel_eth_plat_probe, it must be disabled
> in all error paths to ensure proper cleanup.
> 
> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> [...]

Here is the summary with links:
  - [net,v2] : stmmac: dwmac-intel-plat: fix call balance of tx_clk handling routines
    https://git.kernel.org/netdev/net/c/5b366eae7193

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




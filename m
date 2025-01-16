Return-Path: <netdev+bounces-158856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D27A13947
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD5F1889A74
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD71DE3B7;
	Thu, 16 Jan 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O27Wtx4j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1D1D86F6;
	Thu, 16 Jan 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027609; cv=none; b=TtmXp27ms6dHjI2A1Xz438ePkAiQH4i6KZmrRabp98wZlIjr33IaXvdDoDHKP94K3D8AvpeNRkwu9exuWL4QSYUQ2TJV6I3xMGsjx7o/9GYWfQuzadkGnIBqqGaQngAJ6vU16PUnQqQ8JfUOid0H+RpORAMGNh8e0f8VbIwDkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027609; c=relaxed/simple;
	bh=9kDIJwhprd3J8UBVpElxMP0gxs4aR3treIZNaaamSzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J9Zu3bt9fwHYwXP00fPacLcPiElLQPmBeaC0niC1eK20tBpceshnruU4X+SIJEBV1+e1ybjR0qVYfRKDMAcjOSUwZ4iAobF5HyyUUiwz1s2LwPUyGgryczApN/+cUxXQaB0J/sFr+XNzYCl0fsS/5tZ0/zwM2BeMFI2dLawdxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O27Wtx4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9B5C4CED6;
	Thu, 16 Jan 2025 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737027608;
	bh=9kDIJwhprd3J8UBVpElxMP0gxs4aR3treIZNaaamSzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O27Wtx4j5aKBT4gPT98zbqD37H0u/MtvIb0u4K2cxJF/XWEh3r+SV3yzpdPSC89iY
	 UsNqsdXAE22ukwamWlQHDmrnFZ+9fofuKmr8rpEUi8Ca24WZdak5TN1nSgXIwqohWN
	 9zF2sDjpVukOO5ud1IwX6D8bIQ8PIXyJiTNxWp2EplpDN4AuY3gj4My56scRuvtgSU
	 sd0CnE0JnH2A7O1eznLqTO+pkSdHYqOQWGgornAiPhgr4+9kRjeoNEEH40+PZYhyiZ
	 NB7ESjs3x0sg+wQFyMwXaACd+IQK8SL1FozmQe1iqd6Pjoe3r1u3qjx4cdX0yuLYtA
	 SNpaTa2RuOd1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34555380AA62;
	Thu, 16 Jan 2025 11:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net: stmmac: RX performance improvement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173702763200.1425732.12955141458016148201.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 11:40:32 +0000
References: <cover.1736910454.git.0x1207@gmail.com>
In-Reply-To: <cover.1736910454.git.0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 aleksander.lobakin@intel.com, jdamato@fastly.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 Jan 2025 11:27:01 +0800 you wrote:
> This series improves RX performance a lot, ~40% TCP RX throughput boost
> has been observed with DWXGMAC CORE 3.20a running on Cortex-A65 CPUs:
> from 2.18 Gbits/sec increased to 3.06 Gbits/sec.
> 
> ---
> Changes in v3:
>   1. Convert prefetch() to net_prefetch() to get better performance (Joe Damato)
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: stmmac: Switch to zero-copy in non-XDP RX path
    https://git.kernel.org/netdev/net-next/c/df542f669307
  - [net-next,v3,2/4] net: stmmac: Set page_pool_params.max_len to a precise size
    https://git.kernel.org/netdev/net-next/c/2324c78a75c5
  - [net-next,v3,3/4] net: stmmac: Optimize cache prefetch in RX path
    https://git.kernel.org/netdev/net-next/c/2a2931517c9a
  - [net-next,v3,4/4] net: stmmac: Convert prefetch() to net_prefetch() for received frames
    https://git.kernel.org/netdev/net-next/c/204182edb310

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-127161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533D3974701
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21FC1F25C94
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539B1AB52A;
	Tue, 10 Sep 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqDW12Pp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5EE18E36E;
	Tue, 10 Sep 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012238; cv=none; b=O1ZLO6gc3nqsMJCfrtp+ImJoIQmme7H6lVOQg5X5exHJQ7p40FVTRAGenI9rDijpzRZX2EcvNvQW76tpqadKcmvxqp4eyCc9+fBCRsvO3NCzPJUBUtLQswQS0FLlP0/SztJD372F8OXTdGulhb3rwebE2jwxJevTcEsP8CUm0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012238; c=relaxed/simple;
	bh=sxK+hW8ojfmnkF9vdsCtdaf+hF/tv03gZ0GyRssxpwA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k4UxyRzMSsHIQUCD8mDM3vq20MjRffJPyUVdXYp/Jg8pmVSMn58t3KRyzSKgdPJu/xRACZqCknGNy28deb5AKe3P9+Oa+SwIOrGz8H/HM58RcS1EK6NU0a/wI5NDfMFFt49cQjQp9PdPgvd8oa/t/19EpJFHfeZnx6T1MrIrVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqDW12Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B63C4CEC3;
	Tue, 10 Sep 2024 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726012238;
	bh=sxK+hW8ojfmnkF9vdsCtdaf+hF/tv03gZ0GyRssxpwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dqDW12PpIjo3dStRSFgJwdiS3RKjmOdqEXdFv6GfLMKlCA31hvHmohX41ybmMwizF
	 1r8qLzUregf1qwQSKcwB9tLVeFG9zjchAqZldDx/oIP2b/3PYfkIGjtjejsMuQsHpi
	 TutLU8maG58A3HVTo7cg8jFQ1AdUDnL13kUmiah/H0OesFWLeXSZRm9jNTb13JZ9gQ
	 w186BjzbuUOo7Rfkn83XcK7Ld4CPn8nVe55rL/VXmiWGrIj7xRoQ3GJKG1xQLWspFJ
	 Sm3oLM8KHlfIyFgbjaujRHqc/If1279M9sfEBof+BT9Qqx2DYk9s8rQBnke3RmF0q3
	 iYn3gD1UZgXyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710813822FA4;
	Tue, 10 Sep 2024 23:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/7] net: stmmac: FPE via ethtool + tc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601223908.432718.2243350410657037055.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 23:50:39 +0000
References: <cover.1725631883.git.0x1207@gmail.com>
In-Reply-To: <cover.1725631883.git.0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: olteanv@gmail.com, fancer.lancer@gmail.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 jpinto@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Sep 2024 22:30:05 +0800 you wrote:
> Move the Frame Preemption(FPE) over to the new standard API which uses
> ethtool-mm/tc-mqprio/tc-taprio.
> 
> Changes in v10:
>   1. fixed a stacktrace caused by timer_shutdown_sync()
>   on an uninitialized timer
>   2. ignore FPE_EVENT_RRSP events if we are not in the
>   ETHTOOL_MM_VERIFY_STATUS_VERIFYING state
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/7] net: stmmac: move stmmac_fpe_cfg to stmmac_priv data
    https://git.kernel.org/netdev/net-next/c/070a5e6295e8
  - [net-next,v10,2/7] net: stmmac: drop stmmac_fpe_handshake
    https://git.kernel.org/netdev/net-next/c/59dd7fc932e5
  - [net-next,v10,3/7] net: stmmac: refactor FPE verification process
    https://git.kernel.org/netdev/net-next/c/8d43e99a5a03
  - [net-next,v10,4/7] net: stmmac: configure FPE via ethtool-mm
    https://git.kernel.org/netdev/net-next/c/0f156aceeef7
  - [net-next,v10,5/7] net: stmmac: support fp parameter of tc-mqprio
    https://git.kernel.org/netdev/net-next/c/195e4f409a40
  - [net-next,v10,6/7] net: stmmac: support fp parameter of tc-taprio
    https://git.kernel.org/netdev/net-next/c/15d8a407a547
  - [net-next,v10,7/7] net: stmmac: silence FPE kernel logs
    https://git.kernel.org/netdev/net-next/c/22a805d880c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-40638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E96F7C818C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3905B20A7B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE710A0B;
	Fri, 13 Oct 2023 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHv9mnG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41510A01
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E656CC433C7;
	Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697188231;
	bh=B8lYkA1kPamuqAf5eh8eQ0KJkd4Qj0W/oYKqHpLM10Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bHv9mnG3XUJr463BvJ1+jdjLVK2KXDQKvB0jw9VicIhuPc0BJOmJLt5pSO6YvgCpR
	 G5oouGWKurnNaZmQTd4wke7jMEDpETGR/io383U4XeydOGjj/xVERft15H9whGPwl9
	 Ml2ibLnKTarUPMMK92uXu9IIblZkzQJVp07uLE5SLR76s+7Lk7ownFt/8O3dxWiiw7
	 pHPiLjIQytfayvkTJYMS0h9hOx6ZMQncuu2M29zV8fOlgRzL3sNwA7GQrylh/oP799
	 TzvUXZ5Bz7SRERoF7xC0TrN3DU2iJuxPXHecAUP9/TTYQAeuTQ7dym+Fn3XoUKPdnk
	 G5X8QetVbl5wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA988E1F66B;
	Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: dwmac-stm32: refactor clock config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169718823082.32613.17417632202490226710.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:10:30 +0000
References: <20231009145904.3776703-1-ben.wolsieffer@hefring.com>
In-Reply-To: <20231009145904.3776703-1-ben.wolsieffer@hefring.com>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, christophe.roullier@st.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 10:59:04 -0400 you wrote:
> Currently, clock configuration is spread throughout the driver and
> partially duplicated for the STM32MP1 and STM32 MCU variants. This makes
> it difficult to keep track of which clocks need to be enabled or disabled
> in various scenarios.
> 
> This patch adds symmetric stm32_dwmac_clk_enable/disable() functions
> that handle all clock configuration, including quirks required while
> suspending or resuming. syscfg_clk and clk_eth_ck are not present on
> STM32 MCUs, but it is fine to try to configure them anyway since NULL
> clocks are ignored.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: dwmac-stm32: refactor clock config
    https://git.kernel.org/netdev/net-next/c/4d177f499665

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




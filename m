Return-Path: <netdev+bounces-25086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E969772EAA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32C9281451
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EE015AC3;
	Mon,  7 Aug 2023 19:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B51640C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC2D3C433CC;
	Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691436624;
	bh=uE2fa7Fe0pYN2Kl+HM144jNfenom/57ArJYynw749Y8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rKa2GrlyguweRNZ5knCI8EenRhfj2Xvv2Ldea63alaBe7mpjAlGAOeHhsepJQ14gb
	 Jm8DJwFzGVGq3VyFl8f43PeOU/f/g56xUljiQnpgRNFf31oqYOKnl56HfUFW9ee0Uw
	 x2fiek2lEFT/bjTqiWdNZ+YTEdt18OjnpYIn093Pb4A72qsKCER1Gm5ID5oxgWCrTP
	 hSpy8fDAYm6XQQJPeeDzjc26MsT9BJYnhCbYlY7COpBJY+SKT/0p4aGDOzCmLu0Orx
	 h7gYTFFULHHfLZZtUvi9q+U3h6XA4FJgoQaKdHWAFNK45uIaMreW5vGFCzImfKZouL
	 CNchHLHJC/bqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE4E5E270C3;
	Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169143662470.21933.13583691380398650705.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 19:30:24 +0000
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
In-Reply-To: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
To: Johannes Zink <j.zink@pengutronix.de>
Cc: peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 richardcochran@gmail.com, linux@armlinux.org.uk,
 patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, kurt@linutronix.de, lkp@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Aug 2023 17:44:28 +0200 you wrote:
> ---
> Changes in v3:
> - work in Richard's review feedback. Thank you for reviewing my patch:
>   - as some of the hardware may have no or invalid correction value
>     registers: introduce feature switch which can be enabled in the glue
>     code drivers depending on the actual hardware support
>   - only enable the feature on the i.MX8MP for the time being, as the patch
>     improves timing accuracy and is tested for this hardware
> - Link to v2: https://lore.kernel.org/r/20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de
> 
> [...]

Here is the summary with links:
  - [v3,1/2] net: stmmac: correct MAC propagation delay
    https://git.kernel.org/netdev/net-next/c/26cfb838aa00
  - [v3,2/2] net: stmmac: dwmac-imx: enable MAC propagation delay correction for i.MX8MP
    https://git.kernel.org/netdev/net-next/c/6cb2e613c796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-26592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B6778489
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D895281B0B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57C4A21;
	Fri, 11 Aug 2023 00:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FB29AC;
	Fri, 11 Aug 2023 00:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 001F6C433CA;
	Fri, 11 Aug 2023 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691713822;
	bh=VTdqDcF8RsP1Tx5iHwaXGP1sG1BJp3vTg2yHLtubAGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c1cvUsLVvbNOxrcxKegdBTWgRa317/WWR1Oi1n6cAFjOaCcxZsBiY53OcJg1fS7Ev
	 G89XIHnIu8dqylZvu+OMJMiBDLSZ4Rt7losPpISfhl3+FG02roRQxO9UCWBiKBOi7A
	 fs3ku7qcm6EWDUA4kU/beALERnma4vRJb3x/bB1oztNxINbjIXS/IiRtzJGXVj1gXY
	 YF7+XOdu/pbCTHWoV6Cm7VAkb87fSc0QPrkCdzQ4itEgwZzfsyQKTF0vOQpKCba7Ie
	 dStQ0fBtVtYEhiK6Q4diHYrkE9LtkSbtCIQs/yQnGO3Od3b0l4WKqlK8ZLnvDWcnkY
	 m6dFswKw9/Q9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D498FC595D0;
	Fri, 11 Aug 2023 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/2] update stmmac fix_mac_speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169171382186.19672.4297213896256628885.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 00:30:21 +0000
References: <20230807160716.259072-1-shenwei.wang@nxp.com>
In-Reply-To: <20230807160716.259072-1-shenwei.wang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: mkl@pengutronix.de, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 neil.armstrong@linaro.org, khilman@baylibre.com, vkoul@kernel.org,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
 bhupesh.sharma@linaro.org, nobuhiro1.iwamatsu@toshiba.co.jp,
 simon.horman@corigine.com, ahalaney@redhat.com,
 bartosz.golaszewski@linaro.org, veekhee@apple.com, ruppala@nvidia.com,
 jh@henneberg-systemdesign.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 11:07:14 -0500 you wrote:
> Changes in V5:
>   - fixed the typo in if condition reported by Russell.
>   - fixed the build errors in dwmac-sti.c reported by 'kernel test robot'.
> 
> Changes in V4:
>   - Keep the 'unsigned int' type specifier in the fix_mac_speed
>     function declarations.
>   - Move imx93_dwmac_fix_mac_speed into the SoC specific ops.
>   - Use a read back to replace the wmb() instruction.
>   - Correct the target to 'net-next'.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/2] net: stmmac: add new mode parameter for fix_mac_speed
    https://git.kernel.org/netdev/net-next/c/1fc04a0b9733
  - [v5,net-next,2/2] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
    https://git.kernel.org/netdev/net-next/c/4fa6c976158b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




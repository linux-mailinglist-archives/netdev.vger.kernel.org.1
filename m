Return-Path: <netdev+bounces-42656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15A7CFBA5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0FF2820CA
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256729CE0;
	Thu, 19 Oct 2023 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkn9QIdX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737F27479
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49C7AC433CA;
	Thu, 19 Oct 2023 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697723424;
	bh=KGkjy3SWE/bKA0U7i+Yr3cNTc5UcUvO6Rcal+ZDSr/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fkn9QIdXC75u7o2BeSQnw8oriqaVsbkdmn8v7q3Y4UoyL+L4MJZ6h9ik/lLagxydE
	 DiwqkqGxNnBtwxyWLLVyiJQXVHd4QfSCRXI47MpLNXPHoB3UeMqiBqVYOCVgwVxpuz
	 WGVUQeHGqcB31bycdXPE+CMA2FBzGfJVQCcYtQy1Mw+XRXhVFzDmvemnA03138jiaX
	 QRTCN/gxN/c9idAg16/UIMcJsg98IMHOjg3hZ1pBKVuKkgMb6hcxP+4shcAWE0G4tv
	 WHlcF8N2+AfteiNJsG2Qabz7gH0V/Ge5Ytg+YR2AF6mqMRIBmoaNbdKTdVpPzoJveJ
	 8FBb2rjRTJuwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C8F1C595CE;
	Thu, 19 Oct 2023 13:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4 0/4] net: stmmac: improve tx timer logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169772342417.4360.7732259077441281905.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 13:50:24 +0000
References: <20231018123550.27110-1-ansuelsmth@gmail.com>
In-Reply-To: <20231018123550.27110-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, pkshih@realtek.com,
 kvalo@kernel.org, horms@kernel.org, daniel@iogearbox.net, jiri@resnulli.us,
 liuhangbin@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 14:35:46 +0200 you wrote:
> This series comes with the intention of restoring original performance
> of stmmac on some router/device that used the stmmac driver to handle
> gigabit traffic.
> 
> More info are present in patch 3. This cover letter is to show results
> and improvements of the following change.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] net: introduce napi_is_scheduled helper
    https://git.kernel.org/netdev/net-next/c/7f3eb2174512
  - [net-next,v4,2/4] net: stmmac: improve TX timer arm logic
    https://git.kernel.org/netdev/net-next/c/2d1a42cf7f77
  - [net-next,v4,3/4] net: stmmac: move TX timer arm after DMA enable
    https://git.kernel.org/netdev/net-next/c/a594166387fe
  - [net-next,v4,4/4] net: stmmac: increase TX coalesce timer to 5ms
    https://git.kernel.org/netdev/net-next/c/039550960a22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




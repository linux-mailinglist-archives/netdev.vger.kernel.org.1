Return-Path: <netdev+bounces-13762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB1F73CD4D
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CCC1C20358
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B01EAFE;
	Sat, 24 Jun 2023 22:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537FB79D1
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9878AC433C9;
	Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687646424;
	bh=wFuYPKBZDVE/KNCfDf5udJ5FGoqcIIHcICXY9FCaBa0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GQnPbwWsakuOPo9NzsCGnu7VNIBsah5Ar0vvOSOu4YvOtGm9lpi/EL4HqoankMgSk
	 u53Ss4+2kPxA2IeJYK5BqFk3RcrMSdSEErTSz7iC3XPxgs6D9wzBy0ciln9FfI0Ex7
	 UjsjzMayscYiFKLujaUqU00GpN/41SCRrZVqm4Vvwv8DMe78lgJPO3upHOIschQx3t
	 qJTdVgj2u5Evpw/u0rwZUNwhUn+fXGdRIE0xLreoBqUbCu1BaMjNdY3Ws2i9L2TR7z
	 89+Ho/l2s3/nanrku3QTTn/WZlQamw1sY2v//Cku+fxVTKTjds6CDQzl2EEeTzPk72
	 mjmW5S/7uKrNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C429C395C7;
	Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: introduce devres helpers for
 stmmac platform drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764642450.414.12816371572473277561.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:40:24 +0000
References: <20230623100417.93592-1-brgl@bgdev.pl>
In-Reply-To: <20230623100417.93592-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 junxiao.chang@intel.com, vkoul@kernel.org, bhupesh.sharma@linaro.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jun 2023 12:04:06 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The goal of this series is two-fold: to make the API for stmmac platforms more
> logically correct (by providing functions that acquire resources with release
> counterparts that undo only their actions and nothing more) and to provide
> devres variants of commonly use registration functions that allows to
> significantly simplify the platform drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: stmmac: platform: provide stmmac_pltfr_init()
    https://git.kernel.org/netdev/net-next/c/97117eb51ec8
  - [net-next,v2,02/11] net: stmmac: dwmac-generic: use stmmac_pltfr_init()
    https://git.kernel.org/netdev/net-next/c/4450e7d4231a
  - [net-next,v2,03/11] net: stmmac: platform: provide stmmac_pltfr_exit()
    https://git.kernel.org/netdev/net-next/c/5b0acf8dd2c1
  - [net-next,v2,04/11] net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
    https://git.kernel.org/netdev/net-next/c/40db9f1ddfcc
  - [net-next,v2,05/11] net: stmmac: platform: provide stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/3d5bf75d76ea
  - [net-next,v2,06/11] net: stmmac: dwmac-generic: use stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/0a68a59493e0
  - [net-next,v2,07/11] net: stmmac: platform: provide stmmac_pltfr_remove_no_dt()
    https://git.kernel.org/netdev/net-next/c/1be0c9d65e17
  - [net-next,v2,08/11] net: stmmac: platform: provide devm_stmmac_probe_config_dt()
    https://git.kernel.org/netdev/net-next/c/d74065427374
  - [net-next,v2,09/11] net: stmmac: dwmac-qco-ethqos: use devm_stmmac_probe_config_dt()
    https://git.kernel.org/netdev/net-next/c/061425d933ef
  - [net-next,v2,10/11] net: stmmac: platform: provide devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/fc9ee2ac4f9c
  - [net-next,v2,11/11] net: stmmac: dwmac-qcom-ethqos: use devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/4194f32a4b2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




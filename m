Return-Path: <netdev+bounces-13240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8873AEB4
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9E01C20D42
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584D38C;
	Fri, 23 Jun 2023 02:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9219B
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DCB4C433CB;
	Fri, 23 Jun 2023 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687488021;
	bh=4hiiv6LScRba5gRm6+zidOGp6fL3y8sB78Jonq7Yi5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fx6mJKzWzurGakGjbLbiZNJRv8ANfgoWDY1jbcuzIFoyq9xPlZwGpF099Bu0ycueW
	 rRBkXpQ8LrNUO6zLMsswwxoCAoqxIn4dxPDQQekEun9+ObmSAMdOI0x+5mTNlEzidG
	 VpfsuoAs2/H5hF+mDOiJzWAynk4Kn5GpNFCLxqrVoW2KIWrFiGjXDhXMl8S/SjH1R4
	 z4lIKs4FJqTdh1gPvATsRHfJpz6gGYyIr9UvmwgnYe/v99dMgY3MvzALCOSU47CHVI
	 6UuPqak4OYTYx68mpIxMfwsc3rSj5xsjIa8i8wz1XUg7Nf9ao6WhsJ/kbtiNFnYLUj
	 vYvM8wMA7BdlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7DEAC691EE;
	Fri, 23 Jun 2023 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix double serdes powerdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748802087.26940.10386965323581685154.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:40:20 +0000
References: <20230621135537.376649-1-brgl@bgdev.pl>
In-Reply-To: <20230621135537.376649-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 junxiao.chang@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 15:55:37 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
> stmmac_open/release") correctly added a call to the serdes_powerdown()
> callback to stmmac_release() but did not remove the one from
> stmmac_remove() which leads to a doubled call to serdes_powerdown().
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix double serdes powerdown
    https://git.kernel.org/netdev/net/c/c4fc88ad2a76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




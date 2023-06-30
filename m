Return-Path: <netdev+bounces-14688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BD7431CD
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 02:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D2F280EFD
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD08EBE;
	Fri, 30 Jun 2023 00:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676015A6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 00:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45E86C433C9;
	Fri, 30 Jun 2023 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688085621;
	bh=BW9t0sP6KYmbIRVSLVOs5BM8DUSGY6Wm1V54pVZGmjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GylnbmxmRL0m6gL8br0blgU8xuCnMjhXq9xFHpR3wq5RN9Dzgo0W6ASFxwP1xc7eA
	 QfN+NRIRGSMMCPiiSA6+/bG1n25FP17iQTBdMgzCJ6FSnlVTPz2jVq+N8CnT4w0SqK
	 4CIhn7JPdxK+0flcd5reNHcdUkF2ezGTLHUZ14tEnd6oPVRl6yiIElT86nyIh3nORP
	 mN8+yalsskUutlPSEkLAkEQER6YpeeLJdaiKSWggO1FyJJfJUVMhsvSKfIekTt0j65
	 VnW4fSdoXk/VMbOxCzpqwNuRIit7py54/2LJ0mr3Xp2pW43b4uZmq389L/agyjLeZ3
	 /w4HpRg2Psekw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AAA8C64457;
	Fri, 30 Jun 2023 00:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: vsc73xx: fix MTU configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168808562117.27871.13180013285945472135.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 00:40:21 +0000
References: <20230628194327.1765644-1-paweldembicki@gmail.com>
In-Reply-To: <20230628194327.1765644-1-paweldembicki@gmail.com>
To: =?utf-8?q?Pawe=C5=82_Dembicki_=3Cpaweldembicki=40gmail=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jun 2023 21:43:27 +0200 you wrote:
> Switch in MAXLEN register stores the maximum size of a data frame.
> The MTU size is 18 bytes smaller than the frame size.
> 
> The current settings are causing problems with packet forwarding.
> This patch fixes the MTU settings to proper values.
> 
> Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: dsa: vsc73xx: fix MTU configuration
    https://git.kernel.org/netdev/net/c/3cf62c8177ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




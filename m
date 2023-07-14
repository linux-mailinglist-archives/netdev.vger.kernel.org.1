Return-Path: <netdev+bounces-17848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2A75338B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6911C215AF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E297481;
	Fri, 14 Jul 2023 07:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F584C85
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38620C433C9;
	Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689321021;
	bh=cwHRXo/wW2oWNu56lQpWumfN9yIRdiC3B4zek6vqFec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vPwcgOZyxDwpM34uramttyAkJZPb9WG+KRYmXwhhnI8u9UNgZkvtX/vKp6+o2Vo1y
	 toH97iB2AdbR1UpRzpbkruQi9ilVVO2JmGOQrPqGvrHtULzmFGsfEtYAnDicRo681l
	 kJFvTLCYaUK126+6IrOqemh00oEGkQudQNnc86ftIDvVOGbNTs7HedAwyOPxL578AZ
	 OFDs3jemP8Fo2OVRaOUFDru+its8yfF3MflfS99KDov4ZHGrjusaLobaMS1LqmtCGp
	 cXHTmAPVWB9CettzqZ1ReS1c7houLKId2fAlp22a6OD4bv5e8v70r6BHq+LL+8G3OD
	 WDK0gebedr3XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F4FDE4508F;
	Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: handle probe deferral
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932102112.13275.16065030882031894328.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 07:50:21 +0000
References: <ZK9klTi7XoZZDMeE@makrotopia.org>
In-Reply-To: <ZK9klTi7XoZZDMeE@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 igvtee@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 03:42:29 +0100 you wrote:
> Move the call to of_get_ethdev_address to mtk_add_mac which is part of
> the probe function and can hence itself return -EPROBE_DEFER should
> of_get_ethdev_address return -EPROBE_DEFER. This allows us to entirely
> get rid of the mtk_init function.
> 
> The problem of of_get_ethdev_address returning -EPROBE_DEFER surfaced
> in situations in which the NVMEM provider holding the MAC address has
> not yet be loaded at the time mtk_eth_soc is initially probed. In this
> case probing of mtk_eth_soc should be deferred instead of falling back
> to use a random MAC address, so once the NVMEM provider becomes
> available probing can be repeated.
> 
> [...]

Here is the summary with links:
  - net: ethernet: mtk_eth_soc: handle probe deferral
    https://git.kernel.org/netdev/net/c/1d6d537dc55d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-17764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F52753013
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392F7282006
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E991C30;
	Fri, 14 Jul 2023 03:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1D1C16
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 03:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 208BBC433C8;
	Fri, 14 Jul 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689306022;
	bh=fEVC1IDumQ6vtEVk8WRWYvfdOMoP9HkIJWzx7h2D/CY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rVe4TafjscV8CnUO2MH0x6+JNZg0Dst1Uh+HLC827LzthtVjCE6L7E245SkW4eLih
	 hhUXM3li8KUB4ltykn6i0O+ZVUQwJytFYgzInrlxF2pUbgUyOLFAQeYo3tIFQhQpxm
	 sLwNpRXyXC+fVz0NZOUT/DXkY3vmkHb5ORa2AxbmHRfLb07UnWPMIG4yimMFhDv0Nk
	 UD8kHkg9rTdQXltHxHd4ChBVyVjZBgjDutK0F31O9mEk2bsVDTXodhlZrL3/Zibe82
	 w4fw6gjsv5IZGdJ9cw7qsyumuYQxuO1TdCWDXcFmJY2bcR30kpAo5ZKe4cm4myNLzy
	 RaAowm80DSRmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC918E29F46;
	Fri, 14 Jul 2023 03:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] dsa: mv88e6xxx: Do a final check before timing out
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168930602195.1851.7666446846924104575.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 03:40:21 +0000
References: <20230712223405.861899-1-linus.walleij@linaro.org>
In-Reply-To: <20230712223405.861899-1-linus.walleij@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, tobias@waldekranz.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jul 2023 00:34:05 +0200 you wrote:
> I get sporadic timeouts from the driver when using the
> MV88E6352. Reading the status again after the loop fixes the
> problem: the operation is successful but goes undetected.
> 
> Some added prints show things like this:
> 
> [   58.356209] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
>     for switch, addr 1b reg 0b, mask 8000, val 0000, data c000
> [   58.367487] mv88e6085 mdio_mux-0.1:00: Timeout waiting for
>     ATU op 4000, fid 0001
> (...)
> [   61.826293] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
>     for switch, addr 1c reg 18, mask 8000, val 0000, data 9860
> [   61.837560] mv88e6085 mdio_mux-0.1:00: Timeout waiting
>     for PHY command 1860 to complete
> 
> [...]

Here is the summary with links:
  - [net,v2] dsa: mv88e6xxx: Do a final check before timing out
    https://git.kernel.org/netdev/net/c/95ce158b6c93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




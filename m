Return-Path: <netdev+bounces-13245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2175673AEC6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449AF28186C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B1A20;
	Fri, 23 Jun 2023 02:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B47F7
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C623C433CC;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687488626;
	bh=ko3k7IlM110GNzMw7xNvyXOMwO9tnROCH67Bg+x6p2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mXjrtKdAOLVrhijlbn3v9TmQ8VrYFqxlT38GeuRDBkBSBadiHvGK13z6JgXiKCnjl
	 gGqZCynUgfbi7K8TA/FjqEfbrYwWlF+oALRwsH/6R3DtGd2ghZdR3GFBQbvoKvTV5V
	 /Z5XZnGhLdNH9Feu+q+wWCyLx5nG/pMEyQntXsBdywLOhVLJtJypGF6Drmo+OfFshx
	 7Yo5wxOUc2Z6gwAKHem2GvPBdtDIeTfk2HBn6pkfqFIJMWftiRoOZtGYr2hBG8G08m
	 SVhOrZv1ITARpqtCG8qaIROmCBoZ7i6qEdA4BdAPdTAfuhioX+LpiWJx+CYv+oKsxc
	 6go9jBpvRocQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F874C691F1;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: dsa: microchip: fix writes to phy registers
 >= 0x10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748862638.32034.4855934302738922357.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:50:26 +0000
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 13:38:51 +0200 you wrote:
> Patch 1 is just a simplification, technically unrelated to the other
> two patches. But it would be a bit inconsistent to have the new
> ksz_prmw32() introduced in patch 2 use ksz_rmw32() while leaving
> ksz_prmw8() as-is.
> 
> The actual fix is of course patch 3. I can definitely see some weird
> behaviour on our ksz9567 when writing to phy registers 0x1e and 0x1f
> (with phytool from userspace), though it does not seem that the effect
> is always to write zeroes to the buddy register as the errata sheet
> says would be the case. In our case, the switch is connected via i2c;
> I hope somebody with other switches and/or the SPI variants can test
> this.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: dsa: microchip: simplify ksz_prmw8()
    https://git.kernel.org/netdev/net-next/c/3b42fbd59511
  - [net-next,2/3] net: dsa: microchip: add ksz_prmw32() helper
    https://git.kernel.org/netdev/net-next/c/ece28ecbec9f
  - [net-next,3/3] net: dsa: microchip: fix writes to phy registers >= 0x10
    https://git.kernel.org/netdev/net-next/c/5c844d57aa78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




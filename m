Return-Path: <netdev+bounces-23583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F376C95D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6FA281CE3
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084D763A3;
	Wed,  2 Aug 2023 09:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FB5682
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47F97C433CA;
	Wed,  2 Aug 2023 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690968022;
	bh=cu5aFRwVJ/7kjFhP/oCYSGiLSpU8rxfsKLa8ggeJqWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZXBO7mGaYccWur6Rn/Bx6PHo9QStJ5f4TwDw3dTyxAd43gA+QK5TS2p/ZW26M/Knk
	 HXJVQJ2Z0cScJAxltKZRml0ULPe2o75L1o/xr9SzIHMbuBhwtnMmGVQuqP59K+r7Pu
	 WY2EHPwR04U1Bpouo6riDSqiIQkhwestTqBdC2SRvKU/1FpIIlmKIXx+VUAGcIPsSc
	 83xkIEqYQVO1BtzMtY3TeUXxwMBTt21GgnKgCXfIpVyXkciR1IXoxuzzsBJtxLs1B4
	 x8lrGT5z0JvGXrbLKRzBBhdAfljXnp6T1qu2MyfSSMRcUNr3dElR2qy9E8x5NOEXjS
	 +eyQPtd4zkmgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34041C6445A;
	Wed,  2 Aug 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/4] Packet classify by matching against SPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169096802220.5600.7149545725575410006.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 09:20:22 +0000
References: <20230801014101.2955887-1-rkannoth@marvell.com>
In-Reply-To: <20230801014101.2955887-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 1 Aug 2023 07:10:57 +0530 you wrote:
> 1.  net: flow_dissector: Add IPSEC dissector.
> Flow dissector patch reads IPSEC headers (ESP or AH) header
> from packet and retrieves the SPI header.
> 
> 2. tc: flower: support for SPI.
> TC control path changes to pass SPI field from userspace to
> kernel.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/4] net: flow_dissector: Add IPSEC dissector
    https://git.kernel.org/netdev/net-next/c/a57c34a80cbe
  - [v1,net-next,2/4] tc: flower: support for SPI
    https://git.kernel.org/netdev/net-next/c/4c13eda757e3
  - [v1,net-next,3/4] tc: flower: Enable offload support IPSEC SPI field.
    https://git.kernel.org/netdev/net-next/c/c8915d7329d6
  - [v1,net-next,4/4] octeontx2-pf: TC flower offload support for SPI field
    https://git.kernel.org/netdev/net-next/c/73b4c04e2e9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




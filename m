Return-Path: <netdev+bounces-23591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5C76C9D5
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7DA1C2122F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD063AE;
	Wed,  2 Aug 2023 09:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477825672
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B86ECC433C9;
	Wed,  2 Aug 2023 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690969823;
	bh=YNGg54vc0V6PfCPoIvIB77azQ9/faPnu2+EwvDjYIyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z6WCjDiViJXAZWOfWK8Njn0ud+2JZvyGgjOY7djg2olEBGftboehjEzhNKo9yeg/1
	 awFUHp/TDhTwY4NrXBS4h/fTp5sEGnBUXE271UUiuB2bVkCxm/6hYJuvaWrj0JB3VY
	 7dc+irxCLejgIWYpp0jQ2qykzEKZKlHOacOqqmq1zQJ0mNZqdaPnX/l1xe3O+1K5Ht
	 SE7eWnZnIi23degUzFvl1338uMV0vq7cmeAcSCMic8svYlVNC8B49aWz3TnMPOnIGh
	 6WgxeFwFfhodLHu2tRRzgaYntF/kk4+iOMuxmiTsxRaj29vsN8sRi3UPG5khwaV0eP
	 nD3RPG4subvnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B0FFC6445B;
	Wed,  2 Aug 2023 09:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13 00/10] Introduce ICSSG based ethernet Driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169096982363.22290.18372322517345750878.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 09:50:23 +0000
References: <20230801091428.1359979-1-danishanwar@ti.com>
In-Reply-To: <20230801091428.1359979-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: rdunlap@infradead.org, rogerq@kernel.org, simon.horman@corigine.com,
 vigneshr@ti.com, andrew@lunn.ch, richardcochran@gmail.com,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 1 Aug 2023 14:44:18 +0530 you wrote:
> The Programmable Real-time Unit and Industrial Communication Subsystem
> Gigabit (PRU_ICSSG) is a low-latency microcontroller subsystem in the TI
> SoCs. This subsystem is provided for the use cases like the implementation
> of custom peripheral interfaces, offloading of tasks from the other
> processor cores of the SoC, etc.
> 
> The subsystem includes many accelerators for data processing like
> multiplier and multiplier-accumulator. It also has peripherals like
> UART, MII/RGMII, MDIO, etc. Every ICSSG core includes two 32-bit
> load/store RISC CPU cores called PRUs.
> 
> [...]

Here is the summary with links:
  - [v13,01/10] net: ti: icssg-prueth: Add Firmware Interface for ICSSG Ethernet driver.
    https://git.kernel.org/netdev/net-next/c/61f4d2044aeb
  - [v13,02/10] net: ti: icssg-prueth: Add mii helper apis and macros
    https://git.kernel.org/netdev/net-next/c/b6ba7752149d
  - [v13,03/10] net: ti: icssg-prueth: Add Firmware config and classification APIs.
    https://git.kernel.org/netdev/net-next/c/e9b4ece7d74b
  - [v13,04/10] net: ti: icssg-prueth: Add icssg queues APIs and macros
    https://git.kernel.org/netdev/net-next/c/b8d5008f8c51
  - [v13,05/10] dt-bindings: net: Add ICSSG Ethernet
    https://git.kernel.org/netdev/net-next/c/172e604a8c62
  - [v13,06/10] net: ti: icssg-prueth: Add ICSSG ethernet driver
    https://git.kernel.org/netdev/net-next/c/128d5874c082
  - [v13,07/10] net: ti: icssg-prueth: Add ICSSG Stats
    https://git.kernel.org/netdev/net-next/c/c1e10d5dc7a1
  - [v13,08/10] net: ti: icssg-prueth: Add Standard network staticstics
    https://git.kernel.org/netdev/net-next/c/c2f67d192351
  - [v13,09/10] net: ti: icssg-prueth: Add ethtool ops for ICSSG Ethernet driver
    https://git.kernel.org/netdev/net-next/c/8fb86b0dcaed
  - [v13,10/10] net: ti: icssg-prueth: Add Power management support
    https://git.kernel.org/netdev/net-next/c/a46750a13bb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




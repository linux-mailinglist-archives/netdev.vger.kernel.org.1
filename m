Return-Path: <netdev+bounces-30891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C84789B88
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 08:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9EC280FCB
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 06:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989480A;
	Sun, 27 Aug 2023 06:21:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD27EE
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 06:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B7AC433C9;
	Sun, 27 Aug 2023 06:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693117307;
	bh=6UUXpO9T2ZjC/jSRr1ot3zZfncDhgWdLHcdF5xDh8zk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FO5tXPdOEjpQmNZOqrRATWIad10KITbXuBLgewxwStt1JiDPZCd0dhDxMzc66WPxV
	 yiklSu54L3pE4rHSiCdpcfV0+j1ZdKGc6DLDVpr0FPps2G4R+RUu7wilxXlyWJpize
	 6kEmJAnGOliHg5rcHU5vvhJxB5HepbCR8ScvCGR65WXFUOm8U/HY+MiKAo62TeqBIX
	 pnAQN+sGNzxJv1ditKAvOpny/ODkllPi176IecAYDCYjtCh9Q/mfeChQ7OUq01MWUS
	 TSDLBXdBLWvMq8HE2opTzevd9JQTE8lYywNRcwawF+DM7rVkaV240dX/whs59B1E9q
	 0RP6Zh6oKuV+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BB27E33083;
	Sun, 27 Aug 2023 06:21:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/5] Introduce IEP driver and packet timestamping support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169311730704.334.2679024548095794148.git-patchwork-notify@kernel.org>
Date: Sun, 27 Aug 2023 06:21:47 +0000
References: <20230824114618.877730-1-danishanwar@ti.com>
In-Reply-To: <20230824114618.877730-1-danishanwar@ti.com>
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

On Thu, 24 Aug 2023 17:16:13 +0530 you wrote:
> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ICSSG ethernet ports.
> 
> This series also adds 10M full duplex support for ICSSG ethernet driver.
> 
> There are two IEP instances. IEP0 is used for packet timestamping while IEP1
> is used for 10M full duplex support.
> 
> [...]

Here is the summary with links:
  - [v7,1/5] dt-bindings: net: Add ICSS IEP
    https://git.kernel.org/netdev/net-next/c/f0035689c036
  - [v7,2/5] dt-bindings: net: Add IEP property in ICSSG
    https://git.kernel.org/netdev/net-next/c/b12056278378
  - [v7,3/5] net: ti: icss-iep: Add IEP driver
    https://git.kernel.org/netdev/net-next/c/c1e0230eeaab
  - [v7,4/5] net: ti: icssg-prueth: add packet timestamping and ptp support
    https://git.kernel.org/netdev/net-next/c/186734c15886
  - [v7,5/5] net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support
    https://git.kernel.org/netdev/net-next/c/443a2367ba3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




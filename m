Return-Path: <netdev+bounces-19267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE075A170
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43141C20D66
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 22:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2835625152;
	Wed, 19 Jul 2023 22:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2017FE9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 22:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF889C433CA;
	Wed, 19 Jul 2023 22:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689804622;
	bh=b1Jh+2XWSDzNJT1cGWQC4NXYhXR0setBy5OkZNgNgSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dkxhs9vj0EWDD0LZRlsIKi1wEV6JThp3Zoy8OtothRy9C//hjSWN33fasI791DnNw
	 wMRjZkDmkpuy80IZ9TLgTbhYfJwE+pFQaoJ8EeTcT6NV/GvMFJeYdB4CZ5G9YCWdiN
	 KacRcGf7KSFKH79xfprZw8HCHqfUoZ+0itIpb0BR4EQENPzPRYVbYIGgLqSCDyil2Z
	 hKdvvarLJyNvosI52QiE4zBt9NQazwYjTsnv3uNqazuar3wBGxDo5tfJ/cAOF7kEOR
	 WUWECn7A1eozhOxsoee7dyCeaxNlqMriZV/Z65Hc+k6DoFrD1076w7HzxndzxgpVdT
	 Vh7lAujNYNvjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF686C6445A;
	Wed, 19 Jul 2023 22:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: can: Remove interrupt
 properties for MCAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168980462277.30545.412966680711424216.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 22:10:22 +0000
References: <20230719072348.525039-2-mkl@pengutronix.de>
In-Reply-To: <20230719072348.525039-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, jm@ti.com,
 tony@atomide.com, conor.dooley@microchip.com, krzysztof.kozlowski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 19 Jul 2023 09:23:41 +0200 you wrote:
> From: Judith Mendez <jm@ti.com>
> 
> On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> routed to A53 Linux, instead they will use software interrupt by
> timer polling.
> 
> To enable timer polling method, interrupts should be
> optional so remove interrupts property from required section and
> add an example for MCAN node with timer polling enabled.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] dt-bindings: net: can: Remove interrupt properties for MCAN
    https://git.kernel.org/netdev/net-next/c/bb410c03b999
  - [net-next,2/8] can: m_can: Add hrtimer to generate software interrupt
    https://git.kernel.org/netdev/net-next/c/b382380c0d2d
  - [net-next,3/8] dt-bindings: can: xilinx_can: Add reset description
    https://git.kernel.org/netdev/net-next/c/62bd0232d745
  - [net-next,4/8] can: xilinx_can: Add support for controller reset
    https://git.kernel.org/netdev/net-next/c/25000fc785b4
  - [net-next,5/8] can: Explicitly include correct DT includes
    https://git.kernel.org/netdev/net-next/c/22d8e8d6338d
  - [net-next,6/8] can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
    https://git.kernel.org/netdev/net-next/c/c2ad812956ae
  - [net-next,7/8] can: kvaser_pciefd: Add support for new Kvaser pciefd devices
    https://git.kernel.org/netdev/net-next/c/f33ad6776b2f
  - [net-next,8/8] can: ucan: Remove repeated word
    https://git.kernel.org/netdev/net-next/c/03df47c1bb39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




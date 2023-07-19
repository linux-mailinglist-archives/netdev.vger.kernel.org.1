Return-Path: <netdev+bounces-18805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EE9758B30
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912DD28180D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446361FC6;
	Wed, 19 Jul 2023 02:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADD1FDF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AAA2C433D9;
	Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689732622;
	bh=96Jt0TgXaRl/IuSMTNAabE3RdEAC0ecOVXMrdPNO4NA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kt9G1RN3zRDgO+YWxDqLM3WVtmAxIIsCi6VA42DwfwSADCJ7yGuE8ldBixU3kk+5w
	 4FpYt4okJB7gwYssv6NF9PdK4EwdQQMJi30d3S7dERMqudNU8G5SwmTDv0cvyqpCHC
	 J87j5Fp4PDgNfQGKexv4wbia6GBLKQMtj63zDem8P6RD6k7VWA1apnJOgdGW8JUV5j
	 9me6dAiZ9YEHsdOwqAZRPklrbsPCxHtpkv5y4E8Ivl0n7A77CipbV4Ob6nfhrT5JMm
	 AtO4ZuSwTUcYjbRKhAc8AsRLweMVUrIgxfR8zOY3d24XT0AFU8ctzpufVwZbnq2P8V
	 6+gpnj84fSGFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F06CC64458;
	Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
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
 <168973262231.24960.391251104381339496.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 02:10:22 +0000
References: <20230717182229.250565-2-mkl@pengutronix.de>
In-Reply-To: <20230717182229.250565-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, jm@ti.com,
 tony@atomide.com, conor.dooley@microchip.com, krzysztof.kozlowski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 20:22:22 +0200 you wrote:
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
    (no matching commit)
  - [net-next,2/8] can: m_can: Add hrtimer to generate software interrupt
    (no matching commit)
  - [net-next,3/8] can: ems_pci: Remove unnecessary (void *) conversions
    https://git.kernel.org/netdev/net-next/c/9235e3bcc613
  - [net-next,4/8] can: Explicitly include correct DT includes
    (no matching commit)
  - [net-next,5/8] dt-bindings: can: xilinx_can: Add reset description
    (no matching commit)
  - [net-next,6/8] can: xilinx_can: Add support for controller reset
    (no matching commit)
  - [net-next,7/8] can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
    (no matching commit)
  - [net-next,8/8] can: kvaser_pciefd: Add support for new Kvaser pciefd devices
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




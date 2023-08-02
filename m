Return-Path: <netdev+bounces-23511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F176C3EA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 06:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC6281ABF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 04:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E431102;
	Wed,  2 Aug 2023 04:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7315B3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 04:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93FB2C433C9;
	Wed,  2 Aug 2023 04:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690949425;
	bh=2lpVadl0aFwCvRq8Vg6WN59hGDL3+Vtp94G8+HimX3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NgDhAQgmD7zxG3dnx5wSt5wtiDL2egMDAZZeS3N/dh7tRpPV2TYGRqb8mBj58eCO1
	 LwTqr8c1pPE2G2ypn2mASXahdPCe90j5jSATaoxTbgYj1tcf9ZH3KXEtcYk+9mFpl9
	 ACDE0ULXtdWswBLk2cuWhfgcHSNytKwwVd6ro4vYbdiF2IzOiN8epUpp2L3gk8nEKh
	 VoYcs3sbTNUf9Dp87O4GCMzvQtueyJPZ271VgCb0OXzxO5R/BqvFyoseDoL9rMsHnl
	 GrjFA08aBfowj0f3w9GXC8hwz+1hfYQVKHHgVL3Ibek0zpHfEwAI270CDQU+jW6PGd
	 oZiHzUeVRwWKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B6EAE96ABD;
	Wed,  2 Aug 2023 04:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/11] Add TJA1120 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169094942550.31458.17359755832524116454.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 04:10:25 +0000
References: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
To: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 12:16:08 +0300 you wrote:
> Hello everyone,
> 
> This patch series got bigger than I expected. It cleans up the
> next-c45-tja11xx driver and adds support for the TJA1120(1000BaseT1
> automotive phy).
> 
> Master/slave custom implementation was replaced with the generic
> implementation (genphy_c45_config_aneg/genphy_c45_read_status).
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/11] net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
    https://git.kernel.org/netdev/net-next/c/ac0687e821cf
  - [net-next,v5,02/11] net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
    https://git.kernel.org/netdev/net-next/c/643480a1a73d
  - [net-next,v5,03/11] net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120
    https://git.kernel.org/netdev/net-next/c/6c0c85da044e
  - [net-next,v5,04/11] net: phy: nxp-c45-tja11xx: use get_features
    https://git.kernel.org/netdev/net-next/c/369da333569e
  - [net-next,v5,05/11] net: phy: nxp-c45-tja11xx: add TJA1120 support
    https://git.kernel.org/netdev/net-next/c/f1fe5dff2b8a
  - [net-next,v5,06/11] net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
    https://git.kernel.org/netdev/net-next/c/b0b2247d815d
  - [net-next,v5,07/11] net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
    https://git.kernel.org/netdev/net-next/c/bdb4c5b88520
  - [net-next,v5,08/11] net: phy: nxp-c45-tja11xx: handle FUSA irq
    https://git.kernel.org/netdev/net-next/c/425c8348df7b
  - [net-next,v5,09/11] net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
    https://git.kernel.org/netdev/net-next/c/c552c110d479
  - [net-next,v5,10/11] net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
    https://git.kernel.org/netdev/net-next/c/08e6547c8468
  - [net-next,v5,11/11] net: phy: nxp-c45-tja11xx: reset PCS if the link goes down
    https://git.kernel.org/netdev/net-next/c/68c6af72047c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




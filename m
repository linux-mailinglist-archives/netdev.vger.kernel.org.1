Return-Path: <netdev+bounces-42086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F577CD18D
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A6D281BCD
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D8A5B;
	Wed, 18 Oct 2023 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQMQwtw3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827A1FC9;
	Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6380C433CD;
	Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697590830;
	bh=d+Wil/bELMn0pp9oby9I8jAn5K+oJkpy8LPXyS5vv0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SQMQwtw3BBaWdoJinbS1KszSbe5ucBOs/fOO5pTQRtMHyUEbyDK3VhCeilJLkLoLH
	 AELasY63/afrwdCyw3zOUT/+1Ukz0AHqI3hehYiWVJoIzx2NnphlRiSpqYfA+PSIRK
	 AuqW6PwVC0isSsR0LgBlTNTbFiKGfIyAnwuoNwnZS2R6HiPqg1bOHZ/XgamMEGNxSU
	 kf4rt2+Mar4A9rtwW801ZBMrYNYiNGKVp3xSFDUFSYNeKmfMgPa4J2Td8eV0Do3KqC
	 1313m871PDZ7Fcj7VV0isoXAARATjzRaAeB4VcjMojy/CVlmQvkUAAwDDj0m2zG8wp
	 tHC5Sy4QrmLyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A2EDC04E24;
	Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: remove last of the phylink validate
 methods and clean up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169759083056.18882.13253920837747365472.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 01:00:30 +0000
References: <ZS1Z5DDfHyjMryYu@shell.armlinux.org.uk>
In-Reply-To: <ZS1Z5DDfHyjMryYu@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, madalin.bucur@nxp.com, netdev@vger.kernel.org,
 pabeni@redhat.com, sean.anderson@seco.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 16:42:28 +0100 you wrote:
> Hi,
> 
> This four patch series removes the last of the phylink MAC .validate
> methods which can be found in the Freescale fman driver. fman has a
> requirement that half duplex may not be supported in RGMII mode,
> which is currently handled in its .validate method.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: phylink: provide mac_get_caps() method
    https://git.kernel.org/netdev/net-next/c/b6f9774719e5
  - [net-next,2/4] net: fman: convert to .mac_get_caps()
    https://git.kernel.org/netdev/net-next/c/2141297d4257
  - [net-next,3/4] net: phylink: remove .validate() method
    https://git.kernel.org/netdev/net-next/c/da5f6b80ad64
  - [net-next,4/4] net: phylink: remove a bunch of unused validation methods
    https://git.kernel.org/netdev/net-next/c/743f6397623e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




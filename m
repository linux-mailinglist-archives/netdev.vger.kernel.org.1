Return-Path: <netdev+bounces-45680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9187DEFB3
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A938B20EDC
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB6134CB;
	Thu,  2 Nov 2023 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPmgZRUF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87013AC8
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A1BFC433CC;
	Thu,  2 Nov 2023 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698920422;
	bh=ii46HP7tUM35gdc9V+cshFB8H1AAOg9roojYXu0EpKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lPmgZRUFBj+RkbYSPn2u+YXOY8yKKb+4NWHvcd4A5gO09qOGfyslp8CxBQ0yIa/IU
	 ic3+iouLhDMDmbL5bIaM6Qlc8Y20COv4Y3Pl/wJlOpmjzrcFw8eDAaFERgpqPUHlYJ
	 fcosFE9GlEg7UqKcFeb7G8G+Cj+pd+oXjOa8eqtIopW8M6PyDfQRQt5ZIgmC1l9VJ5
	 bAagTXNbnODcyeSl9X9rt0hl0nwymAsnO7gnw7GsGf64U+7nxSprUDldZ6MP8xpbAy
	 VGXPIY8CElvHqF/3ibFOq6iRS0nX/jNf91MBYXCBig5LK9ZOKanCfakV1To9kwu0Pc
	 246Eg8IaG0Q+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D506EAB08B;
	Thu,  2 Nov 2023 10:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: lan9303: consequently nested-lock physical MDIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169892042224.6656.1197027329614877556.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 10:20:22 +0000
References: <20231027065741.534971-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20231027065741.534971-1-alexander.sverdlin@siemens.com>
To: A. Sverdlin <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jbe@pengutronix.de, jerry.ray@microchip.com,
 mans@mansr.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Oct 2023 08:57:38 +0200 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> When LAN9303 is MDIO-connected two callchains exist into
> mdio->bus->write():
> 
> 1. switch ports 1&2 ("physical" PHYs):
> 
> [...]

Here is the summary with links:
  - net: dsa: lan9303: consequently nested-lock physical MDIO
    https://git.kernel.org/netdev/net/c/5a22fbcc10f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




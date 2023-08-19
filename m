Return-Path: <netdev+bounces-29132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E69781AC5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015D02816B4
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16891ADE5;
	Sat, 19 Aug 2023 18:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022BED3
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02DDFC433C7;
	Sat, 19 Aug 2023 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692470065;
	bh=gfhWesNZR8t19aIZrropqAXyuN5wftiUYNMRwaq/gwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b+kQFtDdXqP0KzKcsoLqYTZFNloGali6UBIJSPWoHvWn79JUsBHPdsxrj8RPe7nK9
	 RanRDLhUpzGMzgQ2ITq657ERwOHaz+ZQIuOb8lEm8PIKqCpNn9Qb6kkbu9AtdtwHNI
	 AGPi0z8i/HaW/KHLMipmlcF2gbprl3QXAd1dT9TB1CnLhaBu3m6fjy50q7kFnEUKtk
	 CEhfX93G9Wzidy4KroNB7+yWCobgolkPt1hu/TVqUZ7KBvoKoxaH6s70LKuZ3n6h+9
	 rc2n3lT+2d5r83OCYaUnuKdLPh83yf/PI3IlkI3px6aHBOwugidZitZp1J5CtvzJIn
	 6zWFttyNvYusA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4196E26D32;
	Sat, 19 Aug 2023 18:34:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: xgene: remove useless xgene_mdio_status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169247006493.18695.8324634375298592126.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 18:34:24 +0000
References: <E1qWxjI-0056nx-CU@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qWxjI-0056nx-CU@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 12:33:24 +0100 you wrote:
> xgene_mdio_status is declared static, and is only written once by the
> driver. It appears to have been this way since the driver was first
> added to the kernel tree. No other users can be found, so let's remove
> it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: mdio: xgene: remove useless xgene_mdio_status
    https://git.kernel.org/netdev/net-next/c/44a696de720d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




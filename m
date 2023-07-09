Return-Path: <netdev+bounces-16246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB1674C1ED
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B501C20749
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19E468A;
	Sun,  9 Jul 2023 10:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EA20EB
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 10:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 193EEC433C9;
	Sun,  9 Jul 2023 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688898620;
	bh=JNjdE7h2KECVVFRvJju8wvUIdWAf0hYPNyWWMZWiwuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cta4/LHpwmWC2DGW1rTuvflBNM0PuxedXbH94A5f1yG6Noihxu+ZEqvKF+bypLOKO
	 8t5IsKUasS4+mXtOGnnumr8lfgjuk3x39881byrMaWByhL5V6RHjycKEiqUBxxZdmV
	 DfrMziZndtZ6ddnzYcEVFxgioPW6MunbG6Bmre8vC5SSQ0aot4IQRYEUmCf0FW12dS
	 q/SvBPH0bYT/KLivtdWau31sfIGklBmZ+vBA8UotUpf4PkNqgUfoXvF2x1WhHM00dI
	 wvQBz82GvO5HCYUDwze/kTk996qE2gdMjivF0/KwdjQ0bCd9cZagoa0lVIRTCkFBg4
	 0HYsBNF/hUKCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF446C395F8;
	Sun,  9 Jul 2023 10:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lan743x: select FIXED_PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168889861997.29064.9707742111397535356.git-patchwork-notify@kernel.org>
Date: Sun, 09 Jul 2023 10:30:19 +0000
References: <20230708-lan743x-fixed-phy-v1-1-3fd19580546c@kernel.org>
In-Reply-To: <20230708-lan743x-fixed-phy-v1-1-3fd19580546c@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Pavithra.Sathyanarayanan@microchip.com,
 rdunlap@infradead.org, stable@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 08 Jul 2023 15:06:25 +0100 you wrote:
> The blamed commit introduces usage of fixed_phy_register() but
> not a corresponding dependency on FIXED_PHY.
> 
> This can result in a build failure.
> 
>  s390-linux-ld: drivers/net/ethernet/microchip/lan743x_main.o: in function `lan743x_phy_open':
>  drivers/net/ethernet/microchip/lan743x_main.c:1514: undefined reference to `fixed_phy_register'
> 
> [...]

Here is the summary with links:
  - [net] net: lan743x: select FIXED_PHY
    https://git.kernel.org/netdev/net/c/73c4d1b307ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




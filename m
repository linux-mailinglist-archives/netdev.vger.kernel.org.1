Return-Path: <netdev+bounces-20178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E675E17E
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 12:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A122814F7
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD41113;
	Sun, 23 Jul 2023 10:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB007F
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 10:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33437C433C9;
	Sun, 23 Jul 2023 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690109421;
	bh=9HWp+aCILxMD6jDD8IMj4CYI865B54wN4mwjOv6/Zt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sb0waR8y5YCr26aL0BhuGRbpaGE8Od1fKoeCrLFpNLS1BJgZFTBPpaiK7RaENXX30
	 6vkZjn9h2a+4Pz3Dni7smbye/8iInBNWXP4XpUwCEVtPa/A9zNL5F2EdtuQzb9AoPt
	 5e+hpOOFxKFuPj367bku9gn3lh6lth9zMGhJ2hXI8JSn+9k9//ykwsgb9sJzSIh3s5
	 aBHNNVKMvCXBmvQ/gO2ylF1SmUvlTicunHfQkZjfFodYEvV00SQxRshPaFccrdQhsJ
	 2B+b8bVovGyOcD3JKMlOGVY6m1opWZcFa5Ng3UFEqW85gp9nvCkrekvakDYOwfhHPz
	 EWSc1mxE+YI0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05F7DC595C2;
	Sun, 23 Jul 2023 10:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: marvell10g: fix 88x3310 power up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169010942101.21900.16629915424532297852.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jul 2023 10:50:21 +0000
References: <20230719092233.137844-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230719092233.137844-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: linux@armlinux.org.uk, kabel@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jul 2023 17:22:33 +0800 you wrote:
> Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> it sometimes does not take effect immediately. And a read of this
> register causes the bit not to clear. This will cause mv3310_reset()
> to time out, which will fail the config initialization. So add a delay
> before the next access.
> 
> Fixes: c9cc1c815d36 ("net: phy: marvell10g: place in powersave mode at probe")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: marvell10g: fix 88x3310 power up
    https://git.kernel.org/netdev/net/c/c7b75bea853d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




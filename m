Return-Path: <netdev+bounces-27874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B577D80D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131731C20D72
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB251115;
	Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE137F2
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E670C433C9;
	Wed, 16 Aug 2023 02:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151221;
	bh=8zy9tuJEYtTlTlsmU6yw8DxWnd3M4qAqXB5IZSXtOWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jkyl5thNvoc2mEJC4kDmAiQcYEAOJ82knh1SV9Uyk1vXBiJwogLh8vmwvL+wyd20l
	 HvqpIbuhmEYDZ3oAyogaGV//PRTfZ4XFb8AeqYr6KfAxNuER4Ur1Dn9YrFDF1pEmOF
	 Zp0l2ZI82rUdo28tiJy5In92xwQSEunxB2rjUpcmvGzdVB0jErnKiZVFWN4JwRa4Lh
	 +RituYE2rOIG57q6y/Df2kgtfFz9WP+jCasjTIp7ywhA/ShyJbJg43rbBpJMNQYc2t
	 Wh/Ap4QTnY4L7wktJMsJVRsWDwca9p0eVcd78PYs0wmekHojjZIr7JMmUruwoWjI8K
	 gwW2V6ZzZp+GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83D5BC395C5;
	Wed, 16 Aug 2023 02:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: broadcom: stub c45 read/write for 54810
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215122153.15326.4625429367970352671.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:00:21 +0000
References: <1691901708-28650-1-git-send-email-justin.chen@broadcom.com>
In-Reply-To: <1691901708-28650-1-git-send-email-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jon.mason@broadcom.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Aug 2023 21:41:47 -0700 you wrote:
> The 54810 does not support c45. The mmd_phy_indirect accesses return
> arbirtary values leading to odd behavior like saying it supports EEE
> when it doesn't. We also see that reading/writing these non-existent
> MMD registers leads to phy instability in some cases.
> 
> Fixes: b14995ac2527 ("net: phy: broadcom: Add BCM54810 PHY entry")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: broadcom: stub c45 read/write for 54810
    https://git.kernel.org/netdev/net/c/096516d092d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




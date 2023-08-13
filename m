Return-Path: <netdev+bounces-27115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B268777A63E
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E951C20757
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9EC5384;
	Sun, 13 Aug 2023 11:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C85236
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 11:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEB1BC433CA;
	Sun, 13 Aug 2023 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691926821;
	bh=Jb+sgdnkxaUgpdngnZskiYGEwFOpJ2WtdO8ncSwEXfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rdd/zZAAj0i5oAS2kjAkwZ2ptm5Gu8xrDtjZR43NofEj3mfcP5RYzMtXWQOgyJ5P5
	 ZQeK3QWvpBDXllbW85B+khzKdRNvRBwjT3LYVQgSjVZX4GVwecBEJXbgcLD0yWnCCv
	 e+hYDz6vSLBN5WIcEmU6vW8N+KQTF0MzqaQWLinDg4fjI/nKHdMC41iJgd8buUg95l
	 yYZaypdeRxqBBH9FwkeVSF6lOy+3GWCccV6m2Vemz5ykYWXXenn6LqNskwkezNUk6a
	 HVL0qjsR10+PPjGLJ/3oFSRHQ1Zbwaima18xbUXn+M9OMA8zcAzd4yNlYF/TDoi4gj
	 loOVpHqx4tepA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B10D5C39562;
	Sun, 13 Aug 2023 11:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pcs: lynx: fix lynx_pcs_link_up_sgmii() not
 doing anything in fixed-link mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169192682172.1919.731891096559433284.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 11:40:21 +0000
References: <20230811115352.1447081-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230811115352.1447081-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, camelia.groza@nxp.com,
 ioana.ciornei@nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 14:53:52 +0300 you wrote:
> lynx_pcs_link_up_sgmii() is supposed to update the PCS speed and duplex
> for the non-inband operating modes, and prior to the blamed commit, it
> did just that, but a mistake sneaked into the conversion and reversed
> the condition.
> 
> It is easy for this to go undetected on platforms that also initialize
> the PCS in the bootloader, because Linux doesn't reset it (although
> maybe it should). The nature of the bug is that phylink will not touch
> the IF_MODE_HALF_DUPLEX | IF_MODE_SPEED_MSK fields when it should, and
> it will apparently keep working if the previous values set by the
> bootloader were correct.
> 
> [...]

Here is the summary with links:
  - [net-next] net: pcs: lynx: fix lynx_pcs_link_up_sgmii() not doing anything in fixed-link mode
    https://git.kernel.org/netdev/net-next/c/2f4503f94c5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




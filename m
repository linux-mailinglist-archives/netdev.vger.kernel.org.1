Return-Path: <netdev+bounces-26594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B676A778499
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67E71C20F2D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B617EC;
	Fri, 11 Aug 2023 00:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AD371
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BAD0C433C7;
	Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691714423;
	bh=OiJe0CYwaZbunlG6mValXSE+sdr6d2DVT7HODnNxbRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QfmAcLFhOMB/BHEc7zHU9O+wsuSPrdzn1TOe/X7U7SZ8QLlbiUVglsXdgQWHwQbKf
	 6vVrIBuDkbkvvxhfP5Jr5/9pcxfDWthkubeHxdwSGBuxwpqqb3Cr/9QKG7JhKyPZE8
	 x/z9nlajugGT4jIa4FHk+Ewhzh60yCwP4uW6y1V0pnV2JxcAlngF9JD3ZZU1EFFfjk
	 roGNrbnepMgN29XgJfKdDVy/iyEDy6a5CdAtfA92gs/VVShs2ivM2pEKoyHwSQy9rJ
	 m+PYMkMNOo+IH+Fm4U03LmOVNYU5lnIqoXdJKuGWC5JiVM5wxYRxZvQbWiky3FJXAv
	 Y8SzZ1LWT6PRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 700CFC395C5;
	Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] Support offload LED blinking to PHY.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169171442345.25552.8793390051761790550.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 00:40:23 +0000
References: <20230808210436.838995-1-andrew@lunn.ch>
In-Reply-To: <20230808210436.838995-1-andrew@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, rmk+kernel@armlinux.org.uk,
 simon.horman@corigine.com, ansuelsmth@gmail.com, daniel@makrotopia.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Aug 2023 23:04:32 +0200 you wrote:
> Allow offloading of the LED trigger netdev to PHY drivers and
> implement it for the Marvell PHY driver. Additionally, correct the
> handling of when the initial state of the LED cannot be represented by
> the trigger, and so an error is returned. As with ledtrig-timer,
> disable offload when the trigger is deactivate, or replaced by another
> trigger.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] led: trig: netdev: Fix requesting offload device
    https://git.kernel.org/netdev/net-next/c/7df1f14c04cb
  - [net-next,v3,2/4] net: phy: phy_device: Call into the PHY driver to set LED offload
    https://git.kernel.org/netdev/net-next/c/1dcc03c9a7a8
  - [net-next,v3,3/4] net: phy: marvell: Add support for offloading LED blinking
    https://git.kernel.org/netdev/net-next/c/460b0b648fab
  - [net-next,v3,4/4] leds: trig-netdev: Disable offload on deactivation of trigger
    https://git.kernel.org/netdev/net-next/c/e8fbcc47a8e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




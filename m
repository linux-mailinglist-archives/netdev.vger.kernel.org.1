Return-Path: <netdev+bounces-19638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC6575B86D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB24281FED
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78341BE74;
	Thu, 20 Jul 2023 20:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAF1BE73
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFAAAC433CB;
	Thu, 20 Jul 2023 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689883222;
	bh=hI8Fmqr0ttPE2QGhKjWCiJYj6F0Ufd8KmtHO2g2k3ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sHAeUz3OWQtRW31l8Etvc4TyALefATcwLb+C+tDcdKsVHE7skYeNWwqyxCjpD4Ha7
	 +n/BM/oNytEWQe4EOg8ZCNJADu6vcrqhR5YS/2RNrWbZYtJFRxAr6zHSiRlVSYf1RY
	 w9PlAzj2T+f6NA6KobHHgVXoxnUpHdCtoUJdz4qKrqkvePM4FTULibCjXcKaqHcu3P
	 iS27EWov3q81RT/cyhKaStSnRnJkNsOxXEe98P/yM+zHuDWGvQQ6Ywry+RitDzaMQa
	 pNYtL6ruNJddUhIaVBkC6MFDfI+pfrUeydbrQmu4HxEcJgUM/jw2uhEzgAtDGPLrvJ
	 rCJrg+r1jjduA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3DF0E21EF5;
	Thu, 20 Jul 2023 20:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: prevent stale pointer dereference in phy_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168988322273.13634.6290441658966987818.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 20:00:22 +0000
References: <20230720000231.1939689-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230720000231.1939689-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, f.fainelli@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 03:02:31 +0300 you wrote:
> mdio_bus_init() and phy_driver_register() both have error paths, and if
> those are ever hit, ethtool will have a stale pointer to the
> phy_ethtool_phy_ops stub structure, which references memory from a
> module that failed to load (phylib).
> 
> It is probably hard to force an error in this code path even manually,
> but the error teardown path of phy_init() should be the same as
> phy_exit(), which is now simply not the case.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: prevent stale pointer dereference in phy_init()
    https://git.kernel.org/netdev/net/c/1c613beaf877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-13639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6C473C630
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 04:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4911281ECA
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE7388;
	Sat, 24 Jun 2023 02:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A67378
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 02:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FFFCC433C9;
	Sat, 24 Jun 2023 02:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687572020;
	bh=/5hqAVUutsRdQlN6XP75PJGI6jtQkVvsi2aP/zYXs1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rRflR4GoNsD9eqByr39w+S7+rvjJxsTuG4gNKP0JNYCleY1wtXV2inSGHq62YV/vU
	 SFbynhaNUHaA9bCeq3JvaRQZ0bgGO6wKmPJhJpZY+v6lFvYT3Pp/kEMHjrehZN8+BX
	 JJcpnc6GCnIJ6pFuMqM5qy5it39iRMT+XEnVJJ3zBgRwpkySS9qmsLx6+EgsCMXMQg
	 P0XppmiIvUCk4E0nvmSQhoSK6ynftvixY3LZcyNeerpHzSuSrgqzEdYMaZ1kxpzToN
	 cJOrpucSYZOZGc0vFo3EuyoIigUr661Wrk3PlvdzoAsrWcmEjuEDxJ45S0ArwDUPJA
	 O2P3gwUQxT89g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2492CC395D9;
	Sat, 24 Jun 2023 02:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: Ensure MDIO unregistration has clocks
 enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168757202014.19315.5128795746838257029.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 02:00:20 +0000
References: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
In-Reply-To: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 ansuelsmth@gmail.com, rmk+kernel@armlinux.org.uk, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 03:31:07 -0700 you wrote:
> With support for Ethernet PHY LEDs having been added, while
> unregistering a MDIO bus and its child device liks PHYs there may be
> "late" accesses to the MDIO bus. One typical use case is setting the PHY
> LEDs brightness to OFF for instance.
> 
> We need to ensure that the MDIO bus controller remains entirely
> functional since it runs off the main GENET adapter clock.
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: Ensure MDIO unregistration has clocks enabled
    https://git.kernel.org/netdev/net/c/1b5ea7ffb7a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




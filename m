Return-Path: <netdev+bounces-27541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813777C5A8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6BA1C20A0B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E517C4;
	Tue, 15 Aug 2023 02:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1B17E1
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2630C43391;
	Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692065421;
	bh=1pdl7jZPtq9JttB+pGHay7vyk18Q793l1mzx4Vt/EwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nGwHKOei4EmT/qh2b4OFRqgabg4JSkRpStz3hWRnliNh7P0UoEtK66BwtCxffNn1n
	 3lSnK6FoW0XBdUrkEPLi/+5zPwadykaEldMz2TDAjkDaOwSqC5I7JlEJfSnscUITpq
	 dbMDuD3HJA2taDxvXHqbi8S8u6aaP8N43Z4xRRYaWeWaVbbbsC8eimTgxc9dDqent+
	 y6MepV8ZZIP3ZkqpvZ8KM1nsCyDriHPi4ZjfYI7EKnp9ESA8eKLDlU5bwra8z6edQP
	 YgJPP4iPEyiTEHJRqJi6Hxn+58A8nhmJ4oWedGMfUrbF/Yvkg7CgwVS6XlhPuy3e9t
	 d7NvLQPiYWwFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE662C395C5;
	Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6060: add phylink_get_caps
 implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169206542177.7478.11235206564251294298.git-patchwork-notify@kernel.org>
Date: Tue, 15 Aug 2023 02:10:21 +0000
References: <E1qUkx7-003dMX-9b@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qUkx7-003dMX-9b@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, saproj@gmail.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Aug 2023 10:30:33 +0100 you wrote:
> Add a phylink_get_caps implementation for Marvell 88e6060 DSA switch.
> This is a fast ethernet switch, with internal PHYs for ports 0 through
> 4. Port 4 also supports MII, REVMII, REVRMII and SNI. Port 5 supports
> MII, REVMII, REVRMII and SNI without an internal PHY.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: dsa: mv88e6060: add phylink_get_caps implementation
    https://git.kernel.org/netdev/net-next/c/479b322ee6fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




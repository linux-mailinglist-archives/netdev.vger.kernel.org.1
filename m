Return-Path: <netdev+bounces-206003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F48B010B0
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED801CA2A8D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A027DA6A;
	Fri, 11 Jul 2025 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDmk07NA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E825A55;
	Fri, 11 Jul 2025 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196791; cv=none; b=rBduieIf+FNh3qIzu0ODub94sj7PCtz3nDufA99nIoQA29a01UkIokbhXcYcrd4RlATRrMdhdgLbGDpQGA3BlFm55eKEia1OXRqAtqGtIMaAjrPvQ6NNn8+CICdxBdnC8OAtHiiOFgCbZJMy0Vhd/tKMgtx/mvS6rSo+KJJT1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196791; c=relaxed/simple;
	bh=YTHuan9dVo8HXhOqdNc8EmP5jDwpAl/inx1SEzWRRBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IrZf17zYvee9YQtzac1V3PvhxFbsgXTHpnwkSNTL71dGhs0TU49dwm/q8GMVrL0QU92/TCzRrRjjcySnFb+iB7tAxMHkDPDqtxoB69B0uuYrt9NTu+dndRdHX3GNPEb9kFCcummmKV+BaeQ+LHU121YILrki1PDyQqlDno7WFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDmk07NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78CAC4CEF6;
	Fri, 11 Jul 2025 01:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752196790;
	bh=YTHuan9dVo8HXhOqdNc8EmP5jDwpAl/inx1SEzWRRBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IDmk07NAeKXtL21G7GhXQ6X/zGrOlos0xL4yRc4pr0VxX4Mwbd1bh1294u7yks+Nu
	 WgImfNffquqtRGyleIHHLRxg3Lsn6D93ks5sNS51f7DsVVwaXjvM6lI4OAmLOmkvNm
	 2wHdlf7lamnZuhIgHCRUwUgdDPFlGk/g3fey/dJYRNeN/Ox+6tw2g1lsr/Ru5tXyn8
	 PlpRXDjDAaeDS0epqHU06dK5UckTHz79bkMgIqJhBtOh16xOW0JFchu/MGNk16HlE0
	 81Ya4SVGeqseBYFopQq68A81jr0hCSdIC/8aMpaCfjL/CyDWs+ijU9pwKuZWuYXmFL
	 /k+eKTBPNWosg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF2383B266;
	Fri, 11 Jul 2025 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 0/2] net: phy: microchip: LAN88xx reliability fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219681274.1724831.17964478524607326355.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:20:12 +0000
References: <20250709130753.3994461-1-o.rempel@pengutronix.de>
In-Reply-To: <20250709130753.3994461-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, yuiko.oshino@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 15:07:51 +0200 you wrote:
> This patch series improves the reliability of the Microchip LAN88xx
> PHYs, particularly in edge cases involving fixed link configurations or
> forced speed modes.
> 
> Patch 1 assigns genphy_soft_reset() to the .soft_reset hook to ensure
> that stale link partner advertisement (LPA) bits are properly cleared
> during reconfiguration. Without this, outdated autonegotiation bits may
> remain visible in some parallel detection cases.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/2] net: phy: microchip: Use genphy_soft_reset() to purge stale LPA bits
    https://git.kernel.org/netdev/net/c/b4517c363e0e
  - [net,v1,2/2] net: phy: microchip: limit 100M workaround to link-down events on LAN88xx
    https://git.kernel.org/netdev/net/c/dd4360c0e850

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-213900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C0B27443
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B4B5E0E97
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847031B983F;
	Fri, 15 Aug 2025 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRxznj1e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE371B21BD;
	Fri, 15 Aug 2025 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219022; cv=none; b=kCdBnGrtzRvfUEEtxHUb6aHqvtrX+KQfP2H13Xc8QO66kpgIB73upOL32jCKA5dkCHAk76C1oM6LRnocILqiYpb7Aw8xMC7/kOSzD7X+1Maoy7/U1bBnlF3fXUmAIWFGHgzlS8UyTd6F093NePM2feey3Dym6R/UBs7cReOPzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219022; c=relaxed/simple;
	bh=MpbwWRBaPVqLQCanzj7ohTCLBxohi4LnF+nL+qVlu8s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B4bpOQclcWFEFyKJFa5UEzRx58WrTKAKm3YNgjcYinFjpsBujdBw6udugKWONQCqaWXcG3yJs2YCCFvJjDV6e8ToLElkyLdutPfp2di3KVIgirUvJ8mg/TAuOJVZem6Jd+oRobMJ2FS3d1Zwp/EYHoz+bJ6J6NuJ6OkEC/r8wlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRxznj1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C7C4CEF6;
	Fri, 15 Aug 2025 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219019;
	bh=MpbwWRBaPVqLQCanzj7ohTCLBxohi4LnF+nL+qVlu8s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GRxznj1etDswukm0HtUYH43SPzcXig1NfUhGAida3+4sBZBBfiEnStkSvlYEJva12
	 dsmJ5qOi/kLzVnMh1evsfTL+/Si+shoylS5iF+KYA48dlKOiKAosRTzpa1yvMW1NBi
	 Ca3bHq2vwnGRV4xdMS3+BtVIPcIGeeSUaj0+CS6v4UOwvQH6u0KxXXQoRnC8/YI9zH
	 aEuBv1Rm7flNDcyG62q/lD6OPH0//67OJwRMU3WLt+pk96VyFRpMOSHEi8LqHmkpco
	 b4758HqLTLAdbW86YQ9Wi9E/HRhwr7UhJPI0aepsYnhIWik4y+2FgnQQKoyHaGMiOW
	 tDWM6Tqf1EXgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B1B39D0C3E;
	Fri, 15 Aug 2025 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: mscc: report and configure in-band
 auto-negotiation for SGMII/QSGMII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521902999.500228.8086153832236304956.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:29 +0000
References: <20250813074454.63224-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250813074454.63224-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 10:44:54 +0300 you wrote:
> The following Vitesse/Microsemi/Microchip PHYs, among those supported by
> this driver, have the host interface configurable as SGMII or QSGMII:
> - VSC8504
> - VSC8514
> - VSC8552
> - VSC8562
> - VSC8572
> - VSC8574
> - VSC8575
> - VSC8582
> - VSC8584
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: mscc: report and configure in-band auto-negotiation for SGMII/QSGMII
    https://git.kernel.org/netdev/net-next/c/df979273bd71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




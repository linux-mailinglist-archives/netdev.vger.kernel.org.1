Return-Path: <netdev+bounces-250434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1848D2B23C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5240A3064FF6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46593451B2;
	Fri, 16 Jan 2026 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJKtcgVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EBE343D72;
	Fri, 16 Jan 2026 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536251; cv=none; b=PxuwTryFgTCUaofph7CKXZ9CqbKqidgHNkgJNT9AIlImuVj3UC/XkBXWdYR0hBHanRAAV+OJbntjVEt6hXbBJU/AqJWTr+okgvUiC+M6WcvKd9QwezfMWoPGdTxcApFkOlEvLYc99JKMvpGgxdxsg/PX4Rww8mo7I/FxaKIC5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536251; c=relaxed/simple;
	bh=u4mWPFY1k07Irj4JuSQvv+bIUy/2ATCv5FF0RJ1okew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ViCQ+jdZNQ1/ZioKob3YRg7C7O7L4F5EUQOSNJIwrYOYmsV5vLfApqld2XT5mk8RiUc8jUicN0keOt3ABPf35hqIb5N4SXUW1qdJdV64nZD8ZM3DWP5bpq+WETlwFScCCTh2NY3eAfp5M8EtTcZDcErKcv3k0+2/FCQlufb8guw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJKtcgVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58427C116C6;
	Fri, 16 Jan 2026 04:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536251;
	bh=u4mWPFY1k07Irj4JuSQvv+bIUy/2ATCv5FF0RJ1okew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kJKtcgVOoSv+wZsDw8a7ZqrfmHik65lPBTMMkQzrSGgdxGjp4OOd9o4OpelmElMwe
	 U9BJX17xOPuTVCcvObjVioZpopi/oxv/c/5zJqQNTrk50hNJp2lKvVvnC92omGLGGb
	 6f8M/C160HFe/CrGJS1fWZiHKioTxnIcxfM2Ynh1zsQO3rXC4RDYyELi4qzTrQuLPI
	 gtK/l12txGwNexxtzbU+PqwCLZX2tvuw8SrAz2WFLn7OFy+d2AtmODu3sGg+jUS0e8
	 UZO1rfauVAqGQ5tXzoXf9HtvOAspeJLwR0NEWbdA/6AT+n2PwJD2dG+o4wMoy0a3G6
	 P10bL4PFcCGsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A9A380AA4C;
	Fri, 16 Jan 2026 04:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: fix in-band capabilities for
 2.5G
 PHYs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853604327.76642.12472604625393596436.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:00:43 +0000
References: <20260113205557.503409-1-jan@3e8.eu>
In-Reply-To: <20260113205557.503409-1-jan@3e8.eu>
To: Jan Hoffmann <jan@3e8.eu>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, michael@fossekall.de, daniel@makrotopia.org,
 olek2@wp.pl, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 21:55:44 +0100 you wrote:
> It looks like the configuration of in-band AN only affects SGMII, and it
> is always disabled for 2500Base-X. Adjust the reported capabilities
> accordingly.
> 
> This is based on testing using OpenWrt on Zyxel XGS1010-12 rev A1 with
> RTL8226-CG, and Zyxel XGS1210-12 rev B1 with RTL8221B-VB-CG. On these
> devices, 2500Base-X in-band AN is known to work with some SFP modules
> (containing an unknown PHY). However, with the built-in Realtek PHYs,
> no auto-negotiation takes place, irrespective of the configuration of
> the PHY.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: fix in-band capabilities for 2.5G PHYs
    https://git.kernel.org/netdev/net-next/c/8744b63e8a9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




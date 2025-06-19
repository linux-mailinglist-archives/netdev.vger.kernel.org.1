Return-Path: <netdev+bounces-199611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AADCBAE0FB4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3135B189E08E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67E25D90C;
	Thu, 19 Jun 2025 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3e1COyJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89430E83B;
	Thu, 19 Jun 2025 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373390; cv=none; b=IsI0T7ZEJPHIh+G1tezmg0tZmn/aR21MZRvMCXPIqrqFhIODghXwJ5Zq7SgkCdZmS22y/k0lbER8qeziHeI8CLLIJBRGbL2owFwnoRALKh7D4zywTcrdZum7rwitv1EXEzfQqliUyAmK9uemwSzj6D1fLVJhsi01YJU1yw1cSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373390; c=relaxed/simple;
	bh=3LSGSLfVYsNvUNKP2SYZvQq460SV3V4VjelImV4scU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GOcTCQeyUoEYoajBsTZLW9XI/Gy8KozN+0WK7P4gUDfT+2ALoorjIR5QyBDPAZaTAE/m33U9tkRhAQjduPpne408nmM4BepQGF5JTQjOL3OJPmIL90MYbop/cxBU1VRTbt18JPP8451KcBpLfBGTEK5m3Pla1RxBeRJmNr8ikXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3e1COyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B0AC4CEEA;
	Thu, 19 Jun 2025 22:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750373390;
	bh=3LSGSLfVYsNvUNKP2SYZvQq460SV3V4VjelImV4scU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X3e1COyJf2ekc3KYU6rK2SEGb3AwODX70cpjWa32BR4xmPqF08VtJGBo8Ieo9HiGe
	 D+1o2NVNJGK+wsS+AlkFIksjy6Omi1+gcC6S5lyEGjRsA2vOkUqncu5o3hIE1ZkQ54
	 vaRJ11z3VOHLMFDQYtpO0DPaFA/at3m7KakP/HODQF4dEBgzJ62/TeCgb6XVLTmMZe
	 Re7i+vQNqltvAb5K7GtfKtwwo0MyTmQ9qYecD72YxmsVWzztQ0zPJbNBrLZbjtTNxQ
	 DtWYa2tEEcFbS5MIwxzffFDXnj4DCwSN9ZA2Xn80vp1O57n3c3nMzVuZxx6jcRptk/
	 SqcaG1eaEtHQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1FF38111DD;
	Thu, 19 Jun 2025 22:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/6] convert lan78xx driver to the PHYLINK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037341850.1010622.7477310203588526997.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 22:50:18 +0000
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
In-Reply-To: <20250618122602.3156678-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 rmk+kernel@armlinux.org.uk, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org,
 maxime.chevallier@bootlin.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 14:25:56 +0200 you wrote:
> This series converts the lan78xx driver to use the PHYLINK framework,
> which enhances PHY and MAC management. The changes also streamline the
> driver by removing unused elements and improving link status reporting.
> 
> This is the final part of the previously split conversion series:
> https://lore.kernel.org/all/20250428130542.3879769-1-o.rempel@pengutronix.de/
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/6] net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management
    https://git.kernel.org/netdev/net-next/c/e110bc825897
  - [net-next,v8,2/6] net: usb: lan78xx: Rename EVENT_LINK_RESET to EVENT_PHY_INT_ACK
    https://git.kernel.org/netdev/net-next/c/2c7fad8a9c66
  - [net-next,v8,3/6] net: usb: lan78xx: Use ethtool_op_get_link to reflect current link status
    https://git.kernel.org/netdev/net-next/c/69909c56504b
  - [net-next,v8,4/6] net: usb: lan78xx: port link settings to phylink API
    https://git.kernel.org/netdev/net-next/c/297080cf87a9
  - [net-next,v8,5/6] net: usb: lan78xx: Integrate EEE support with phylink LPI API
    https://git.kernel.org/netdev/net-next/c/673d455bbb1d
  - [net-next,v8,6/6] net: usb: lan78xx: remove unused struct members
    https://git.kernel.org/netdev/net-next/c/6a37750910da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




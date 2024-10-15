Return-Path: <netdev+bounces-135509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1443299E2A6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD96428311B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025131D9A47;
	Tue, 15 Oct 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsGpLfO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F71BE854;
	Tue, 15 Oct 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984026; cv=none; b=sgOO2e7vWP0YEH4CsJDa60pEiavzDNQMiQCV694TLP3IqcCNTKK4VCYYdAiKDiTeDsg1dt5xKcg6CkA7XG+8RFqOQDh9HvtITDgBvwrLZpZWEIX+0pw/KjVIyTtoIWGUk6M4eB+gDPmC0gBg9c+rYQo3G+3WfD9LvDZ8FZS0lIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984026; c=relaxed/simple;
	bh=0/2K0bhJeAkm6/7sg4ysryFBGytwQfnlFQcMiTWVRyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CB09PS0sbG12T3NoCepyrPcsKHczIj/E3bGOSiA5jTQMl79pDTabKSlN2I9rL7qUSV4p1/iIWnFtYOkSRTrvZCi6WSAlSQpkOn/uGqsnYxXGHnijUfd8IruVk7tnUhaaGKpL6UvOVubNZZNp/h4BrJgAvdDBwh+sxvBGhUOSl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsGpLfO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA02C4CEC6;
	Tue, 15 Oct 2024 09:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728984026;
	bh=0/2K0bhJeAkm6/7sg4ysryFBGytwQfnlFQcMiTWVRyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BsGpLfO479fGxceEcZN98XeYHDLTzPqQSEYLXEzIxF19jRpO20Lz+VJJYkfBblQax
	 el0vzmzm5wsZ3G9kXZItI9p30/NafDSpBxDSuHM7iPrrbrGkYlO2/MiUiUuk1asMaP
	 zcLFNYd8DrZcNxPjCoSQ3lp96ZUQTgywIuP4dlQa/iJMzOiyYd1Ul6QSQCYr3tR/Lx
	 NFaEO+U1LrjAPxOgNx64TJgewxrwsU7jtiQ8MewFfCh4WxDU25E4zE+D+CRfe0doZG
	 nNDg8MldmLw3sETnlJPDcU60dE8d1TOiKVsRMND4UvRhCY9LiHYqcrvtf81T/E2GIp
	 StvkJehS+Wpgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF853809A8A;
	Tue, 15 Oct 2024 09:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/2] make PHY output RMII reference clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172898403175.1090412.4776964842960064624.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 09:20:31 +0000
References: <20241010061944.266966-1-wei.fang@nxp.com>
In-Reply-To: <20241010061944.266966-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
 andrei.botila@oss.nxp.com, linux@armlinux.org.uk, horms@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Oct 2024 14:19:42 +0800 you wrote:
> The TJA11xx PHYs have the capability to provide 50MHz reference clock
> in RMII mode and output on REF_CLK pin. Therefore, add the new property
> "nxp,rmii-refclk-output" to support this feature. This property is only
> available for PHYs which use nxp-c45-tja11xx driver, such as TJA1103,
> TJA1104, TJA1120 and TJA1121.
> 
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/2] dt-bindings: net: tja11xx: add "nxp,rmii-refclk-out" property
    https://git.kernel.org/netdev/net-next/c/09277e4fc9a6
  - [v5,net-next,2/2] net: phy: c45-tja11xx: add support for outputting RMII reference clock
    https://git.kernel.org/netdev/net-next/c/6d8d89873ae0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




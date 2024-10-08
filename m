Return-Path: <netdev+bounces-133020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBC9944BE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780F61F22524
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199CF18C035;
	Tue,  8 Oct 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIq+O07B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D2173336;
	Tue,  8 Oct 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381028; cv=none; b=RYS3Knfdgg6942uduTs8mISwnyjGZqjf3denseD2BAioP8QASvmxXVXm7Epe7j9kwmqe21OiL0cnvyvUdgEsXLeR0FTZWBrUz21MoD/axwu1Ia/t96Au77h/X0/RGIgnnlTUT75kDPilPFSAQIfA9OlWH6Mpy4D7w92dkmvCBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381028; c=relaxed/simple;
	bh=XEm2ORiPKfTRSrw0KpulPUwOgoWHLL9ryCeASyTK1ec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZA1fTjl2D5hJRi0AU1ozRNcyFnudB0n0mzvtkaRA1Y036+t7RW9MwhlTeXM9V+0Unc5xTzaDsxGAO+6wjvmtS0Xkxe8cypTDx+vdoXX2XaD9+zXq6uaXCqyhDKFRGCeE+WO3vI1V5OpeBk2M+sdGVi9/YMsNE1UZWxvztUihJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIq+O07B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C444C4CEC7;
	Tue,  8 Oct 2024 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381026;
	bh=XEm2ORiPKfTRSrw0KpulPUwOgoWHLL9ryCeASyTK1ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MIq+O07BVQWa6upj60nCwdO1Qt7nViDEdOxFbQm+bk1Aye7F78rmUZiEjFvQKgGTv
	 ccujhfrgiLAfYrG16rAo3SoIi+G8UTvzlZ9x2yS8MyOFAJELNlX3Rdgu20NUxOIZaP
	 mxw0g+xJ7a3JYLvvFwK1yPZhx4d95j5hjFroMI6cfxlcrRe4jM0Yh+YzWzmdHldyN3
	 3hBm9eb5CaTpZ9rQjD9DXafrJC619vsIbUJYsb6icbKEEtbXTaGr2E7GLPwsofxeIE
	 dc6Jb3bSIlVOr82+MZcq7fHIPKEobwE/7K3s4sk46PUztdtVocnChZBlWNbmnTdFvd
	 LK2auw7HfBMtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD203810938;
	Tue,  8 Oct 2024 09:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/1] Documentation: networking: add Twisted Pair
 Ethernet diagnostics at OSI Layer 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172838103051.472898.7922396138133362766.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 09:50:30 +0000
References: <20241004121824.1716303-1-o.rempel@pengutronix.de>
In-Reply-To: <20241004121824.1716303-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, f.fainelli@gmail.com, maxime.chevallier@bootlin.com,
 kory.maincent@bootlin.com, lukma@denx.de, corbet@lwn.net,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk, Divya.Koppera@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Oct 2024 14:18:24 +0200 you wrote:
> This patch introduces a diagnostic guide for troubleshooting Twisted
> Pair  Ethernet variants at OSI Layer 1. It provides detailed steps for
> detecting  and resolving common link issues, such as incorrect wiring,
> cable damage,  and power delivery problems. The guide also includes
> interface verification  steps and PHY-specific diagnostics.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] Documentation: networking: add Twisted Pair Ethernet diagnostics at OSI Layer 1
    https://git.kernel.org/netdev/net-next/c/e793b86ae44e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




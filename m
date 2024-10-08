Return-Path: <netdev+bounces-133005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845B99441B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A1FB279AA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3D770FE;
	Tue,  8 Oct 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJbwQtgf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15F2566;
	Tue,  8 Oct 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378629; cv=none; b=SYzsimG67CEBVRTHn/tEe+04IeqNTXee9MinjBSrr6+k9eO36KfPenWwE8r5dV+zawSsEc6iBF+niqT8QXPLJc76PU/cPhKfID+3y6cocSueiV5UvoBv92fnK6V9QAPDcyk41nVEgFoWj7D2EqyVZ6WnfWD7cgwjh9l7VyDQa4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378629; c=relaxed/simple;
	bh=iuIxUbU2NfPT4USCHStLk58dF2v7gq0WCkoP1lrK370=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WYsEskKALvmWZU6Fbt+vffUMGWVjjpV44Rf5A+ZGnBIowXM4JqMIQkdWDIWK2fe8ThZ8DPk3NWWOU4dxPI3VxtewrQaeJMd/yPBBo85arWE+mva+qwMoIahiyxKkpc+YuQeHZle7edLb1cK46Ctm8SFNlD5q84kS1172pbbcd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJbwQtgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56141C4CEC7;
	Tue,  8 Oct 2024 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728378627;
	bh=iuIxUbU2NfPT4USCHStLk58dF2v7gq0WCkoP1lrK370=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cJbwQtgf6IkhXnSEnRj8Q1nZIeo/3rH4RxSYMTPws9Fh7EmDI+PFpGkDTqNKPcsmk
	 /9a+hwksl0WT4TW2uEFXy1+igf9ofyTKX+G7GKE0aiZrNhX420MdMHKFjKeatgQjLS
	 2iLHb+wD3ueobMm1giDCYtLHn5qv9wO4usK8YgqGn6HdjW3gkAfE5e34A9OEl1TPEB
	 +hWPc161BAIY8ZY/Euw2sa+CNukCGrETJcTsCgtfeX2f/vRNuiEI3WnXQKaHSA1jHc
	 VSxbC5fga2SndUy65zXXACmfKSMlFir67t35rEP+zgQzjtIaXh+XMWNEA1HzOYBXC/
	 Th2/NooTGl7fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD853810938;
	Tue,  8 Oct 2024 09:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] net: phy: Support master-slave config via
 device tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172837863152.459226.10784291070277874863.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 09:10:31 +0000
References: <20241004090100.1654353-1-o.rempel@pengutronix.de>
In-Reply-To: <20241004090100.1654353-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk, devicetree@vger.kernel.org,
 Divya.Koppera@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Oct 2024 11:00:58 +0200 you wrote:
> This patch series adds support for configuring the master/slave role of
> PHYs via the device tree. A new `master-slave` property is introduced in
> the device tree bindings, allowing PHYs to be forced into either master
> or slave mode. This is particularly necessary for Single Pair Ethernet
> (SPE) PHYs (1000/100/10Base-T1), where hardware strap pins may not be
> available or correctly configured, but it is applicable to all PHY
> types.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] dt-bindings: net: ethernet-phy: Add timing-role role property for ethernet PHYs
    https://git.kernel.org/netdev/net-next/c/31a9ce20fa8d
  - [net-next,v5,2/2] net: phy: Add support for PHY timing-role configuration via device tree
    https://git.kernel.org/netdev/net-next/c/20a4da20e0bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




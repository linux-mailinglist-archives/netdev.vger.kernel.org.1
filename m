Return-Path: <netdev+bounces-99248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D1A8D4340
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0050BB244F0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A8208AD;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmreo7DN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A186200C1
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034434; cv=none; b=Mjd03TEkaNpzsjMH2lyAi9OQUqTRHnllCtms4Voroy7wqc5gtR2nfX/vUSBFdq2UjanFMREOOtHDlPhgxmfzCI67KUCwKAwWGZFDodSKaM2txL3hBp7rkptauL0FwBexAmhcvgNIR4nwAeq9stl/KlEuspT9PqsljvZhJQBTP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034434; c=relaxed/simple;
	bh=E4P+l2PZq0o8H67f1m5niT+vrJI8McXbI43CalgS1/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CiK9Cr6QdxZIirAUf/yAjyZFaIojZfFxum+vqzga7bYftMG43aiXGqO7NvMfrQdR2gMdI8JQq2/5o5TE1JLibzkBolqnl3Ead5jfIy+uIZbJZVqXD883dDiWqYAvc8rsD7XCNFXBlYi1QemaJkoQi6Tf2+RTBgEzShCObaJbOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmreo7DN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40379C32789;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034434;
	bh=E4P+l2PZq0o8H67f1m5niT+vrJI8McXbI43CalgS1/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tmreo7DNad47rL8vbi+rfqNDSPHvcMBd0JGFWDSXPVw2r20ZEldEeuIlJu+UZ3Flv
	 +9QZEylsX19CZ876Mk67fyfFhmf9eyUxa2OkdGjgknpdCPnOpL+BmkSxLZdpzbuumP
	 1exi2mZaD3GTRl236q/gI0YfA2kz+IzAmn4r9iTfiNLCt9h6c8kUOPa1B0DXuBK/zV
	 Ub1f+Wl2+Ci6M/HgsXv4e+ZOxlpbvCeCbrdW0/crmZQaHl4yGLrQZfCJi6+DtnZ/Ut
	 Mlm+TtaxAxR/OWuT1+Db3EoykKYD2ik4OZXzirSFnTLDjTLRLzyd1n+9yl1x3SccYt
	 R9N5OMSzvo2DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34D73D84BCF;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: felix: provide own phylink MAC operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703443421.3291.3657268633743130112.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 02:00:34 +0000
References: <E1sByYA-00EM0y-Jn@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1sByYA-00EM0y-Jn@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, vladimir.oltean@nxp.com,
 claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
 UNGLinuxDriver@microchip.com, f.fainelli@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 colin.foster@in-advantage.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 16:15:42 +0100 you wrote:
> Convert felix to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Back in the thread for the previous posting
> https://lore.kernel.org/r/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk
> it was identified that two other sub-drivers also needed an update,
> and through that identical code in each was identified. In the
> final message of the sub-thread from Vladimir, Vladimir volunteered
> to pick this up and I agreed. However, I haven't seen anything yet.
> I guess Vladimir's attention is elsewhere, so I've done the minimal
> fixup for this driver.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: felix: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/ef0e51dccdc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




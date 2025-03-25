Return-Path: <netdev+bounces-177477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D9A704B1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512331894CB2
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0236025B681;
	Tue, 25 Mar 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSv+owgN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225F1B85FD
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915403; cv=none; b=TcwOThTmj7Ohf0w7awLg4IhD01tHm3Tt/TlPndzCFO9hQBdSelcRtM9wKd85lUGLEkzFQkNi4Z5zX3rQcPjNKn8CIRyBGV3lrpHtLaVHI7SDSrYJxJpmiuDy9TFVSVReGPASpy05vACMeiKevF6l2t+BJVG/dL74YlZfdcc1XhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915403; c=relaxed/simple;
	bh=LeTQS4831V5MzsLiMC9LAw9t50lIBowdpyY0TiML4j8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lsl9Zb2WJSztqUWGyE7uH4zJzDl9fQACH2ytrIJhBKmpYHwWMA+xSIaFugh6kJaBnC+zw0gpX3vWQS79J0aliJDGTvYC3g0I13l0UpQ2XLaDyBXtt7oeu+bvIhQPG9B2ZVUytKWpRAFLWFaRlen9RGaaljLgaAJw0cTPaVUWbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSv+owgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5FDC4CEE4;
	Tue, 25 Mar 2025 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915403;
	bh=LeTQS4831V5MzsLiMC9LAw9t50lIBowdpyY0TiML4j8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OSv+owgNR70SmVzshxqqtEMPZkBl/rNogjzzKsghyVHlQ28cLSkSU9S/GVwbqpgsq
	 hUMhkGTKbJ4QDckbTjwRefRsG3C+58481bAz4v/iuCcIHMWR6LXkqfwdV2bMHUywZM
	 5DLt3iDXsoGjGGu6GRI6rzgDeRTKkjRiC4ERjnzDbUyP5s7NTWOmL61d847gDli+aI
	 r86gRcsJ0VfBhzqFu4Wmg0kAuLtov8i/nSGY52Odk9mDRowrmnZmS8WfIkJwGDCFY/
	 sngqbstTr1Xy/huJRbp/lTdykx9mm7/aeG7I7zf37Rm5vsjWlXBPNTPtP1KESIqN1y
	 BinaN4QGIvxaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0FBF380CFE7;
	Tue, 25 Mar 2025 15:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: improve stmmac resume rx clocking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291543949.609648.15797575724114490670.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:10:39 +0000
References: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
In-Reply-To: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 22:11:06 +0000 you wrote:
> Hi,
> 
> stmmac has had a long history of problems with resuming, illustrated by
> reset failure due to the receive clock not running.
> 
> Several attempts have been attempted over the years to address this
> issue, such as moving phylink_start() (now phylink_resume()) super
> early in stmmac_resume() in commit 90702dcd19c0 ("net: stmmac: fix MAC
> not working when system resume back with WoL a ctive.") However, this
> has the downside that stmmac_mac_link_up() can (and demonstrably is)
> called before or during the driver initialisation in another thread.
> This can cause issues as packets could begin to be queued, and the
> transmit/receive enable bits will be set before any initialisation has
> been done.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: phylink: add phylink_prepare_resume()
    https://git.kernel.org/netdev/net-next/c/367f1854d442
  - [net-next,2/5] net: stmmac: address non-LPI resume failures properly
    https://git.kernel.org/netdev/net-next/c/ef43e5132895
  - [net-next,3/5] net: stmmac: socfpga: remove phy_resume() call
    https://git.kernel.org/netdev/net-next/c/366aeeba7908
  - [net-next,4/5] net: phylink: add functions to block/unblock rx clock stop
    https://git.kernel.org/netdev/net-next/c/ddf4bd3f7384
  - [net-next,5/5] net: stmmac: block PHY RXC clock-stop
    https://git.kernel.org/netdev/net-next/c/dd557266cf5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




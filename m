Return-Path: <netdev+bounces-187567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC9AA7DE5
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 03:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D285A3047
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4403C465;
	Sat,  3 May 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYBU9/NC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49192581
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746235797; cv=none; b=J1Hc3Fd7RJvwC3IARsLLLCe+wU1gD/YCZb05ITT6jWfkM7c10x5X6yZi+s5d9HSaSD9gF0Tf+N3XlHyV3bM/lJK4TRdlEHYTrYhqkMz3ubpq4wsmTBDuA9b4bH2fsbryDvp6oB80K4GDKOitvWCCkxHspjIaGCbeDNVXfFSsrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746235797; c=relaxed/simple;
	bh=ckSRd/Z1qnGR5wOXMVaoNwn10WAMsGKB1bQB2+988VI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dyno4T5J4K4eydZ1W2YxP8bNacnCC1F+4KvEBQCGBnuxTpmq45134F4tCjbaiuKuSMC3pOlRpoDfX01uchmF4XYyqYw3OoZ+caioGbFlf9ZsIClgKSi9+A7DqoIttoxgBC5YzbviK5zOjSKs8HHpT9MgNSrmgHz0GQEHwqHkpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYBU9/NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6C7C4CEE4;
	Sat,  3 May 2025 01:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746235797;
	bh=ckSRd/Z1qnGR5wOXMVaoNwn10WAMsGKB1bQB2+988VI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dYBU9/NCWhZT9cEjrZ/wwIvulZvVimgDEDPtNxu5T/H7Gzd8/Z64POfrz+Bvgbs6f
	 MB72dWx4d/9CklUKdQ0/rjWzddt9bhkzZMTrAYouMti9W0vwq+chHA8hilvNpJzTPG
	 0ApbmwCIEr0wIoHxP3W+WZmoFN3lWJubLBpSdz5UXOvB7olLl4REF3b3UlIKlO993s
	 j6Tn6Z58KboK8DCCdnVmKsIqGfhLihnTtvfGDL1R23dsZf4DijJSBlumm6M3R86z8E
	 0vfPmCv1lHOaZoX5p0i9E0RcInCPYY5YzuaCsyBKWhI7njUoY6EPykgVxR5O9mHt2H
	 Q4oDSB9UI4/cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C66380DBE9;
	Sat,  3 May 2025 01:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: stmmac: replace speed_mode_2500() method
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174623583625.3773265.4045311227752993763.git-patchwork-notify@kernel.org>
Date: Sat, 03 May 2025 01:30:36 +0000
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
In-Reply-To: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 1 May 2025 12:45:21 +0100 you wrote:
> Hi,
> 
> This series replaces the speed_mode_2500() method with a new method
> that is more flexible, allowing the platform glue driver to populate
> phylink's supported_interfaces and set the PHY-side interface mode.
> 
> The only user of this method is currently dwmac-intel, which we
> update to use this new method.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: stmmac: use a local variable for priv->phylink_config
    https://git.kernel.org/netdev/net-next/c/5ad39ceaea00
  - [net-next,2/6] net: stmmac: use priv->plat->phy_interface directly
    https://git.kernel.org/netdev/net-next/c/1966be55da5b
  - [net-next,3/6] net: stmmac: add get_interfaces() platform method
    https://git.kernel.org/netdev/net-next/c/ca732e990fc8
  - [net-next,4/6] net: stmmac: intel: move phy_interface init to tgl_common_data()
    https://git.kernel.org/netdev/net-next/c/0f455d2d1bbe
  - [net-next,5/6] net: stmmac: intel: convert speed_mode_2500() to get_interfaces()
    https://git.kernel.org/netdev/net-next/c/d3836052fe09
  - [net-next,6/6] net: stmmac: remove speed_mode_2500() method
    https://git.kernel.org/netdev/net-next/c/9d165dc58055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




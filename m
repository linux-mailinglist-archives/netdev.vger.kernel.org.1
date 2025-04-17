Return-Path: <netdev+bounces-183581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D4A91147
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEFA19077B3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5346A1B0405;
	Thu, 17 Apr 2025 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGlMmei8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA72184E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854018; cv=none; b=G/0hjb3NSncgeseWn6Pur3kwYhYSXKG8tRIGD6HETutzUZUutpn4Ob9VVf3XE6EuIaHVLigtylEW26/OBS0NeIQOs6KihI2j/hTdGPzheimrBQo1CMjoh3xv0V4plq2+pGz7MYRPl6+hDEuQtsp2ppZnmqRwWP1GoKhJ7c3QglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854018; c=relaxed/simple;
	bh=UoCuiaGvDBeZSmxO3zSagieMB01Bk1UlqzL8YeuKlqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ruq9NRCLnvj7VqoJEJ5ZS7uPYQgE+W3lpcJnHMuUnsWmcWz5s5biwX9VhvTQCHDXM00YVOrOzl7r76QUTIy67nLnUCtcZ3YYzw9fDXNzcwp6yw+v726nENo+/+EsOcN+6I3eR5Q7mmcZopQidN0bTgBdkyOgmGSm8hQtiCjAf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGlMmei8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E85AC4CEE2;
	Thu, 17 Apr 2025 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744854017;
	bh=UoCuiaGvDBeZSmxO3zSagieMB01Bk1UlqzL8YeuKlqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZGlMmei8xjtxQyO6x4K3hletTYTm9UxXges6gJQHhLUYnbdxutkvIw2eyEy76Reps
	 iAe94TvZSef60IabGBW2/KCK7o07LQ2zeqGLrFO9ToPFvQQyARVjqVGiZ5jfMRwUic
	 hNyd7id0u5XLeC9pp8IW+X/FccvQwQ6Rs7P0dXb1DE0BdsfOwFCQX9IsvDfC5Ojdjq
	 q9r3DXaqzHSS6tY9LSjaJm8ycfsyqdnagIC+e4SaGROsleRRRrCgHa73O9pCNeKBNo
	 wJFbA76HTCVUr13N9JLtlW5V8Lawhqo0Id57jkmQNU7xSwHADxO+q5Ly7idtT+y/YR
	 8BcEYKP6h3GDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD203822D5A;
	Thu, 17 Apr 2025 01:40:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: stmmac: sti cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485405548.3559972.7306929702229052794.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:40:55 +0000
References: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
In-Reply-To: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 17:42:39 +0100 you wrote:
> Clean up the STI platform glue code.
> 
> - IS_PHY_IF_MODE_RGMII() is just a duplicate for
>   phy_interface_mode_is_rgmii(), so use the generic version that we
>   already have.
> 
> - add init/exit functions that call clk_prepare_enable(),
>   sti_dwmac_set_mode() and clk_disable_unprepare() as appropriate,
>   converting to devm_stmmac_pltfr_probe().
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: stmmac: sti: use phy_interface_mode_is_rgmii()
    https://git.kernel.org/netdev/net-next/c/72d02a9f9410
  - [net-next,2/3] net: stmmac: sti: convert to devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/403068c6c9c2
  - [net-next,3/3] net: stmmac: sti: convert to stmmac_pltfr_pm_ops
    https://git.kernel.org/netdev/net-next/c/b3334f9f708c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




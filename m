Return-Path: <netdev+bounces-212738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF8B21B8B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66045174AE3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E572D9EF3;
	Tue, 12 Aug 2025 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="halp2w/8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48FB2D9ECF
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968800; cv=none; b=Xd0b1YI0vd3Ld9pKSqdgM27U5JEHEt695wwlWYXVmnFGN9Nfd0Kq1DeItQgK71wj2C5Nh4FbaO3VBNSpTXoKiJ0kQACNZlxdpiQa+dhH9gJWMEEyk7MCE4emEbiuIEmzDCyXhnMPCqaLEimAtkV0t+RJZH5N3YocW9tclAW+tUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968800; c=relaxed/simple;
	bh=6A+jeyPnXO4AX6ZcycgzjX1K4rTdQsKw738pZ+L6V6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I4OL49KIzaBjezgrEj9vYxVcXXwnpEtDm28Ad+bc4diIN8oB5q18dSaUb6H7nJ6UEMi4Sghi3WiiMg5f3MHcFEfT/81U7xtnTBvkEdL6Jtirv69dKQA81SmKL1UK/ofQV293tyG3dVziC0xVYPfJCFuhI85P05RVJjTmNEremPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=halp2w/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3438C4CEED;
	Tue, 12 Aug 2025 03:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968800;
	bh=6A+jeyPnXO4AX6ZcycgzjX1K4rTdQsKw738pZ+L6V6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=halp2w/8T0gvAzda6uNomNpUXHnhiG6miLpGMs1Ys53r8W/N4R2ccWOxIdvct14ta
	 Y0rY4PE9oLh6DauJzq+PB5cFu53b67nXF4KzfSKpMEjeJGCcIa4nKDSaA1Ml91drmy
	 Y4/AUu9PgKOw9idpCrXIZZ0m0qKcuUeofMMZsgpQzCJCzMM2R3/zCqJs2PShyWcZNj
	 L2mRj/PR8Jxf3ScUKCILXuZx97QDEWc6jBBQNi4hcFKRPDV2wPKajw1pR1pYuC3jhJ
	 cbl7r5y3TkbA92bZjieH5TAnxn3N9qSEad/8O8D6ZNj5z/nCz72p31Dt3u9PVIOmK6
	 Hhuv9L8A8soQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B35383BF51;
	Tue, 12 Aug 2025 03:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: rk: put the PHY clock on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496881199.1990527.5027010954317382429.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:11 +0000
References: <E1ukM1S-0086qo-PC@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1ukM1S-0086qo-PC@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, david.wu@rock-chips.com, hkallweit1@gmail.com,
 alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Aug 2025 13:16:34 +0100 you wrote:
> The PHY clock (bsp_priv->clk_phy) is obtained using of_clk_get(), which
> doesn't take part in the devm release. Therefore, when a device is
> unbound, this clock needs to be explicitly put. Fix this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Spotted this resource leak while making other changes to dwmac-rk.
> Would be great if the dwmac-rk maintainers can test it.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: rk: put the PHY clock on remove
    https://git.kernel.org/netdev/net/c/de1e963ad064

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




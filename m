Return-Path: <netdev+bounces-163491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D4A2A6B3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F67016887E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746922DF91;
	Thu,  6 Feb 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax4G5C+h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DB227B97
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839614; cv=none; b=QkA3LSjq7oe6NR0Z3XYau3P1Hy+S1n+cfMjMb1UNdgTXbFMdeH+VVTS5GnrdpGLgsIbjo/+muX3DFohH9m0FRUx9K0wVgMq8OzR12kWCRfTQ1+lDkSkvsAsDhoOgUfOatbBqXa4j/YjgV947Hk6+3ONXqCpnuILAQl/Cp3PTaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839614; c=relaxed/simple;
	bh=lpTq10HbuJat5mBzaHY7lLZhSBugc0nzpDwYi/R8+iQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S6nYd0r7vblGnRa62yheyNKyo/unLSZNtOtnbNSOlwBiXL/66PTe8tmDKedAM+asg3fkk7QBnM5M1JoVFiBeTRyb3itRlO3WJwKaVsG1IdGXuHDyRyR+hzSDn6Y0yvHTmxiyEcjxhRmFgdlpxqBlgSaWoM/ZRmyc7fUTb7Zh4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax4G5C+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577F2C4CEDD;
	Thu,  6 Feb 2025 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738839613;
	bh=lpTq10HbuJat5mBzaHY7lLZhSBugc0nzpDwYi/R8+iQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ax4G5C+hTI0afgJ6/cr2y/a4AUwUJ4g+kNwm8Dsa3XpeD9nt/pgkpsTVS3tRZlbwf
	 8VLnoip3vbmsLgZWgteQ5HZtN4FHNanLP0WNF1N/bomBqY+NrqtQalLYRQdypUUWuG
	 gpV3om44hnB8MaDMGeM+NvKoJovBoZQ2Av9qZiNPWNvAcnJI3ujRjAJL2C/bnmithC
	 d966pUTv+lvT/VRHvDDvPjMp6qLkyW36A5lHWrbWiFuU4pCI3LvHUSbx7lyC11DyZm
	 eIHgm7+RchhLBXeviGRS4c0riVHwtI9xwQuIxHnt5ImsKKPCzAH6y0yy9U/vbHSqdp
	 cyOLrWyAJTT2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F0F380AAD9;
	Thu,  6 Feb 2025 11:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net: stmmac: Specify hardware capability value
 when FIFO size isn't specified"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173883964070.1434316.3945736866379293001.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 11:00:40 +0000
References: <E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 05 Feb 2025 12:57:47 +0000 you wrote:
> This reverts commit 8865d22656b4, which caused breakage for platforms
> which are not using xgmac2 or gmac4. Only these two cores have the
> capability of providing the FIFO sizes from hardware capability fields
> (which are provided in priv->dma_cap.[tr]x_fifo_size.)
> 
> All other cores can not, which results in these two fields containing
> zero. We also have platforms that do not provide a value in
> priv->plat->[tr]x_fifo_size, resulting in these also being zero.
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: stmmac: Specify hardware capability value when FIFO size isn't specified"
    https://git.kernel.org/netdev/net/c/2a64c96356c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




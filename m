Return-Path: <netdev+bounces-238834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB7C5FEAF
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987F33BAC42
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4C619EEC2;
	Sat, 15 Nov 2025 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcMTQWxz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636735CBD3
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174444; cv=none; b=HFHVeBZ1iujxEfDu+T3ghJHBU0rSmNlq4pROto3NntBNa/YNF39G2mMgTNUUBMcynKCiv2LBRWqgUSyxNia+C2XxQgwQBIHqdnzIIjbDe+o8roEO/vQAxWqokoYMXiroyaVebfzYl8j1pVd9RsrI0fDFGU5jKIcakZm1UtwmaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174444; c=relaxed/simple;
	bh=FsDd8OSRS1boKHVWER5PG2YUTZRXls0/bADOA6JY/pU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H/LebdA9kNWnkgcOC9l63gFCsNTLgrgOP4H6mHtDDo/NqkxTncq44bFJUojTkyp6H7a7GEdCuz/SaKE2uCoknr4i2euG0ukJeQKuQyhbBoGOSoVkkNdBh0N5PhYpo+EkepbRioVYrckp9lZOEzMPXGSj2M0S79Jtm6mevZXj5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcMTQWxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95060C4CEF1;
	Sat, 15 Nov 2025 02:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763174443;
	bh=FsDd8OSRS1boKHVWER5PG2YUTZRXls0/bADOA6JY/pU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JcMTQWxzJFH3zV8FtzNtiE+MXJ1ME/2xY9p13ILTSIxmpCrtP/mTB2/EoQ8rQTNyO
	 8HAEEFb/3lRkkLfo69tKXVBt2fPVtQf3FUdQKOQoHshkYVPfLwPyrTiYH9pIqzOoZw
	 2GoNgSSXuuR6cZKqTsa4XqRr0OfQF8Q9me1LuoTeobgFnK5NG9lHUje8qZMyZqhkwv
	 TzEwmaaXqYeMcWyG3SUSwePS3UbWDZFPwBszJuHCUJr55TWW4ky9MeM1nnz1tUeai8
	 afSiU0jeB0pm0spKensp0YkzN2mFjqbJvanuyoPC04HREhGSrByF6IOKpVUZ/BiLPF
	 FNw8jEVewMYzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E203A78A62;
	Sat, 15 Nov 2025 02:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: stmmac: rk: use PHY_INTF_SEL_x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317441200.1916016.12907239609584301623.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:40:12 +0000
References: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
In-Reply-To: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 heiko@sntech.de, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 17:46:16 +0000 you wrote:
> This series is a minimal conversion of the dwmac-rk huge driver to use
> PHY_INTF_SEL_x constants.
> 
> Patch 2 appears to reorder the output functions making diffing the
> generated code impossible.
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 245 +++++++++++--------------
>  1 file changed, 109 insertions(+), 136 deletions(-)

Here is the summary with links:
  - [net-next,1/4] net: stmmac: rk: replace HIWORD_UPDATE() with GRF_FIELD()
    https://git.kernel.org/netdev/net-next/c/ebb07edf9738
  - [net-next,2/4] net: stmmac: rk: convert all bitfields to GRF_FIELD*()
    https://git.kernel.org/netdev/net-next/c/764ebe423ef9
  - [net-next,3/4] net: stmmac: rk: use PHY_INTF_SEL_x constants
    https://git.kernel.org/netdev/net-next/c/5e37047f745b
  - [net-next,4/4] net: stmmac: rk: use PHY_INTF_SEL_x in functions
    https://git.kernel.org/netdev/net-next/c/1188741cb5a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




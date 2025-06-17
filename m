Return-Path: <netdev+bounces-198828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D006FADDF69
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795E8189DD97
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA82957CE;
	Tue, 17 Jun 2025 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeY+/BRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADB295531
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201813; cv=none; b=Ub0mOtvFcME5hO9J6OwbkS7F+WEBLp4bJxgugyhSz35Nnm3FJ2KdT5ePPf6ORIMdciX2r+hmxnQ/28ixSgS43sA3wmaScgOIHLL77lQ1wGlVCs56Or2VnT/pKlVrboADqUSdjYBlQTXR79pi/BuQ3RJo4Dt7Cp0rkAwxmKMEi1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201813; c=relaxed/simple;
	bh=NLmZbAINQrKpTqQpqNfxPgtqEb0sB7XeT47yiorXI6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YDSi/XO6fyNytGPklLNOlVfZVy1HqbCjBJ+viT83WAS6bkvfykdF2to8d1tPCLh5APrIy9BYmN7iA5pEQ7HseKyqUA+ibvWq0g2foyJULgwgApjHMPnphJ0MFkN+2kXT77K6qgVY6uAEe0mJs1LxyD7eNgoQy7O+SrDbDuicld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeY+/BRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328ACC4CEED;
	Tue, 17 Jun 2025 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750201813;
	bh=NLmZbAINQrKpTqQpqNfxPgtqEb0sB7XeT47yiorXI6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MeY+/BRnKSJtQIpfkUgm5S90dpg8BaAd3E9/X4zxA9F3zdFVm0v82Low6gsBPBOHe
	 iFFOjUJp1giTMHEe0SPayfjJOKYUIxYagHv0n+AAF2ilgYK90TtH9zlfBog6ugcEP4
	 WGcwTuQGzAKLT2wW8gItRfMw2MulwZU5f0u1o+1KwDaGyGvmel+8JA6h0vXVDdI8gk
	 l9MlsvBi9aRk9Ja+hujhrKFI28BcH+xjVLN2PqAHEsl+vVZhgrIub71qvkzsxR9Jo8
	 O87Frd6uUIw9izt1Omd0Md27fdFbmaeiOWUrV/l5WX85U49iWn+A4vTD0mJzoCV/eV
	 HsEiOX7K/5QfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB638111DD;
	Tue, 17 Jun 2025 23:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: stmmac: rk: more cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020184173.3730251.3213755803607439009.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:10:41 +0000
References: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
In-Reply-To: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 11:16:18 +0100 you wrote:
> Hi,
> 
> Another couple of cleanups removing pointless code.
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Here is the summary with links:
  - [net-next,1/3] net: stmmac: rk: fix code formmating issue
    https://git.kernel.org/netdev/net-next/c/a44769c97e9a
  - [net-next,2/3] net: stmmac: rk: use device rather than platform device in rk_priv_data
    https://git.kernel.org/netdev/net-next/c/8f6503993911
  - [net-next,3/3] net: stmmac: rk: remove unnecessary clk_mac
    https://git.kernel.org/netdev/net-next/c/cf283fd6b8be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




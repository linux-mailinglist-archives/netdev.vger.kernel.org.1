Return-Path: <netdev+bounces-215127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2EB2D25B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51742188D95A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D998235BE2;
	Wed, 20 Aug 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guq1KpVB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650521CA03;
	Wed, 20 Aug 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659471; cv=none; b=H++i99rym7IA+PjG4+F/6kc03Vs4gfyiPL+VpwA5VHw/XaHTo4Vzq7ErAEW6Y1GPuKP47TI3TEX+C7GoUcGhDJxGDuhh+9/JcKp3GX0VTUctCqlaNjPvgLHWxVkFr/Vvqii1OgBVhOrRfGEvSk7oeQZN01xtcT32HV/jjBKxBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659471; c=relaxed/simple;
	bh=LT6R7YJMHT6UyzzmXs+K8jVBtoOfXB2lShI26qQTqQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a06Q/ujEm4UUjEP/Leck8HOs8LiCV9DVpHLdXBfPuNMB+A0/LvM56VvCbli6k7yB8MaSy3SW9tUNeRy1aI33FMtNcVmnF+CE9qrGwccB/2jDUzSbJnHoHFY5ZXdudXYo6aajG7MO7IU1ejk+jwfgZ0E01GOlHqfiQd5f0CBvaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guq1KpVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6E5C4CEF1;
	Wed, 20 Aug 2025 03:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659470;
	bh=LT6R7YJMHT6UyzzmXs+K8jVBtoOfXB2lShI26qQTqQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Guq1KpVBaz/G8CtBEhQKgWrgqUlrQKotSfNI2Q85lxBeTlbHZZvUJbUsUzI2vcc+3
	 45j3WHGekslcbh9y4jRfceVANTQ+gygfoR9REOWo4xBjFOAhH72Y+vcABZ41m3ELhy
	 JcKrXxPmL3JVSPQXOU/fC1+T/jJ8SevE+1jx1058rm6fO4bLTyg8EONK2B0mDHNAJn
	 bLpC1p/fq2VpqwferGqBtMgIWKSCUImg9lDkUD1P8pBckaoeGVdStrnfN1BgQr7wxE
	 39wPjIvjbuozCQ7398TuXTjOm6dHOpDebNoizr0KWrjXQEZh3lQEmEkFqOcNe9bGNq
	 9LE+HKbciszsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7D383BF58;
	Wed, 20 Aug 2025 03:11:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: thead: Enable TX clock before MAC
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565948024.3753798.258151801285164029.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:20 +0000
References: <20250815104803.55294-1-ziyao@disroot.org>
In-Reply-To: <20250815104803.55294-1-ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>
Cc: fustini@kernel.org, guoren@kernel.org, wefu@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, emil.renner.berthing@canonical.com,
 jszhang@kernel.org, nux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, rabenda.cn@gmail.com, gaohan@iscas.ac.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 10:48:03 +0000 you wrote:
> The clk_tx_i clock must be supplied to the MAC for successful
> initialization. On TH1520 SoC, the clock is provided by an internal
> divider configured through GMAC_PLLCLK_DIV register when using RGMII
> interface. However, currently we don't setup the divider before
> initialization of the MAC, resulting in DMA reset failures if the
> bootloader/firmware doesn't enable the divider,
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: thead: Enable TX clock before MAC initialization
    https://git.kernel.org/netdev/net/c/6d6714bf0c4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




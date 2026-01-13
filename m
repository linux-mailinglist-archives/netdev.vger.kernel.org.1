Return-Path: <netdev+bounces-249297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D3AD16854
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DF22304713B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C434AB03;
	Tue, 13 Jan 2026 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRIwHmg8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF02DFF1D;
	Tue, 13 Jan 2026 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275228; cv=none; b=gMY0IjWZb9s0cW4KBAmV4Vid2JxxA4UQ9xF3AC9WUA//RCB9Yzujg1DHPmrrO0yoh4RQ5shr5rFde+GsykoSQVFuNvqEZMzF4ap65x4TXsjvbnKNlATqevszVqvZcfJdP8TJ2LRI/ZWvgGG3WFVimpCR7FMfqkp4pw3NV83nun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275228; c=relaxed/simple;
	bh=KPmm7bq3E3SkV3QKIe1hRYRDBqOBhOsYpoXUummIvV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TSuqYvLgN/3OtD+TysF1dweycMumQEvLgPvmcbJ8Fz1UZAXsKyh20NfqxRmpm3fphk2Lb1mTq69WJLyaX9CSINWBzGOAw8F+8i2Q5sghmiFhgsUVkYgmBqPmOSkZSf+7TgQQtd6hNQIZ026egTXTopCltur8ODhbElSczdJRgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRIwHmg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D62C16AAE;
	Tue, 13 Jan 2026 03:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275227;
	bh=KPmm7bq3E3SkV3QKIe1hRYRDBqOBhOsYpoXUummIvV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VRIwHmg8cD9M9i9ebgJoC5/7EU33y4RrM7FeTAZXuFfuVyNoStCA/2al2Y8iyPfTD
	 d5O0+88uvWNnvfYF5KfocLr24mXPFNsFVocf7q5KPkjVckLz8mQpDb8kkhHjioPeOX
	 87injzyZjmcMTofaPCWgxHqxHRSCNLKeUhCxeeo9fKA4ynk1/Jagx4VZhGaEnSZ2hX
	 3NpMr/HwxaVjzcyR99dlr2yTKxNj6IdfuRa74CP2l8DzxAtxFs3z7FMJdFG020GLy6
	 e1DIbZgfDqh/s/h1yCxalnbatKzj+ayJajM/n71VwcAoeXV0R8CxLev4805EQk1nQ6
	 m1F2e5Inj3Vyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5E0E380CFE1;
	Tue, 13 Jan 2026 03:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next v6 0/3] Add DWMAC glue driver for
 Motorcomm
 YT6801
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:30:21 +0000
References: <20260109093445.46791-2-me@ziyao.cc>
In-Reply-To: <20260109093445.46791-2-me@ziyao.cc>
To: Yao Zi <me@ziyao.cc>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Sae@motor-comm.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, wens@csie.org, jszhang@kernel.org, 0x1207@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jeffbai@aosc.io,
 kexybiscuit@aosc.io

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jan 2026 09:34:43 +0000 you wrote:
> This series adds glue driver for Motorcomm YT6801 PCIe ethernet
> controller, which is considered mostly compatible with DWMAC-4 IP by
> inspecting the register layout[1]. It integrates a Motorcomm YT8531S PHY
> (confirmed by reading PHY ID) and GMII is used to connect the PHY to
> MAC[2].
> 
> The initialization logic of the MAC is mostly based on previous upstream
> effort for the controller[3] and the Deepin-maintained downstream Linux
> driver[4] licensed under GPL-2.0 according to its SPDX headers. However,
> this series is a completely re-write of the previous patch series,
> utilizing the existing DWMAC4 driver and introducing a glue driver only.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v6,1/3] net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
    https://git.kernel.org/netdev/net-next/c/365e649361cd
  - [RESEND,net-next,v6,2/3] net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller
    https://git.kernel.org/netdev/net-next/c/02ff155ea281
  - [RESEND,net-next,v6,3/3] MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue driver
    https://git.kernel.org/netdev/net-next/c/40ca42c8429b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




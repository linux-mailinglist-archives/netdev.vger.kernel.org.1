Return-Path: <netdev+bounces-141374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922519BA996
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD262819AA
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB50189B99;
	Sun,  3 Nov 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5y1Se85"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BFC2FB;
	Sun,  3 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677221; cv=none; b=S5cz0knfvsXyFDvI61Jazj7Kx/NNrQubMff+yI6BSx5NWrUaWBCepCM3PlIeaZzEMFKyFEEXsNIVP9wFiR62oEpL6q38dhUYpG/ixei6xpYxdh8+IYlNpXVmhZUj8PPv7ikTUlRtfeVvapQor+x0RFvBAw+eDe2rGvuwyAM0mBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677221; c=relaxed/simple;
	bh=Fpk5/6wEk3/C7/XnnbdYZqJeyR/d7QRxg8mqahUQje0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BasMC5G1dSFyf3uIKdUFo7+cWhJbbLFUTI/1GLkNHLY75Z/M8lgMvrlnSXDpb7ipkG/oWFa5PIOhd/x90xVnlwSw3V3AkxpSoQ/Q94R2YJNsvMby1dy5iAZpb7ZYKOfl882JM/SjfkOFwRONZWxbAeZQzuDeoOz5nvp0x68dHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5y1Se85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4216C4CECD;
	Sun,  3 Nov 2024 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730677220;
	bh=Fpk5/6wEk3/C7/XnnbdYZqJeyR/d7QRxg8mqahUQje0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o5y1Se85YGaNi46PIpCG3IAkB/9cfCO/zEuGXlPlNZl44IP6NkIteQYvLzdTIAxRu
	 6j124vRpxxT0uN7ViTo3CPUOUJ3/xksJhw+Zvf6w6Tcak/WGnDAKFloGWQheOy1JyP
	 +wGBZMCZnoiULs2q3l6i44ZmJtXrRYmlHOw0FHVBs9sRHzCc1ahZ4fCCo9Ydr7eH3U
	 qIQbXAH8hPHHBy5pjYvMjtjX/lQhEqDlzSuj8crVR+5Spb9HIf6TzC0w653QcdBlO2
	 sA5pqauaU3x89iv2hAz6B4rWkmZz1vOuXfBwHIYnQkJ/0UMBkaMrPZUtRznqnsjAC/
	 AuEanAEtsqQ3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710B738363C3;
	Sun,  3 Nov 2024 23:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/8] net: stmmac: Refactor FPE as a separate
 module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067722927.3278663.4571680407072079402.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 23:40:29 +0000
References: <cover.1730449003.git.0x1207@gmail.com>
In-Reply-To: <cover.1730449003.git.0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 olteanv@gmail.com, andrew@lunn.ch, horms@kernel.org, andrew+netdev@lunn.ch,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Nov 2024 21:31:27 +0800 you wrote:
> Refactor FPE implementation by moving common code for DWMAC4 and
> DWXGMAC into a separate FPE module.
> 
> FPE implementation for DWMAC4 and DWXGMAC differs only for:
> 1) Offset address of MAC_FPE_CTRL_STS and MTL_FPE_CTRL_STS
> 2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1
> 3) Bit offset of Frame Preemption Interrupt Enable
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/8] net: stmmac: Introduce separate files for FPE implementation
    https://git.kernel.org/netdev/net-next/c/2c6ad81de163
  - [net-next,v8,2/8] net: stmmac: Rework macro definitions for gmac4 and xgmac
    https://git.kernel.org/netdev/net-next/c/61e6051f4bbb
  - [net-next,v8,3/8] net: stmmac: Introduce stmmac_fpe_supported()
    https://git.kernel.org/netdev/net-next/c/af478ca82204
  - [net-next,v8,4/8] net: stmmac: Refactor FPE functions to generic version
    https://git.kernel.org/netdev/net-next/c/c9cd9a5a834c
  - [net-next,v8,5/8] net: stmmac: Get the TC number of net_device by netdev_get_num_tc()
    https://git.kernel.org/netdev/net-next/c/2558fe30ae8b
  - [net-next,v8,6/8] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
    https://git.kernel.org/netdev/net-next/c/df9e7b0250ad
  - [net-next,v8,7/8] net: stmmac: xgmac: Complete FPE support
    https://git.kernel.org/netdev/net-next/c/b440d677e15f
  - [net-next,v8,8/8] net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio
    https://git.kernel.org/netdev/net-next/c/77be7d737305

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




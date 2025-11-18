Return-Path: <netdev+bounces-239374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5276BC6742A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1063364DDF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5B264A77;
	Tue, 18 Nov 2025 04:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHr0Uw0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE61459FA;
	Tue, 18 Nov 2025 04:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440259; cv=none; b=k9Zfcog4Kv1oyWqXC/0uXLHlzrUFeL/GfDC2gS5CnkGFut9UamW4hxGCrvEj0m4Ayd4rZVCSsH3N98dVfL18FxWtJXYvn2wq4q9GfZ5EgR3zksHsx6UMgnRrMFEwHhdp7qacSNOqrwSNmpExZJQXRqePSxptELgSI+14kzoLGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440259; c=relaxed/simple;
	bh=b0tK/QFOidIQQqfzTvlAPr1kSgWygac/TGHNviqWPbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LfWQ4sFJUgok0ont+/wk3W6QRTxdz+waK9VUoyycEVjSPagO+fj28Hfr4cEY4fvOn/yGOc6YsWhKOcffQgTAnEOiIs69Yu/L7aynOtKjDBnvDQSEH+8Vwa+cgzssLOM6vBrc1Mna/hflZy+HbJykIzhxdCsoMkeQO756TWFk7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHr0Uw0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C70AC116B1;
	Tue, 18 Nov 2025 04:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763440258;
	bh=b0tK/QFOidIQQqfzTvlAPr1kSgWygac/TGHNviqWPbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kHr0Uw0Bjoa7ZnKIST07TsbWvMUE7coMCj+Mn+sszlvaBiJPkR45qgQEmyH0T33cJ
	 vwa7fSHLmtvdybBP8E9lnjb8zlIqCfSaX1NxNseYS5YrH/eYTQd93gQ723mIJBV310
	 ZgzPP2k+/Xwc8SWo1C8oQKmD35q/G2YJdMssggnMOVtQw7aqQiGRvccfxmBHeg953M
	 0mgNR3xgmJveKIbcHjMeyrqs4AmOtS4MG5/K829TC3wKSShgH5UwTqFEe9F29OXhvD
	 WAVk2GvaqYjeqeBkHMB5Sl/2kk+3JcERe3sAQQzaOTFgSRZZMBfuqugbkGF6/7/xR1
	 +DPh6QTK1f7Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E143809A1E;
	Tue, 18 Nov 2025 04:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 0/3] net: stmmac: dwmac-sophgo: Add phy interface
 filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176344022426.3968687.3804479598141783177.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 04:30:24 +0000
References: <20251114003805.494387-1-inochiama@gmail.com>
In-Reply-To: <20251114003805.494387-1-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: rabenda.cn@gmail.com, uwu@icenowy.me, wangruikang@iscas.ac.cn,
 ziyao@disroot.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, unicorn_wang@outlook.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dlan@gentoo.org, looong.bin@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Nov 2025 08:38:02 +0800 you wrote:
> As the SG2042 has an internal rx delay, the delay should be remove
> when init the mac, otherwise the phy will be misconfigurated.
> 
> Since this delay fix is common for other MACs, add a common helper
> for it. And use it to fix SG2042.
> 
> Change from v7:
> - https://lore.kernel.org/all/20251107111715.3196746-1-inochiama@gmail.com
> 1. patch 1: fix a mistake that using rgmii-txid instead of rgmii-rxid
>             for SG2042
> 
> [...]

Here is the summary with links:
  - [v8,1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
    https://git.kernel.org/netdev/net-next/c/6b1aa3c87fcb
  - [v8,2/3] net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
    https://git.kernel.org/netdev/net-next/c/24afd7827efb
  - [v8,3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
    https://git.kernel.org/netdev/net-next/c/db37c6e510de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




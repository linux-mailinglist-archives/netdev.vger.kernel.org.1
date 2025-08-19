Return-Path: <netdev+bounces-214979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E82EB2C6A6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CE61888959
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06876218AC1;
	Tue, 19 Aug 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apcXmVfa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3B20299E;
	Tue, 19 Aug 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612596; cv=none; b=dKTmC4TtSSLPVE0geQ5dgHDXCnmSaKriEGeqxmSjnFXqx6xGgsVVOHnhkgMnHIFyvkpdRzEwlmGaCvg8nwDH2h2kt6o4gzI0Z0oLzmuuqXf1uG527yoV1TNnAzQwnIO65k/lrNvTqcQMjJ2cW0t4ylf85Xfrcg4yWDZ+ToVOGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612596; c=relaxed/simple;
	bh=C9R2a3UImpDUwLItRbJv/q0jFqTxivYVJ3q07lWXyDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IEYKgStUKpHruEPKIOLo4ej9FgpgN16ITblWw5brRph+F5lbISptmm6RYGq/rGrSR/QtLTAGJpcUun0GsKDv7eNrUu6JPU88PF/l1eXgOSKLshrRxzL8hWhVnLOPe40SXeKD7UZXOMSFiEK1SxBBMGSVFcpWdxWEtfontBZ8yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apcXmVfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6344EC4CEF1;
	Tue, 19 Aug 2025 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755612596;
	bh=C9R2a3UImpDUwLItRbJv/q0jFqTxivYVJ3q07lWXyDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=apcXmVfafje+5HvFMjxEsJPOn0tFF4tPGhw+16QWPs9YoiW7GpcOluBCHsrNrvBRG
	 bTE0og6J8sNXAkgXhPbt7zfNaUsrzssFfPn8ffER0/+EXGoTsq/ddbWaarIK6yA4Xb
	 /LhNUMpMA8Mmz5J04vhLzSbQdXAEXfwNzAG97L8U7nl2Bvopemdu77tyXfpnMASV7h
	 Cx59/ziGZ0FI2TRo8APi/jWQ+KruDxim9jvZ5QuCdR+DAWf+YYLHvVxK1Mldd7UtYH
	 T11iBytdeNXR/ghlc3bmyeaTleuZ1TayMWmBZXv/prdaKy7hrDzp3XC1tgLs9h31Yp
	 aC4LQzgR9fYFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71057383BF58;
	Tue, 19 Aug 2025 14:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ethernet: stmmac: dwmac-rk: Make the
 clk_phy
 could be used for external phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175561260627.3565986.5334175865969423538.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 14:10:06 +0000
References: <20250815023515.114-1-kernel@airkyi.com>
In-Reply-To: <20250815023515.114-1-kernel@airkyi.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, jonas@kwiboo.se,
 david.wu@rock-chips.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, chaoyi.chen@rock-chips.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Aug 2025 10:35:15 +0800 you wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> For external phy, clk_phy should be optional, and some external phy
> need the clock input from clk_phy. This patch adds support for setting
> clk_phy for external phy.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy
    https://git.kernel.org/netdev/net-next/c/da114122b831

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




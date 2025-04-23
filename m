Return-Path: <netdev+bounces-184960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F2A97CBE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 04:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EF117FCDA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A81F17EB;
	Wed, 23 Apr 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfcvWSod"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121C14A06
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745374790; cv=none; b=IaiMxOg2F3pXNXhj8dA+yTU4uldFZ5EyXG9Z+bkdZy+gFvU943ocgbPPJouq1gXtfIxvZhOdOeBGmDcw9pQcuGc8SMf+zAUBahx1sMCL00+xtGEoQ4Rk1pvPYPKK/ov6cEZWpqbNvEYazBYYH8TI4dZ1HAs5dR38QeWBAfDVKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745374790; c=relaxed/simple;
	bh=PmqJ5fbv0Mb9f8TlIqRagmhuSF46zrJ7usQ1IDVuaXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S+u5yyEF5DNRzW0dDAtLTuTkEponzwuTvlPpL04lzfzvw70bj6j9s2KpPx7QGO8K3tCbriHBZJeUS/gvaM84fjzyVu0AfCDTfdZza8DGu9tykHQduH2kjnDMnxOxgLSq1P2N38HG4cxlvpi91z4D7KxZwoee5XrAVuvJ+8aE1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfcvWSod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7268BC4CEE9;
	Wed, 23 Apr 2025 02:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745374789;
	bh=PmqJ5fbv0Mb9f8TlIqRagmhuSF46zrJ7usQ1IDVuaXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nfcvWSodfR9C9TKP3Gi15gNNyd4MIUK7B2Qgrdtr4CpFYjzCYQ4dispyNAct3JVnb
	 POFVgOA6ZBsQ+tKt9hFpfCStJ5CIx8m4hzGp8+0C0kwB1tV7MsEZYLg/luOUrYBTpL
	 QPosVAOjBf37Oyco78m4AD8++24zmFkRTZGJ7L3w2QYNerdHHif1x9OXxR1yMfc+81
	 nHN2SM4gDqpigTm/TP1UcYnGZ40C8Z+FCPFVoIUpU4GZWHXdjsfE4TVlbQYQuVTch3
	 XsLTTIdWXqwBv/+6n0AVJJb7mkAdc3HzrP2UB3UggSZACiHBB3M//OL3TKq6DObdQl
	 tg+1dA4c7xIUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D86380CEF4;
	Wed, 23 Apr 2025 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: stmmac: visconti: convert to
 set_clk_tx_rate() method
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537482800.2117251.2809618036505175108.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 02:20:28 +0000
References: <E1u5SiQ-001I0B-OQ@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u5SiQ-001I0B-OQ@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 18:07:54 +0100 you wrote:
> Convert visconti to use the set_clk_tx_rate() method. By doing so,
> the GMAC control register will already have been updated (unlike with
> the fix_mac_speed() method) so this code can be removed while porting
> to the set_clk_tx_rate() method.
> 
> There is also no need for the spinlock, and has never been - neither
> fix_mac_speed() nor set_clk_tx_rate() can be called by more than one
> thread at a time, so the lock does nothing useful.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: stmmac: visconti: convert to set_clk_tx_rate() method
    https://git.kernel.org/netdev/net-next/c/21b01cb8e88e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




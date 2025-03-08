Return-Path: <netdev+bounces-173138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDBFA577FB
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF684177784
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9A418787F;
	Sat,  8 Mar 2025 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN9oY017"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC6186E2D
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405217; cv=none; b=AQ4VNBu+yrQReGQHPz78k27Pz5sw8OD01d2LY70eUjgZlemYwk38eMP9xTbxcezNo3PuId90NenYBBz7MHcAlpVyC3dnm9loyt3Q9VvsMTQRdYqLkzGUjOtbnGdo0JY68odGQRlSoib1ovEmOutNrfaW35btJqALx1RMRYpco4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405217; c=relaxed/simple;
	bh=/1551EvwFLFRJgDZVyhrnnVaVXrnUUlMvSTMNOwJ2lU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YLjlKPex4bgljmiXFGugYxvm8HxKz9D6Un6US1cASCxZVOael1aaDsw+7NfqXsiisvqQWXIPZ7dtj4MyVPNGMiWkJ+MmvOEhnIfMXlRAYdO2pxaXQLCq+tGEq10Qezh7DMnjkfScytJBMOaLbUzzQ1Wn7QZOmBZIhRVUIxBbM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN9oY017; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61973C4CED1;
	Sat,  8 Mar 2025 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405214;
	bh=/1551EvwFLFRJgDZVyhrnnVaVXrnUUlMvSTMNOwJ2lU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fN9oY017Ls8+PnLtnXlkLqnk6xJ8SIsGVkNRV7njjgGQunqPJ1J3CZshucoLnX7fq
	 34gDS4FJM05Udfnjt83J+sk/d+WcNTHZEa4eEUDcVLpHLRBMb06QIdNB4+ImB3zjDX
	 DulC7OrPKKo7TYefkXHYNY1laYXghgaRJmjQBF5SDfvhL2AOBzXtvj2iwnAGeeSF0l
	 2egyiTsIls2QcjHWcqtVyO5zu/rnP68+jCaioXLrQJmP9W8EibmxD0RVk2diDCOhAj
	 mcHuzyjHAggi1DmnxNe4S4bN0eGw84zo7d5MPm5V7ZtvGhzAGgpbYO+xZDMJfKkb4v
	 TFvhu6ilXUfnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D93380CFFB;
	Sat,  8 Mar 2025 03:40:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: remove write-only priv->speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140524774.2565853.6497124340077503983.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:47 +0000
References: <E1tqLJJ-005aQm-Mv@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tqLJJ-005aQm-Mv@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Mar 2025 00:11:29 +0000 you wrote:
> priv->speed is only ever written to in two locations, but never
> read. Therefore, it serves no useful purpose. Remove this unnecessary
> struct member.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 1 -
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
>  2 files changed, 4 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: remove write-only priv->speed
    https://git.kernel.org/netdev/net-next/c/64fdb808660d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-144422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6CB9C704F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F3A1F250E3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB01FB8AC;
	Wed, 13 Nov 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMubksJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FA433CE;
	Wed, 13 Nov 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503425; cv=none; b=hSq/OPLGXiDZ2vXqrTDLZShF+Mwp1m8R63GX5WzECho37Z9gFYrFswT/KRsZZFZxPZ6RyiTVY3gfzuIEn3QE26HSERmoRggMvfRxb6UVy8YQeEa+gp88CM6zjGDOkIEUDSMdSst+hE4v81sveShmJrA7QWo1Gi9ZyxicJ2m9MaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503425; c=relaxed/simple;
	bh=9vr6tI1szK5Unm3lwJO3ytVbP8bZ0zDKkxo9WexlNH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hGiWCzh1f1CQjuAUo+GSEh4NYWIBcRYGrNKY7yNWi64ni2eeQbmieWTfw1CN9ZCImtVI4EHU1pF1o8aqb1Fxcu9rCo9Zr4ekCG550fI37i6rCxlhAJW+pgWGZm3tSxYiEBZJshn4U5rGUIXd5w3K2PZGk1afuF/tlNU0RylKz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMubksJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCE4C4CECD;
	Wed, 13 Nov 2024 13:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731503424;
	bh=9vr6tI1szK5Unm3lwJO3ytVbP8bZ0zDKkxo9WexlNH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SMubksJfwYxg+9zGeltQjFzmBmYTJBju+k1u/Tu1qPf13N5Yp9X8Q45o2vYXcIix9
	 nn4Lm5dL/c7u1pT1zgESdBXv5ZT+IetT6RbEURWGrYN5d5J2U4zmdZFBGOzWYuymFb
	 LkwtL2/eWMr13rNoyiGDw1UuyL40R7YQs51cGOgvKBvbBBG0eu90/kGurELdWmb1Tl
	 v7EZy6m6On8KaUQM2zZ9IN/XaD/EBpBlaep89bwOQgxQNir5rF1nAxdQLBzoTTLmFG
	 hXdZ/dnMt8XHQ79pyI8c8izfjmfVJJxqpKPWVjWrUBA03fiJmDbAMO+H6ST9Nh1bL8
	 nNysmcmSDOySA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAD3809A80;
	Wed, 13 Nov 2024 13:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] Re-organize MediaTek ethernet phy drivers and
 propose mtk-phy-lib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173150343476.1214780.13147107754252375046.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 13:10:34 +0000
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
In-Reply-To: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
To: Sky Huang <skylake.huang@mediatek.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Steven.Liu@mediatek.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 9 Nov 2024 00:34:50 +0800 you wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> This patchset comes from patch 1/9, 3/9, 4/9, 5/9 and 7/9 of:
> https://lore.kernel.org/netdev/20241004102413.5838-1-SkyLake.Huang@mediatek.com/
> 
> This patchset changes MediaTek's ethernet phy's folder structure and
> integrates helper functions, including LED & token ring manipulation,
> into mtk-phy-lib.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
    https://git.kernel.org/netdev/net-next/c/4c452f7ea862
  - [net-next,v3,2/5] net: phy: mediatek: Move LED helper functions into mtk phy lib
    https://git.kernel.org/netdev/net-next/c/7f9c320c98db
  - [net-next,v3,3/5] net: phy: mediatek: Improve readability of mtk-phy-lib.c's mtk_phy_led_hw_ctrl_set()
    https://git.kernel.org/netdev/net-next/c/477c200aa7d2
  - [net-next,v3,4/5] net: phy: mediatek: Integrate read/write page helper functions
    https://git.kernel.org/netdev/net-next/c/3cb1a3c9cbaa
  - [net-next,v3,5/5] net: phy: mediatek: add MT7530 & MT7531's PHY ID macros
    https://git.kernel.org/netdev/net-next/c/219cecbb3e86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




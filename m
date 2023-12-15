Return-Path: <netdev+bounces-57742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD556814050
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E2C1C2225E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275B10E1;
	Fri, 15 Dec 2023 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRwSWnt1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37602ECD
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7985C433CA;
	Fri, 15 Dec 2023 03:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702609225;
	bh=HFaFjJvn/zq+F9S8iOFXH+H7RIjwp4YVAC4Ez/fj9kw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZRwSWnt190fNNHVTC3f2cD8oBU0YuPrKQm8oKqSN71w0Qmdw1djYEJoyDSHqdv3rp
	 zayMubTqKovd+cOHJOBgXYik2z5BsfTwaHA9xYP3PID/Wad9GRQiVJG55B94xHNVId
	 338x1YYb684uihxafx+SFDJAKePI+/Z2HC0xX8tBCjJYC1Rx60m3rJMW7qorDEHiLm
	 DE7XSNE0/g6twZKR6jrJusVU+y37FaEIvSooj5CafryFsjnkpBzoBIqOvFi3+mnmK5
	 ylL8IYV2Ma1glcG82oE0cfEsWMIQTw7a1T2ypAxvPiLqjawWd/uto7Yvi6eNe7uzPp
	 j0VAvSOMYH3vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 997E2DD4EFF;
	Fri, 15 Dec 2023 03:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] MDIO mux cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260922562.28655.4681247726760762836.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 03:00:25 +0000
References: <20231213152712.320842-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231213152712.320842-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Dec 2023 17:27:10 +0200 you wrote:
> This small patch set resolves some technical debt in the MDIO mux driver
> which was discovered during the investigation for commit 1f9f2143f24e
> ("net: mdio-mux: fix C45 access returning -EIO after API change").
> 
> The patches have been sitting for 2 months in the NXP SDK kernel and
> haven't caused issues.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: mdio-mux: show errors on probe failure
    https://git.kernel.org/netdev/net-next/c/d215ab4d6ae8
  - [net-next,2/2] net: mdio-mux: be compatible with parent buses which only support C45
    https://git.kernel.org/netdev/net-next/c/10ad63da5c03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




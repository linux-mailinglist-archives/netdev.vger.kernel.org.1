Return-Path: <netdev+bounces-177478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD5A704AE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE081708D8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853125D1FA;
	Tue, 25 Mar 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw5sPzUV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3C25D1EA;
	Tue, 25 Mar 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915405; cv=none; b=MNolyxxSzTVnd7S3w0wp2dRAIoterr0JVq0Obcg0i2XdAmR8KcBRbUHt7wuwnJHxSfd41IlqYscII+GDEsCHe6b0IeZzGfX6clrziuvoqKRcPETD3DiaxRls8aRNd95+IncUjX5nxG3nHcZa0hXM9M1wRzSIoF2wnpVkkjpWBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915405; c=relaxed/simple;
	bh=rM2cEQEVYKda9LgagA18a6qU64i4bQNXa6hgu74L26A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mBg6KodpQ9BFpbHKCu8Xf0LrAb28KgStA2binSAQRrW5RtPheoZ++KpsU4br30OFw9p3ijjN1dcaAqvn7i/e7t8jrsTu7k50xzuU1/u9lDEPrmNN6ob+hTsDGyDsx4PUeT+XScSQ/SvpRqgzl1TDLbq+e5I34gS1kYmv1AaQvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw5sPzUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB9EC4CEE4;
	Tue, 25 Mar 2025 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915404;
	bh=rM2cEQEVYKda9LgagA18a6qU64i4bQNXa6hgu74L26A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qw5sPzUVhPHUW9fD/il87+6z83Jw4hwaJrAGTBy9CUiqw3koPQWc9H/VQKqDTpEBV
	 lXc88fT5IhlMVkV+F0G/kg8fb83Tpq931IlK+GqHe/rEujg345ZUB7aok1aGXWMvuu
	 xIcn8DgX/oczkCxpSFxf7KsqehTQt6JdYIbjrHhTZpqi8xMsTkD+m1N0AX8d7CvoCp
	 JZqSVQuFj65qOGbT/kOqgpeM0+ddZTzn1kryyBXmf3yaWWBMFNcWIBMEIDUpNn2B7I
	 d0NwG3K9seJJEMRpMlunFvX3Kh/BWShA1U3y70fqWV+S7aBwKfecwr7/Pv5IkGho+h
	 SMrIfjj19viBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34F0D380CFE7;
	Tue, 25 Mar 2025 15:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: stmmac: dwmac-rk: Add GMAC support for
 RK3528
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291544076.609648.8594782943472190694.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:10:40 +0000
References: <20250319214415.3086027-1-jonas@kwiboo.se>
In-Reply-To: <20250319214415.3086027-1-jonas@kwiboo.se>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: heiko@sntech.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, david.wu@rock-chips.com,
 ziyao@disroot.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 21:44:04 +0000 you wrote:
> The Rockchip RK3528 has two Ethernet controllers, one 100/10 MAC to be
> used with the integrated PHY and a second 1000/100/10 MAC to be used
> with an external Ethernet PHY.
> 
> This series add initial support for the Ethernet controllers found in
> RK3528 and initial support to power up/down the integrated PHY.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] dt-bindings: net: rockchip-dwmac: Add compatible string for RK3528
    https://git.kernel.org/netdev/net-next/c/1b22f686f199
  - [net-next,v3,2/5] net: stmmac: dwmac-rk: Add GMAC support for RK3528
    https://git.kernel.org/netdev/net-next/c/1725f0eb37d6
  - [net-next,v3,3/5] net: stmmac: dwmac-rk: Move integrated_phy_powerup/down functions
    https://git.kernel.org/netdev/net-next/c/0bed91f2b183
  - [net-next,v3,4/5] net: stmmac: dwmac-rk: Add integrated_phy_powerdown operation
    https://git.kernel.org/netdev/net-next/c/32c7bc0747bb
  - [net-next,v3,5/5] net: stmmac: dwmac-rk: Add initial support for RK3528 integrated PHY
    https://git.kernel.org/netdev/net-next/c/83e7b35c7879

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




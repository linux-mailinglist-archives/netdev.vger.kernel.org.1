Return-Path: <netdev+bounces-174502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA155A5F04E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF423B3A58
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81360264FBB;
	Thu, 13 Mar 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNtyegOu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533EE264F8C;
	Thu, 13 Mar 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860599; cv=none; b=DfWd9el/1KZqleaPw3RCU1iUFfxiHZcjQSGrUkwxM+efPlDiqAkpJAK0IKFWVq01Vwbuxb9ItxVZOcZFyiG+V4B5Y1AX6/XDHF+zsXRWLos+x5arGMqA6HR+4J1oDBrTM/0Ft1w8N91L/4hsDAlxRcZ3hgtEubdytdkv1EZLIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860599; c=relaxed/simple;
	bh=3ia4Sn6jj2l6liyurFbn7ply3ehwt3UFgJmXXXgNixs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BAeCIi0C/aW4z+Cc4sZWOsZhrYzKiWZa0ygDyMa7kJZWKWCLVDA+NJGvl4juuHtoEjTSp1VuVTj8054OINDMDecsDxyCg/XwJ5XX3dSG6BW8LD3557ldPtC6zqT3RbwEVD9lu66mKeEyU2nkt8+Ge+nLHzHMwR/ZpJ4HOyAY/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNtyegOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D0FC4CEEA;
	Thu, 13 Mar 2025 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741860598;
	bh=3ia4Sn6jj2l6liyurFbn7ply3ehwt3UFgJmXXXgNixs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNtyegOucLPnqQ38sjFfRNvvezBFC4y9FCkZcmFH2kWyqiF9R/iS7BkNuRtP3S1u8
	 KiHhdWl+mGBJJgaazt2AOesNpi9zIdIn6Y2kNzPavbAbR/mhddZP+hfwrbL/MyJD0M
	 B5K+82CiclQzGCs5NcG5cmWHeT9EaK7aT6tuJMY0wROiolOBKIfPuYbNIVacqCkbA9
	 10oEzXg6zG2/IklQ50xj9u9uu8wnkuJuZh363iPIHrTVHmuSEtSc2OQkojILJLibqZ
	 +yWBS6dIDSs65QEkQMUVTmw6PadG440vJqMvbAJklNP2QyciSbI8g7DWPZ2zpIdJFB
	 h9C7azPak9Qcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD63806651;
	Thu, 13 Mar 2025 10:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] net: stmmac: dwmac-rk: Validate GRF and peripheral GRF
 during probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174186063226.1446759.12026198009173732573.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 10:10:32 +0000
References: <20250308213720.2517944-1-jonas@kwiboo.se>
In-Reply-To: <20250308213720.2517944-1-jonas@kwiboo.se>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: heiko@sntech.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  8 Mar 2025 21:37:12 +0000 you wrote:
> All Rockchip GMAC variants typically write to GRF regs to control e.g.
> interface mode, speed and MAC rx/tx delay. Newer SoCs such as RK3576 and
> RK3588 use a mix of GRF and peripheral GRF regs. These syscon regmaps is
> located with help of a rockchip,grf and rockchip,php-grf phandle.
> 
> However, validating the rockchip,grf and rockchip,php-grf syscon regmap
> is deferred until e.g. interface mode or speed is configured.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] dt-bindings: net: rockchip-dwmac: Require rockchip,grf and rockchip,php-grf
    https://git.kernel.org/netdev/net-next/c/313cf06ef4de
  - [v2,2/3] net: stmmac: dwmac-rk: Validate GRF and peripheral GRF during probe
    https://git.kernel.org/netdev/net-next/c/247e84f66a3d
  - [v2,3/3] net: stmmac: dwmac-rk: Remove unneeded GRF and peripheral GRF checks
    https://git.kernel.org/netdev/net-next/c/41f35564cb71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




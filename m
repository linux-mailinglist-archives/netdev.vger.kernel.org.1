Return-Path: <netdev+bounces-158654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC8A12DDA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D71A188772A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84E1D7E3E;
	Wed, 15 Jan 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGSRAZzm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82FF1D61B7
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977208; cv=none; b=SWagcSp6k2tP2HIi3lVqm2xHs5s1xusQrV67Y0W6dt4nvmkQOWLHdtHjTnBZOEDKK66KrgRVAdbDrED5U7zOzPTUf4uVpKWlv9arvn6quP6bekjoaEhlyfKQO1e9RSMqmw/azmtkBWbakCPhpAySEkXoTPfb9N5dZyK5C9tBo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977208; c=relaxed/simple;
	bh=gut49WiCKxX4n39WuHEwRqu0ukBnMA0KGglJN1AgLgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D4pky7ZgcpHsV6xkzGgmQ4TORl4C/ljQ3urYlX55dUSdwnWr2g73DXIpDVj4OdzGdcNgfY2bfbvZX8JifZ/KRiro/WXc7RlyURr/ej69RQPyMn63FF+s2N6hlC8J6iMVft43GE4x8l3O26L5Duv6dyy/PlsbG1xY/k3hLuFUZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGSRAZzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2F5C4CED1;
	Wed, 15 Jan 2025 21:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736977208;
	bh=gut49WiCKxX4n39WuHEwRqu0ukBnMA0KGglJN1AgLgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sGSRAZzmIyhDs4sd/QqsAgpVUTyeuTv+Qi8kffEeh4cqGUweFtBwQ5sbDVTKyzhmm
	 d+RZqRowZgcryVBscafmimbAScgW648X5+A7PABsUk5Npk6qWHxPUXPOcKh9bSJi7B
	 r3k6cJptdfUmMiamKD3T9bYoRa960D+3J5h1nNDxzNtI9ylGAo8tVABWMarrmSH7M5
	 KBrDhcLO1NuYDd2uUQte2pbu0GzW4F1Ynp3HXfpxgVZShMTeufXluw21tB1fxN54c7
	 Le16QiWyAqexo3Wqis190bE6jSx3ZErqsAPz2Ota8TJZSZ1AWpMYre8mlrFU0VIagN
	 Rz8HCdmMpg3Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711ED380AA5F;
	Wed, 15 Jan 2025 21:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: xgbe: re-add aneg to supported features in
 PHY quirks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173697723128.888488.12904892558277541822.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 21:40:31 +0000
References: <46521973-7738-4157-9f5e-0bb6f694acba@gmail.com>
In-Reply-To: <46521973-7738-4157-9f5e-0bb6f694acba@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch, andrew@lunn.ch,
 linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Jan 2025 22:59:59 +0100 you wrote:
> In 4.19, before the switch to linkmode bitmaps, PHY_GBIT_FEATURES
> included feature bits for aneg and TP/MII ports.
> 
> 				 SUPPORTED_TP | \
> 				 SUPPORTED_MII)
> 
> 				 SUPPORTED_10baseT_Full)
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: xgbe: re-add aneg to supported features in PHY quirks
    https://git.kernel.org/netdev/net/c/6be7aca91009

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-145502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C939CFAE4
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0441F250E9
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD01AAE33;
	Fri, 15 Nov 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnD9imAr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2211AAE23
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712223; cv=none; b=chYNyiYaw+XeeYOpM5ZtOhVyayaihoFIjAmON9PuX8ea1rqtaLzLapxxf5s09W3AouiOHrHBa717kROAswD5/m73MhHcr1w3aLNqTsoP/TJkZ5Ja7xbwDnlqa2Z/XErB4/ONlLY1qVOt1vXswVG5Q0BY9/UEXL1yTn9tr6wC9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712223; c=relaxed/simple;
	bh=oCUKF6cBt/4O4d/cz5YmO/ity7sBkaZwVFnz8Fvltaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c+AKaaVuK5h6NfPbHs4r88OCovfvtcTmn9TGrjXTtycttzJYain8O39jrXmcxT058n2JHMYTOwbxsY8Fh+JxkMHuQMwkBzgwsANGliGjTkacApjv71goOfW/kz6XvJ3e7w6OF9hW6lbOEJKltMtaQrbtlUp05QHrERWkTYYJMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnD9imAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75B5C4CED2;
	Fri, 15 Nov 2024 23:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712222;
	bh=oCUKF6cBt/4O4d/cz5YmO/ity7sBkaZwVFnz8Fvltaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hnD9imArQJXhFMdPiWEr8qnY/XRBuXHFWiYaQO8THiarSaBsXbTPhapzLrBfc6Zpc
	 K6REoQ9LujG6GXUCdMp7wNVBnuI9ruyZvO2WxrOw+AScYmX71iWVNmxa6dWTeiBr3t
	 0tcWJlWTOhzwAxxqheRZ9NHq54ELRRGg5p6InVAv+oNqAZVujtobyjJQDO9YemgQxR
	 U2T7J7wKcQWH4KR9MRrnkMX0D1uMS6hr3pCjVJKBhzxgcC2swafQp6uyvC398iAIkD
	 5UETQnQgsHGOW/HQXnfZw4c9F52Nnq/rMY1wJF1I/BW+xCJ+tClr6khHdXC58onvTq
	 Gbk/rOGz65uMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC593809A80;
	Fri, 15 Nov 2024 23:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: fix phylib's dual eee_enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171223323.2762542.9633235764277517210.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 23:10:33 +0000
References: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 10:33:27 +0000 you wrote:
> phylib has two eee_enabled members. Some parts of the code are using
> phydev->eee_enabled, other parts are using phydev->eee_cfg.eee_enabled.
> This leads to incorrect behaviour as their state goes out of sync.
> ethtool --show-eee shows incorrect information, and --set-eee sometimes
> doesn't take effect.
> 
> Fix this by only having one eee_enabled member - that in eee_cfg.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: fix phylib's dual eee_enabled
    https://git.kernel.org/netdev/net/c/41ffcd95015f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-243695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DC1CA5FED
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 04:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02FE230C48F8
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE52BD5A1;
	Fri,  5 Dec 2025 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEYAknZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFAC29E113;
	Fri,  5 Dec 2025 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905000; cv=none; b=iobkEcpegTdGL4XNBu4mtPpzrZgBfb5ZAaBtrDj1Iuny1ikFis5MxH9gyhScQTdkMHmeM2U0g0KK7WRiQoPuz6sPWYWCKwsekqO/WJ7JRzfaL079n7QFGZl9u4p3sl4mC3ncrSp7wa65OdYMH8zB/uV4f6K/wABy7O2EB/qiYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905000; c=relaxed/simple;
	bh=d4/ZDFQyRlkt1RU41iBWWaqBDRFgPFWAm3GzxfH2Whk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gk2pMGBb1KTIkfpM1JXsjOUggAupfSiUk/T+FlOI7yww5hqqdfcMPpvui4zIspOiXZuAfAhcjp3U7baMWoVsN4QY/oBpsmhS91LAhpP/N0Q8ZJ04AxlMWjHFz3hfuUyMpf2OwCPLedbkIYtPrJqSJizWYq6R0rFI3+EHnxskxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEYAknZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4579FC4CEFB;
	Fri,  5 Dec 2025 03:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764905000;
	bh=d4/ZDFQyRlkt1RU41iBWWaqBDRFgPFWAm3GzxfH2Whk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lEYAknZKyBf7UO2RmW3Fz7zY7YW22Je9ZQ76Fbon0ZKyhChC2w2sLNJVshX/ftqdW
	 YMhxzrLpzMXFrXGRu9Tw/gjhj9LY5uytzkO0x2e/e9q0O5GjLBGnvNqihyh0Ey/Vx5
	 qP4Gn8SMnx1BjuH7TFDNZy6w9jkJ2O63Cd3Dsup+dNi0xyE/6yTTMW8hrJWNuDRxIp
	 j3ivJwwDUtlkZUPSvDVILcXhlJjZDMX9iHwRIOqNoWRB0AgeqaJUOTvBa13MSFeXnB
	 y+JeJClRVLraua/IjRxJ2yyCk2IfkvfibcK4e0WO+v7WRRQ5WH5+sGR7+ATPKKYv4l
	 LfkcgfKh/1XQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789283AA9A89;
	Fri,  5 Dec 2025 03:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176490481827.1084773.16829863307342043595.git-patchwork-notify@kernel.org>
Date: Fri, 05 Dec 2025 03:20:18 +0000
References: <20251202.194137.1647877804487085954.rene@exactco.de>
In-Reply-To: <20251202.194137.1647877804487085954.rene@exactco.de>
To: =?utf-8?q?Ren=C3=A9_Rebe_=3Crene=40exactco=2Ede=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 romieu@fr.zoreil.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 02 Dec 2025 19:41:37 +0100 (CET) you wrote:
> Wake-on-Lan does currently not work for r8169 in DASH mode, e.g. the
> ASUS Pro WS X570-ACE with RTL8168fp/RTL8117.
> 
> Fix by not returning early in rtl_prepare_power_down when dash_enabled.
> While this fixes WoL, it still kills the OOB RTL8117 remote management
> BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.
> 
> [...]

Here is the summary with links:
  - [net,V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
    https://git.kernel.org/netdev/net/c/dd75c723ef56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-224648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A3B87504
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E691C875D5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F231C596;
	Thu, 18 Sep 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPfnW5fi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484E31BC81;
	Thu, 18 Sep 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236417; cv=none; b=R4dr2aoqMd99s2Tk9TSiMSQS2FwPtuyf1AgxGnlKji4OSMcAEQEqGEqd9nv8wMJMYreAxFNlanCgX4rjwJXM5WyJjzMv5auoghgFgpAotwtXLv4McGLHGTGRu3Fk9vFPRRtPrwAH9SYoYi7zHI5viHt+xnrfuRXVCkcvIpeM510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236417; c=relaxed/simple;
	bh=HuRoVKhkn0H5T8vzt24njCHdEDuvN03sB0dQwqMhh1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y3rcfB3qRR52E/T0z/VcTQrS6dV2EBEtFXLO9fZr6tkEqusEEypHAhoTG9idlZw88STiLiLRTzfqJ54dwhKqWQdEzdlYvjj/Q3wzMVga43eQ1UGTHyIRPA3cms44KU+GsratCAiBvRrysux+a/JZB9zdS85LryGQ1v+zTuF9Mn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPfnW5fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A7AC4CEF7;
	Thu, 18 Sep 2025 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236417;
	bh=HuRoVKhkn0H5T8vzt24njCHdEDuvN03sB0dQwqMhh1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QPfnW5fim3iAQ/GF8qLRBMPgln1Fvq2nye4t+bfg//DocOE/587ZB7gSiWiWn2ivB
	 UpwbwMI/cvK/XvjujsExB44fyediG258SA86xBjmO4NO0602zyzNkTnZlu1v8rV+4O
	 dvSfKprs7odfQ05Twfdutl33DO2SDLe4ycF+XZRd+tFP/Ql3ydUPZhtBNCAOJm5WED
	 KF6ltzyhOdEIOnJvES+hbh1cxWD8THO0hyWt8Lq6wlZsX6fTgSJcMLVDTZsdqCGYoa
	 zRv1Z+qP1gOslzAQGXlYqHMzPtIgOv4Gflw+4mHz6BpXY3Ne5P4MmE0xVMnXvRa7uS
	 /x7aSo8uFGH+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2B39D0C20;
	Thu, 18 Sep 2025 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: micrel: Add Fast link failure
 support
 for lan8842
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175823641699.2980045.17251885322621372139.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 23:00:16 +0000
References: <20250917104630.3931969-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250917104630.3931969-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 12:46:30 +0200 you wrote:
> Add support for fast link failure for lan8842, when this is enabled the
> PHY will detect link down immediately (~1ms). The disadvantage of this
> is that also small instability might be reported as link down.
> Therefore add this feature as a tunable configuration and the user will
> know when to enable or not. By default it is not enabled.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: micrel: Add Fast link failure support for lan8842
    https://git.kernel.org/netdev/net-next/c/5a26346e6250

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




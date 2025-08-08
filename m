Return-Path: <netdev+bounces-212296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284BB1EFE3
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F055A110C
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7924293B;
	Fri,  8 Aug 2025 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Hqq+Ty"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB5241114;
	Fri,  8 Aug 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686197; cv=none; b=KniG9x14JmUQybEKGpeQRxX1FX0EAYGAe5eSN3Hwdgd0PVYlt8cH+fbSF9v4OsFgSSiXq+Rc9//OAAPEsBIexIIgjTNHfPPujIXQixL9Tm2GVpfJ1je0agGNhdHxI0wZcROLbpNZDb1GO2Tb1WJBq7s7tLr4DhSwOQsixlsZxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686197; c=relaxed/simple;
	bh=pMlTIqeVM+zN4DO5zAsim5SBQEc6MM2tX6ksnYnijqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=riL0BJKTOR2L3QbKYm1OV8WOV+Iu67/sshXoa1FEsXwZzPT53THgxpfaoi8UEu40Hvhs4KP1Awk4Hs2rBB4fzhgpYS14pu4LtZ1e7RF2OpH1D4sgxOxVBpyuxaskH5wzYSplvCNN5IIu81/W10XboLtLvBwrAXwhVjbJljX89Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Hqq+Ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA23C4CEF6;
	Fri,  8 Aug 2025 20:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754686196;
	bh=pMlTIqeVM+zN4DO5zAsim5SBQEc6MM2tX6ksnYnijqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c3Hqq+Tyti0B9ctLaZlwqhb4e4d5v7VT8WdvQjnsRbB2YjuS7UXN/ZHAvSzgM2zeX
	 FUzcGDisg3VoCZFzd+DLzJUZtQ5YbJTL5g2eiOfDCRtEEScUGW0jESElogXiSg0VbD
	 574q/3xW8fITEv0GzXjZlXVn5LVoqCGd35o/LJTnfKDTwdKJ6Gj+X8V6zqXy2EbAFS
	 zGVT1X24DKAYnl27UDjeENydPVpYFSkN9x+hJ4aysT2nE35vjH3asOGC5Zehaqvmo2
	 hMmc8rQwUKhNzoci+EttmuVO6ciyfd9iKW6GIpYeAHdSdYe8Pv9wf5JdPO1ehJwA/y
	 BViSh/2snE+Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B09383BF5A;
	Fri,  8 Aug 2025 20:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: microchip: Fix KSZ8863 reset problem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175468620974.263488.6867802167260106516.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 20:50:09 +0000
References: <20250807005453.8306-1-Tristram.Ha@microchip.com>
In-Reply-To: <20250807005453.8306-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: linux@rempel-privat.de, woojung.huh@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, maxime.chevallier@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Aug 2025 17:54:53 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> ksz8873_valid_regs[] was added for register access for KSZ8863/KSZ8873
> switches, but the reset register is not in the list so
> ksz8_reset_switch() does not take any effect.
> 
> Replace regmap_update_bits() using ksz_regmap_8 with ksz_rmw8() so that
> an error message will be given if the register is not defined.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: microchip: Fix KSZ8863 reset problem
    https://git.kernel.org/netdev/net/c/829f45f9d992

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




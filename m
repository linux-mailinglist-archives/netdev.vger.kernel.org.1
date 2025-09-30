Return-Path: <netdev+bounces-227332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65067BACAF7
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC8816AC4E
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27472F90CD;
	Tue, 30 Sep 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph2IW9GV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA552F8BF3
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231814; cv=none; b=szsIKoJKRKRqCHwjMooEk16dVk2EblWH2jPUMdAzmnBQesI5Z1UfFNKf+ITpeUuAIIJiHmlFZ0PQohGjxdq0bR+pCjqYxzqVUkEb+KmY8QEa+W0/GcyUAaIGjTtzV62gi+Foc21/WLlL+Ct00Fme9FprTBZkHQ9SDvRVaAFJ7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231814; c=relaxed/simple;
	bh=ZtFkd7qSml64odVU1SyxDJgtOOmFvp2G9g8Vb211ejM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XGUfO4R11YahDqH/O8JsTXK6+qvToeGKiJRfJ9tOEBhJjN4x08V58At/XkLEQ1nTL2Gv5CiiMLJVZN2cqURhXRuIypGfqcapL3AWokOJF6075dPreQMpaxZdgCqzDV2qv0EnJlBjAU8Ce6/3yMXvCvxsG9d0/jUuXYdToRafzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph2IW9GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478D2C4CEF0;
	Tue, 30 Sep 2025 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759231814;
	bh=ZtFkd7qSml64odVU1SyxDJgtOOmFvp2G9g8Vb211ejM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ph2IW9GVtcrMAgPZLjw0IxR0ki7PuLI1rXbSJ8mXnFVCHDryg6Rf5elhbVr0lMdIG
	 ddvZzTH699yGXkK3fW5TUJdywHirbPS07vOJG9STfuWNtA8S23Alo48oyX7FhCHaik
	 L/rzzPRDnXRk0YdYeIXHPJKMai0tyMWhXNUXq4ycQvp3cA9T6OcYuDeM0CpRXwYiSR
	 30R+TDPY0+SxH4CLC3UG2xZNFrm3H1RQRbOpJPJbmhInysI3heJar4pmj8QdIBA46X
	 XoXeoctxLiED2eDp6xQ0B4R1HoHGpQ+5mn00bPELICOrR4UEK43vw3wyZ8H75KbdMc
	 nohqY4uZJ+ULg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE09639D0C1A;
	Tue, 30 Sep 2025 11:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: annotate linkmode initializers as not
 used
 after init phase
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175923180751.1951629.9077298718392362908.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 11:30:07 +0000
References: <5fb9c41b-bf44-4915-a3c3-f20952fce6de@gmail.com>
In-Reply-To: <5fb9c41b-bf44-4915-a3c3-f20952fce6de@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 27 Sep 2025 21:57:07 +0200 you wrote:
> Code and data used from phy_init() only, can be annotated accordingly.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy-caps.h   |  2 +-
>  drivers/net/phy/phy_caps.c   |  2 +-
>  drivers/net/phy/phy_device.c | 16 ++++++++--------
>  3 files changed, 10 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: annotate linkmode initializers as not used after init phase
    https://git.kernel.org/netdev/net-next/c/49ac3d782693

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




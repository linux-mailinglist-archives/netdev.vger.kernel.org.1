Return-Path: <netdev+bounces-183080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C52A8AD22
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6637B1903D74
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B045E1FCFE9;
	Wed, 16 Apr 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCy9oYMB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5891FCFE2
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765196; cv=none; b=F19ittElY87ZjL4e6vF5nYQmX9N4eUdreZa1XbtDu5u/ZHrDyGeO7pCHWlV/fzP8fa3djrkWZPRz9+sztH35z562IuAWgGIKMGeAU+bzto7z/UxkY8qsGi1oufxnp7p3dE7E6tT9/N8tPkTMRF2+UoweGr6c4FCQtzFJQBjSy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765196; c=relaxed/simple;
	bh=hGH0o+4gDQfGzm7P611fFgrwMCpHqpvDs3hZ3Y0SosQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KtRNCG+WK7EZb2cyCydsIaAPQ9KqkU4qgPQf2QMuLbWUIflbeL9bY8JvaB9qvgU8omi51xwhxzNGmZWoQaOClwwhIl1TLqt2CjT0+G8/Fd/RjJfs56XzGUusekRZOJkyWtpOEBMv9RrRCevZaMgkUBAg8Xp3FFS84cytJ+DWGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCy9oYMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B44C4CEE7;
	Wed, 16 Apr 2025 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744765196;
	bh=hGH0o+4gDQfGzm7P611fFgrwMCpHqpvDs3hZ3Y0SosQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BCy9oYMBx7IkN77ijrW93KpGmPhuV8vccSr7E/ziLxsEcn09365HLFZg+/DNDkVTn
	 5E+0Y1hlim4Ev0dC9rh7chzHsPMCfGxe6Y4KRoHN5csf3U6B5FdMPkmXPxmzFXvufJ
	 sKDDV3/0kng3TMf3msZywMKcDb3bIGasKKZ5djzWMKCjHIuLHSsSmSxd6SELNze6/Y
	 N4yTEd4N5zKwhqYYt35BOP02GjEhiH0+CCW5xFPduwiSFo+/D+8dORXru0SotzQ5uw
	 NEX7QS5kx+De1Zxx+j0DctTMQJ6gnI+6Juo0a8tMrDLzMVMAY6iIHJmoc5hn2BKisX
	 vm9vB9aZzkP2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0A3822D4B;
	Wed, 16 Apr 2025 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: remove redundant dependency on NETDEVICES
 for PHYLINK and PHYLIB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174476523401.2834710.7627186393705689816.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 01:00:34 +0000
References: <085892cd-aa11-4c22-bf8a-574a5c6dcd7c@gmail.com>
In-Reply-To: <085892cd-aa11-4c22-bf8a-574a5c6dcd7c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, davem@davemloft.net,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Apr 2025 23:23:25 +0200 you wrote:
> drivers/net/phy/Kconfig is included from drivers/net/Kconfig in an
> "if NETDEVICES" section. Therefore we don't have to duplicate the
> dependency here. And if e.g. PHYLINK is selected somewhere, then the
> dependency is ignored anyway (see note in Kconfig help).
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: remove redundant dependency on NETDEVICES for PHYLINK and PHYLIB
    https://git.kernel.org/netdev/net-next/c/1310f44dd4d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




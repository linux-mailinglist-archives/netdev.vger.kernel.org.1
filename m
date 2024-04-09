Return-Path: <netdev+bounces-85969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F889D10A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 05:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91111C2414D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A42548F9;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdL4mJNl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41C2572
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633427; cv=none; b=deK18ykHgSOWj8biDd+Z13gVvkrlcxQ5xeWO7GVG5Bo6rSM9zFwt+H0aCxYuJVxuiwha66XS5sMJcsTkFtvZSs42hx5Q00HbqMHgAe7wAq6S/T0fEUMKcLftF/wyxk6zv/2fWwzH2mAvMH49hcIz3fidNCP65U5Jj5b7Pgd6M5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633427; c=relaxed/simple;
	bh=/cnROwdNL11P9DMvZ+TbXMOX92JS2D235YqPpr3M0+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aBlWX60qS7tozygl47OH8VTNBWU8vnNqpGQw7YdILtBmb7I7UNpnsTHNXKWgKzgDFJVP6ZAIZonxBDLH0OHOxyNRPrC9jf78BeKK4jkkeX6ueQQXYjCLl/r5JtA2ycD+C/sbR60/LGbB76WUqXhQLoheOOqM236s6os6hFA4pVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdL4mJNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FC00C433F1;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633427;
	bh=/cnROwdNL11P9DMvZ+TbXMOX92JS2D235YqPpr3M0+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FdL4mJNl4+GArdilWnX9GOiM4iNcOMpkqtb4ZUMSpvOOSILMw98grX7VmoACFzQIv
	 UaB4K+x+poPENat3/HNm61D69QDncL7C41ig7x50Hb7wFoy6OVCMcuLumuqwBlkuXx
	 HykcNWGp3humdFBuWAJDXZ1Cc0NBw2wZo0xbzjxpUDXERmuAhVcic7VToQLGrcaZGh
	 T9q3gWdnpnLIZdF9e4Hn++SeeQchrpyLDT5keHxsQ1zIZJmV2Akek+V98Jlj422lHW
	 6KkP85iQrmRo9ry4y8Zad/3dlRzLwMkrDiQNSvfmFFLxLg/cQT9wmutaGb/BuuU1hY
	 OtoM5TMGAzOOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69DF0C54BD3;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net: ks8851: Inline ks8851_rx_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171263342743.31710.1700532342959631639.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 03:30:27 +0000
References: <20240405203204.82062-1-marex@denx.de>
In-Reply-To: <20240405203204.82062-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net,
 u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
 dmitry.torokhov@gmail.com, edumazet@google.com, kuba@kernel.org,
 broonie@kernel.org, pabeni@redhat.com, rkannoth@marvell.com,
 ronald.wahl@raritan.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Apr 2024 22:30:39 +0200 you wrote:
> Both ks8851_rx_skb_par() and ks8851_rx_skb_spi() call netif_rx(skb),
> inline the netif_rx(skb) call directly into ks8851_common.c and drop
> the .rx_skb callback and ks8851_rx_skb() wrapper. This removes one
> indirect call from the driver, no functional change otherwise.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: ks8851: Inline ks8851_rx_skb()
    https://git.kernel.org/netdev/net/c/f96f700449b6
  - [net,v2,2/2] net: ks8851: Handle softirqs at the end of IRQ thread to fix hang
    https://git.kernel.org/netdev/net/c/be0384bf599c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




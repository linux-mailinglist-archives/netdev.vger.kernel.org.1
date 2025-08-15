Return-Path: <netdev+bounces-213886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FAAB27424
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2150DA01519
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A360C27713;
	Fri, 15 Aug 2025 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqjHtTCL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7651F92E;
	Fri, 15 Aug 2025 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218412; cv=none; b=aPur1PcoqclIVI0tLDqKFS5/93qb9uKCMPeKu7v0IVpypRYVnoEnmVKf+judInCpxp8ZXaiuyyxJSPL4Y3qyayRGtbkhJMF3n6/kxal2ARW99FhaZ9bAU5yecN8dCbH32snVgM/MVh1CVNf0p9tS4Fq68Ccdaq97qIRoekN2IS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218412; c=relaxed/simple;
	bh=+J6qCeq+RfgdaLZGjaHd7KGcwCzwvC+yAk+DmxDtm9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=seuTBoYVnVF5Rree61bAo/32Az47HQrb8k2FWHx1oQ0D8LwaHExwuBYgYkwVUTIeP26dwN+1bp/MCi0kAVZFaoKotfrt+u962duOSD8hZFYDMzPnpPeEMTdokXIjdxTUB4sj+DxufqFB20dkjSg1yipuCTplwU25atoOaRK0Qwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqjHtTCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41609C4CEED;
	Fri, 15 Aug 2025 00:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218412;
	bh=+J6qCeq+RfgdaLZGjaHd7KGcwCzwvC+yAk+DmxDtm9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sqjHtTCLeavD0RvaVQsIx2LCJCRx9MkeS/AkzyFUiY2h7Npsec5AD74xfSTCfjhab
	 0SYnoWYEI7wsMP+FnWCQSn5pnleCgPmFDmFHDKScauyiZoS/X9DEWxCzPGanmYv+/K
	 wQhmUl5Mo8LOzfd9fiMnpbuufcIKNLXdsE5LaEHzyfFndtFLACaeabBZ5EpxzF1oKR
	 hhm3bUoJko4DkjdoYLQwBOOG+NyOwklaxURmh09J2Il2boAbk7RDyWW82QgmZLIX+b
	 2evsVVhkUfrK1ZNn9LVcR7sCB3Zegd2tGHbfNn5aPWqbpQOr3jCiC20k7mmXlW9gNg
	 tDr6JuqU/dvDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1239D0C3E;
	Fri, 15 Aug 2025 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: phy: motorcomm: Add support for PHY LEDs
 on
 YT8521
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521842350.497413.4780510981924359436.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:40:23 +0000
References: <20250813124542.3450447-1-shaojijie@huawei.com>
In-Reply-To: <20250813124542.3450447-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, heiko@sntech.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 20:45:42 +0800 you wrote:
> Add minimal LED controller driver supporting
> the most common uses with the 'netdev' trigger.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> ChangeLog:
> V1 -> V2:
>   - Replace set_bit() with __set_bit(), suggested by Russell.
>   - Optimize the names of some macro definitions, suggested by Andrew.
>   V1: https://lore.kernel.org/all/20250716100041.2833168-2-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: phy: motorcomm: Add support for PHY LEDs on YT8521
    https://git.kernel.org/netdev/net-next/c/355b82c54c12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




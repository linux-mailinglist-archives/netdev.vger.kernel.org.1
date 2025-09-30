Return-Path: <netdev+bounces-227245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07ABAADD0
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA56B18943B2
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BFE1EDA0F;
	Tue, 30 Sep 2025 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKmhymDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9711EA7D2;
	Tue, 30 Sep 2025 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195258; cv=none; b=C4x6xBoPZSCVpE+hejUwmvOdWsVW2sVxxOSUompJJ+VerRudJruuvuTsY1+ICJ5Eu2XpqperbavoJzu6tlsDvf3TN046BGsQVKR97n5JTBAMiCBTqmVjz3132sJhgo4fX8o4Y3N2URe8NVN2o2ng1KTjRsjINOnhA2at20yOXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195258; c=relaxed/simple;
	bh=ve5UTXQfuF4pVLNY0yY3DClkLpo0efls5iY+2K7GFUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pT2rBBsdE4Lm58FlkGW4xN9kCvVlY5jOnARM5iYS1nvFX5xQ4qBsHYlUJJFPcKurFkuxu5WRcYrH+aSEzCt+JgP5kgVV/ByYrHbzzfIXN+85kKEjdB8uRH3k3LLoZYMJNveN9x5TxcjVoPWZTPYWXgcBSUHl4eefTsAhP7saiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKmhymDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1A5C4CEF7;
	Tue, 30 Sep 2025 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195257;
	bh=ve5UTXQfuF4pVLNY0yY3DClkLpo0efls5iY+2K7GFUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SKmhymDTXt1LllgWKoYx2rWf6Dvxlia9gfTyVl83bB4pvAWjfyGvge6KzavVFaHos
	 GvM1HksGMdVo86weSmWA8oUpk5CLtOrdbWoEDArl3DjN7nLzInN98SANJfgb1uQNch
	 Z9SJuH1ogmiR5/O9XymoLDarqAiGB7/yF2ViWgdduuKFjBcAgj18qPg1SdhcryT5ox
	 c+2Z+bPLvEyYfBOPJIKld6JNWNZF1ueV+1MUg9SsMDQUDDBFrWwZGMR25g7sv/tMrP
	 hBID9dvuKUXOU86cTHRcRSOtzxvZd7RV5Ano3SehtElhMRaRoAgBqsbAoSj4kNhSkb
	 yy9rLuprOaNpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D3039D0C1A;
	Tue, 30 Sep 2025 01:20:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethtool: remove duplicated mm.o from Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919525074.1775912.16980428373235703917.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:50 +0000
References: <20250926131323.222192-1-m.heidelberg@cab.de>
In-Reply-To: <20250926131323.222192-1-m.heidelberg@cab.de>
To: Markus Heidelberg <m.heidelberg@cab.de>
Cc: andrew@lunn.ch, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Sep 2025 15:13:23 +0200 you wrote:
> Fixes: 2b30f8291a30 ("net: ethtool: add support for MAC Merge layer")
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
> ---
>  net/ethtool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> [...]

Here is the summary with links:
  - net: ethtool: remove duplicated mm.o from Makefile
    https://git.kernel.org/netdev/net-next/c/280435953627

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




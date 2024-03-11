Return-Path: <netdev+bounces-79288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0528789DA
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 22:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62723280E39
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 21:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622B455C08;
	Mon, 11 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPNgOQ5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53556B6B
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191432; cv=none; b=spu6414uYSst6ErEyj4mdUH7MiUQUoWcg2amcbWgSiN+OhUadIJDoFxhkdziUQlzXelcj1jAjv+hqdqQ+FFfhMADjthRmGVSsSVqo7bZr7ZojFNMV9CrfWhksAkqwcTwMl16+cwa7qBkDdAkbhehBwibpdQvQJPrAh7O74pqKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191432; c=relaxed/simple;
	bh=8sce2YD1w7tA0qJ4HQkB7anP5jtnBAu0IJi7kFwIxz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PONGw0uizNFs5wvqcoM5P19EMS0Ja6fw+SZlGj8IUF+nnfOhcXoOTnG4f99TGeJUs89tZ0pGrNQc/OmY3zzieQZfXbdzqr/xxLa6jX/ABE7R156iSlgMeVAt8aCS5HV1Yc9gZ8TiacM+eQPlZzdEevYrcoJjpUN4PXgpp4kBdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPNgOQ5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE911C43601;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710191431;
	bh=8sce2YD1w7tA0qJ4HQkB7anP5jtnBAu0IJi7kFwIxz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XPNgOQ5LyOT8wQOEA1+c7DshKhwVrwBO2ult01YBlDhWSdDzKzrrWU6u9GK9a/590
	 o2lzeTDS0XVZjRspewzf1lLQngjeXn5/Y3upctfz2UYh8XhMOlNAch4J5fHbWLVKsH
	 KcNsifJclBkbcxzdyBNzgQ02+Vy6iH4JTL2vBlDou0I8WI5rxoeX6szlBU2kTPJlsl
	 YAwrGaFDmWYxcUnOmQ5wtbA8l18a7vt1OcWIdVKt3wQ3W0PzHTgkaQHaRuSeIxakTJ
	 ihidXyILo1gm0dhfqsovyDFelt+fO3GRN2zHtaSvteahrqOln82q+qnc8YBQn2duBe
	 HTIvc+ebMycbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3863D9505B;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: switch to new function phy_support_eee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019143179.14853.17307091578877094539.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 21:10:31 +0000
References: <92462328-5c9b-4d82-9ce4-ea974cda4900@gmail.com>
In-Reply-To: <92462328-5c9b-4d82-9ce4-ea974cda4900@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 Mar 2024 22:23:20 +0100 you wrote:
> Switch to new function phy_support_eee. This allows to simplify
> the code because data->tx_lpi_enabled is now populated by
> phy_ethtool_get_eee().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] r8169: switch to new function phy_support_eee
    https://git.kernel.org/netdev/net-next/c/031a239c2209

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




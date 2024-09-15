Return-Path: <netdev+bounces-128418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45E9797AF
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8F81F21860
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2131C9EC4;
	Sun, 15 Sep 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHkWk0JA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96331C9EBF;
	Sun, 15 Sep 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726416088; cv=none; b=Y2fzgzOwnI5xMNb2R0J98OrLet9NpWNXL6FJJRnVXzFH5Vko45HJhjjKBWxEcImwputRNzt8Iq0CHJqdun1D6bK8VgcNbSErFI/GFMqi/gwXsqQkI1DRlkLHyOH5+2LRU0lwkPxvuWvL/ISbIWjYHx4ZxvVqdO6KXalDTOsGnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726416088; c=relaxed/simple;
	bh=Y8QP24CKHUvxLYd6VZy5Fp3zHnNGYYSNewltGROYn34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cNKw6MGKaqSV+4L8aiuO1ZBxbikp2yBY7DScevRZh2aRCTKZU58IVNrxw4D6M0zfQqPLOZQdeeSapxRwFxnKJOqbTbTYWOKQ7edVYEK6qVY8B2eUCBLRc+hRtkGyeYODGyeStRcR8mMYP9ykYurE6PZgr+LUD/h8HA48tLdqAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHkWk0JA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878FAC4CEC6;
	Sun, 15 Sep 2024 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726416087;
	bh=Y8QP24CKHUvxLYd6VZy5Fp3zHnNGYYSNewltGROYn34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZHkWk0JA/Ib6KBKxL+0HxbEwiOP+hmS3CZCOYnTJOS5KKOfuVxrG83DRGloVa2hMl
	 XjrOrOu3mZdFpJL9JOdX1oHsBWfHa0SBcMWeNQePdpZpo0mGKWJcyo9nftFyLg/MCV
	 qOTjCzlVKTUk5yyai9tIZRDIRiR+ozqu+qUXhPKFZ8csxkbxFkWCR3J+NNMGlj73s/
	 RcNJil1qYQV4wOWsrSEEnAGVZBIUQZvRIKkbVttB4F/5iAAnxTqfcsLKFc/cnnl59L
	 cUY4E8VgFBQMeH1UEXwPZGO3nKBFQnU73dfmyBEHeYb0D9n7yu+4JLAsRHuieWgboj
	 jwzOuBM6qNRVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6B3804C85;
	Sun, 15 Sep 2024 16:01:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: fs_enet: Make the per clock optional
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172641608876.3111582.12752959256186522702.git-patchwork-notify@kernel.org>
Date: Sun, 15 Sep 2024 16:01:28 +0000
References: <20240914081821.209130-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240914081821.209130-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, pantelis.antoniou@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com,
 christophe.jaillet@wanadoo.fr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Sep 2024 10:18:20 +0200 you wrote:
> Some platforms that use fs_enet don't have the PER register clock. This
> optional dependency on the clock was incorrectly made mandatory when
> switching to devm_ accessors.
> 
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/netdev/4e4defa9-ef2f-4ff1-95ca-6627c24db20c@wanadoo.fr/
> Fixes: c614acf6e8e1 ("net: ethernet: fs_enet: simplify clock handling with devm accessors")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: fs_enet: Make the per clock optional
    https://git.kernel.org/netdev/net-next/c/c209847b8974

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




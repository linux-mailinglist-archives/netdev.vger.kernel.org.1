Return-Path: <netdev+bounces-122498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B88961856
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3A4B22BE0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232DB1D2F55;
	Tue, 27 Aug 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guGQwFmY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE911D2795;
	Tue, 27 Aug 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724789430; cv=none; b=T28QGF72TgKL6lzj+fKb/ryKfHeZ45c5ve1NXhJM7poLPahyVzDMyMaLsEyyQOz2wEWL20pFsRyriaeYO7B0EwhAfhCYRu0NwNn3D0rZK1mBM0KvSg6z8giLsjgP/7i5m9n8e/HXxA3GV0TYo6NcofKqC3Ml5Gvz9IyRBl/tvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724789430; c=relaxed/simple;
	bh=OkUOAd6/Vg3krwkHJycEkw5OmKOpNRLIKkZC0UvEngU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jX2GtzUCnaIyGg4wfTr8SVJ+R57E5i+uyAV190lXLtGOH9W2knaXaEE/Rd8vHY6XqDSa0evnw4M7cRwkBS7ZXVgoZgRqg3JEqhIobvkTTRR08l/8D+BjVDKwqcHn8pHCx/DtjxfrUL6/ciNrYobGSQJbGiTcAodvWAE1MdYX3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guGQwFmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67374C4FE90;
	Tue, 27 Aug 2024 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724789429;
	bh=OkUOAd6/Vg3krwkHJycEkw5OmKOpNRLIKkZC0UvEngU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=guGQwFmYjc8F/V6JWGVe3tp2ZVwUX+TP4+LXt3ecosCzGcEmrO2Guu/niWW8TV1WF
	 1A8ARfmiPs8hJClKsHpgW3nW83xOOJrTnN9k4MBrSurVJbyODYnbb4Yu/aNkfCt7fp
	 f2ce6g6awGaXd68V1HTa5D26wcPoa7J4Kt6BT1egyVic2bJpQCJYJ/GUI+AI7asLRq
	 62kr+yQIiDzj2LpcI0TvkGgPoNQ+u+IQ8B+gczcljcRFhyzNfxq4PPr5pfvyCLt2fy
	 9pUUAM6QWrohPa/oOzeN5QOvBNFjtN4hC7Zs7mxxu2xRwgmhJH6nVdyM292zRK15cb
	 Fa7NQdP/4PivA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6243822D6D;
	Tue, 27 Aug 2024 20:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: ethernet: ti: am65-cpsw-nuss: Replace
 of_node_to_fwnode() with more suitable API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172478942955.751194.671625843718565559.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 20:10:29 +0000
References: <20240822230550.708112-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240822230550.708112-1-andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jpanis@baylibre.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 02:05:50 +0300 you wrote:
> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: ethernet: ti: am65-cpsw-nuss: Replace of_node_to_fwnode() with more suitable API
    https://git.kernel.org/netdev/net-next/c/3333df3b4bc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




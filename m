Return-Path: <netdev+bounces-26029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7BB776987
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0368D281D90
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E892453A;
	Wed,  9 Aug 2023 20:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBE24530
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2521C433CC;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691611825;
	bh=be/zbLSNsRZyx72HDcZLrKskDTySW6E4Xcr/gAHgvkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EhB9gw9/Dfz3Baz4vdsKCr8SItwcLo6hLyCM/WyQ1hsQOTBUGwdf0dAe9y8uSeFTa
	 t2lbygV9neAsalEKO5Tyj9pb8HKEYyHn1uURSkZaWiHlSwEtxwCl21Yp6PRPGdV0Qz
	 96rwUOH9NK9b/YR85EON5It+HEIKYKKAHPglxDMrgF4a+Dl4YcU1GHcDKt6jqXZ/Gu
	 PesD7f9BeksvyqmFVJh1O0rRFqPZMqS34Bj1keMtp3uuXnazeAZuZDlA5Cj1IHervN
	 uTcIdNjLYJEOJPuKtiC/HWtOMjVJiYmK5mYjdEfzpaF53X0dSHnVnGvUnPQ5kTdZN/
	 +/Tm+2swn5k/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7729E3308E;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bcm63xx_enet: Remove redundant initialization owner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161182574.10541.11251407121400050700.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:10:25 +0000
References: <20230808014702.2712699-1-lizetao1@huawei.com>
In-Reply-To: <20230808014702.2712699-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shayagr@amazon.com, thomas.lendacky@amd.com,
 leon@kernel.org, khalasa@piap.pl, u.kleine-koenig@pengutronix.de,
 wsa+renesas@sang-engineering.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 09:47:02 +0800 you wrote:
> The platform_register_drivers() will set "THIS_MODULE" to driver.owner when
> register a platform_driver driver, so it is redundant initialization to set
> driver.owner in the statement. Remove it for clean code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/ethernet/broadcom/bcm63xx_enet.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] bcm63xx_enet: Remove redundant initialization owner
    https://git.kernel.org/netdev/net-next/c/09c80167dbec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




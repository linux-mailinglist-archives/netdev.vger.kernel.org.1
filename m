Return-Path: <netdev+bounces-42475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C417CED35
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F15281EE3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54CC7FD;
	Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVkw50+a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4BC65A
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E343C433CB;
	Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697677823;
	bh=V5vkASz9bpy7bKti08B9IXh8TObTes2FNEz103yALoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GVkw50+a8YBNMoXtlvjrtdXfISTbAFbw44792495Ud2aDJA4wDk5Hf6ZmuHQ2AJIv
	 /K6/e3/IBeCsMIVZW+xhJhCiad5EyNcqlvBm5b6tYvso4fDZFd6DuwgCK/cSvJqZCa
	 EbUAByrzx0BWQ3zKU8yYmBesV1gq6tHPjvM0H+CMdKKDCKI3aCdWxa3R+CtGVfP7zM
	 DmCWitBnEQnaYxHjfxubkQEIszFhVY3F61pY+m/nbH4MfyZDZ5d9k3vtk11S8LRHvK
	 h2qjuRQT4c/vXbMJbaYE9hyNN1BxeltpRkK4SW+hxaruPZfZVv6gpPQzkL6yTUNdxI
	 BqC4US4Q/FxwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A430E00080;
	Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wangxun: remove redundant kernel log
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767782330.12246.6508153491612410831.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:10:23 +0000
References: <20231017100635.154967-1-jiawenwu@trustnetic.com>
In-Reply-To: <20231017100635.154967-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 18:06:35 +0800 you wrote:
> Since PBA info can be read from lspci, delete txgbe_read_pba_string()
> and the prints. In addition, delete the redundant MAC address printing.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   5 -
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 108 ------------------
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h |   1 -
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   8 --
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   6 -
>  5 files changed, 128 deletions(-)

Here is the summary with links:
  - net: wangxun: remove redundant kernel log
    https://git.kernel.org/netdev/net-next/c/48e44287c653

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




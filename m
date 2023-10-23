Return-Path: <netdev+bounces-43395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050F7D2D7E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 11:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD28D281586
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D0125D8;
	Mon, 23 Oct 2023 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGrAye67"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83036107B3
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE44CC433C8;
	Mon, 23 Oct 2023 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698051624;
	bh=ZlNpwhUkebIo3i3YOLtax4PKr90vncJVlptPpqAmTzY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WGrAye67GjP4iFW9muOWZAiOfYPRghgFf7X0BhCqiJa1e/h1oHH4dPHGbka/pYkGx
	 dZacYXs2sbTKxn1cMrzNqdj+Td9UvaxdxGSqI9DHvnMC30He47mwRFP0k6mYlwCmcm
	 nw2s7f6ybZKP10AoM46ruCuWlkTB8TghOMKtGjqjxSiqPhYoblmscQpHjzZDvc6lBf
	 Wy32p3uz0vYXfvk7ozWUJE0Jj9dSaehcKUiIAXDp/TyukmAoQYzwWiHHD55mNuI6f+
	 p4/WvOM4iCl3BLlun3OQM1SDWfJCswObZvc15CkJhHrG2pCrZqm4wQYLEXybkgWF4p
	 3j6G9IEpzUXWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2C03E4CC13;
	Mon, 23 Oct 2023 09:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: lan966x: remove useless code in lan966x_xtr_irq_handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169805162379.8476.6620826650761032188.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 09:00:23 +0000
References: <20231020091625.206561-1-suhui@nfschina.com>
In-Reply-To: <20231020091625.206561-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 17:16:26 +0800 you wrote:
> 'err' is useless after break, remove this to save space and
> be more clear.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - net: lan966x: remove useless code in lan966x_xtr_irq_handler
    https://git.kernel.org/netdev/net-next/c/6e7ce2d71bb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-63437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA9982CE18
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 19:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3171F2244D
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC753B8;
	Sat, 13 Jan 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmkA/TQT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA884C98;
	Sat, 13 Jan 2024 18:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF25AC433C7;
	Sat, 13 Jan 2024 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705170625;
	bh=MG9Wlx4R4S2zGi7okNTmvi9dnMhosSiOampEM0Qx/R8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kmkA/TQTjCtuqlcVysy/wpbTH8tX32NUvePZ6pexImCAdZj5VSYpbFaJEkzzFXqS5
	 UwF3HqXyMOwbyp9bqarYn33lWkKa67gpyTzDFNDHNAp5HeXNM2UyQqvyFPnGP7t1bG
	 GfZR3lffk5GYPCmHUS/HUyabwYnSj6K+QxDFDQ7xBqSp03OiJSibrD6jR9JOLLHRUw
	 EpLKC3P9nHBk+I1pio4koCR8zc0PZtOHMN45+sh5qLlR4fMGXa1VVshVAp+NAsZKIQ
	 Ob4f2w1IicI2r1dZghckBPgxHIOewF0RbORMtKW/3leJN+hGgFIvJDehQAdvzVZce6
	 0hFIUomCJnqIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5EC8DFC697;
	Sat, 13 Jan 2024 18:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: netdev_queue: netdev_txq_completed_mb(): fix wake
 condition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170517062574.3794.10700436076304248955.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 18:30:25 +0000
References: <20240112-netdev_queue-v1-1-102c2d57e20a@pengutronix.de>
In-Reply-To: <20240112-netdev_queue-v1-1-102c2d57e20a@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, herbert@gondor.apana.org.au, kernel@pengutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Jan 2024 17:13:14 +0100 you wrote:
> netif_txq_try_stop() uses "get_desc >= start_thrs" as the check for
> the call to netif_tx_start_queue().
> 
> Use ">=" i netdev_txq_completed_mb(), too.
> 
> Fixes: c91c46de6bbc ("net: provide macros for commonly copied lockless queue stop/wake code")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - net: netdev_queue: netdev_txq_completed_mb(): fix wake condition
    https://git.kernel.org/netdev/net/c/894d7508316e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-49865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112CD7F3B5E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCD9B210BA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DA94426;
	Wed, 22 Nov 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVTKsz1y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEA4409
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8E49C433CA;
	Wed, 22 Nov 2023 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617225;
	bh=VDRkxPsO1X5oNTY+T0eh8UWsW3IKGlw9yTLLtni4EHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IVTKsz1yNsnTH21uzTwctw2mBISoNP4V6V6ILtOVNG9EX6qDIG+tyfzIHMzxHBTQ2
	 eKw+nmGqTGHdKhFkfiuQIqAkKX1n4dOfVhGTjlcr7/hd2NkqFLJ81p4J+mKpsRE3Qz
	 8owj2KdoeaXq1GmZ36dqKANn3fTWvzvYijoU9hw6mCWuAfLo/euhWr7FPcehQ2un9c
	 Sh9nUvoBHAk/v/H2V3ZX8+w2F6BwAaxzlQCNBwLtDcQnUUDNOhfdfZMejJbvlUEemp
	 qXCOf2L0c5IuqFq1AtX7oDw6VFuWL2b0zxoMjA1QASOVmTosoNs1MzpBgIQYdqhSGW
	 1dKM7pQZQKd5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D6ECC691E1;
	Wed, 22 Nov 2023 01:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/15] net: page_pool: add netlink-based
 introspection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170061722564.4150.17893320111700452496.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 01:40:25 +0000
References: <20231121000048.789613-1-kuba@kernel.org>
In-Reply-To: <20231121000048.789613-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, dsahern@gmail.com, dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Nov 2023 16:00:33 -0800 you wrote:
> We recently started to deploy newer kernels / drivers at Meta,
> making significant use of page pools for the first time.
> We immediately run into page pool leaks both real and false positive
> warnings. As Eric pointed out/predicted there's no guarantee that
> applications will read / close their sockets so a page pool page
> may be stuck in a socket (but not leaked) forever. This happens
> a lot in our fleet. Most of these are obviously due to application
> bugs but we should not be printing kernel warnings due to minor
> application resource leaks.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] net: page_pool: split the page_pool_params into fast and slow
    https://git.kernel.org/netdev/net-next/c/5027ec19f104
  - [net-next,v2,02/15] net: page_pool: avoid touching slow on the fastpath
    https://git.kernel.org/netdev/net-next/c/2da0cac1e949
  - [net-next,v2,03/15] net: page_pool: factor out uninit
    (no matching commit)
  - [net-next,v2,04/15] net: page_pool: id the page pools
    (no matching commit)
  - [net-next,v2,05/15] net: page_pool: record pools per netdev
    (no matching commit)
  - [net-next,v2,06/15] net: page_pool: stash the NAPI ID for easier access
    (no matching commit)
  - [net-next,v2,07/15] eth: link netdev to page_pools in drivers
    (no matching commit)
  - [net-next,v2,08/15] net: page_pool: add nlspec for basic access to page pools
    (no matching commit)
  - [net-next,v2,09/15] net: page_pool: implement GET in the netlink API
    (no matching commit)
  - [net-next,v2,10/15] net: page_pool: add netlink notifications for state changes
    (no matching commit)
  - [net-next,v2,11/15] net: page_pool: report amount of memory held by page pools
    (no matching commit)
  - [net-next,v2,12/15] net: page_pool: report when page pool was destroyed
    (no matching commit)
  - [net-next,v2,13/15] net: page_pool: expose page pool stats via netlink
    (no matching commit)
  - [net-next,v2,14/15] net: page_pool: mute the periodic warning for visible page pools
    (no matching commit)
  - [net-next,v2,15/15] tools: ynl: add sample for getting page-pool information
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




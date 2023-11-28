Return-Path: <netdev+bounces-51722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424927FBDBF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00FF281AE1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702D5CD17;
	Tue, 28 Nov 2023 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS9KXWrI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1595C081
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D37D6C433C9;
	Tue, 28 Nov 2023 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701184227;
	bh=ypxTtCyXWgfFA9YBmaYcWg4oS4uF6KU1B/4hQ/kcalI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pS9KXWrIpGE5ADHef1Z9BTb9gBe+LmalNu5AN4TfIb4f+YbzZ35aZ48UdIsQM8t8r
	 VsKOp/gtdezdQB061o4xdzp+kDQyF6DlXa9mIrXsG5GEEcWhZe9aPNdvVezvpQO4yQ
	 OwmpSARgKi3NScmXfj+9hIc9CoHkzjq0uwC3vxQCGPQgCQrnZ9AoqFDaJuruslWX7D
	 FxWN5kbfEEIYkbCKf4ZRndpFTO5ETfnGOycGSUxC//gx/slfSUsEwA4Axd0xnS/HlP
	 JFe6FrLVkTE8h0h3YCApAm9jwtEjlxuWt98ITgnu+PSlAAPCR1BXx1LveoWWmQH6c1
	 EIALncoE8//4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5383C39562;
	Tue, 28 Nov 2023 15:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/13] net: page_pool: add netlink-based
 introspection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170118422773.21698.10391322196700008288.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 15:10:27 +0000
References: <20231126230740.2148636-1-kuba@kernel.org>
In-Reply-To: <20231126230740.2148636-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com,
 almasrymina@google.com, shakeelb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 Nov 2023 15:07:27 -0800 you wrote:
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
  - [net-next,v4,01/13] net: page_pool: factor out uninit
    https://git.kernel.org/netdev/net-next/c/23cfaf67ba5d
  - [net-next,v4,02/13] net: page_pool: id the page pools
    https://git.kernel.org/netdev/net-next/c/f17c69649c69
  - [net-next,v4,03/13] net: page_pool: record pools per netdev
    https://git.kernel.org/netdev/net-next/c/083772c9f972
  - [net-next,v4,04/13] net: page_pool: stash the NAPI ID for easier access
    https://git.kernel.org/netdev/net-next/c/02b3de80c5f8
  - [net-next,v4,05/13] eth: link netdev to page_pools in drivers
    https://git.kernel.org/netdev/net-next/c/7cc9e6d77f85
  - [net-next,v4,06/13] net: page_pool: add nlspec for basic access to page pools
    https://git.kernel.org/netdev/net-next/c/839ff60df3ab
  - [net-next,v4,07/13] net: page_pool: implement GET in the netlink API
    https://git.kernel.org/netdev/net-next/c/950ab53b77ab
  - [net-next,v4,08/13] net: page_pool: add netlink notifications for state changes
    https://git.kernel.org/netdev/net-next/c/d2ef6aa077bd
  - [net-next,v4,09/13] net: page_pool: report amount of memory held by page pools
    https://git.kernel.org/netdev/net-next/c/7aee8429eedd
  - [net-next,v4,10/13] net: page_pool: report when page pool was destroyed
    https://git.kernel.org/netdev/net-next/c/69cb4952b6f6
  - [net-next,v4,11/13] net: page_pool: expose page pool stats via netlink
    https://git.kernel.org/netdev/net-next/c/d49010adae73
  - [net-next,v4,12/13] net: page_pool: mute the periodic warning for visible page pools
    https://git.kernel.org/netdev/net-next/c/be0096676e23
  - [net-next,v4,13/13] tools: ynl: add sample for getting page-pool information
    https://git.kernel.org/netdev/net-next/c/637567e4a3ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




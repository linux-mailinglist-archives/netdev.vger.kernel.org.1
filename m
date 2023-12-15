Return-Path: <netdev+bounces-57915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58F8147B4
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703051F23FD3
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252928DA0;
	Fri, 15 Dec 2023 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZMwzbuw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89682C691
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A444C433C9;
	Fri, 15 Dec 2023 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702642224;
	bh=OR2V8qaS2tX/4N0I6H+yYf1T2A40D14EWeUDw3n1MoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NZMwzbuwVui8xhvlrW3hqZWGOS5HHBIuBGpCUtuPRI+MBKS/L6Rd52E01N42/8xYW
	 sOgw6rNQdEJLYFziVVyKQh/pgzjAIonjAf4HN65T1U3A2kR61EZhAn7Ie1IKQEziGX
	 srsxsc8Z2k2wH1gK3v5AFp+0KHfGR4C9a9YZV5MtjpGSFBP7QQP+5sxOP31VfiYNqe
	 T103J2vWYYBuRopXCfziDi9O+nTmvxe3rQobFN3lxYncSxDR3UVZWR51IYHQ041Ndn
	 BFgL1wRo+Ztt3P7C2BUw/C+KPZ8SMMBiMF+AfXUb2ZelJaPGqwCIH+8pcavCWdNjPL
	 a1UvUxxACiLQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41215DD4EF7;
	Fri, 15 Dec 2023 12:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/rose: fix races in rose_kill_by_device()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170264222426.21512.10024922314954258007.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 12:10:24 +0000
References: <20231214152747.1700980-1-edumazet@google.com>
In-Reply-To: <20231214152747.1700980-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 f6bvp@free.fr

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 15:27:47 +0000 you wrote:
> syzbot found an interesting netdev refcounting issue in
> net/rose/af_rose.c, thanks to CONFIG_NET_DEV_REFCNT_TRACKER=y [1]
> 
> Problem is that rose_kill_by_device() can change rose->device
> while other threads do not expect the pointer to be changed.
> 
> We have to first collect sockets in a temporary array,
> then perform the changes while holding the socket
> lock and rose_list_lock spinlock (in this order)
> 
> [...]

Here is the summary with links:
  - [net] net/rose: fix races in rose_kill_by_device()
    https://git.kernel.org/netdev/net/c/64b8bc7d5f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




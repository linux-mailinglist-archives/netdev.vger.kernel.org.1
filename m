Return-Path: <netdev+bounces-37257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25DD7B474F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 13F84B2096C
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D8F17721;
	Sun,  1 Oct 2023 12:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DE5666
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 12:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC4ABC433C9;
	Sun,  1 Oct 2023 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696162829;
	bh=I38svwnmcb+sPcAQD1YVln6VjsiOXPPcFSO3nDIBelc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XFBEsrmLvXV/LRvwC2txQNUwtt5l54becjWRmhhvyWJ4JlxgTtYZJUefpkPRdK7jp
	 TEfimQXSJ05yJ67uc6pb8YCAQWIunXbVa+ahQOvyLTfMdIrWQFEdqE4YL+fRbVIj4x
	 edy7d1OL0ajYz1hoOqnVxMjLKEY3VEwpXUGzHjdXvT4m+n7lq/gzLAgNiybtH48kdK
	 mvbpFv82a+7Eb5jYDYSj50g4dryxyKCry/sfmljhWPoZr9zpveth2xjd7plnCy3T1K
	 9BiiZWyb/VzgQv3HVyhdJL2L9SWg1OYJAYHROaYNTqHOWxYBV3PFuh2f2WMh3mQwEM
	 KoWDXH/HfAUxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B33E7C691EF;
	Sun,  1 Oct 2023 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tcp: add tcp_delack_max()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169616282972.12522.9918976877085029703.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 12:20:29 +0000
References: <20230920172943.4135513-1-edumazet@google.com>
In-Reply-To: <20230920172943.4135513-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 soheil@google.com, ncardwell@google.com, ycheng@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Sep 2023 17:29:40 +0000 you wrote:
> First patches are adding const qualifiers to four existing helpers.
> 
> Third patch adds a much needed companion feature to RTAX_RTO_MIN.
> 
> Eric Dumazet (3):
>   net: constify sk_dst_get() and __sk_dst_get() argument
>   tcp: constify tcp_rto_min() and tcp_rto_min_us() argument
>   tcp: derive delack_max from rto_min
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: constify sk_dst_get() and __sk_dst_get() argument
    https://git.kernel.org/netdev/net-next/c/5033f58d5fee
  - [net-next,2/3] tcp: constify tcp_rto_min() and tcp_rto_min_us() argument
    https://git.kernel.org/netdev/net-next/c/f68a181fcd3b
  - [net-next,3/3] tcp: derive delack_max from rto_min
    https://git.kernel.org/netdev/net-next/c/bbf80d713fe7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




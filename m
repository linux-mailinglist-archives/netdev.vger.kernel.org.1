Return-Path: <netdev+bounces-59982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5843681CFB9
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 23:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3451F23123
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B752EB0E;
	Fri, 22 Dec 2023 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo/3RgOc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2192F844
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 22:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3610CC433C7;
	Fri, 22 Dec 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703283627;
	bh=QwBETdVwQSC85MllFIvnvKzSiGwI674fKqK/ez86W0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qo/3RgOcbayO+2yVG0Nw4NgerIMHZB7SpbwbygUJQj+EqSjrtT1Aba3OJkrDLgr8b
	 NcCIdbD1/wvRbvZQqFWCrr2wiXlu9xBAtNRa8hlRMfNZETvkknxXxMnGGeBjB7GSWA
	 HaGbL/QkCbRp51min+e6sIEzk5Z9u6z6gJV1Jss6/eN884tA0PxN/dhudCa32kgcZN
	 bNVM2zYxKwyR494BBUIz0eWpXTXIZCGsxyjTD3QEECFtCas0CM8Ugbmr0+otWw2ca9
	 7peqK1P81jINP9z5hQINUa0FmNzu/3bLXw6JWB6+xuvjWazAIUH6qxC9bEg+cVbYs3
	 S6632LrhGW8Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18DB3DD4EE5;
	Fri, 22 Dec 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v2 net-next 00/12] tcp: Refactor bhash2 and remove
 sk_bind2_node.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170328362709.7428.12153134588085000481.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 22:20:27 +0000
References: <20231219001833.10122-1-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 09:18:21 +0900 you wrote:
> This series refactors code around bhash2 and remove some bhash2-specific
> fields; sock.sk_bind2_node, and inet_timewait_sock.tw_bind2_node.
> 
>   patch 1      : optimise bind() for non-wildcard v4-mapped-v6 address
>   patch 2 -  4 : optimise bind() conflict tests
>   patch 5 - 12 : Link bhash2 to bhash and unlink sk from bhash2 to
>                  remove sk_bind2_node
> 
> [...]

Here is the summary with links:
  - [RESEND,v2,net-next,01/12] tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.
    https://git.kernel.org/netdev/net-next/c/5e07e672412b
  - [RESEND,v2,net-next,02/12] tcp: Rearrange tests in inet_bind2_bucket_(addr_match|match_addr_any)().
    https://git.kernel.org/netdev/net-next/c/56f3e3f01f81
  - [RESEND,v2,net-next,03/12] tcp: Save v4 address as v4-mapped-v6 in inet_bind2_bucket.v6_rcv_saddr.
    https://git.kernel.org/netdev/net-next/c/06a8c04f8994
  - [RESEND,v2,net-next,04/12] tcp: Save address type in inet_bind2_bucket.
    https://git.kernel.org/netdev/net-next/c/5a22bba13d01
  - [RESEND,v2,net-next,05/12] tcp: Rename tb in inet_bind2_bucket_(init|create)().
    https://git.kernel.org/netdev/net-next/c/4dd710885430
  - [RESEND,v2,net-next,06/12] tcp: Link bhash2 to bhash.
    https://git.kernel.org/netdev/net-next/c/822fb91fc724
  - [RESEND,v2,net-next,07/12] tcp: Rearrange tests in inet_csk_bind_conflict().
    https://git.kernel.org/netdev/net-next/c/58655bc0ad7c
  - [RESEND,v2,net-next,08/12] tcp: Iterate tb->bhash2 in inet_csk_bind_conflict().
    https://git.kernel.org/netdev/net-next/c/b82ba728ccfe
  - [RESEND,v2,net-next,09/12] tcp: Check hlist_empty(&tb->bhash2) instead of hlist_empty(&tb->owners).
    https://git.kernel.org/netdev/net-next/c/8002d44fe84d
  - [RESEND,v2,net-next,10/12] tcp: Unlink sk from bhash.
    https://git.kernel.org/netdev/net-next/c/b2cb9f9ef240
  - [RESEND,v2,net-next,11/12] tcp: Link sk and twsk to tb2->owners using skc_bind_node.
    https://git.kernel.org/netdev/net-next/c/770041d337a8
  - [RESEND,v2,net-next,12/12] tcp: Remove dead code and fields for bhash2.
    https://git.kernel.org/netdev/net-next/c/8191792c18c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




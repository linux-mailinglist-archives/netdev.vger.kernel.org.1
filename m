Return-Path: <netdev+bounces-117359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A276E94DADA
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC161C20FFB
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FEA43ACB;
	Sat, 10 Aug 2024 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouNVjOF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72F15C0;
	Sat, 10 Aug 2024 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267235; cv=none; b=f3whW5SBxB0KXRo+cgdf0ks5w63H/o2Km5/QYynb05F/k38sJWdvBO0jmkVYdsCOXzfj8vLcFtwK2imWVURRycSUAO4Ls1kYROYqQ54kxCC8SZl2QqM7gUnHlzNYjQg6n37juH6ANKCR+3nSy8NhCpoG6xNbwwiqko4XXJBa0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267235; c=relaxed/simple;
	bh=4t9MZ/peOgftmugUsMu11XbhTMGWMCiZrCe7d4ROebA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OFeULKmXSlWFy4MYtg2LjPQ0VnXB4RKl0Lq1hG3Lp9nmozrAknfiMyFAnypmdw1wdcX2kblHWgK8NPdrh0Uc+j8guN1eAe8x0quXpO+B80y1h2NPNw6ZC8CbQvi9o3rc+pvmQuqQ1xmgW0yuD677UsfM7GKDXwQDaB/b+9eDaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouNVjOF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C05EC32786;
	Sat, 10 Aug 2024 05:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723267235;
	bh=4t9MZ/peOgftmugUsMu11XbhTMGWMCiZrCe7d4ROebA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ouNVjOF3erXM5y/j1KtrT+AjiNF2rgm52PrCeWL4Z0vCEZvYoPwjENSsRNoc7Qs88
	 o9tKO3uuW06GRjk78pftn7CRfye3ajrbkFePA4Zu5nk/Ivpjn5lMxXsU2P0FPDdzHW
	 ieCsRe5Qk4R2UF6UANR+sEslCfhkxJPss80u1aGFzpZxBRuEUKwCOawuaZEWyXmIeV
	 sk8VTXIpM+s6DepOM42YnbWumooEj96Kv+t4OzgYIacCYg/MAm9y6YPlnz+E0Q33P0
	 yqYqk+HdnyUnxl4AC4XHrCnjdxf2FFhyOyP4RJ1i/vQ1Ur6kIPH0Y29iUuC6NBSSBB
	 PzsERrn8S7Arg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7124C382333F;
	Sat, 10 Aug 2024 05:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fs_enet: Fix warning due to wrong type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326723426.4145426.15655037908010047292.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:20:34 +0000
References: <ec67ea3a3bef7e58b8dc959f7c17d405af0d27e4.1723101144.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ec67ea3a3bef7e58b8dc959f7c17d405af0d27e4.1723101144.git.christophe.leroy@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: pantelis.antoniou@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Aug 2024 09:16:48 +0200 you wrote:
> Building fs_enet on powerpc e500 leads to following warning:
> 
>     CC      drivers/net/ethernet/freescale/fs_enet/mac-scc.o
>   In file included from ./include/linux/build_bug.h:5,
>                    from ./include/linux/container_of.h:5,
>                    from ./include/linux/list.h:5,
>                    from ./include/linux/module.h:12,
>                    from drivers/net/ethernet/freescale/fs_enet/mac-scc.c:15:
>   drivers/net/ethernet/freescale/fs_enet/mac-scc.c: In function 'allocate_bd':
>   ./include/linux/err.h:28:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>      28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
>         |                                                 ^
>   ./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>         |                                             ^
>   drivers/net/ethernet/freescale/fs_enet/mac-scc.c:138:13: note: in expansion of macro 'IS_ERR_VALUE'
>     138 |         if (IS_ERR_VALUE(fep->ring_mem_addr))
>         |             ^~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net] net: fs_enet: Fix warning due to wrong type
    https://git.kernel.org/netdev/net-next/c/c146f3d19114

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




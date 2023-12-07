Return-Path: <netdev+bounces-54711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9B807F12
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 04:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1FCB20EE7
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210411FBA;
	Thu,  7 Dec 2023 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP/jInMv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B01C3B
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 03:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84EC0C433CA;
	Thu,  7 Dec 2023 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701918624;
	bh=CxbWwYR9nNOhf83mDjbMnPggh99gL/cNE89T71Ok0iM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qP/jInMvoUvanXpiDINCbTM2GUogn66+9IDLCpL7iJmSgsn/I7CdKAa9pABtyKPu7
	 ZWis67V/Aq9IP+tCtjawSLMHohUObDYJci5UWpFTluYziv4WNucwpQZDCYUDPG53iV
	 OhwkQ8628Osh1koAjhwBr3fdTz2jPKDje7crxnTOFmhhaIn/Jj9Is34GXCFBze3Wmd
	 GNfM9wsmYmkf/3lv4LBtZZeMi74IoM2T4Um7S+Jem4I3lqLzQyGy19yWGxV+2BDUuj
	 ITiw7TjhL6hTn+y9egTjw0U3MiKEFDPyM3Mq9bxt2+syPf8JuhBKlFcFrk+7GjWeVV
	 jQEE9CESFDFvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71563C04D3F;
	Thu,  7 Dec 2023 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 03:10:24 +0000
References: <20231205173250.2982846-1-edumazet@google.com>
In-Reply-To: <20231205173250.2982846-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Dec 2023 17:32:50 +0000 you wrote:
> Some elusive syzbot reports are hinting to fib6_info_release(),
> with a potential dangling f6i->gc_link anchor.
> 
> Add debug checks so that syzbot can catch the issue earlier eventually.
> 
> BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990 [inline]
> BUG: KASAN: slab-use-after-free in hlist_del_init include/linux/list.h:1016 [inline]
> BUG: KASAN: slab-use-after-free in fib6_clean_expires_locked include/net/ip6_fib.h:533 [inline]
> BUG: KASAN: slab-use-after-free in fib6_purge_rt+0x986/0x9c0 net/ipv6/ip6_fib.c:1064
> Write of size 8 at addr ffff88802805a840 by task syz-executor.1/10057
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: add debug checks in fib6_info_release()
    https://git.kernel.org/netdev/net-next/c/5a08d0065a91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




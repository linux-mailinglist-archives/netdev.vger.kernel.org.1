Return-Path: <netdev+bounces-21265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E07630AC
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD73B1C21111
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4FAD51;
	Wed, 26 Jul 2023 09:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12999455
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E78EC433D9;
	Wed, 26 Jul 2023 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690362020;
	bh=hu42oBZW1c+tecfvWgMv3CP+UiAieioJtItZYJGVrlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G4V4/UIcyYaCSUbhOSrSgJ2qUeE85kXtUQvsdQWiYDEA2UAFj+Lb1tA91kaOzvbH2
	 E/hvURz9JX8CDQYbRhHaGJ/IXbbaTyuDUwx/O/E1vmxVS4qImTsBEDHMs4gAeoXdoj
	 opQ3SI5Z/58cXi+Z7gAwQV6hkE9bDiEHkk+5tfR5c1IGb7JDFlMKt2zVaTkCSdRm+y
	 cVqLMLGOS5NZJzOGIFAmLdLtWhuAPdWFh3U4OQafSrmcqzvNyRNUjj7By7FlOgJeTE
	 Wj99u+0cp+uCK7fLkYDzivOR+PBzZXTUZfwiJh2oa93I0Uwnz2K7mn1JxcoY3M7bR6
	 beMKVcfJmUjiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B5F5C3959F;
	Wed, 26 Jul 2023 09:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: skbuff: remove unused HAVE_HW_TIME_STAMP
 feature define
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169036202030.9751.13798450530247127386.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 09:00:20 +0000
References: <20230724162255.14087-1-ps.report@gmx.net>
In-Reply-To: <20230724162255.14087-1-ps.report@gmx.net>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, simon.horman@corigine.com, ast@kernel.org,
 linyunsheng@huawei.com, asml.silence@gmail.com, richardbgobert@gmail.com,
 patrick.ohly@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 24 Jul 2023 18:22:55 +0200 you wrote:
> Remove unused HAVE_HW_TIME_STAMP feature define (introduced by
> commit ac45f602ee3d ("net: infrastructure for hardware time stamping").
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v1 -> v2:
>   - specify target tree net-next
>   - subject change from 'skbuff: ...' to 'net: skbuff: ...'
>   - add CC netdev@vger.kernel.org (instead of linux-kernel@vger.kernel.org)
>   - add CC Patrick Ohly <patrick.ohly@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: skbuff: remove unused HAVE_HW_TIME_STAMP feature define
    https://git.kernel.org/netdev/net-next/c/2303fae13064

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




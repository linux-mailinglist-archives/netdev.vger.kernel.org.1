Return-Path: <netdev+bounces-34542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFFC7A48BD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28693281D7D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2B61CA83;
	Mon, 18 Sep 2023 11:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59E38F88;
	Mon, 18 Sep 2023 11:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B14C7C433C7;
	Mon, 18 Sep 2023 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695037824;
	bh=lLmkRmQrVDMuWLiRnc6WZi6wkS4qkGabF5MldHO9ynE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XMsUM/6PTgmQgGOOp+k7DuQuDMgisWtNdzkwmPbc9znYTejBeA+hsBwQw3bKOTREQ
	 gw/88uAwnjD/eBg5/DaeyqOfGKRvuutbX4nMRIL3elp/RoyhlzIPMeRFx+BTfIVpEA
	 lGC7Y/mu+YyXSR3UY7IJF2t3xHwj26jtDMSa2kNablJvBh402XtE76bGbdXeYxTvky
	 WcSEacr2gCfOqDXYr6jwORaRCG2EFYBzeqyvdsgPUVWpYbJ7YDaxEEWDGgo88Xtpc0
	 xT2b6SQzQyW5I0JAzykFpg8Ml9NRGr2tfwZkXFgUgZQpXdgf6wuy7SqgKWd7eQg0Po
	 KWftbkmHd8jCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 909DFE11F41;
	Mon, 18 Sep 2023 11:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: fix stalled connections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169503782458.2272.14155670573882201410.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 11:50:24 +0000
References: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
In-Reply-To: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dcaratti@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 16 Sep 2023 12:52:44 +0200 you wrote:
> Daire reported a few issues with MPTCP where some connections were
> stalled in different states. Paolo did a great job fixing them.
> 
> Patch 1 fixes bogus receive window shrinkage with multiple subflows. Due
> to a race condition and unlucky circumstances, that may lead to
> TCP-level window shrinkage, and the connection being stalled on the
> sender end.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: fix bogus receive window shrinkage with multiple subflows
    https://git.kernel.org/netdev/net/c/6bec041147a2
  - [net,2/5] mptcp: move __mptcp_error_report in protocol.c
    https://git.kernel.org/netdev/net/c/d5fbeff1ab81
  - [net,3/5] mptcp: process pending subflow error on close
    https://git.kernel.org/netdev/net/c/9f1a98813b4b
  - [net,4/5] mptcp: rename timer related helper to less confusing names
    https://git.kernel.org/netdev/net/c/f6909dc1c1f4
  - [net,5/5] mptcp: fix dangling connection hang-up
    https://git.kernel.org/netdev/net/c/27e5ccc2d5a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-29025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F07816BF
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57781C20D8A
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13791817;
	Sat, 19 Aug 2023 02:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2B2632
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC7E8C433C9;
	Sat, 19 Aug 2023 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692412821;
	bh=8AFt+3D5Ud6YPMMkymI82UF20wZ3CUQgkzOSNNa7DvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M3FzaLP/EXfmRgKFb+1JJBP6jVwv0Ed1iRrNN6KW6uOZ7KIEvafreH0maLUq9LTib
	 kcwivvxVV9Y6YqGyFE4RvR+6HlGls4MjL0pEW+xkRxxQMQLbTjXuCEz97XmFaOXKjX
	 0nlaeLimkR7MzWSDXn7ziVJ3wTtSXmpKOdzh5CJg60+MwBRSMVLtCm2E17PjzK7sHv
	 ZdbJKjTTMV1Ex8tblkwSRX8NNMpLg4/RP8ROIV36bLfFgI/eRbZXJ7v+qvZ2ckAwhT
	 3f6xf7R44KSyTkQBIq9MOlDvT5eKGycdpzpau9g0tNl1H+Ptt3MbcOwTJbH/oe/hfQ
	 taMNc5xLPXzvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D233FE1F65A;
	Sat, 19 Aug 2023 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sock: annotate data-races around prot->memory_pressure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169241282085.17352.16613003208460701805.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 02:40:20 +0000
References: <20230818015132.2699348-1-edumazet@google.com>
In-Reply-To: <20230818015132.2699348-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, wuyun.abel@bytedance.com,
 shakeelb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Aug 2023 01:51:32 +0000 you wrote:
> *prot->memory_pressure is read/writen locklessly, we need
> to add proper annotations.
> 
> A recent commit added a new race, it is time to audit all accesses.
> 
> Fixes: 2d0c88e84e48 ("sock: Fix misuse of sk_under_memory_pressure()")
> Fixes: 4d93df0abd50 ("[SCTP]: Rewrite of sctp buffer management code")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Abel Wu <wuyun.abel@bytedance.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> 
> [...]

Here is the summary with links:
  - [net] sock: annotate data-races around prot->memory_pressure
    https://git.kernel.org/netdev/net/c/76f33296d2e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




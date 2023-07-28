Return-Path: <netdev+bounces-22421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462C767723
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5DC2823E5
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69848156C3;
	Fri, 28 Jul 2023 20:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F028ED
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 20:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD8AFC43395;
	Fri, 28 Jul 2023 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690576824;
	bh=n8+5Jeqs2Vak+HqO4726x3f+bcTekfKU41XLHggg804=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qPkkhEaW+5yu6GXq86cAb8FGqX9U+g3RVq/6KkxnLg9pkOlGEfhvg9BrJh64PWIpy
	 qmZxZhoNT+q8v1haF4B90NfONJb+HK/luIwx18v2kpdImhESvamJn+eLt6r0I5l1w0
	 l4cRvuzYDdJ31FNAMYvdCtGN2YF52n0YxT75JJ477WNy+qDyfKo1nGGioSBCvOKSof
	 pewCBa74Aq0fBhCKCsZGuqiP0CWxbc6Qwo3FeEFW366b3M7kBs7YH68lPf+y8s5XDV
	 DvO0iKzsKLUu1XfGIoPVlubkMfzixqWdjY3B9BeG5Vj1mBge1eqrBU+zsSFoWFeB4w
	 OzoBcQl6P/9dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C95FC4166F;
	Fri, 28 Jul 2023 20:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2] net: change accept_ra_min_rtr_lft to affect all RA
 lifetimes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169057682463.20429.934464089446215537.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 20:40:24 +0000
References: <20230726230701.919212-1-prohr@google.com>
In-Reply-To: <20230726230701.919212-1-prohr@google.com>
To: Patrick Rohr <prohr@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, maze@google.com,
 lorenzo@google.com, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 16:07:01 -0700 you wrote:
> accept_ra_min_rtr_lft only considered the lifetime of the default route
> and discarded entire RAs accordingly.
> 
> This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
> applies the value to individual RA sections; in particular, router
> lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> lifetimes are lower than the configured value, the specific RA section
> is ignored.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
    https://git.kernel.org/netdev/net-next/c/5027d54a9c30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




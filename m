Return-Path: <netdev+bounces-115445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624F94662B
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408AE283580
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA913B7BC;
	Fri,  2 Aug 2024 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDS57pco"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D222EF4
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641445; cv=none; b=Y4X0pYWhyNcP3YkieVilhVFcnatVE0EAlgO4n4F+1YSGd48lvmmXA3PoVJhCUrOiBqSphPu1D0aglnwgovgw9T0hKCAf3AxAe7gSlh2pA9nQjmti6+PkYG0E7yjBSl+kwU2DOqkyWs2MyYJb66GlhNRv72XfkIFQo2lQCzVuALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641445; c=relaxed/simple;
	bh=vsAeKCg2q4wwXl51PjzXPMINW3pDmp4GVvx1Qb7m+DI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZrzNf/7Ej29EMwrECzJbyeuUN4TyBqYwE86FOvjChUSnsZtDJSLAz53o08odzUlJlBNRlUiP3TBKMveDrysJNS74HI4sq0Xt6tDfUSV2n0RRcSp2kI2Z1l5eylGj0JUccVSTdQL+JtdVZepSWbRrYVJnbjIIwObdk0Lxyrbr+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDS57pco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA9BFC4AF17;
	Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722641444;
	bh=vsAeKCg2q4wwXl51PjzXPMINW3pDmp4GVvx1Qb7m+DI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lDS57pco+v3XY8oKGhvfxfMkp2gXFZ800x/Sgn/tfZWsDY0EgLtiFZoN25YD+TGRB
	 OVf2coOLltAZuP1s42mdp7OgU6e579TWqSin6pqJNjY4UkTODY5wjU8dcifunpcwYE
	 2GOnu7bIC/4rLXmRIug7h+wKvpDGGqPnmlv76S8qFqE1YXH9DN9WRkHsg0zJMrz30o
	 nLEO9B1LJp3hEyjfneKo9aUSXlcc/o63FhS4NLg5FTXvatlMG+5Uad6L8W8UlB4zFa
	 J2MGGMhiG7svNg/gpS98URoHFv8pNQr++i3m+Imp9hfz4TWRQoUtgNtNPtdPPxhWBD
	 KMMVwFUUuVEbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99DF9C6E39D;
	Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: ksft: print more of the stack for
 checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264144462.25502.8074535994926179602.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:30:44 +0000
References: <20240801232317.545577-1-kuba@kernel.org>
In-Reply-To: <20240801232317.545577-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Aug 2024 16:23:17 -0700 you wrote:
> Print more stack frames and the failing line when check fails.
> This helps when tests use helpers to do the checks.
> 
> Before:
> 
>   # At ./ksft/drivers/net/hw/rss_ctx.py line 92:
>   # Check failed 1037698 >= 396893.0 traffic on other queues:[344612, 462380, 233020, 449174, 342298]
>   not ok 8 rss_ctx.test_rss_context_queue_reconfigure
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: ksft: print more of the stack for checks
    https://git.kernel.org/netdev/net-next/c/46619175f1b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




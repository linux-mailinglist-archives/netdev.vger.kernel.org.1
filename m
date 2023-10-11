Return-Path: <netdev+bounces-39796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6568D7C47F8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9636F1C20A71
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27328610D;
	Wed, 11 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRS9cSDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219F4693
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88B8CC433CC;
	Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696992625;
	bh=dhq0OY2ZHhEPu7TLUXVwoChTdS8iexXUUd96uFlgNek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRS9cSDDN3W5xLm86r68016t6MZiDIEFORyr6YtLAqWHUHglCfeNeEMOT0k+4O/79
	 Ir5SIFj5cH3qtcQ4qFsEnKqvkq5sT8bxoUWb6j/cZM3bhu54kwO2msOf0zYUPlkdn7
	 gI20/ufuoPupr01J0HJzFGfh7y9N1ACwA/yz1OK8PkOdqvvEJ53+2DGVAljXX/h/tJ
	 256IyVaKMidpluv5YhUnd7P16BxQ+1/85/UVeChubxVmq+AhgMB69l+RfMLPiJ9mDc
	 OFhaTHF5lhH7jsqMqcOmrkW2/+zHYiIrErt5JSdQWMCiqLrK/kTylhIG0ztbchoQKa
	 vN9K/qZJZk3pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 709FAE11F45;
	Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mctp: perform route lookups under a RCU read-side lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169699262545.24203.13245962379132650786.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 02:50:25 +0000
References: <29c4b0e67dc1bf3571df3982de87df90cae9b631.1696837310.git.jk@codeconstruct.com.au>
In-Reply-To: <29c4b0e67dc1bf3571df3982de87df90cae9b631.1696837310.git.jk@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, rootlab@huawei.com, matt@codeconstruct.com.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Oct 2023 15:56:45 +0800 you wrote:
> Our current route lookups (mctp_route_lookup and mctp_route_lookup_null)
> traverse the net's route list without the RCU read lock held. This means
> the route lookup is subject to preemption, resulting in an potential
> grace period expiry, and so an eventual kfree() while we still have the
> route pointer.
> 
> Add the proper read-side critical section locks around the route
> lookups, preventing premption and a possible parallel kfree.
> 
> [...]

Here is the summary with links:
  - [net] mctp: perform route lookups under a RCU read-side lock
    https://git.kernel.org/netdev/net/c/5093bbfc10ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-180721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE6A82416
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1BD1B66FA9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBCC25E463;
	Wed,  9 Apr 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQGK+l/y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B125DCE9
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199998; cv=none; b=dGBn1P7dFjWA7rPGUQdooiP70YNHB1n7P9imdLagaygpJcSZKDMn8GWWcOeMnruVdVjoTH7GdqZ1hwbVdO81MNG9KT3zL/CxEO0H8RTIJknoIipA/nteRBlJ4vNSP/Mhpb5hOYtk10CKeWTh0D7/v28gv0VqS7fOBE79cp7mOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199998; c=relaxed/simple;
	bh=UeVaUpGckLqe3u4NPYNDHrmcLio1DL+K4Gg3hUTZ2M4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PE0qXXqCubwnDMzFY3jSOatgEUKA5NSOvG3rBzRn7FSkLtSL9Bg8YOe2fV+RB1OQOeWxROOWPQ/tJrDBb17+UV6CI6njAGhULKhxU//lJysW/dvTacGW7xbT0OZqU8EAngeTieOlhc2d4Ux3FECZ+rw39KGn7tTs8wlj59tkdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQGK+l/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41386C4CEE3;
	Wed,  9 Apr 2025 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744199998;
	bh=UeVaUpGckLqe3u4NPYNDHrmcLio1DL+K4Gg3hUTZ2M4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mQGK+l/ym3thsVasbrehMvUkBRRpnpl7SgRYewIpj/E214YV8AfgYpK8/o1vUUrzj
	 F0hzdBU1iUVEJAWPDPbEaQjl2bbCF/RgZMUndv0pzfvW5XTLXRxMq+UJCkVeDunpFT
	 ae1EA1/a5Q014r/ktymD+U+AisPzwWwg95Q+PXdws9M/6SbsAoB+Dc07bI35XhthxP
	 TdeBAe4KnQtSELAAnSVz3CC/D4oEipIgwtpY8EYcls8YWgxOicHNpAsu8OQSnym13W
	 5sbzbb5RN6r2FFcgmSTNVEpVJeP85zvWlMCPYTiHyAee4vibYu5AYT2pbTkP0vFoSq
	 0WJ94FUzphusQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DF1EC380CEF0;
	Wed,  9 Apr 2025 12:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net_sched: sch_sfq: reject a derived limit of 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174420003545.2791114.5721266695877616211.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 12:00:35 +0000
References: <20250407202409.4036738-1-tavip@google.com>
In-Reply-To: <20250407202409.4036738-1-tavip@google.com>
To: Octavian Purdila <tavip@google.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  7 Apr 2025 13:24:06 -0700 you wrote:
> Because sfq parameters can influence each other there can be
> situations where although the user sets a limit of 2 it can be lowered
> to 1:
> 
> $ tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 depth 1
> $ tc qdisc show dev dummy0
> qdisc sfq 1: dev dummy0 root refcnt 2 limit 1p quantum 1514b depth 1 divisor 1024
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net_sched: sch_sfq: use a temporary work area for validating configuration
    https://git.kernel.org/netdev/net/c/8c0cea59d40c
  - [net,v3,2/3] net_sched: sch_sfq: move the limit validation
    https://git.kernel.org/netdev/net/c/b3bf8f63e617
  - [net,v3,3/3] selftests/tc-testing: sfq: check that a derived limit of 1 is rejected
    https://git.kernel.org/netdev/net/c/26e705184e7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




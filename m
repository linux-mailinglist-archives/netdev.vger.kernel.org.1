Return-Path: <netdev+bounces-126140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC196FEFB
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956D2284475
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B658836;
	Sat,  7 Sep 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd4vdpkE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4B7483
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672632; cv=none; b=cBfhBwBqdlatw7qZX0yuw9sKROuLzXuSmhDjnrSFNsmKF71HLASut1+Iubn3CHjJP6uj/3lyA5aVc6iwybBXgHX5yxyG2Tfsl5hbCiDXzJig2ClgYEldVmzP86p8809r2oY+tKd8k6VV86R4wsxckyKFVjn2poHdsg5KSv15Cew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672632; c=relaxed/simple;
	bh=JEVEsXWvTmVhhSdIIT6QAg4x10SZR9cuh+pS/Hqij88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RDgfR4crFks4/xLrAEDK5nVrHpYrr+Uh+vXkYS91ITg+WMGGLPQ3A5JWx4e82j1xk0qvsZmsltTZFAv+mV9J5CU/nNoYhQxoJ2e00vvL1CheZSnRhpZbo8Qnzbu5rONd0u5+Kzces3eoQ6684STG0cWFNHI/Rgf4v2WgdkNmMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd4vdpkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB0EC4CEC4;
	Sat,  7 Sep 2024 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672631;
	bh=JEVEsXWvTmVhhSdIIT6QAg4x10SZR9cuh+pS/Hqij88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gd4vdpkE8xCXdYteMbyEa0Fmo038AtA0nmTe/zZPjfYq28IejTy7kdKd8X7pGq6Uq
	 QfD1237N1rOjHAY91jteu4PgoQ016d8rlF9jzojQ62NJE3aML5rLAIg0L9YBrzUoOr
	 qbtjNXd91SkicDVbuN56Vqywq/RWI2s2ssIpdBps+A8u4D+cfbD5oI3sLiihY7cY4d
	 TYdTgcIgjbBc3V+yULALDhx4ocg8E3/ANSnT2Pfs1ROiYBpcEW+gIO9Mqte08Z2f/G
	 KABtfDqYZZdTa/k/eacJDYGpfy9w3woxrqB9w2nm/PrLqmic1YB5ZYycjDb5Elw8+L
	 NL+wGRjERVQsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4E3805D82;
	Sat,  7 Sep 2024 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netpoll: remove netpoll_srcu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567263251.2576623.13971300092615224613.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:30:32 +0000
References: <20240905084909.2082486-1-edumazet@google.com>
In-Reply-To: <20240905084909.2082486-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, leitao@debian.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Sep 2024 08:49:09 +0000 you wrote:
> netpoll_srcu is currently used from netpoll_poll_disable() and
> __netpoll_cleanup()
> 
> Both functions run under RTNL, using netpoll_srcu adds confusion
> and no additional protection.
> 
> Moreover the synchronize_srcu() call in __netpoll_cleanup() is
> performed before clearing np->dev->npinfo, which violates RCU rules.
> 
> [...]

Here is the summary with links:
  - [net-next] netpoll: remove netpoll_srcu
    https://git.kernel.org/netdev/net-next/c/9a95eedc81de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-251287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B4D3B81B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B52343008E02
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D52BEC41;
	Mon, 19 Jan 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT5rrgmF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D5265CA8
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854012; cv=none; b=Y7iN+KHN/Grm/MzQ9meVbCx4n2YrFbbkvLLxvMuQJXV6m5y+rwlHVQGkPfx10wO38eyGOa2mn+88SSCx+dLiOXTafoV5gP/efYaHa29lovPV31Xtr8CB8bvsikYlh4dnpAyaCEzzYvEZMmkAzUParTnENxrTUPAyPezSW/GuWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854012; c=relaxed/simple;
	bh=wvK3Zd6V6eiO6j1ryz1b7EuxshxMrcRo0utuLa1/Be0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n5jiQaACjkthIDZt+Q0LW5/zhcvPbk0Bb2sOCRQbawWaB5BvPXd8qb2dIM3XRFoZGSoMzG96jr8wBRqs0keh0NFP+0Ok/Tc0CqgBWfoC2hJbRs5lZ5meFDx3AlDqRHqIiHDH1dfVxVjHHGqIuOcHJmLdgg4MbFUHmN8KFuoqjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT5rrgmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3E2C116C6;
	Mon, 19 Jan 2026 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768854012;
	bh=wvK3Zd6V6eiO6j1ryz1b7EuxshxMrcRo0utuLa1/Be0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZT5rrgmF2Bhok0Wtl3yLl4AVvFuxoWuDeSwFFS+TWbSMnTJfJ1kwcyWkIRBdux55W
	 MCuTjDaI00ryObZh2q+C4mjKre8s/eU5kvjogDVCdRqmEmffyXRR6RZHoRzxWcJNVC
	 todV3pbvJm7xSh8k6ae8qJ0eIqE8r2PUBXY5SED4mntY9iuKSyXMxAWa/fafsAZwOT
	 Rm0BaoX80fs7zX3OqZThtc8rV7S9bbBTQdb1cnZkLbq6NfoeKsTxIT/Sz9TB2dYWyT
	 wpXNT8oCu7v+/niMPG6tqXL9s8wqTOtiUr+p2NFetMpdzXv2VqHlLzPH15JiHwWnEw
	 fPXZzrnpfRxKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3ECB43806907;
	Mon, 19 Jan 2026 20:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net/sched: teql: Enforce hierarchy placement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176885400979.123996.17622042838765819298.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 20:20:09 +0000
References: <20260114160243.913069-1-jhs@mojatatu.com>
In-Reply-To: <20260114160243.913069-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 victor@mojatatu.com, km.kim1503@gmail.com, security@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 11:02:40 -0500 you wrote:
> GangMin Kim <km.kim1503@gmail.com> managed to create a UAF on qfq by inserting
> teql as a child qdisc and exploiting a qlen sync issue.
> teql is not intended to be used as a child qdisc. Lets enforce that rule in
> patch #1. Although patch #1 fixes the issue, we prevent another potential qlen
> exploit in qfq in patch #2 by enforcing the child's active status is not
> determined by inspecting the qlen. In patch #3 we add a tdc test case.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/sched: Enforce that teql can only be used as root qdisc
    https://git.kernel.org/netdev/net/c/50da4b9d07a7
  - [net,2/3] net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag
    https://git.kernel.org/netdev/net/c/d837fbee9245
  - [net,3/3] selftests/tc-testing: Try to add teql as a child qdisc
    https://git.kernel.org/netdev/net/c/2460f31e6e44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




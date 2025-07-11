Return-Path: <netdev+bounces-206279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB34B02747
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0521C8837D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF71F2C34;
	Fri, 11 Jul 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP8eD9zX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F133993
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274786; cv=none; b=IhS41ylpPmTsst3E2WzcYzmak2bib4BPNj2UHBN04jhm+q4L2pDt7WCL9tLufeGpKEkUQ448bUKhsvhQM+H420yhMVFvsiw2bkZRnUY+Vmd1ZmyvHuI78i5RUgMNzloWKFvXvVT79r47QfhHGbLXJToxPJfd+rTJyJbHchkQzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274786; c=relaxed/simple;
	bh=J43fBBxBDlZZ75uuU4jPmdFK/GEdc8kCWdPSAD+3/0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfBVTiYo4+BRV5y4GwvFbniHhGJuGhv0jPl39628T7HIdRJwEA9qU5wrxdUUc33oR100Y399KVySREiSjauf3tPoaMQA/hD9/vWx1nvQiWH4KJwJ+7R2T19AFHNbhcCgRzVCg9ezDxF9It44BndocnQOQQw0JdGxBo+hCWFSfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP8eD9zX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2012C4CEED;
	Fri, 11 Jul 2025 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752274785;
	bh=J43fBBxBDlZZ75uuU4jPmdFK/GEdc8kCWdPSAD+3/0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pP8eD9zXUOQ5qN5cIbdGbFNDGyk+1Fk6h03qkdVV+ESsuJ2wx/rFys7TRrrLlYo7X
	 SM0rLYpjYP7riRkxk+wPjH9RaETlgpMy2a7CRkzF5amtYfqI8+ZDGCW0C5+RLrSJQy
	 ohR7++dB97GTmZGm9XQxtt7cof4Yv9Vc6KnnHnlIg8IIOjHifyvsg9+5j8mnr3P9k6
	 AcbQvxKx5DOo0TEhS+7hpIqLZNAHTUtzvtBwpMe4FRpQkVahra/GOw2TVK41pIdhgC
	 ZALM5QTfa44trXCZLXt0fMT7/7YvjZrAQqhTzBp/4ObVnSHa7LmUoLHYcR6lGwcQuS
	 KVjg/mE8KPMfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE28383B275;
	Fri, 11 Jul 2025 23:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175227480776.2426458.11434480154400917099.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 23:00:07 +0000
References: <20250708164141.875402-1-will@willsroot.io>
In-Reply-To: <20250708164141.875402-1-will@willsroot.io>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
 kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com,
 savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Jul 2025 16:43:26 +0000 you wrote:
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue, as seen in [1].
> Ensure that a duplicating netem cannot exist in a tree with other
> netems.
> 
> Previous approaches suggested in discussions in chronological order:
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
    https://git.kernel.org/netdev/net-next/c/ec8e0e3d7ade
  - [net,v5,2/2] selftests/tc-testing: Add tests for restrictions on netem duplication
    https://git.kernel.org/netdev/net-next/c/ecdec65ec78d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




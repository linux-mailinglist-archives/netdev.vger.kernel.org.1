Return-Path: <netdev+bounces-73651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8713E85D6F4
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5401F22908
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA845BFE;
	Wed, 21 Feb 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN7LOEsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AE405EB
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515027; cv=none; b=P+iSqqCqUjnNTTwVaTCJlIz3+XkvFuChkQvfeWsr7FMC2KJUIZO09excGw6JmA2mZepM31AeEZHehtF/6pXrsgjG4RNwpWSFtQBS0Kg4xF3QGIxFe5PqeJfTKJh2BnNCRQ913f4MDCo3vAu9iHwLCQhm2NmgETVidkNzlGZF5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515027; c=relaxed/simple;
	bh=ZBq0h7tgOSSSNR7Ehu4pQcBsQwLbLZ/cHx4GR18DrbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j/DBffdK9K9NuisHHhYJfs7Bert29YKkC9YTmvIPVGfWBL5+idRAIxcm61XIL7rr9nFmyNanS0wsb7sXszzLaTt2R+1DZ6A8S72LOLvOJD0vYUumB8jT6ijBWALcWTl1IdKAiYqM3d1pC7t9K8PmSn/DRG/2fXBGPYM3nZl2c2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN7LOEsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C519C43390;
	Wed, 21 Feb 2024 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515026;
	bh=ZBq0h7tgOSSSNR7Ehu4pQcBsQwLbLZ/cHx4GR18DrbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GN7LOEsnlCRwcBXxciORAzJtC/e6qU4MBslPFwpv+l+qEGvHVVJTNTbH85PdDpB7J
	 8YrB1Ld/5d+hDl8LwjunjTmyhcLtDxloS9P39NfdNIdrsb5EPipdzn3R8tNEq8zvj3
	 SPMPr/pESkYBlEM0vbdKZl1CaApA3aA9i8ZWYV6/+MCdogT039NAeyuNw7lziOU2Cq
	 sl6LUkZ8te5oCkei+kDs8quJ/oJiUSaaqZLc96FAAzBOnKB2uxJMAHBnKaKsUoZxN0
	 WOW1M6PuML8z9gwkM90l4DfETNWQAC2+pi+zgarwtD4qeV47yVydZsCFSZqO5jshmc
	 x7NxDdUhKcIAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 851FFC04E32;
	Wed, 21 Feb 2024 11:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851502654.15341.9370041553811583230.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 11:30:26 +0000
References: <20240219141220.908047-1-edumazet@google.com>
In-Reply-To: <20240219141220.908047-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 willemdebruijn.kernel@gmail.com, daan.j.demeyer@gmail.com, kuniyu@amazon.com,
 martin.lau@kernel.org, dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Feb 2024 14:12:20 +0000 you wrote:
> syzbot reported a lockdep violation [1] involving af_unix
> support of SO_PEEK_OFF.
> 
> Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> sk_peek_off field), there is really no point to enforce a pointless
> thread safety in the kernel.
> 
> [...]

Here is the summary with links:
  - [net] net: implement lockless setsockopt(SO_PEEK_OFF)
    https://git.kernel.org/netdev/net/c/56667da7399e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




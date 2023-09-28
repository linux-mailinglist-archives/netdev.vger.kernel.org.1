Return-Path: <netdev+bounces-36703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12997B15EA
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3248B28266B
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2854328DD;
	Thu, 28 Sep 2023 08:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2B328DB
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D4A9C433C9;
	Thu, 28 Sep 2023 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695889224;
	bh=8JQsMXc3iJmoCzRo09nhAL5gB78xT9aEZYwZ4ZJ2+mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mMch98jDC2aGYEhL46mnZulyKVlkzcp+TC243pAdKRxxKinO5DwpWlvyFfsKU8HOE
	 z3zTOu9vAxDOanlNL02OQGqjbJfk2Xai88MkJc6RA+on38xxM5pybyC+BEP/EqocuD
	 1j35FCck/WMWP6f1MnvhwFrFPkXgGSgxgYuI4z8SudJxHAqY4cWsMv8lSUd2/IBQF5
	 Nal1lWmPuKLHbtx+Y8iyiVy4ew4eTyyndRCdOkNOdr+3XV2K/4x+rE9PK8aDdJwdNj
	 iQhFkqfDGQejihxz06VSbDXjaR5MDrMwLg8UQH44kAUgGU+kyTrd4KBNH1vaZ8q0ZA
	 e4X5dzuRELvoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 135D3E29B00;
	Thu, 28 Sep 2023 08:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] selftests/tc-testing: parallel tdc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169588922407.16415.6964851286478885748.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 08:20:24 +0000
References: <20230919135404.1778595-1-pctammela@mojatatu.com>
In-Reply-To: <20230919135404.1778595-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 10:54:00 -0300 you wrote:
> As the number of tdc tests is growing, so is our completion wall time.
> One of the ideas to improve this is to run tests in parallel, as they
> are self contained.
> 
> This series allows for tests to run in parallel, in batches of 32 tests.
> Not all tests can run in parallel as they might conflict with each other.
> The code will still honor this requirement even when trying to run the
> tests over the worker pool.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests/tc-testing: localize test resources
    https://git.kernel.org/netdev/net-next/c/98cfbe4234a4
  - [net-next,2/4] selftests/tc-testing: update test definitions for local resources
    https://git.kernel.org/netdev/net-next/c/d227cc0b1ee1
  - [net-next,3/4] selftests/tc-testing: implement tdc parallel test run
    https://git.kernel.org/netdev/net-next/c/ac9b82930964
  - [net-next,4/4] selftests/tc-testing: update tdc documentation
    https://git.kernel.org/netdev/net-next/c/d3fc4eea9742

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




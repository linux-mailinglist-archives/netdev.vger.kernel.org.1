Return-Path: <netdev+bounces-17517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDCD751DB1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5F4281C82
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58A7101CB;
	Thu, 13 Jul 2023 09:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E09100D6
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08624C433CA;
	Thu, 13 Jul 2023 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689241822;
	bh=ua6AeNPHoldtpje7N2OSlaux2Q4O19S9mN14afTmFy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UOYqcQBwh0BuvFiqgKuGNIBtgWUOIackyK2PiRpUSh67hFlzrPgYKVEzGzDPkPim9
	 k+fyx6Pu6cI0daU/rsi9apP9wMaaN5hIXnPpnnrRuxZyUbRihlWwC0/JOCzxJxxriT
	 jbKzdFv3TBEHxPf88ScDZX5btREpqtqbTRkWOIx3qf+7dVMyuhTLJhw8Q0zaBYm9Po
	 +y2ECDhV8bvN0PKAMMG8PpV6bqVzw1MuCiBto5yY4yo54D7kn+5XAPTWEu2MZgykx1
	 gcsgDbshpTSIUccUgZZNNJXl+6pyD4TJHEVE67xPKH6l0fe3CuubfGYLyaN46GknUj
	 2PKuhRaxqdV4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0791E4D002;
	Thu, 13 Jul 2023 09:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] net/sched: fixes for sch_qfq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168924182191.11208.6008643972888907150.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jul 2023 09:50:21 +0000
References: <20230711210103.597831-1-pctammela@mojatatu.com>
In-Reply-To: <20230711210103.597831-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, shaozhengchao@huawei.com,
 victor@mojatatu.com, simon.horman@corigine.com, paolo.valente@unimore.it

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Jul 2023 18:00:59 -0300 you wrote:
> Patch 1 fixes a regression introduced in 6.4 where the MTU size could be
> bigger than 'lmax'.
> 
> Patch 3 fixes an issue where the code doesn't account for qdisc_pkt_len()
> returning a size bigger then 'lmax'.
> 
> Patches 2 and 4 are selftests for the issues above.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] net/sched: sch_qfq: reintroduce lmax bound check for MTU
    https://git.kernel.org/netdev/net/c/158810b261d0
  - [net,v3,2/4] selftests: tc-testing: add tests for qfq mtu sanity check
    https://git.kernel.org/netdev/net/c/c5a06fdc618d
  - [net,v3,3/4] net/sched: sch_qfq: account for stab overhead in qfq_enqueue
    https://git.kernel.org/netdev/net/c/3e337087c3b5
  - [net,v3,4/4] selftests: tc-testing: add test for qfq with stab overhead
    https://git.kernel.org/netdev/net/c/137f6219da59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




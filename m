Return-Path: <netdev+bounces-31908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF8B791584
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327F5280F06
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571A186E;
	Mon,  4 Sep 2023 10:12:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225A7E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 10:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8790C433C9;
	Mon,  4 Sep 2023 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693822336;
	bh=fezHBA/M3OEKY2x4ARKuM/ronSTwC271t2A59PBCFso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VYoDBjvnvZ5mwzR2d9GxEIfaqnYFdUilX6wmg8fBDe1G/BaJzNqjOh5zBf7beknpx
	 Q9NZq53g+mjguXbP83V6FMCgZQ3hx40zf0oaw/NAcuBfFO93CSx80SPrEiwWadO1Jl
	 0G2zNdnQjpjaExIZMlxJqJOmUIXCEEvnb/rAkp3tlv4luB7dmwB1D32g+26qFmJR8P
	 u9V57QHHbCFuaTHzz4AK2o9XLecH4atO9tio1x8J3uLlPBqqKD6gjnhC/O5Piyfd8k
	 PtzeM71FekDWeuRcJLNgA3w6xnJb5NJBucFqd2vfh4m54OmKSMzPOk/otcrT3Le03P
	 u45+tl+DPIxWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF3E7C04E26;
	Mon,  4 Sep 2023 10:12:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/4] af_unix: Fix four data-races.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169382233671.16998.8860537158332315850.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 10:12:16 +0000
References: <20230902002708.91816-1-kuniyu@amazon.com>
In-Reply-To: <20230902002708.91816-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 1 Sep 2023 17:27:04 -0700 you wrote:
> While running syzkaller, KCSAN reported 3 data-races with
> systemd-coredump using AF_UNIX sockets.
> 
> This series fixes the three and another one inspiered by
> one of the reports.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net,1/4] af_unix: Fix data-races around user->unix_inflight.
    https://git.kernel.org/netdev/net/c/0bc36c0650b2
  - [v1,net,2/4] af_unix: Fix data-race around unix_tot_inflight.
    https://git.kernel.org/netdev/net/c/ade32bd8a738
  - [v1,net,3/4] af_unix: Fix data-races around sk->sk_shutdown.
    https://git.kernel.org/netdev/net/c/afe8764f7634
  - [v1,net,4/4] af_unix: Fix data race around sk->sk_err.
    https://git.kernel.org/netdev/net/c/b192812905e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




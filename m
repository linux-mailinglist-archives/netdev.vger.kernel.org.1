Return-Path: <netdev+bounces-45890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1957E024D
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 12:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D4D1C209CD
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0B154AF;
	Fri,  3 Nov 2023 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCtjUrkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD514F9F
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 11:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF32EC433C8;
	Fri,  3 Nov 2023 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699011623;
	bh=sqzwThwQ8TsmxUE5Zzgl2JfsfAgSBHnHcqG9N4ciCIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uCtjUrkcSJN0qWpy1qwce6Ygfw89cwNLqIm9Sq8Xu0ODJ3mYEUVKBi6aexoFur8CJ
	 9rIaGHGBUDnz7VREPh7LPcyGxYlwYmFmLmKxDEbyjeBKtPazYkZ9XguONMkHfm38fa
	 nuW8vW2cAFzAa/rx93sOM2RS3TXhIv8mQKk+QNFwoFbZliUXKmxt9t5UQugIIq0Qyh
	 x4OKG5xDByMG1174LHyYz6SOgtGCNFKAHyvtj6PAVUoTuLo+XQWEUecyTcryM6VVno
	 kJnhMAe57j3I0Egum/Ny3aEQFOVHdSPABQl+SI2BKu7D+BdZdDWdmr9oU3oYTuoc0r
	 op1GwMdT5gH0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2E3CEAB08A;
	Fri,  3 Nov 2023 11:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/tcp: fix possible out-of-bounds reads in
 tcp_hash_fail()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169901162366.23509.10060779621583802405.git-patchwork-notify@kernel.org>
Date: Fri, 03 Nov 2023 11:40:23 +0000
References: <20231101045233.3387072-1-edumazet@google.com>
In-Reply-To: <20231101045233.3387072-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 dima@arista.com, fruggeri@arista.com, dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  1 Nov 2023 04:52:33 +0000 you wrote:
> syzbot managed to trigger a fault by sending TCP packets
> with all flags being set.
> 
> v2:
>  - While fixing this bug, add PSH flag handling and represent
>    flags the way tcpdump does : [S], [S.], [P.]
>  - Print 4-tuples more consistently between families.
> 
> [...]

Here is the summary with links:
  - [v2,net] net/tcp: fix possible out-of-bounds reads in tcp_hash_fail()
    https://git.kernel.org/netdev/net/c/02f0717e9835

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




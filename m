Return-Path: <netdev+bounces-15062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B2745754
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E821C20834
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318051FA4;
	Mon,  3 Jul 2023 08:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57320F0
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46F7FC433C9;
	Mon,  3 Jul 2023 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688373020;
	bh=DUYAofIaOjiCvEN7NTlcA7wsBaCZHD7tf2PWXdXPuGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GCqKLTGmgyIvN2d5xFKAJbGfwVmOBXfFOBshSAZKygSq1M0mrcxlPhOv5QFp8lhxO
	 +Uq/FZLQvdy9d8VHhRFvBY/b1/6jOX2yPY/FmtogbBh61hentEfZr9i0ZHXjr+xJGR
	 7rmFoGz99uSvOrGGqfurDQB5VHiA+BbiZh4vUWSVfnnwA404B+2DgIltQoEiHu9JWT
	 21ZTr8QTxE3JkE2yC6ZyqD/yZb2l3BXVihVBtGdCvpu3u702tJTilLxLwnl/bYevcR
	 o5yQl+EQgLy14ARQfiEztdNzKS0bbQy/AtZ20eGmHUsmLLuuhOfTEEWgOn16pXUmcy
	 bnhi6EDtFHoKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DB91C39563;
	Mon,  3 Jul 2023 08:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: annotate data races in __tcp_oow_rate_limited()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168837302018.15739.6916662349843984262.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:30:20 +0000
References: <20230629164150.2068747-1-edumazet@google.com>
In-Reply-To: <20230629164150.2068747-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Jun 2023 16:41:50 +0000 you wrote:
> request sockets are lockless, __tcp_oow_rate_limited() could be called
> on the same object from different cpus. This is harmless.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations to avoid a KCSAN report.
> 
> Fixes: 4ce7e93cb3fe ("tcp: rate limit ACK sent by SYN_RECV request sockets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] tcp: annotate data races in __tcp_oow_rate_limited()
    https://git.kernel.org/netdev/net/c/998127cdb469

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




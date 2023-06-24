Return-Path: <netdev+bounces-13754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E451D73CD42
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6AD1C20912
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD88F515;
	Sat, 24 Jun 2023 22:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3AF9D3
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D319DC433CC;
	Sat, 24 Jun 2023 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645220;
	bh=rn9tmFC5y/JKmpNNqDIjrmIXf8YG4r+JU8rTlrdCx7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AgQKVOY61sDPudbN8JjWtqFgEuLb0h07fxtoP7Vv+Xg3gG19noY4qgcg4lKSg8643
	 RBzJpWprNy8czCdFfJREnKk51P8cWmRJ8eARmf8h5is07Q/z5MmIN8SfNL33SoDzxr
	 4JX631SpGMoQsnxnqJZWOjVD73SzVIdatzR1EIYhVaJNQOcp9ouxkU9wxsLokEjcAD
	 q7VX5gJhFTUfjiNLHbs5+Qm33C/zL2Z2sRayCr7h7yr6UQJolMLHh2JxHJaunMl5jA
	 kJxNT0gdAkoNuLoNB1JttNsSjxMu0VgsRfhuWkFy7xD0ewF6KIcdPJH0la6CKa8Y2z
	 f1QjIHLuNQxTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDD96C395F1;
	Sat, 24 Jun 2023 22:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] af_unix: Call scm_recv() only after
 scm_set_cred().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764522077.22804.9437508384826137554.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:20:20 +0000
References: <20230622184351.91544-1-kuniyu@amazon.com>
In-Reply-To: <20230622184351.91544-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, brauner@kernel.org, alexander@mihalicyn.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 11:43:51 -0700 you wrote:
> syzkaller hit a WARN_ON_ONCE(!scm->pid) in scm_pidfd_recv().
> 
> In unix_stream_read_generic(), if there is no skb in the queue, we could
> bail out the do-while loop without calling scm_set_cred():
> 
>   1. No skb in the queue
>   2. sk is non-blocking
>        or
>      shutdown(sk, RCV_SHUTDOWN) is called concurrently
>        or
>      peer calls close()
> 
> [...]

Here is the summary with links:
  - [v2,net-next] af_unix: Call scm_recv() only after scm_set_cred().
    https://git.kernel.org/netdev/net-next/c/3f5f118bb657

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-43167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298A7D1A07
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A49228262F
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E3641;
	Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKzHtiNZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1E37C
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9CE9C433C9;
	Sat, 21 Oct 2023 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697849424;
	bh=edyvrYtR2LXESNdu3MnzIvEMOD98LBY8UogFpY754rU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKzHtiNZYR4VMz8tLPjoyr3HWNF4/odNK9O0fDrUOUxdJmLWugFORB6vL4iUKVlXl
	 2LnxtyomHoTb0Eh1iZZqd/A6+0BscP/d/pxDPfkQmA5mPZScs59MgbV9lb1awByJJ7
	 JPMI0q3jpvusW2i3vHw9nS5fn1W8diHHDMkWfFt1ZBIltEbhKRPwIq0mLnIUgY+92T
	 BI8CjoszOEeY6aanXv8/sop8ZZ22t94MeVJKHBufHR0BntGs++NXbCQn7A4fHFuDu3
	 LsGbIXMhWivloQBVeSkxnT2rvslCSbq1/MmjmFkY0QlggfSryqYVjukZ9EKlz2HnGO
	 kK/KZNt8mTkIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAA7FC595D7;
	Sat, 21 Oct 2023 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: do not leave an empty skb in write queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169784942469.14403.8655221823473150989.git-patchwork-notify@kernel.org>
Date: Sat, 21 Oct 2023 00:50:24 +0000
References: <20231019112457.1190114-1-edumazet@google.com>
In-Reply-To: <20231019112457.1190114-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 soheil@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, shakeelb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 11:24:57 +0000 you wrote:
> Under memory stress conditions, tcp_sendmsg_locked()
> might call sk_stream_wait_memory(), thus releasing the socket lock.
> 
> If a fresh skb has been allocated prior to this,
> we should not leave it in the write queue otherwise
> tcp_write_xmit() could panic.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: do not leave an empty skb in write queue
    https://git.kernel.org/netdev/net/c/72bf4f1767f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




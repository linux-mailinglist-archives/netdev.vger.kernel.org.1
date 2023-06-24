Return-Path: <netdev+bounces-13760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0E73CD4B
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3EC2810F5
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7642B111AD;
	Sat, 24 Jun 2023 22:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856A11CB0
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3912FC433CD;
	Sat, 24 Jun 2023 22:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645820;
	bh=FUlI3FH3vGsBVmvCer6c6I63F5J0VwxMN+tLZf3yIAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JZQ6soclol2+1gY4IuneV49uKGqwQKd6vczGr00+1/tiuaUmL3Ld5/lreybDQaRLN
	 cmEeLt3vFWvFL8nkd6ZYo8oEkrl/iIjQfxMQ4Uo/ZO9quENz5esKxG++H4zeihzBr2
	 ElUtAgSZO4CnH+ojvcs5Sz7zEPB1zplc9Ij+Pi1JVvsU+b2frPSu0WVvgoQKqpEYKZ
	 VNm7yAc9XbkgRPsmNE9qT1qiogPT4u3m4BWAf+Ku+ZoWncwdkrs/H0DBNe4aKK8Yqt
	 sYD2FoVLITFnS8U08PoRvQDfu6GXoQdnZurm5DNllw/ikMS++aSZxB0rbN6LbjArNU
	 qIw1kUVx4Zlfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 224C4C395F1;
	Sat, 24 Jun 2023 22:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/tcp: optimise locking for blocking splice
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764582013.27285.4309029125859380205.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:30:20 +0000
References: <80736a2cc6d478c383ea565ba825eaf4d1abd876.1687523671.git.asml.silence@gmail.com>
In-Reply-To: <80736a2cc6d478c383ea565ba825eaf4d1abd876.1687523671.git.asml.silence@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jun 2023 13:38:55 +0100 you wrote:
> Even when tcp_splice_read() reads all it was asked for, for blocking
> sockets it'll release and immediately regrab the socket lock, loop
> around and break on the while check.
> 
> Check tss.len right after we adjust it, and return if we're done.
> That saves us one release_sock(); lock_sock(); pair per successful
> blocking splice read.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/tcp: optimise locking for blocking splice
    https://git.kernel.org/netdev/net-next/c/2fe11c9d36ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




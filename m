Return-Path: <netdev+bounces-73672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382285D844
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 13:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CA11C20E21
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451569945;
	Wed, 21 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI3BYS4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680D657AC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519827; cv=none; b=bwQ7argHJQbieWMPnW283AQdOFfVZHZLro2e3CRLBUzrNCK48KvnR4hQgbnBX2wm6qt7FxHrTYDZcru49CV3Kl6ivNsKUqGsaCTZ6GcCdgHA6+KZ9u7OCWD5LoHvOLfzdP5mnIIOyZhDlY/m0BebMRplKJDTyWoDdF+MxvHaTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519827; c=relaxed/simple;
	bh=+so7R9P99YaPVqLGEU+p7gfax/8fd6mveellPkgrEYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LVYCekogBsBVvm6La1g0RXLISLd6Jws+JHg4d8Cn/8MIRINfzKsQcHz1Dimn5obHeGQChiJhaYB3BsM1G/1AO9B87tbqviIMQxYdM+Xti3bL0+jfnIK1Aj5Y5PfA3Cdy79p2N+vRv+X8zANOA5meoN2uRo9aLx4AMlMaO6PKwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI3BYS4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A0FEC433C7;
	Wed, 21 Feb 2024 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519827;
	bh=+so7R9P99YaPVqLGEU+p7gfax/8fd6mveellPkgrEYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dI3BYS4P2FjcgbVmr1hpuD6w49BQfQXjQfgCT0cwYdMNYYRnxDX5nrao1HzlEA32g
	 Ql+3j5nSyOtQU/youPCehrkY/pU1gaUFf5bnYYfx59hJgmfE1k4vvKJ7aR1oZMFWbu
	 f+FEBOY+7ucQ+2bYcIKx5JtB3zz3btRj705TMWVdEy1U+4Fz0j4UHSD7k1zTSst3Z1
	 g2zr2RPrKBq4vS2RjFkehUKmDYvVusRoYHmAsdASGqFHyqgYa2uDHybuAv1FMfuZFQ
	 81hmZxaTh98TqBKu2G2LUC4D+s950texTvwZd43NsNaB3TxuZs1n6reMcnNlwDAA5a
	 EeKPoy4jBtOWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19A5DC00446;
	Wed, 21 Feb 2024 12:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Drop oob_skb ref before purging queue in GC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851982710.28838.13826338277536240420.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 12:50:27 +0000
References: <20240219174657.6047-1-kuniyu@amazon.com>
In-Reply-To: <20240219174657.6047-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Feb 2024 09:46:57 -0800 you wrote:
> syzbot reported another task hung in __unix_gc().  [0]
> 
> The current while loop assumes that all of the left candidates
> have oob_skb and calling kfree_skb(oob_skb) releases the remaining
> candidates.
> 
> However, I missed a case that oob_skb has self-referencing fd and
> another fd and the latter sk is placed before the former in the
> candidate list.  Then, the while loop never proceeds, resulting
> the task hung.
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Drop oob_skb ref before purging queue in GC.
    https://git.kernel.org/netdev/net/c/aa82ac51d633

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




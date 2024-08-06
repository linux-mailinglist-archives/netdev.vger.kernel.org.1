Return-Path: <netdev+bounces-116244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65603949908
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958E61C21485
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A815B12B;
	Tue,  6 Aug 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9WcwxM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D540875
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976077; cv=none; b=Tgp3K5U3dotHQSXqEOwtJ21s1dLG9F/RxKNu1VhV6AhQhvaIwktj/WTKdLZFoHNHnbiYSIx0BNaPoQUCTgLR9AQvL4EAfbYk17OzpKIe21w05JR0QLvY6ruCprlgzepTSJui9GvdyfFrkGNj2JWkAoW+7XVldXxkBxAmUoLj6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976077; c=relaxed/simple;
	bh=FKSDW+ZR4DSreRKvARM/cUtSxbMj2F4rhzWq8rgeAbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FXBYBB9KFwggtrkfe3Th8xdP0LSW/O4BNq3Kzgc2BYHe6GmTj+0Ofl5R/46dhZitSLOlM0n3ibwXloE7/U2hCdA5X3nNlzpROh9TFSSWaRJpoucTjPKAww/2lfOLD8OFXdmqAKB+iIx62P3sdla0LSjXVvWwpH3SAi3Z5QBQtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9WcwxM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD02FC32786;
	Tue,  6 Aug 2024 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976076;
	bh=FKSDW+ZR4DSreRKvARM/cUtSxbMj2F4rhzWq8rgeAbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M9WcwxM4KoGAdrYMzt61t8JM7oIAsO0GR1En2VkGZtPxybTkNGXYWhociEKUjr9+F
	 3i17s+tpguTWPyRwvtjk+nzSvy/KjI7B53UMsWL8LDbPyCl4hTfuoZhOksSVacal2e
	 aaDDjXsCevdSAELPlmFcbdpz189oosiKIS9Zaw09bCUtjx4TwYHdmm/dALmsEl1uu6
	 0u6Cw3ap75LbyMWJVRBFQzDqpFArna6Crt4R2l+ghKL5s9GHJ011F9yVbJ20C4/o0N
	 FJ5xvA0TfYruKLJEJs+f0LgSZCu2dHhFrleBAv9VTOCcGP9o+qH5n7eqJ0le6wSeXS
	 lDRQ5ftF4d5NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE06B39D6562;
	Tue,  6 Aug 2024 20:27:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: linkwatch: use system_unbound_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172297607550.1692635.2271755679626099885.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:27:55 +0000
References: <20240805085821.1616528-1-edumazet@google.com>
In-Reply-To: <20240805085821.1616528-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Aug 2024 08:58:21 +0000 you wrote:
> linkwatch_event() grabs possibly very contended RTNL mutex.
> 
> system_wq is not suitable for such work.
> 
> Inspired by many noisy syzbot reports.
> 
> 3 locks held by kworker/0:7/5266:
>  #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
>  #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
>  #1: ffffc90003f6fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
>  , at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
>  #2: ffffffff8fa6f208 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
> 
> [...]

Here is the summary with links:
  - [net] net: linkwatch: use system_unbound_wq
    https://git.kernel.org/netdev/net/c/3e7917c0cdad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




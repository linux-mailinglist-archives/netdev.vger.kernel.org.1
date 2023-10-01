Return-Path: <netdev+bounces-37286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD1B7B4867
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 73C9A1C20510
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D4818AE4;
	Sun,  1 Oct 2023 15:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A5171CE
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B302BC433C9;
	Sun,  1 Oct 2023 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696174222;
	bh=gM4K0Y7Ad432DogcHx5yhF8zXNNJLHUpDBTGj8iSHgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fBmFYVSsnpQjr4Pn2RgH+ILii1EFeNS85Uakqhaa3ecDLY1QysRDGZszSxnzF6Dck
	 KtCV+74CP+duWniVo8LBvf/BkLVqHNn7QH1uuRxpbXqT+f3i5u2jNI3cGlsD/T5TYp
	 P+7q0tadppe7T/8t/TFzpZ1wYZGdtqkl84g8bCT6FTXafGJL1KNsqSXksKv9EG7Lhj
	 1bJgLAjvcA20FR+T/fTpF15lYVU/qSgbEVc0OSID6T6waCPvwiIL+l3lqcETU+2R93
	 d0QLo56PjALJQPdJfN6uJeuaH+1Gt23d9WDHNnZvzWc+dYQ9zc2zo8l7qC+RTxkzcG
	 c66bT8cse8ofg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96962C64457;
	Sun,  1 Oct 2023 15:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix possible store tearing in neigh_periodic_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169617422261.792.1601669172019556047.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 15:30:22 +0000
References: <20230921084626.865912-1-edumazet@google.com>
In-Reply-To: <20230921084626.865912-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 08:46:26 +0000 you wrote:
> While looking at a related syzbot report involving neigh_periodic_work(),
> I found that I forgot to add an annotation when deleting an
> RCU protected item from a list.
> 
> Readers use rcu_deference(*np), we need to use either
> rcu_assign_pointer() or WRITE_ONCE() on writer side
> to prevent store tearing.
> 
> [...]

Here is the summary with links:
  - [net] net: fix possible store tearing in neigh_periodic_work()
    https://git.kernel.org/netdev/net/c/25563b581ba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




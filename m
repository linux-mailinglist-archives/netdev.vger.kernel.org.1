Return-Path: <netdev+bounces-33764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BA979FF84
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78C31C2105D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C53415EA9;
	Thu, 14 Sep 2023 09:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E315E81
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2815DC433CC;
	Thu, 14 Sep 2023 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694682027;
	bh=5bU9qR39gngwCu3APW1x3czMByPo1K5PMaeutKBdb1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qHQelEMMhVp6cmRTLLIYO/u7tNlYpbEu8Ft/jObRqbbU+corze+zvzO8os800G4+3
	 noHFXvzI31r4nl2P42KDVvyZtVU9LRq1LPoKY+gWJqLJUq88fr5O59BXrW3dDk2EJc
	 A9jEvMTToi6K0kstPYxm1OGUup8VQwxxQN2VrGn3fYmm3ARcokJNII04z2qfZ85Jsr
	 VM8XK54Sauc3O8+cwaPWEN7D7//V5fKSoEQcOuDzOdGOZ6YgMNfQv78UOA7W5kY19j
	 Q9H2gw56Pd6KBB0ffoQ2YxODHOSejdR4/NKbXBW5jVaBufMnhe9MuPPxDxhxhcS+wG
	 WdiJtLZF0ZZnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09519E22AF5;
	Thu, 14 Sep 2023 09:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] kcm: Fix error handling for SOCK_DGRAM in
 kcm_sendmsg().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169468202703.21796.14136496528263954193.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 09:00:27 +0000
References: <20230912022753.33327-1-kuniyu@amazon.com>
In-Reply-To: <20230912022753.33327-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, syoshida@redhat.com, tom@herbertland.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 19:27:53 -0700 you wrote:
> syzkaller found a memory leak in kcm_sendmsg(), and commit c821a88bd720
> ("kcm: Fix memory leak in error path of kcm_sendmsg()") suppressed it by
> updating kcm_tx_msg(head)->last_skb if partial data is copied so that the
> following sendmsg() will resume from the skb.
> 
> However, we cannot know how many bytes were copied when we get the error.
> Thus, we could mess up the MSG_MORE queue.
> 
> [...]

Here is the summary with links:
  - [v1,net] kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().
    https://git.kernel.org/netdev/net/c/a22730b1b4bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




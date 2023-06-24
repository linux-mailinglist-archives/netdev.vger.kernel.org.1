Return-Path: <netdev+bounces-13759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B645E73CD4A
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB0A1C208E9
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80BC746F;
	Sat, 24 Jun 2023 22:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4A11C81
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C8DC433C0;
	Sat, 24 Jun 2023 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645820;
	bh=JozKjvJVVkOwV24oHfc7a0IHdN5lV4lR3XNj2AhWo8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J1mcA+rXUBfgoqXG0kYWs3QwB3lm9aHrvMAr4JHuRN0pN8RREJeUcoZ7rCHUz4/mp
	 2ZkfaVPKIUGl0WagKblXq3gbzBI8BtIKWK5DyYmTjW9X/K6PSWMjx/lizBB32IaHG3
	 G4t6IPKPXKgY/GaipTswJsbgXY4AVO7WpELFGQASU8+xi9Pq0sl4u0/T57dr/l6zFp
	 2zpS9tZPyzdjiKONtP7t2xhQ5qA6iFtM/Khxv5ODdNH/1/WPTdxH0rAD1bh24jwlbz
	 9ClntGuTILrseRhB//L1JdPffy30l2h3ifl9Q+Pypwi1bIgHRn48lKaTTvaFuqGKMZ
	 lQn7CcvfgM6LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C76CFC43157;
	Sat, 24 Jun 2023 22:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] gtp: Fix use-after-free in __gtp_encap_destroy().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764581981.27285.13297166277839266868.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:30:19 +0000
References: <20230622213231.24651-1-kuniyu@amazon.com>
In-Reply-To: <20230622213231.24651-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, pablo@netfilter.org, laforge@gnumonks.org,
 ap420073@gmail.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 14:32:31 -0700 you wrote:
> syzkaller reported use-after-free in __gtp_encap_destroy(). [0]
> 
> It shows the same process freed sk and touched it illegally.
> 
> Commit e198987e7dd7 ("gtp: fix suspicious RCU usage") added lock_sock()
> and release_sock() in __gtp_encap_destroy() to protect sk->sk_user_data,
> but release_sock() is called after sock_put() releases the last refcnt.
> 
> [...]

Here is the summary with links:
  - [v1,net] gtp: Fix use-after-free in __gtp_encap_destroy().
    https://git.kernel.org/netdev/net/c/ce3aee7114c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




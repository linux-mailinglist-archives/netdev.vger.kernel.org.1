Return-Path: <netdev+bounces-27112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C8577A637
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16361C20909
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410DE538D;
	Sun, 13 Aug 2023 11:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C95395
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70E1DC43395;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691926222;
	bh=umlfftQDdO38eX1vPlADRHALH0qWXuzWks/iWSUv9H8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nr6jwfnU7rQ1whz+ar/GwM3RcGih4Ex9MvYo3T+zbzMrT9aHzeQKAKXzJ7EathgTN
	 JLr9FPa1SzJsXO2yWflXcGR8nILMJ6S2nc+gRXHJA787u4HS7a132XprXFJGE/l9FE
	 vjEtU4oLb714RD91CZKquo3U7f5DUgpBwj9r8W5OL6MZzysiTi1+mPWFi+4SGpKhvI
	 99xdOPSH/Ft1Gyr7vYh+g9l4ZatbAA9pvv3O0X6GQzYnDhQLUcrYnzVxzx5CBld7cY
	 tmDdObekS5y+XKfTXFfIlFfFBlDyj2e6eORXm90/Sni9v6wfwiSfBoRNoI5iCHiZt2
	 8A5Kq3jy6laSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 591C2E3308F;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: convert nlk->flags to atomic flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169192622236.28684.14090690519376565352.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 11:30:22 +0000
References: <20230811072226.2777425-1-edumazet@google.com>
In-Reply-To: <20230811072226.2777425-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 07:22:26 +0000 you wrote:
> sk_diag_put_flags(), netlink_setsockopt(), netlink_getsockopt()
> and others use nlk->flags without correct locking.
> 
> Use set_bit(), clear_bit(), test_bit(), assign_bit() to remove
> data-races.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: convert nlk->flags to atomic flags
    https://git.kernel.org/netdev/net-next/c/8fe08d70a2b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




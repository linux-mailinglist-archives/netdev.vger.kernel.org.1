Return-Path: <netdev+bounces-30978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E1B78A573
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1E01C20852
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D407A2C;
	Mon, 28 Aug 2023 06:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CF81F
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9135C433CA;
	Mon, 28 Aug 2023 06:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693202422;
	bh=5KbFWcWekHL941V4FhYf9bpTanNDHKceogKpRkcxYEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ADpbnU1aeyJE5JeFkYxpPBYlxFKJCobc+BcSX5uYzvVPZFuLakz029J1PhwyBJ52r
	 Lw9ySXNBIvbpEqh8KeWgb395vpEJ6ep21ZxOdWj1O9OO4HSipy/aNKgg2RtZ5+zEA0
	 n+a5L3DMlbGf3MBbQjirFj+0TmcgbI10LFqj282Ybd9Cee9Ed7vZmWBO5iwC26s3ds
	 k2mfIY68QmIEIXizwCme6xDrt+WWDlvppJvHs+VgzfiEHo6zKpWG8QwehKNWXs236R
	 Yn20PcakwXaFjOtNTcB5PUyLiSfikEulYHD4xQOcK3axUVyoMhCUyOKscmXygyz211
	 KgelQYU/FpRWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBC93E33081;
	Mon, 28 Aug 2023 06:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] netrom: Deny concurrent connect().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169320242276.13305.1320954627222633912.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 06:00:22 +0000
References: <20230824165059.90977-1-kuniyu@amazon.com>
In-Reply-To: <20230824165059.90977-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ralf@linux-mips.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, linux-hams@vger.kernel.org,
 syzbot+666c97e4686410e79649@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 09:50:59 -0700 you wrote:
> syzkaller reported null-ptr-deref [0] related to AF_NETROM.
> This is another self-accept issue from the strace log. [1]
> 
> syz-executor creates an AF_NETROM socket and calls connect(), which
> is blocked at that time.  Then, sk->sk_state is TCP_SYN_SENT and
> sock->state is SS_CONNECTING.
> 
> [...]

Here is the summary with links:
  - [v1,net] netrom: Deny concurrent connect().
    https://git.kernel.org/netdev/net/c/c2f8fd794960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




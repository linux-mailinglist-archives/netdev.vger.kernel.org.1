Return-Path: <netdev+bounces-12465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38717379D5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40A11C20CE1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805A23CB;
	Wed, 21 Jun 2023 03:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425945238
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AC1BC433BB;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318822;
	bh=DxSe0oUxOgvJkDVLDRiUIpRroFrzNGkKZ23zlOmRbEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kUU5JUfV99yAUxZ6TBRo0RNzlS5JmdvWoTfLY/wNGJfJvif48D3+fAwnmbxBdsyy+
	 YTUfucdMVFQso5SuIm/pN/HpxdYYzDXjWP+h0dfum+b0aPu5Xebdb1kgYC7gWjW0pN
	 sKN1Z/cXVyTaSCgfFSrwz90rzMW0XSx0VPKHrQBDAA9qYNg0IaAEfudeYrl2IjOet6
	 8su2ETngNBM2W7Alyj5t7XhRj+M65ob6pCo9xRefXufZdyeeK8vHDcOpcKyX8g3RxK
	 r8X12aZekLMGgnwro2EQ63WsUQZLefHniP/pJkSBNy9RTxm5z017luunF5NnJJ3ngU
	 X2wsaZxXufyqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E4C4C43157;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: fix a typo in ip6mr_sk_ioctl()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731882238.8371.5060341998196565928.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:22 +0000
References: <20230619072740.464528-1-edumazet@google.com>
In-Reply-To: <20230619072740.464528-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 leitao@debian.org, willemb@google.com, dsahern@kernel.org, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 07:27:40 +0000 you wrote:
> SIOCGETSGCNT_IN6 uses a "struct sioc_sg_req6 buffer".
> 
> Unfortunately the blamed commit made hard to ensure type safety.
> 
> syzbot reported:
> 
> BUG: KASAN: stack-out-of-bounds in ip6mr_ioctl+0xba3/0xcb0 net/ipv6/ip6mr.c:1917
> Read of size 16 at addr ffffc900039afb68 by task syz-executor937/5008
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: fix a typo in ip6mr_sk_ioctl()
    https://git.kernel.org/netdev/net-next/c/3a4f0edbb793

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




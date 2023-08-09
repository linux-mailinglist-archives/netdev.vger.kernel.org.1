Return-Path: <netdev+bounces-26097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B6776C8B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8014D1C21197
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026A1DDFA;
	Wed,  9 Aug 2023 23:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B01DDFC
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 407AAC433CB;
	Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691622024;
	bh=Q4uOJqSUcI+0qYf2jQ5ogbq7w0U6rn4+ghoCCuOn17w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UUh74HHSWQ+K1cD3NqybCZ80QGw7nxVvEGig2+1REtXAyPU8q6NTy/dDf53hPpsxg
	 +iN9TQ9tGROA+0KZi4WCpOysxK1FCWaWigWT7br9z5K2o/hDs6Zv8j+pQObR+Aatjc
	 ItnbgoDta+7Ixp0YF61qvgxb5b1e9IZSeRQAG+VG6pkZbgfZRnIII7lGHNjqdX5Ntr
	 ESGh7vHu7xNuXViOkFd9Zt/GdTIHUpyLTUvELaWaxQT2fRUAsCuO7JU1DF0GMP4E9m
	 HJosKMkhB6riObwFV7O6nptUVPfjLVWJ4TuCGPDZ1pA5YOrvQ+xIsA1pB6UlfWIzml
	 rzKIVFhiYUVlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19DB8E505D5;
	Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: annotate data-races around sock->ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169162202410.2325.18112282191763649384.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 23:00:24 +0000
References: <20230808135809.2300241-1-edumazet@google.com>
In-Reply-To: <20230808135809.2300241-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Aug 2023 13:58:09 +0000 you wrote:
> IPV6_ADDRFORM socket option is evil, because it can change sock->ops
> while other threads might read it. Same issue for sk->sk_family
> being set to AF_INET.
> 
> Adding READ_ONCE() over sock->ops reads is needed for sockets
> that might be impacted by IPV6_ADDRFORM.
> 
> [...]

Here is the summary with links:
  - [net-next] net: annotate data-races around sock->ops
    https://git.kernel.org/netdev/net-next/c/1ded5e5a5931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




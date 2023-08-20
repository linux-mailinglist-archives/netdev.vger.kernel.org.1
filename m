Return-Path: <netdev+bounces-29172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F6F781F2B
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 20:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5237280F9E
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B17863B7;
	Sun, 20 Aug 2023 18:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326B63D5
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1ABDC433CC;
	Sun, 20 Aug 2023 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692555210;
	bh=XXl2unqcgruRRu9b/DEKz7B9R0+M+yNhUED3nemOtr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WnMFNlzCWg8uB20vYT/l/Ka+LGDo4yikY2CzOc7zWSztdYaDutFP9I+1vj8BRscMJ
	 T4hWUrRQSx6N/onaDaMFAkf4S6iRcyaFE2HdqHVPHY9nP9Dt9O011j0GISsATIwmwU
	 RCCHbC07YTHX5lBzX8ohVftqCZodb/xg6/R4y6DbZXVtgKkjO94khtY9pmCPa0pjhd
	 Xhtt0k6C/Hpk189blEexfka0EJntsX1NoZI8PWS8CAJqre40YlOhpUiTE9bc+ziRJe
	 ixXa5bkBTn0iRhGhNkZoPoKv/Fe6W00CtIBnFP9Au7jZVUqXFtZ1+AN52MUqpKSOE6
	 4nABD49uXMrRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D762BE26D32;
	Sun, 20 Aug 2023 18:13:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv7 net-next 0/2] ipv6: update route when delete source address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169255520987.4244.9366813628919644122.git-patchwork-notify@kernel.org>
Date: Sun, 20 Aug 2023 18:13:29 +0000
References: <20230818082902.1972738-1-liuhangbin@gmail.com>
In-Reply-To: <20230818082902.1972738-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@idosch.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 16:29:00 +0800 you wrote:
> Currently, when remove an address, the IPv6 route will not remove the
> prefer source address when the address is bond to other device. Fix this
> issue and add related tests as Ido and David suggested.
> 
> Hangbin Liu (2):
>   ipv6: do not match device when remove source route
>   selftests: fib_test: add a test case for IPv6 source address delete
> 
> [...]

Here is the summary with links:
  - [PATCHv7,net-next,1/2] ipv6: do not match device when remove source route
    https://git.kernel.org/netdev/net-next/c/b358f57f7db6
  - [PATCHv7,net-next,2/2] selftests: fib_test: add a test case for IPv6 source address delete
    https://git.kernel.org/netdev/net-next/c/429b55b441f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




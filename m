Return-Path: <netdev+bounces-24697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5E67713D4
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4492813D3
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E023AF;
	Sun,  6 Aug 2023 07:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30511FAF
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 07:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20598C433C9;
	Sun,  6 Aug 2023 07:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691307022;
	bh=NiXYxoydN9I0Sar1wtrXmGSUkGn1RvNbW4Te3k6P934=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uSxmuqKDbLcbSAIN0WtnCCw3pctbHC3K8nl8Ld5rwQsxMrAqTZRef3Bc0r07Fs/j2
	 gWuLm47WqaBLdBTTZfrZMAUK3Omc20fNSwIBKymJUQAo96+OZfP3gIfOqN21E5lM/l
	 wxSzctIY9FvlqKrqy2SqzgX7OJwmRTxthFDCBCsjoU5GRd2HQZV+RPBxgIPiJX2w1G
	 krappyKqrgPlshmd4iqhfB1m3HV5mxmlECgQF9ukH8L7Li45mq8lWhcvi71YHxqjN7
	 0IEi9Uh5CrsaqWd0JikgsQzP3TQusWyH6SzKZ8AMeG7ns9hu1fKOFgPYm1RHnC8hah
	 asZIWYlfKVs2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E72EFC395F3;
	Sun,  6 Aug 2023 07:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] tcp: set few options locklessly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169130702193.4254.1792153786396320348.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 07:30:21 +0000
References: <20230804144616.3938718-1-edumazet@google.com>
In-Reply-To: <20230804144616.3938718-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, soheil@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 14:46:10 +0000 you wrote:
> This series is avoiding the socket lock for six TCP options.
> 
> They are not heavily used, but this exercise can give
> ideas for other parts of TCP/IP stack :)
> 
> Eric Dumazet (6):
>   tcp: set TCP_SYNCNT locklessly
>   tcp: set TCP_USER_TIMEOUT locklessly
>   tcp: set TCP_KEEPINTVL locklessly
>   tcp: set TCP_KEEPCNT locklessly
>   tcp: set TCP_LINGER2 locklessly
>   tcp: set TCP_DEFER_ACCEPT locklessly
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] tcp: set TCP_SYNCNT locklessly
    https://git.kernel.org/netdev/net-next/c/d44fd4a767b3
  - [net-next,2/6] tcp: set TCP_USER_TIMEOUT locklessly
    https://git.kernel.org/netdev/net-next/c/d58f2e15aa0c
  - [net-next,3/6] tcp: set TCP_KEEPINTVL locklessly
    https://git.kernel.org/netdev/net-next/c/6fd70a6b4e6f
  - [net-next,4/6] tcp: set TCP_KEEPCNT locklessly
    https://git.kernel.org/netdev/net-next/c/84485080cbc1
  - [net-next,5/6] tcp: set TCP_LINGER2 locklessly
    https://git.kernel.org/netdev/net-next/c/a81722ddd7e4
  - [net-next,6/6] tcp: set TCP_DEFER_ACCEPT locklessly
    https://git.kernel.org/netdev/net-next/c/6e97ba552b8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




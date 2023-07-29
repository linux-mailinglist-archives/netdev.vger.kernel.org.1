Return-Path: <netdev+bounces-22571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DDF7680BF
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D251C20A7E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D32171AC;
	Sat, 29 Jul 2023 17:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0270816
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AE2EC433C9;
	Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690651221;
	bh=suQCxUD/qom1K4xxmTFKPlUYAFoN4oJdj12wtXU/J3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OuqGEH+HXbvRT5KAfyxHVgM3SnUxMjVHdErHzSGa/PfPUmwKa2v+NulfocjN0PCqS
	 PbnZ9Jcyd2Zk5++XdooJmzNXEma3KQ/F0F4SUBcViwH1vRlLaaHkg4/6XbO7+K0drB
	 VxhEuf7bdr/Ui/SAZP6Euaricj6zcrSy4puAlmvmd9PwzuLDYMvVAmbe2SLQkBr2hk
	 7MaMdSUO+2XmcO3HZUdp+mq75Usuux38fAaXaNziBQEWQqFloz3CcxcMYD6NapyFNm
	 xXsMg3YE3VVm6SZlNAsE9R8Yffu3NsKZY/qsLLs0zYFD+nGd7K4fotLTkkwyVl1de4
	 jd/0FSOFyyqCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1168AC40C5E;
	Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/11] net: annotate data-races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169065122106.20073.1317085374302458162.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 17:20:21 +0000
References: <20230728150318.2055273-1-edumazet@google.com>
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Jul 2023 15:03:07 +0000 you wrote:
> This series was inspired by a syzbot/KCSAN report.
> 
> This will later also permit some optimizations,
> like not having to lock the socket while reading/writing
> some of its fields.
> 
> Eric Dumazet (11):
>   net: annotate data-races around sk->sk_reserved_mem
>   net: annotate data-race around sk->sk_txrehash
>   net: annotate data-races around sk->sk_max_pacing_rate
>   net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
>   net: annotate data-races around sk->sk_{rcv|snd}timeo
>   net: add missing READ_ONCE(sk->sk_sndbuf) annotation
>   net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
>   net: annotate data-races around sk->sk_mark
>   net: add missing data-race annotations around sk->sk_peek_off
>   net: add missing data-race annotation for sk_ll_usec
>   net: annotate data-races around sk->sk_priority
> 
> [...]

Here is the summary with links:
  - [net,01/11] net: annotate data-races around sk->sk_reserved_mem
    https://git.kernel.org/netdev/net/c/fe11fdcb4207
  - [net,02/11] net: annotate data-race around sk->sk_txrehash
    https://git.kernel.org/netdev/net/c/c76a0328899b
  - [net,03/11] net: annotate data-races around sk->sk_max_pacing_rate
    https://git.kernel.org/netdev/net/c/ea7f45ef77b3
  - [net,04/11] net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
    https://git.kernel.org/netdev/net/c/e6d12bdb435d
  - [net,05/11] net: annotate data-races around sk->sk_{rcv|snd}timeo
    https://git.kernel.org/netdev/net/c/285975dd6742
  - [net,06/11] net: add missing READ_ONCE(sk->sk_sndbuf) annotation
    https://git.kernel.org/netdev/net/c/74bc084327c6
  - [net,07/11] net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
    https://git.kernel.org/netdev/net/c/b4b553253091
  - [net,08/11] net: annotate data-races around sk->sk_mark
    https://git.kernel.org/netdev/net/c/3c5b4d69c358
  - [net,09/11] net: add missing data-race annotations around sk->sk_peek_off
    https://git.kernel.org/netdev/net/c/11695c6e966b
  - [net,10/11] net: add missing data-race annotation for sk_ll_usec
    https://git.kernel.org/netdev/net/c/e5f0d2dd3c2f
  - [net,11/11] net: annotate data-races around sk->sk_priority
    https://git.kernel.org/netdev/net/c/8bf43be799d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




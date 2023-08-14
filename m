Return-Path: <netdev+bounces-27234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308DE77B144
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E074D280FF0
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D35393;
	Mon, 14 Aug 2023 06:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE65237;
	Mon, 14 Aug 2023 06:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D181BC433C9;
	Mon, 14 Aug 2023 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691993423;
	bh=NHnjRKtw8AgBc1nGIFhnjo9Ir+/TB9yG1+otJ39s1mM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dK6N5B9T7MU3nZsq0jm7eM98Y2swR8l0mgR2gpc3z55kNI4pSh0UuvQdhWKr/Cmj2
	 pDk9ymc8c9qxOlH/7n8dtF/lCag28JQDpAlZ1Dnamx4+dZrTfRvHDBdAUBn8pkmjTb
	 zs/2sAdQNLBvzqbb6tHxqLt6JIgmS9gP3+UuQ8L8YHLEu9WoC1T4cf1iTwJi/QQgcY
	 lR6vFBl7Ykx1FrmtaLUIrWG4Y2KiSL1D+C7hcEaHYDWIF0JiBL0bezE5KhB6xqiR1+
	 r6UtMnGLahFxoVlU40OYgZMZZxUmfWjuBoTDRRLz0ZaWE3gZHybuB3ddlRdIr0j8E1
	 xiQxyvJ8CGxBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B51E9E93B34;
	Mon, 14 Aug 2023 06:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] mptcp: get rid of msk->subflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169199342373.13316.7611325761631728090.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 06:10:23 +0000
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuniyu@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 17:57:13 +0200 you wrote:
> The MPTCP protocol maintains an additional struct socket per connection,
> mainly to be able to easily use tcp-level struct socket operations.
> 
> This leads to several side effects, beyond the quite unfortunate /
> confusing 'subflow' field name:
> 
> - active and passive sockets behaviour is inconsistent: only active ones
>   have a not NULL msk->subflow, leading to different error handling and
>   different error code returned to the user-space in several places.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] mptcp: avoid unneeded mptcp_token_destroy() calls
    https://git.kernel.org/netdev/net-next/c/131a627751e3
  - [net-next,02/14] mptcp: avoid additional __inet_stream_connect() call
    https://git.kernel.org/netdev/net-next/c/ccae357c1c6a
  - [net-next,03/14] mptcp: avoid subflow socket usage in mptcp_get_port()
    https://git.kernel.org/netdev/net-next/c/cfb63e50d319
  - [net-next,04/14] net: factor out inet{,6}_bind_sk helpers
    https://git.kernel.org/netdev/net-next/c/e6d360ff87f0
  - [net-next,05/14] mptcp: mptcp: avoid additional indirection in mptcp_bind()
    https://git.kernel.org/netdev/net-next/c/8cf2ebdc0078
  - [net-next,06/14] net: factor out __inet_listen_sk() helper
    https://git.kernel.org/netdev/net-next/c/71a9a874cd6b
  - [net-next,07/14] mptcp: avoid additional indirection in mptcp_listen()
    https://git.kernel.org/netdev/net-next/c/40f56d0c7043
  - [net-next,08/14] mptcp: avoid additional indirection in mptcp_poll()
    https://git.kernel.org/netdev/net-next/c/5426a4ef6455
  - [net-next,09/14] mptcp: avoid unneeded indirection in mptcp_stream_accept()
    https://git.kernel.org/netdev/net-next/c/1f6610b92ac3
  - [net-next,10/14] mptcp: avoid additional indirection in sockopt
    https://git.kernel.org/netdev/net-next/c/f0bc514bd5c1
  - [net-next,11/14] mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()
    https://git.kernel.org/netdev/net-next/c/3aa362494170
  - [net-next,12/14] mptcp: change the mpc check helper to return a sk
    https://git.kernel.org/netdev/net-next/c/3f326a821b99
  - [net-next,13/14] mptcp: get rid of msk->subflow
    https://git.kernel.org/netdev/net-next/c/39880bd808ad
  - [net-next,14/14] mptcp: Remove unnecessary test for __mptcp_init_sock()
    https://git.kernel.org/netdev/net-next/c/e263691773cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




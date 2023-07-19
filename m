Return-Path: <netdev+bounces-18811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4B3758B8A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B8E281635
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2C17D1;
	Wed, 19 Jul 2023 02:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB717C4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD815C433C9;
	Wed, 19 Jul 2023 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689735021;
	bh=F7gNBhf+Y8pXU4TOhLiheY70KYUGv9M/EPahKtG19pE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gjU2Qr+sdPxPmPEFHFddByXrf8KUrKRc2ib/RTVLG9wwkLwJDo81olyS1rVmEvW8B
	 a8DY7ggPwnIekR99VjucJiI1zQ1ayd+qAnqtfkK69sQhOUGh7B6wVYOUK2uo0fe8jQ
	 beKacM50DZz1DAjzOgP/zvFjEUOpIIdM1/S8tkg5WeISsH9f9+5nTCyc3NZyCzBoXg
	 sKZOhCGGmOZKwmqxQwsttwfCKw9sCN4lKkudZZp3FaLv7Qm6ez8hpvRsUYIuKI44rR
	 ZABSn6Qq/mZzFD3oMfeqRHCO0UBWeCrybz1FnHQkuTHqjdWDihBths2hAuJKd0yKJH
	 9vJCXcUudkBcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE53DE22AE0;
	Wed, 19 Jul 2023 02:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] tcp: annotate data-races in tcp_rsk(req)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168973502176.11704.1441831941657942533.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 02:50:21 +0000
References: <20230717144445.653164-1-edumazet@google.com>
In-Reply-To: <20230717144445.653164-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 14:44:43 +0000 you wrote:
> Small series addressing two syzbot reports around tcp_rsk(req)
> 
> Eric Dumazet (2):
>   tcp: annotate data-races around tcp_rsk(req)->txhash
>   tcp: annotate data-races around tcp_rsk(req)->ts_recent
> 
>  net/ipv4/tcp_ipv4.c      |  5 +++--
>  net/ipv4/tcp_minisocks.c | 11 +++++++----
>  net/ipv4/tcp_output.c    |  6 +++---
>  net/ipv6/tcp_ipv6.c      |  4 ++--
>  4 files changed, 15 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net,1/2] tcp: annotate data-races around tcp_rsk(req)->txhash
    https://git.kernel.org/netdev/net/c/5e5265522a9a
  - [net,2/2] tcp: annotate data-races around tcp_rsk(req)->ts_recent
    https://git.kernel.org/netdev/net/c/eba20811f326

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




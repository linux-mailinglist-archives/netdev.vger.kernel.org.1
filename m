Return-Path: <netdev+bounces-19636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1527C75B848
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F0C1C21442
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D21BE6E;
	Thu, 20 Jul 2023 19:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953361BE67
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0829BC433C8;
	Thu, 20 Jul 2023 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689882625;
	bh=NQ8PIZhjuCDudL31yUq+49oMBQMpdrPLXCaG7bR5yHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G0telbMXzVZfi2b8iORR05YVqO03QZ1bvj1CSTGmE6X8g3rc/vfFTDVriGFh0reLM
	 ayiHoE95qfocCQjsqdy+Y2TterDw/WdvQOVk4V+GLc46aMTKyj/cAl4rcFKlLq6/Gm
	 m2LtKc/2jtl1opna5akGTag4QpzIJDj5NsqU9Rg3xbMMVsLXrgnspxZzRDEwe+G5km
	 82ZT/LqpTkTDXv19YzVJ0MhDJtECZKeJrAr7IH/X7D/yXT9n1ip7/Rk+ILHv8ZjgnX
	 /DboZsByy7Y8ZrQ3nVdc1dYe6OrKe1gG69SiX128cVoEr51iQ7LR5ssey9quQz7lec
	 iNaa+TY9NURrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6798E21EF6;
	Thu, 20 Jul 2023 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/11] tcp: add missing annotations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168988262493.8271.7964075962351926642.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 19:50:24 +0000
References: <20230719212857.3943972-1-edumazet@google.com>
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jul 2023 21:28:46 +0000 you wrote:
> This series was inspired by one syzbot (KCSAN) report.
> 
> do_tcp_getsockopt() does not lock the socket, we need to
> annotate most of the reads there (and other places as well).
> 
> This is a first round, another series will come later.
> 
> [...]

Here is the summary with links:
  - [net,01/11] tcp: annotate data-races around tp->tcp_tx_delay
    https://git.kernel.org/netdev/net/c/348b81b68b13
  - [net,02/11] tcp: annotate data-races around tp->tsoffset
    https://git.kernel.org/netdev/net/c/dd23c9f1e8d5
  - [net,03/11] tcp: annotate data-races around tp->keepalive_time
    https://git.kernel.org/netdev/net/c/4164245c76ff
  - [net,04/11] tcp: annotate data-races around tp->keepalive_intvl
    https://git.kernel.org/netdev/net/c/5ecf9d4f52ff
  - [net,05/11] tcp: annotate data-races around tp->keepalive_probes
    https://git.kernel.org/netdev/net/c/6e5e1de616bf
  - [net,06/11] tcp: annotate data-races around icsk->icsk_syn_retries
    https://git.kernel.org/netdev/net/c/3a037f0f3c4b
  - [net,07/11] tcp: annotate data-races around tp->linger2
    https://git.kernel.org/netdev/net/c/9df5335ca974
  - [net,08/11] tcp: annotate data-races around rskq_defer_accept
    https://git.kernel.org/netdev/net/c/ae488c74422f
  - [net,09/11] tcp: annotate data-races around tp->notsent_lowat
    https://git.kernel.org/netdev/net/c/1aeb87bc1440
  - [net,10/11] tcp: annotate data-races around icsk->icsk_user_timeout
    https://git.kernel.org/netdev/net/c/26023e91e12c
  - [net,11/11] tcp: annotate data-races around fastopenq.max_qlen
    https://git.kernel.org/netdev/net/c/70f360dd7042

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




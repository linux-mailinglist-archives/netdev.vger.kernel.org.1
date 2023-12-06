Return-Path: <netdev+bounces-54531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCCF807653
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D03282096
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD97B63DF8;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7IA2wav"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53F61FBD
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E18FC433CA;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701883053;
	bh=P/Xbhox7Kex9jDeLci78aoTGW/OLBV2bLRdUqL9szL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h7IA2wavUb334O+5CgA+13KHjitYBs7b9MWRKbvTAwtjzYXb9Orf9EFTaCcTvhpDO
	 JA/2lh3G6zXT7N7RhZD+Rca6nEqOdoDOQ6Kj51MyNctx6sQ6HVH1FvZPY7SoV1LQID
	 mKgX0RSmXHl5XHAfyIRaduWQjTblcyq3u9YiLLPa6FyR2yvJxPxs5ix28YxuDmUch0
	 wGNwrv2TM19YAYBE+M6EHA9NbUAT1rvbH3FsrGvuRu05zN/pwSic6hyV+pVPWyxK3d
	 lhwvEyZfNJIGyfmFdYMosvDmxZtIQfsp6pclKLv9c2cXPUWx01SCOhqTWkFeyMVq/I
	 o77gagXCROzKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09FEBC00446;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/5] TCP usec and FQ fastpath
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170188305303.32642.2317593357716477885.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 17:17:33 +0000
References: <20231204091911.1326130-1-edumazet@google.com>
In-Reply-To: <20231204091911.1326130-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon,  4 Dec 2023 09:19:06 +0000 you wrote:
> Add iproute2 patches to support recent TCP usec timestamps,
> and FQ changes landed in linux-6.7
> 
> Eric Dumazet (5):
>   ip route: add support for TCP usec TS
>   ss: add report of TCPI_OPT_USEC_TS
>   tc: fq: add TCA_FQ_PRIOMAP handling
>   tc: fq: add TCA_FQ_WEIGHTS handling
>   tc: fq: reports stats added in linux-6.7
> 
> [...]

Here is the summary with links:
  - [iproute2,1/5] ip route: add support for TCP usec TS
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=a043bea75002
  - [iproute2,2/5] ss: add report of TCPI_OPT_USEC_TS
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=467879b418ff
  - [iproute2,3/5] tc: fq: add TCA_FQ_PRIOMAP handling
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=73a31c945481
  - [iproute2,4/5] tc: fq: add TCA_FQ_WEIGHTS handling
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=567eb4e41045
  - [iproute2,5/5] tc: fq: reports stats added in linux-6.7
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3086a339f681

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




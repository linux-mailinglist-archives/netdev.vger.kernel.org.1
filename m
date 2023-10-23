Return-Path: <netdev+bounces-43667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567207D42FA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8890C1C20AC4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33F241EC;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG7QxU4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32F241E6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DC68C433C9;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698102024;
	bh=XbDa6df+9KaW+t3AOI4JvITw41j10bu9zfx3bHdGkHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qG7QxU4SZRftGahI/rSpFHEWNm6K/mcl4LGmzwZmW11q6xrqkJc4emq9FMtnuysn9
	 H8PLIeyresMSFdNwINBgu7NKrbhjHBTKVCkkgB88BzpN+Yf+c48txmjDwHz9Op5Spy
	 nEOmuOJoxqpZGLAt3S/m5VIiprTABok79VHYPeTKMsPxV+q1YrFyNncOPZB9FX3qg7
	 V7sXAMnNKEhgadSQ6b9ENA7Yg1CFzQ9WEfHFnd73LIqv8p/hd5cm2dsxrKOX9PU8AT
	 Reab69kZUxkoaX6pIHk4KE/vhIXCCDigCQHBUxD5GXxc7wkZI2atGcDNqroZshvUSx
	 qlN2WA2pLt2qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3380CE4CC1D;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: sch_fq: fastpath needs to take care of
 sk->sk_pacing_status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169810202420.28561.5470461138331521927.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 23:00:24 +0000
References: <20231020201254.732527-1-edumazet@google.com>
In-Reply-To: <20231020201254.732527-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Oct 2023 20:12:54 +0000 you wrote:
> If packets of a TCP flows take the fast path, we need to make sure
> sk->sk_pacing_status is set to SK_PACING_FQ otherwise TCP might
> fallback to internal pacing, which is not optimal.
> 
> Fixes: 076433bd78d7 ("net_sched: sch_fq: add fast path for mostly idle qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net_sched: sch_fq: fastpath needs to take care of sk->sk_pacing_status
    https://git.kernel.org/netdev/net-next/c/81a416985698

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




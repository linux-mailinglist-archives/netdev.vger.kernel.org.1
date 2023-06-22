Return-Path: <netdev+bounces-12921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0F73970F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208A92818A4
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA65239;
	Thu, 22 Jun 2023 05:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762C223CE;
	Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7F6FC433C9;
	Thu, 22 Jun 2023 05:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687413028;
	bh=OYg5ge6Kr4l4m8LMnxD4kc9VVSwZvM9wrscOlZMJXQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LWAXZDwY5SlQ3gR5ryK6j5wsSVnGH+pc6heHaa4yYTIydh7DshL3aSwXiUc11gQb3
	 kkxIKXGcoFuEjVMOqEnikwO85mjVIUcZ0PxwD6R6HqitOTqBy9THQfSIsb9j6LqNer
	 oP46S85CJlU6m4o2++mUraSFySs1MwW1D/NkEPSjt9TRW9rXUp7pJVddEF8+pYtSqQ
	 9pBTNZwN9Mj3klf7eiA+sI1ZP4BOJTCo0aSJx+Ri6w7A5NXmXhRr5LDBCbYnrSTHc5
	 oPqOtfKIF/rGeN+OCw5dDf/enusYWDeuEeojVVRBQa1aeB6Qm1KkOSgYuSJxy26H1h
	 G/C9Fs1VC7Sig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B83A8C395FF;
	Thu, 22 Jun 2023 05:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] mptcp: fixes for 6.4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168741302875.1197.7249004377645808995.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 05:50:28 +0000
References: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
In-Reply-To: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 cpaasch@apple.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 18:24:17 +0200 you wrote:
> Patch 1 correctly handles disconnect() failures that can happen in some
> specific cases: now the socket state is set as unconnected as expected.
> That fixes an issue introduced in v6.2.
> 
> Patch 2 fixes a divide by zero bug in mptcp_recvmsg() with a fix similar
> to a recent one from Eric Dumazet for TCP introducing sk_wait_pending
> flag. It should address an issue present in MPTCP from almost the
> beginning, from v5.9.
> 
> [...]

Here is the summary with links:
  - [net,1/6] mptcp: handle correctly disconnect() failures
    https://git.kernel.org/netdev/net/c/c2b2ae3925b6
  - [net,2/6] mptcp: fix possible divide by zero in recvmsg()
    https://git.kernel.org/netdev/net/c/0ad529d9fd2b
  - [net,3/6] mptcp: fix possible list corruption on passive MPJ
    https://git.kernel.org/netdev/net/c/56a666c48b03
  - [net,4/6] mptcp: consolidate fallback and non fallback state machine
    https://git.kernel.org/netdev/net/c/81c1d0290160
  - [net,5/6] mptcp: drop legacy code around RX EOF
    https://git.kernel.org/netdev/net/c/b7535cfed223
  - [net,6/6] mptcp: ensure listener is unhashed before updating the sk status
    https://git.kernel.org/netdev/net/c/57fc0f1ceaa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-27796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F063677D364
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B393F2814F0
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978818053;
	Tue, 15 Aug 2023 19:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983B1426C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03B92C433C7;
	Tue, 15 Aug 2023 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692127822;
	bh=BM184u5nvZhwsYkbxwLOdm0WI6C650QvMdfNsc9YvoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5TPSOmnLCXW2G72+oNMAn+op+Y3aKJMQY58JAztbjdqsUmBUDQY/M5l0wbqkW4Z8
	 nr5wuwCVzM60Y+OkBqzgyhVw5cwmCuFkP2CWXZEcoGHTnWqhJaWwcgoIwNgzqik4gO
	 HRuT6IOVP5RlPvnB26soQGBzZJvxOPx0G65EGqZVZ5u8TKOV873fX16eIGZXA+roa8
	 z3jHqA6HMh3Qg07FhIbcALiBe5tHl0Caw/X+WNWxU53RRRn/o20MXdnIOJ56tiXHJr
	 i4QKCOfFd2H/mQomtQAqqZmDAfIKuhaRLqmi4sSRA3lccFpLh7Lzzjt0uvkhQI0gjP
	 1EKy+94pfksLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6C02C395C5;
	Tue, 15 Aug 2023 19:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: fix the RTO timer retransmitting skb every 1ms if
 linear option is enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169212782187.7072.16617221851171968021.git-patchwork-notify@kernel.org>
Date: Tue, 15 Aug 2023 19:30:21 +0000
References: <20230811023747.12065-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230811023747.12065-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, apetlund@simula.no,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 10:37:47 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In the real workload, I encountered an issue which could cause the RTO
> timer to retransmit the skb per 1ms with linear option enabled. The amount
> of lost-retransmitted skbs can go up to 1000+ instantly.
> 
> The root cause is that if the icsk_rto happens to be zero in the 6th round
> (which is the TCP_THIN_LINEAR_RETRIES value), then it will always be zero
> due to the changed calculation method in tcp_retransmit_timer() as follows:
> 
> [...]

Here is the summary with links:
  - [v2,net] net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled
    https://git.kernel.org/netdev/net/c/e4dd0d3a2f64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




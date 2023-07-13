Return-Path: <netdev+bounces-17340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46FF751522
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815851C2115D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945A364;
	Thu, 13 Jul 2023 00:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626D7C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC31FC433C9;
	Thu, 13 Jul 2023 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689207620;
	bh=ho8G3pd0KuiTAYD5vxaiJqIZF//Y9/MED/YaoPsHH84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkdMsEe19yusZW8LPRPwXfK4RpqW7kmhwD3qPFLS+OPqurkBVzrnxO4wPfO/BJxL+
	 +bfxFO9R9TKAn2uRcgNKtraUmEngoQXsd/fTMRpWf2/Lhmo7xaDoB1lFfSuBnyNBqO
	 6meIOqeLW9ntsX3SuXVVN31rVROcsQtNiW/gTSPyl8gj0jBgZ1u/mm43ybgpEFhR5k
	 FuiknhphGsKZJFUIUOiXulIUqi/7tyl/sJ4xBe8a2+k+4ZxjuWIRFyAwzTXQ1lrZW6
	 sELM34fmUq8RAl9RriUCNIH4NLYS0qL4LjrZ7TE6N6bJ3EQptwktGV73Ujh8pQN4Wt
	 JN1xb7c3J8UTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFE6FE29F44;
	Thu, 13 Jul 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] ipv6: rpl: Remove redundant skb_dst_drop().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168920762077.17837.12263036084287457130.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jul 2023 00:20:20 +0000
References: <20230710213511.5364-1-kuniyu@amazon.com>
In-Reply-To: <20230710213511.5364-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 14:35:11 -0700 you wrote:
> RPL code has a pattern where skb_dst_drop() is called before
> ip6_route_input().
> 
> However, ip6_route_input() calls skb_dst_drop() internally,
> so we need not call skb_dst_drop() before ip6_route_input().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] ipv6: rpl: Remove redundant skb_dst_drop().
    https://git.kernel.org/netdev/net-next/c/c5ec13e38af5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




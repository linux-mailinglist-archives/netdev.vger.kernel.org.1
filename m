Return-Path: <netdev+bounces-37301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830AD7B4941
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0A2E2281A77
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6BEED5;
	Sun,  1 Oct 2023 18:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460019473
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDB18C433CA;
	Sun,  1 Oct 2023 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696185627;
	bh=qevOZWO9MSO1kPTL8Y3MoL5kdTLEmzfQWM1JPojf63E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JsMYTPce4efE1X/PS8exkhRoLLU2d0ovWYKSLl1qFu/KjWhsA0VkrL3G0LE2ImE7H
	 Gg6baYJSHpkMpFmjxvLeQhbzDPnIpFD5h0rE8yoB24rkBSTKlganca6F7EJ8iay3Uo
	 S6BAwtn4yTgliqJEzAsfl7+bqXL94ncAKyVTmUZh1AIjTv/6BqUYKYLZlPVi4kzVoS
	 vR57MnqGZQDYY84SRQXjeeuutUFQH4161OvN3J1OwIyoCA2dWsoNPJRpRY1Rqw4QUa
	 u8lzzvD6unz24feMrHEvxhnC6fNZrsg0Lv3waXqKyAaxPDBXSCSN7CVA+lEa88hknX
	 WduIZ4iWLzkVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA574E29AFE;
	Sun,  1 Oct 2023 18:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/8] inet: more data-race fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169618562782.20334.8717767644405837568.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 18:40:27 +0000
References: <20230922034221.2471544-1-edumazet@google.com>
In-Reply-To: <20230922034221.2471544-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Sep 2023 03:42:13 +0000 you wrote:
> This series fixes some existing data-races on inet fields:
> 
> inet->mc_ttl, inet->pmtudisc, inet->tos, inet->uc_index,
> inet->mc_index and inet->mc_addr.
> 
> While fixing them, we convert eight socket options
> to lockless implementation.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/8] inet: implement lockless IP_MULTICAST_TTL
    https://git.kernel.org/netdev/net-next/c/c9746e6a19c2
  - [v2,net-next,2/8] inet: implement lockless IP_MTU_DISCOVER
    https://git.kernel.org/netdev/net-next/c/ceaa714138a3
  - [v2,net-next,3/8] inet: implement lockless IP_TOS
    https://git.kernel.org/netdev/net-next/c/e08d0b3d1723
  - [v2,net-next,4/8] inet: lockless getsockopt(IP_OPTIONS)
    https://git.kernel.org/netdev/net-next/c/a4725d0d8935
  - [v2,net-next,5/8] inet: lockless getsockopt(IP_MTU)
    https://git.kernel.org/netdev/net-next/c/3523bc91e4b4
  - [v2,net-next,6/8] inet: implement lockless getsockopt(IP_UNICAST_IF)
    https://git.kernel.org/netdev/net-next/c/959d5c11601b
  - [v2,net-next,7/8] inet: lockless IP_PKTOPTIONS implementation
    https://git.kernel.org/netdev/net-next/c/c4480eb5504c
  - [v2,net-next,8/8] inet: implement lockless getsockopt(IP_MULTICAST_IF)
    https://git.kernel.org/netdev/net-next/c/02715925222c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-23844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D976DD8D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC78B281E0E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 01:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B54C92;
	Thu,  3 Aug 2023 01:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39E3C2C
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB931C43397;
	Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691027425;
	bh=rkZyjFoiINJKcvgjJDh15mma4DAFQkOxn8TW8UF6ZPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OezC8qZdgtZnhVZwcUtTHWLVY8zyCdOSTlHfTPSdL+xAoj+m67bNIt1evOdQGHR9f
	 3ch28xTx2M427xq1iHXQnHkhNS46NzmjG9AsU41m8iz0tGS09Rl+vy27+KHeuH2bbs
	 /jlxgcEWMu2Ki3qikBcTGMHqNSLHGWRN0FtrgUwL/OGnNR88GA8giqHZFc313rF1vL
	 3EFNUeQwzdjmidMQCCpVzTTvrOr9IlZ2K6HVVI66VI8siPuY5YiuWVL3dDMpTafusa
	 bQWM/SQNyjizMI8962jGUe/koSDFPXs1hPvxxC7lFOAF2SP+ILLTwyYSUB53BpCXyO
	 SWKbtaPfHnxqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 977E4E270DA;
	Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] net: extend alloc_skb_with_frags() max size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169102742561.3352.14967614117346481811.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 01:50:25 +0000
References: <20230801205254.400094-1-edumazet@google.com>
In-Reply-To: <20230801205254.400094-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, trdgn@amazon.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Aug 2023 20:52:50 +0000 you wrote:
> alloc_skb_with_frags(), while being able to use high order allocations,
> limits the payload size to PAGE_SIZE * MAX_SKB_FRAGS
> 
> Reviewing Tahsin Erdogan patch [1], it was clear to me we need
> to remove this limitation.
> 
> [1] https://lore.kernel.org/netdev/20230731230736.109216-1-trdgn@amazon.com/
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] net: allow alloc_skb_with_frags() to allocate bigger packets
    https://git.kernel.org/netdev/net-next/c/09c2c90705bb
  - [v2,net-next,2/4] net: tun: change tun_alloc_skb() to allow bigger paged allocations
    https://git.kernel.org/netdev/net-next/c/ce7c7fef1473
  - [v2,net-next,3/4] net/packet: change packet_alloc_skb() to allow bigger paged allocations
    https://git.kernel.org/netdev/net-next/c/ae6db08f8b56
  - [v2,net-next,4/4] net: tap: change tap_alloc_skb() to allow bigger paged allocations
    https://git.kernel.org/netdev/net-next/c/37dfe5b8ddeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-23842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5B76DD8B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4441C213C8
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 01:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A291FB7;
	Thu,  3 Aug 2023 01:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA53C23
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA23CC433CC;
	Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691027425;
	bh=XtgZ/qI++KtWGKqmJn7j1/0RNquJ6mZwl8XDpi2J/m8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s9wfx+A0G0+QR6vElATTpSm8Wg0oMGaV200fgPv5Ox1BlrCQjWKo1qBzf8abzNXnT
	 EwXdYKSU05+rH5ur3TIyKsqdCkuP8+DLsnS0GSveKiFtL+H8NUbyRZhNhZp21IsQ3v
	 kH1GbjRgr/n/QDatKFTljHj9gvJTaSij+COt+srlP9nu9l6it2QFQrlUHJ3iWftJ2M
	 B3NO/qLFs+O/cMAIlbVh+NJx6tj/edyovZ4sCQgtAyCFBZjYSM8dXC8yRnDD5F1RCT
	 eHk7XZghvy1EF25T69Go0j/9w9c5yPptUVMKdWkw7Ww/3+6ba2LYv7DNpsZL62EcvZ
	 hKy2c5cRU/u7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F58BE96ABD;
	Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: relax alloc_skb_with_frags() max size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169102742558.3352.14898612361078870781.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 01:50:25 +0000
References: <20230801135455.268935-1-edumazet@google.com>
In-Reply-To: <20230801135455.268935-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, trdgn@amazon.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Aug 2023 13:54:51 +0000 you wrote:
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
  - [net-next,1/4] net: allow alloc_skb_with_frags() to allocate bigger packets
    (no matching commit)
  - [net-next,2/4] net: tun: change tun_alloc_skb() to allow bigger paged allocations
    https://git.kernel.org/netdev/net-next/c/ce7c7fef1473
  - [net-next,3/4] net/packet: change packet_alloc_skb() to allow bigger paged allocations
    https://git.kernel.org/netdev/net-next/c/ae6db08f8b56
  - [net-next,4/4] net: tap: change tap_alloc_skb() to allow bigger paged allocations
    https://git.kernel.org/netdev/net-next/c/37dfe5b8ddeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




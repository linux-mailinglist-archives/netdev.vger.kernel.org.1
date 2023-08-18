Return-Path: <netdev+bounces-28981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C271E78155F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEEC1C20C5B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC4B1C29C;
	Fri, 18 Aug 2023 22:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D69182BC
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B101FC433CD;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397227;
	bh=yAGr1Gud/zMTA5aV2+7QBJBGy56ox43o/qp8vDYB6ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=icg86KYtc8pxZQwQglwFEqsrtSZOx+I3+vyngjkUbIFVmIl8q8ceuXLgyGX2qR4NP
	 Kvlp9ZGFsg3Ry5XhGViNMRQr1ZYxd91RtVb0Vif0N0mmIfANiCsFkG/yAEiZQl7D6M
	 KpIY/If9NGRaDupVsSApm4vykxQ4uYS6vmz8HE8F7PjdqGlduigPIzSYDu9Ucqjt+8
	 QtzJV2ovPVn7TPBloOqSfDLuhcOQIDyJm7xxPQfemfjJp9c7kUJD3vIAskwI/LB+kt
	 8oVJzdE1h8PeAW4lZdXGNohDXI25KsHVCX2qP4vPRwSbrp3R5JfEgV6s5itzzcZDfs
	 ZIqozcP6cj6GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 985A9E26D36;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache skbuff_head_cache
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239722762.24641.15513664740628258314.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:20:27 +0000
References: <169211265663.1491038.8580163757548985946.stgit@firesoul>
In-Reply-To: <169211265663.1491038.8580163757548985946.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, vbabka@suse.cz, eric.dumazet@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, mgorman@techsingularity.net, cl@linux.com,
 roman.gushchin@linux.dev, dsterba@suse.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Aug 2023 17:17:36 +0200 you wrote:
> Since v6.5-rc1 MM-tree is merged and contains a new flag SLAB_NO_MERGE
> in commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag SLAB_NO_MERGE")
> now is the time to use this flag for networking as proposed
> earlier see link.
> 
> The SKB (sk_buff) kmem_cache slab is critical for network performance.
> Network stack uses kmem_cache_{alloc,free}_bulk APIs to gain
> performance by amortising the alloc/free cost.
> 
> [...]

Here is the summary with links:
  - [net] net: use SLAB_NO_MERGE for kmem_cache skbuff_head_cache
    https://git.kernel.org/netdev/net-next/c/0a0643164da4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




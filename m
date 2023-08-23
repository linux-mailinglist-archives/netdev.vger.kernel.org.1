Return-Path: <netdev+bounces-29915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E978530E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0DD1C20BA7
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A67A94B;
	Wed, 23 Aug 2023 08:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4410E882A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D141BC43395;
	Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692780622;
	bh=D59qyq58UezOttgdWtESqgR1cWRWfhp0fLfSQcwW5b0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s29Oj2Vn6Y/etE5V4qIM4XmlsVUEBUi8axTHTrt9o706JSONZLdnWC3CTeIwvMBYP
	 7mdcW0+m0skTxWYwMvtgfTCzpNgRb/EPVsl9SUgIexWTiF4iRZNThk4/5C7C6F7yqz
	 mkbUiEayrhJzp8N/GG3uxG7zv0y41fOYKmFkM3+C1HlgS8iq1YJzL6OpM8qSDqM7hg
	 otRVpAGr8kSWnYVfnvBIDntBHUmLxaa7EFXGj/hm1cks+RsFpZADp6lhAUu0G3FegL
	 mSdmkfKfc1agGQoJ+A6lHwcQmSWCBx6RSFxHSrNn43gt6Ug4CTKHbUUlu7YLo97KMS
	 1gVofXoic1PWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9D7DE330A1;
	Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169278062275.13745.14874894207832456687.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 08:50:22 +0000
References: <20230821142713.5062-1-feliu@nvidia.com>
In-Reply-To: <20230821142713.5062-1-feliu@nvidia.com>
To: Feng Liu <feliu@nvidia.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jasowang@redhat.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, willemdebruijn.kernel@gmail.com,
 horms@kernel.org, bodong@nvidia.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Aug 2023 10:27:13 -0400 you wrote:
> The virtio_net driver currently deals with different versions and types
> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> on multiple type casts to convert memory between different structures,
> potentially leading to bugs when there are changes in these structures.
> 
> Introduces the "struct skb_vnet_common_hdr" as a unifying header
> structure using a union. With this approach, various virtio net header
> structures can be converted by accessing different members of this
> structure, thus eliminating the need for type casting and reducing the
> risk of potential bugs.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] virtio_net: Introduce skb_vnet_common_hdr to avoid typecasting
    https://git.kernel.org/netdev/net-next/c/dae64749db25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




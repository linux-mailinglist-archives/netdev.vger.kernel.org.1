Return-Path: <netdev+bounces-24346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BB76FE29
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385581C2179E
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6999AD29;
	Fri,  4 Aug 2023 10:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A4A92F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFD83C433C8;
	Fri,  4 Aug 2023 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691143820;
	bh=Xc3OKQSd3PrTUhz9ThOXVWsk0oIpJWblGCBXe2VUwrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NElv208tUJZtArIw3syRtQy2EfGQfk0a+GQbY1mYyHCYWze7XxV5ecQYsKzKX+4NN
	 rwF8asWqK16M4ZVdbePm+itvGthfKQ56fNibdP4Dba+XYoBxLhe/vqYDmaYkeoLOzd
	 0mAJKxOhnIt9x6llO0gGeh7M0rSIi1qJ2/OSZVIi5q5ilH4sanDfr7pI0rvGx5K3uj
	 8fPiB3gn/T5t6bi4AlINGd/4dmt5RSXzSlatgOLznLLSBdJSbaNCRMkyti8y2Vqctd
	 eysMGq2GslWmUjUS65CdO1MR1u6goCTvK1N9xeYS99Gv2e1630px8LUVWdgs3Rg9py
	 HHDR3j+d1y9uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1C69C395F3;
	Fri,  4 Aug 2023 10:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: vlan: update wrong comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169114382079.5978.17989706850682909943.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 10:10:20 +0000
References: <20230803071426.2012024-1-edumazet@google.com>
In-Reply-To: <20230803071426.2012024-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  3 Aug 2023 07:14:26 +0000 you wrote:
> vlan_insert_tag() and friends do not allocate a new skb.
> However they might allocate a new skb->head.
> Update their comments to better describe their behavior.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/if_vlan.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: vlan: update wrong comments
    https://git.kernel.org/netdev/net-next/c/7740bb882fde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




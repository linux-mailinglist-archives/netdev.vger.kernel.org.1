Return-Path: <netdev+bounces-31559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CE78EC44
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378A82814E2
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD71D9447;
	Thu, 31 Aug 2023 11:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762C8F7D
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEB2BC433C9;
	Thu, 31 Aug 2023 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693482022;
	bh=Wo1xSHg+4FEP4DFGrh3+62tTcLkkA4WL5msk1a1esp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DITEl4oUHbOHGU8ARqZCucId2JlK/xcrfWo35PQWoV5LNYItf9T4mPHta3LgZhtgQ
	 cqHvClT7wCO+neaxBPX2Zs0HbVxhOsN4tdJWV5QTnnznjaE0IamcS2qdmu6oNh2kp+
	 EeYhKBbIKd54t1eWYRe+bZJ8kIrN+KzGt2ZNJ1ymFLvoKkCdJdYYn3wwtS+o6XHqy1
	 CeiWjd/jeDSvMOW1ch9xMPQfwzerkMutW/WckG8LMPeZ5C3jBGaixqOMfAVYImeaPk
	 y96PYrpTuncMuxA/1rRYWKyNBhG2rlydcMq8OEvkpAgx7uJCB8o113GrMceRpBMhFG
	 PgUSVf3smNO+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 963EBE270FB;
	Thu, 31 Aug 2023 11:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fib: avoid warn splat in flow dissector
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169348202260.28655.16047640718927905946.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 11:40:22 +0000
References: <20230830110043.30497-1-fw@strlen.de>
In-Reply-To: <20230830110043.30497-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, sdf@google.com, dsahern@kernel.org,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 30 Aug 2023 13:00:37 +0200 you wrote:
> New skbs allocated via nf_send_reset() have skb->dev == NULL.
> 
> fib*_rules_early_flow_dissect helpers already have a 'struct net'
> argument but its not passed down to the flow dissector core, which
> will then WARN as it can't derive a net namespace to use:
> 
>  WARNING: CPU: 0 PID: 0 at net/core/flow_dissector.c:1016 __skb_flow_dissect+0xa91/0x1cd0
>  [..]
>   ip_route_me_harder+0x143/0x330
>   nf_send_reset+0x17c/0x2d0 [nf_reject_ipv4]
>   nft_reject_inet_eval+0xa9/0xf2 [nft_reject_inet]
>   nft_do_chain+0x198/0x5d0 [nf_tables]
>   nft_do_chain_inet+0xa4/0x110 [nf_tables]
>   nf_hook_slow+0x41/0xc0
>   ip_local_deliver+0xce/0x110
>   ..
> 
> [...]

Here is the summary with links:
  - [net] net: fib: avoid warn splat in flow dissector
    https://git.kernel.org/netdev/net/c/8aae7625ff3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-17087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603C4750363
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AF2281672
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA51F94F;
	Wed, 12 Jul 2023 09:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3E100AA
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67DAAC433C7;
	Wed, 12 Jul 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689154820;
	bh=eui3ElizVALJvQPZAnA8auZoUXaOjtaF95AYMnojz8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y+aGD5s/2vrJeLtKX0Sncf1yk/4WD0FiBMuWLSV0Fmn1ScZy1jDYqNFDiazoeadDi
	 pviOWa0U9Qhqgv50spuT+jZYLLZLL67t0UxXnFAd+fGQ+ymgFENlcuvBn/vl6YLNP1
	 g4cG8km9CupiV7JsxRc6yH7XTYfp31T2axspvqsbj+e2YVmqt41sOrCj0qibJrRFI1
	 WJjdT+6RBR0bWzxlDjrP0sUuFf3wnA+g+jjwdULYa3UNtg1Jx/kBvdn6ckMGUmuqMq
	 kZXn1g/UnwZoJh13FRgE9K66Rm7jInp0WyQdyVzlIHArb+Q38ifsyy8z41LARi6cxP
	 s6tZvQE5qUFHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50F0AC4167B;
	Wed, 12 Jul 2023 09:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: flower: Ensure both minimum and maximum ports
 are specified
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168915482032.15286.5930612075785239000.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 09:40:20 +0000
References: <20230711070809.3706238-1-idosch@nvidia.com>
In-Reply-To: <20230711070809.3706238-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, amritha.nambiar@intel.com,
 petrm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 11 Jul 2023 10:08:09 +0300 you wrote:
> The kernel does not currently validate that both the minimum and maximum
> ports of a port range are specified. This can lead user space to think
> that a filter matching on a port range was successfully added, when in
> fact it was not. For example, with a patched (buggy) iproute2 that only
> sends the minimum port, the following commands do not return an error:
> 
>  # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 100-200 action pass
> 
> [...]

Here is the summary with links:
  - [net] net/sched: flower: Ensure both minimum and maximum ports are specified
    https://git.kernel.org/netdev/net/c/d3f87278bcb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




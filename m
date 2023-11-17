Return-Path: <netdev+bounces-48536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA27EEB71
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 04:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C1E280EC9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6BB5683;
	Fri, 17 Nov 2023 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXPJwkXS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD962610D
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 03:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E7EBC433C9;
	Fri, 17 Nov 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700191823;
	bh=0PYGxLD+QauCZZaLemIjij07LmWjZ5wPxa+fS3UHPUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tXPJwkXSG1gnNouHzAf/swq450e94Y8u0sD3qVRtWR3RUUZguEdlnUB1msXS4tiB7
	 3AduCEFR7AMwUV8N7awO7Hbb+oMFn+rkbwal9WR9QX2h/BtIm/XaagHM2ADWrnAYO2
	 hxS29iP9CtM8/MMy2HoHhL7qeKRJKGGisx9h8JmLCA36tJEGElyAJxOcfn2EdXhELC
	 FUWQzfESFJ8iX4hF9XVaDmCmgYE+ZeMCeX2hgyradFDSGK16PlB8exMCSrR/6z/291
	 +QkbmgOe+iRgC7ihYPb+PXL4nIPuU+646bwdkQHdDGzANKU1vRK4mVhNvLhRQBtco3
	 WJt8r3OMmxUOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14ADAE1F662;
	Fri, 17 Nov 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: add gve_features_check()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170019182308.16394.9220064510619411582.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 03:30:23 +0000
References: <20231116085707.2475816-1-edumazet@google.com>
In-Reply-To: <20231116085707.2475816-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, bcf@google.com,
 willemb@google.com, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, ziweixiao@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 Nov 2023 08:57:07 +0000 you wrote:
> It is suboptimal to attempt skb linearization from ndo_start_xmit()
> if a gso skb has pathological layout, or if host stack does not have
> access to the payload (TCP direct). Linearization of large skbs
> can also fail under memory pressure.
> 
> We should instead have an ndo_features_check() so that we can
> fallback to GSO, which is supported even for TCP direct,
> and generally much more efficient (no payload copy).
> 
> [...]

Here is the summary with links:
  - [net] gve: add gve_features_check()
    https://git.kernel.org/netdev/net-next/c/18de1e517ed3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




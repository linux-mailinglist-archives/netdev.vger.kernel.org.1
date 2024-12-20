Return-Path: <netdev+bounces-153829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D869F9C98
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9A71894A71
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E5022618F;
	Fri, 20 Dec 2024 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl9VUhPJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311639FF3
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732614; cv=none; b=jeADegrcfkxfmhN9bIOs8X8GafFVYGlmT+ZWqc69/1NnhGW2+DwFQkNs7VZ6QCdtWVG3Vk6czxrn/gHfyqV/4HphUz0ONuNoXNpmvfQzt+TeWUHb8UP5SSu2yA5Hx9+vVk8+BLoYPz6+9URNYwtGWZFvl0Vy/vcCNFNY304pLQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732614; c=relaxed/simple;
	bh=Ax/6aooeKtOtgpvgvbBbKoD8s5ph/AFHrg5zQNWTKJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JhGzwLACenZl6c9H9+EkWBrC7XVFGxTGvRunKPOilYki60VddO9iBJF9aY8ncw972LKbjKPjDBiy1RCmYj/QnnjGuXULDYb9excSAvNHTUnEHwp9C8x58KTgM3fSv3ESzgJxebJJCjciuosaYAfvujdJT1PP7cOFaxT5KBB5J3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl9VUhPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56907C4CECD;
	Fri, 20 Dec 2024 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734732613;
	bh=Ax/6aooeKtOtgpvgvbBbKoD8s5ph/AFHrg5zQNWTKJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jl9VUhPJ8L8/xH+y3CRy+9jFlNOTZs8GeRUZFPQGYTslsP46IL6nlFqTRpfQl9o9H
	 LRTtDga0GXKlH0E+rdC/llK1OptX/2sjnYnR95l35GlFDevL9el5d9CcO61hGcrCev
	 rcPQQxn2ZYFfWWfh5TZxYO7ZX9iAG6K7q3V4MAhf4bzIg2pHIXw/RwZvTu4evL59Aa
	 k3+9jHAVmXNT2cmLWra+pZFWH+gz0EItd5sxTvVGPuEr55dXnzf111yetm0gOvzgzd
	 0FrQrHa6dp/XwUo4aE3oBwPN2DQpqtjX5WGxUp4zBB09dq49Arlcw6LPcHj5JBz8Xl
	 4y97dI+8L2P3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCC3806656;
	Fri, 20 Dec 2024 22:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] ipv4: Consolidate route lookups from IPv4
 sockets.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173473263127.3034452.1670644709350879348.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 22:10:31 +0000
References: <cover.1734357769.git.gnault@redhat.com>
In-Reply-To: <cover.1734357769.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, jchapman@katalix.com, tparkin@katalix.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 18:21:40 +0100 you wrote:
> Create inet_sk_init_flowi4() so that the different IPv4 code paths that
> need to do a route lookup based on an IPv4 socket don't need to
> reimplement that logic.
> 
> Guillaume Nault (5):
>   ipv4: Define inet_sk_init_flowi4() and use it in
>     inet_sk_rebuild_header().
>   ipv4: Use inet_sk_init_flowi4() in ip4_datagram_release_cb().
>   ipv4: Use inet_sk_init_flowi4() in inet_csk_rebuild_route().
>   ipv4: Use inet_sk_init_flowi4() in __ip_queue_xmit().
>   l2tp: Use inet_sk_init_flowi4() in l2tp_ip_sendmsg().
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ipv4: Define inet_sk_init_flowi4() and use it in inet_sk_rebuild_header().
    https://git.kernel.org/netdev/net-next/c/1dbdce30f040
  - [net-next,2/5] ipv4: Use inet_sk_init_flowi4() in ip4_datagram_release_cb().
    https://git.kernel.org/netdev/net-next/c/5be1323b5041
  - [net-next,3/5] ipv4: Use inet_sk_init_flowi4() in inet_csk_rebuild_route().
    https://git.kernel.org/netdev/net-next/c/42e5ffc385f3
  - [net-next,4/5] ipv4: Use inet_sk_init_flowi4() in __ip_queue_xmit().
    https://git.kernel.org/netdev/net-next/c/148721f8e04a
  - [net-next,5/5] l2tp: Use inet_sk_init_flowi4() in l2tp_ip_sendmsg().
    https://git.kernel.org/netdev/net-next/c/c63e9f3b89d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




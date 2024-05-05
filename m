Return-Path: <netdev+bounces-93470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A018BC092
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 15:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFC52817EB
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47691BC5C;
	Sun,  5 May 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxdMDLXK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9C847C
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714916429; cv=none; b=GJb8hN6em26gB98JAoFZxgYOlYuIavzJoQkhoUO0qivjxsjagJa03Zg1tRPFsn3DVYRuFrH/qi3dc/CZ9MX8yYqnpudHdub9KGk37Iky230fvY5hUqcU5oqIcJgZ8prQoV7ofBJiZhM/J4GphHVRUETs0Meu9PjgeAXoTXfgr8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714916429; c=relaxed/simple;
	bh=sSxitplGFqNjh8N52IplEoFTCDOinmD/xyRf1KU0QLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P6mWHp/xjeRJku6lBN8j+1EdqbMWt46ync3CutxdK7/3MHJL1ZyosqYbbANBfcr+awn6iPHL9J0gYZ4L3lef7OIB7zV6VUn76EnW96sOZ7fCA6QKLn0VLpRQv7W1fDBpyR91EJuSZDbQa8hg6pj4DZ+quSO1DiR229cm0oNdpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxdMDLXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BF2FC4AF18;
	Sun,  5 May 2024 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714916429;
	bh=sSxitplGFqNjh8N52IplEoFTCDOinmD/xyRf1KU0QLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oxdMDLXK/rnHBySsJ1vSkBTKwM4bODQKbZiEXOG70TWmznmmlwa+YO/pq7Wg7d6nr
	 CRWlhcJExFw694PQdnAXjsVj5a6wuC3U/tgcuhMXJMLXVaPoc7eI6oBRyia2husyMh
	 9jx97KXuYsUkAvmFTBljc5YgWVIJN5nHza7aaQeBnStZ9oDEsv38tppmry0pDnrd1K
	 p6c4AYzjKXSKC0WB7M7qYPXOVYf51ZVuNY+3NQf62Erg8grlICkJhXV1YZJkzg+0nL
	 +lYSVXutnRfgiKpvhQzeg1ITPRgspqIc4kl48MN5H/N6iug/Doq6d24XSoX4d2s1MX
	 1T8yBUar9Fbpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE34FC43444;
	Sun,  5 May 2024 13:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] gve: Implement queue api
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171491642897.19257.15217395970936349981.git-patchwork-notify@kernel.org>
Date: Sun, 05 May 2024 13:40:28 +0000
References: <20240501232549.1327174-1-shailend@google.com>
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, davem@davemloft.net,
 edumazet@google.com, hramamurthy@google.com, jeroendb@google.com,
 kuba@kernel.org, pabeni@redhat.com, pkaligineedi@google.com,
 rushilg@google.com, willemb@google.com, ziweixiao@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  1 May 2024 23:25:39 +0000 you wrote:
> Following the discussion on
> https://patchwork.kernel.org/project/linux-media/patch/20240305020153.2787423-2-almasrymina@google.com/,
> the queue api defined by Mina is implemented for gve.
> 
> The first patch is just Mina's introduction of the api. The rest of the
> patches make surgical changes in gve to enable it to work correctly with
> only a subset of queues present (thus far it had assumed that either all
> queues are up or all are down). The final patch has the api
> implementation.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] queue_api: define queue api
    https://git.kernel.org/netdev/net-next/c/087b24de5c82
  - [net-next,v2,02/10] gve: Make the GQ RX free queue funcs idempotent
    https://git.kernel.org/netdev/net-next/c/dcecfcf21bd1
  - [net-next,v2,03/10] gve: Add adminq funcs to add/remove a single Rx queue
    https://git.kernel.org/netdev/net-next/c/242f30fe692e
  - [net-next,v2,04/10] gve: Make gve_turn(up|down) ignore stopped queues
    https://git.kernel.org/netdev/net-next/c/5abc37bdcbc5
  - [net-next,v2,05/10] gve: Make gve_turnup work for nonempty queues
    https://git.kernel.org/netdev/net-next/c/864616d97a45
  - [net-next,v2,06/10] gve: Avoid rescheduling napi if on wrong cpu
    https://git.kernel.org/netdev/net-next/c/9a5e0776d11f
  - [net-next,v2,07/10] gve: Reset Rx ring state in the ring-stop funcs
    https://git.kernel.org/netdev/net-next/c/770f52d5a0ed
  - [net-next,v2,08/10] gve: Account for stopped queues when reading NIC stats
    https://git.kernel.org/netdev/net-next/c/af9bcf910b1f
  - [net-next,v2,09/10] gve: Alloc and free QPLs with the rings
    https://git.kernel.org/netdev/net-next/c/ee24284e2a10
  - [net-next,v2,10/10] gve: Implement queue api
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




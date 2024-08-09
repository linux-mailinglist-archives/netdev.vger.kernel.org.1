Return-Path: <netdev+bounces-117075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A87294C8E0
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42D01F2240C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20317C96;
	Fri,  9 Aug 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNxAUH74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526244431;
	Fri,  9 Aug 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723174233; cv=none; b=OYHMyBufS/RiGlLsYHLIps8tYa6NRuv6pgHsNLUs6nLi1U1tKXYRE6ouHmQ+IKHUqjrX63Vgss4v7fIMysD2Ix5LOdiEYqXD87S3JjQKclTbYAk59hvsaeOayCsRBP1DDn1NA2J6VeHnjdLs36i/eRwUcgy6hESa3pT5kgQhwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723174233; c=relaxed/simple;
	bh=gJMVksyl2Ls2p9cs9deXH622UqCW3R8X5vPzXU+vTX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QJb3/ynJSZuI2lv/6zwNVdgOFP5ASYd+84bLUCRz0hoYi5Ym7p64KPBE/J7N+HiCbe92qjGZv12dKT/IaF3CFISkPvaf2yrWnIyr4brocSiQlzXhG7MZx0WgwbHx52bIYwQ8TDqZmg/jo5bss3gJ1UApvgiV3oNnxnEfD2FvZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNxAUH74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AB2C32782;
	Fri,  9 Aug 2024 03:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723174232;
	bh=gJMVksyl2Ls2p9cs9deXH622UqCW3R8X5vPzXU+vTX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jNxAUH74LyTW8Z07+bmDZjOgVgaPBhMBAZRJrOw+FxX8u/kjLW1Rmdj3gBZBd2p+Z
	 0YFQ0ycxs8IjTFfI5xGCJWaO2l2s1SLzJBJ4G62CRFWdrUv9XHLQdNMhvGM8xYG9MT
	 IeZdHLLjrUUOH5pRlYVkEvwbJSWMGhgipAVdqQ+UB53XKQO+wlLn78KLQPJIrro9k6
	 or7WJUOvx3Jtzk9se55UoYsTjNPWvVKOabhYj0Gqa0zc/UjvUvD5cL8d5dOFLUnPOz
	 qGXx7XswS9fHvK8ZqD7NaEnynS7u1oXwwsbqpTddqA5ix3lWhgNTluu/vYRYCInxTV
	 Odxso/m5QV9lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3E03810938;
	Fri,  9 Aug 2024 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ti: icssg_prueth: populate netdev of_node
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172317423175.3370989.5473311644599624049.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 03:30:31 +0000
References: <20240807121215.3178964-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20240807121215.3178964-1-matthias.schiffer@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Aug 2024 14:12:15 +0200 you wrote:
> Allow of_find_net_device_by_node() to find icssg_prueth ports and make
> the individual ports' of_nodes available in sysfs.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> Tested on a TI AM64x SoC. I don't have a device using the icssg_prueth_sr1
> variant of the driver, but as this part of icssg_prueth.c and
> icssg_prueth_sr1.c is identical, it seems like a good idea to make the
> same change in both variants.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ti: icssg_prueth: populate netdev of_node
    https://git.kernel.org/netdev/net-next/c/eb3ab13d997a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




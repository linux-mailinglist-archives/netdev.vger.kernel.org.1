Return-Path: <netdev+bounces-102099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9190166A
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B67B20EA1
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253ED45BE4;
	Sun,  9 Jun 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED0Fo0Rn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ECB4501F
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717945232; cv=none; b=nYTp+qLwe4GtsDDpnEM6COW1Av9vtXCCjxAI4k8c2UJ1BcoYiDrvELzeZSQ2aBNn50VFBkfs1FDNsjgBM3+eTP09D6j3nHYUPCvzSsOhMIUV0CW4jKKwh4Qz53B8vf84SSbmsiXOL4SGNMm+QiiwmtDz3D9FuDHxvSkhbz+WMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717945232; c=relaxed/simple;
	bh=I/j3nqgYfuNhpZBCVLkvnIYqdAyWVLX4mBILsLwxEhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hzkupqC6aGCD1YwrkXFL7xjCyeRrEZR8PZh0a3+w/P5AKBbzughEwtvvL5l6Fiw6bwhGHjJL32ipKz9E8IMFJQpaCTtZJ3aBzT+sJbQo0Mrz7wBLSx1zfJMN7bBT4u817gWCS8SJM3vKIQDWm1kPA6V8KhWn1R8aV/H8OZpwKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED0Fo0Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9448C4AF51;
	Sun,  9 Jun 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717945231;
	bh=I/j3nqgYfuNhpZBCVLkvnIYqdAyWVLX4mBILsLwxEhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ED0Fo0Rntia23OeD1yOEWZciS4iAz2h0kcz1aFgMINS7kR+FrQQ6ugo59pdhx8dr0
	 WqM1mUQQwRENwKlGteyzk8lzzMK0/nTb1MoO6WHeBE8RjlNWu+Knt7GjtPx5g24fGr
	 8Xo4M7aE+Hb1lw68PJkzbKmycS02ttFJAqD0L0h30X+2sukH4UUAg/M41OhLHxsDYj
	 v2aZJVD2wcVGYZNq3jDfOjnn3jsftOcQyt9PtGkRBo/aqQxc+WyZOYfI6yzCZzIvUr
	 rUPywuyJfJwC8rgCKTFYn91p9yO3QdPJ48dmQvbezzj3GYUiiVjgsThXhB485oN+bN
	 020btFZ/OBrLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98D23CF3BA4;
	Sun,  9 Jun 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] page_pool: remove WARN_ON() with OR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171794523162.27019.14950141542807883185.git-patchwork-notify@kernel.org>
Date: Sun, 09 Jun 2024 15:00:31 +0000
References: <20240605161924.3162588-1-dw@davidwei.uk>
In-Reply-To: <20240605161924.3162588-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  5 Jun 2024 09:19:24 -0700 you wrote:
> Having an OR in WARN_ON() makes me sad because it's impossible to tell
> which condition is true when triggered.
> 
> Split a WARN_ON() with an OR in page_pool_disable_direct_recycling().
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] page_pool: remove WARN_ON() with OR
    https://git.kernel.org/netdev/net-next/c/3e61103b2f78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




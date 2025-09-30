Return-Path: <netdev+bounces-227364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A648BAD226
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 16:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AE47AAC81
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82166284896;
	Tue, 30 Sep 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl4ljwK2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07D3C465
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240818; cv=none; b=RLbAuVqYIoGsXxcddOg8+bG0liwzYd4K2Eo70NRVgKS02xQbNLKVGaZRjHqCjSAzXNFobOOy149quPzlUGwGAe8aGR3aZJbsBeWKmL3TQaaMOFp6nFOR66Pvwqkl8GQbxy9+8z95qXryEMXMAddOfP7TDipceSY67N9odS0fjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240818; c=relaxed/simple;
	bh=Ts6wcWVdFjr1sK5hWHMKkL+k8xjX2HCgScXfTSerirY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FCB7LjNb1b77TZus8Um/IQ0AdeZRQvWdyevzX3JLwEW4XmLolJQuyzLxd2MRNvFcJUk3BNR3mahpXe5W1n5HeyYOHxDSk7qrYtr63V8yoOgyd2cDakmVGmQjYVjSZ6uyYUn0A0ZhIc+k5gjpqBBs+PzhpuKTB1YGbeEaNNt6A+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl4ljwK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA46BC4CEF0;
	Tue, 30 Sep 2025 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759240817;
	bh=Ts6wcWVdFjr1sK5hWHMKkL+k8xjX2HCgScXfTSerirY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pl4ljwK2JPX5qiESFGWjIgFWgg/zLoEldk/sO1DJyIbA+OXWVG1WLaTdwBdCOHdYP
	 y2Wo3cQxZLaYsAU9c1B8JDXIinBNCe0Ouky+vhiTo5bclWp0l8q6rdyS/fJa/and4B
	 f4DQpZa+RplmHU8fYJ18KxYNvkOO2LI2OVpnSKRwuQkcujqLM2KXYDdEuy8NwDzm06
	 eb1+O1eFQseYyj1nhltCvUGctXgA+9mS9cVak1yvsa+2Yt+BMxAkjLy3BbQobZhvL9
	 04SwSFIcwg85j4HMwnUyKZwoQ0x5irOmVETX/r7+SJRcwYaFkPoiQyYefT1qszKHmU
	 +fnI9ewpcKRuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F7239D0C1A;
	Tue, 30 Sep 2025 14:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: lockless skb_attempt_defer_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175924081095.1995551.12064784563384056373.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 14:00:10 +0000
References: <20250928084934.3266948-1-edumazet@google.com>
In-Reply-To: <20250928084934.3266948-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Sep 2025 08:49:31 +0000 you wrote:
> Platforms with many cpus and relatively slow inter connect show
> a significant spinlock contention in skb_attempt_defer_free().
> 
> This series refactors this infrastructure to be NUMA aware,
> and lockless.
> 
> Tested on various platforms, including AMD Zen 2/3/4
> and Intel Granite Rapids, showing significant cost reductions
> under network stress (more than 20 Mpps).
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] net: make softnet_data.defer_count an atomic
    https://git.kernel.org/netdev/net-next/c/9c94ae6bb0b2
  - [v2,net-next,2/3] net: use llist for sd->defer_list
    https://git.kernel.org/netdev/net-next/c/844c9db7f7f5
  - [v2,net-next,3/3] net: add NUMA awareness to skb_attempt_defer_free()
    https://git.kernel.org/netdev/net-next/c/5628f3fe3b16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




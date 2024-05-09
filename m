Return-Path: <netdev+bounces-94766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3CC8C0986
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0BE1C21022
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1BB13CFBD;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY+5MhZj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20213CFB6
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220031; cv=none; b=ZJdEgTbnXNTF+fGfNUae3PM/DmVnyCb7cbfDegP6e+wf7uSM6jJwPrwrTSqWkym0HlPQ4n6ww2mlu0eAYAL7qVqzZgkbpPSHfg9ynGUV7NxctZH6iGhXxOwnXkJe9mCeJwX91nkkMWAC6YWJPXnlzp3+sceHGSOCiNTLk/DRc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220031; c=relaxed/simple;
	bh=egyBxKKm3P5fJNLb7d0itqyXOYhWVVIj82KneG4O2us=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N/kOHIOBHMNVUqNpnh/7vvgufh5i5nfnHvb6TW5hmkr+nsiUbrmZVmkWd4POHa9XVlHqPngSC/79djlLG1UH/jfpotgOcFMzLe0xSA51ix6FLy5lr7ryGEyw2VxyL7Xb9s7ydeVlyKvN97onLVtd4g2nG53EctvJVCiHIaQqqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY+5MhZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFF10C4DDF2;
	Thu,  9 May 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220030;
	bh=egyBxKKm3P5fJNLb7d0itqyXOYhWVVIj82KneG4O2us=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VY+5MhZj5GZL/R3jgvCyoE/+Sqk6zU8i88P4N6f4W+HyM0uYEjb0lG3tkDZrtOM9X
	 Ta3dYcB/fw/iXx/qCrya7JqmbOZT5zavPziuj4TQOvo73kl7kK2T43TM3mowKTf5iH
	 ZA/Wzz9AR0yls5pY8qoGRnQhjVfiBjkQuUFlIfHk82YuxqDtxjJOmMCX3ecnDwSN7X
	 UbwGVXosMWenvY9tw//80RyvyiQhVjhlffdn4t2kLyjWgAr8LSfHmYw4I81iP9Hata
	 DgoNg07lrYjN71tuOLxamUwbbnSUCC9g3ftm7nAsWrKAZHQIMqeQTZkKgYmlNboLgu
	 af4G9soe5aKGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B61ACC43332;
	Thu,  9 May 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dst_cache: minor optimization in
 dst_cache_set_ip6()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522003074.32544.12466092115683383249.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:30 +0000
References: <20240507132717.627518-1-edumazet@google.com>
In-Reply-To: <20240507132717.627518-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 13:27:17 +0000 you wrote:
> There is no need to use this_cpu_ptr(dst_cache->cache) twice.
> 
> Compiler is unable to optimize the second call, because of
> per-cpu constraints.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dst_cache: minor optimization in dst_cache_set_ip6()
    https://git.kernel.org/netdev/net-next/c/e2d09e5a1e8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




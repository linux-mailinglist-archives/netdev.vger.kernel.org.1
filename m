Return-Path: <netdev+bounces-45699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6A7DF1A2
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB81B20FCD
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E014F67;
	Thu,  2 Nov 2023 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g61e9KKx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DF14F61
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2AC1C433CA;
	Thu,  2 Nov 2023 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698925822;
	bh=Pf1c1Zob157wCaR6+3UGacUZgEjfHNk4/blaFlwOIY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g61e9KKxYXnPaOy4HQNQiHKLCkleVBQ9jeHTzMv4fNQV50tCVr+tD+u/NbOcnLOEB
	 qFb8OEy1wdVuPxTLftK2XY+ZKJLoIxtHvIhq68bQxkElI7uDgoKqo7v8E57F9H31K5
	 TF2UmU+yJQURjUiGUhOgQfC/xcNNHyc7Q0Kc29cmz5jQBNowZkDQh2hyL2x/gsUtW1
	 BoRIIVpiGAv91UuvtmQYmxOQU9QtbI1GNFiIg6og3m6nzPSLtvYq2moCnRjU0NlCOH
	 1dW2F9HIJebzbGVPg9DS5p7BqaNGa/z6uGYMlazafc2ZDcwPL2zyOaa/JsfwJ1+ow6
	 cUo92UmTLRyyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5E88C4316B;
	Thu,  2 Nov 2023 11:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: page_pool: add missing free_percpu when
 page_pool_init fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169892582274.28990.7721054439007529390.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 11:50:22 +0000
References: <20231030091256.2915394-1-shaojijie@huawei.com>
In-Reply-To: <20231030091256.2915394-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jdamato@fastly.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 linyunsheng@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Oct 2023 17:12:56 +0800 you wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
> is not called to free pool->recycle_stats, which may cause memory
> leak.
> 
> Fixes: ad6fa1e1ab1b ("page_pool: Add recycle stats")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net] net: page_pool: add missing free_percpu when page_pool_init fail
    https://git.kernel.org/netdev/net/c/8ffbd1669ed1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




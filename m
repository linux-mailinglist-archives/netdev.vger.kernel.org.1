Return-Path: <netdev+bounces-47332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729F7E9AC3
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6459A1C20937
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6B91CA93;
	Mon, 13 Nov 2023 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTTYL7Ph"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B861C6B3
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8094EC433C8;
	Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699873824;
	bh=PwdpDTxuSeGxY9qFxmap+ZfHLLhNQOBW+QJH+KdZ4po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NTTYL7Phgj62BeuEJE/ZhyrIHFENWz+pDLTxHQtf6NC6PGv/PoPsrkZYGYHhtUBPE
	 uwC2BI5YpiUu/O5jXWvmZM7pyVK5Nv6HkGro8313qT6Y3I94guwGjrFxIFYuDxbQsC
	 lga8baqv9HR4cK6BXK68Ecxslm8DvrytT3nkfYkGJFc8ATxl9fpYN4Oo3IarH6w4SA
	 LuB1BaB1RzI1u+TQIKoFdneOKBiNIE+6mE18qb27A2SNTlElrOq4TUI4aJfqxMmewB
	 OZF+CgrST7Z8qU2am3LHqq9DT1UHQ1gLYVHbGZCMVDfeKIEbcORY2e7pC5xJfQq/t9
	 vk9nUY/ZaLjEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60ACCE32711;
	Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: gso_test: support CONFIG_MAX_SKB_FRAGS up to 45
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169987382437.356.8501412151889691918.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 11:10:24 +0000
References: <20231110153630.161171-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231110153630.161171-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 10:36:00 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The test allocs a single page to hold all the frag_list skbs. This
> is insufficient on kernels with CONFIG_MAX_SKB_FRAGS=45, due to the
> increased skb_shared_info frags[] array length.
> 
>         gso_test_func: ASSERTION FAILED at net/core/gso_test.c:210
>         Expected alloc_size <= ((1UL) << 12), but
>             alloc_size == 5075 (0x13d3)
>             ((1UL) << 12) == 4096 (0x1000)
> 
> [...]

Here is the summary with links:
  - [net] net: gso_test: support CONFIG_MAX_SKB_FRAGS up to 45
    https://git.kernel.org/netdev/net/c/e6daf129ccb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-40931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C967C91F1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E601C20963
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96564B;
	Sat, 14 Oct 2023 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxMLKdS/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5417E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DEACC433C9;
	Sat, 14 Oct 2023 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697245225;
	bh=kSmVt9zmG9FehpYGin07k7CMV8LujE3xnbHWAa/hy2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mxMLKdS/SEQiUVLVz2y0Hjyz9tHqbX/2+lpN2vMkmnVYGJz9lzAGdZL48RG8Yf6bl
	 Kmz5RVyOko1RdIzQo91yR1O/9BEdiUm46aGe7lEvV+JOkKNVhrOwTpUMH6UseTy+5L
	 BacL4yS5TkyfEAzaEe20JtMeqnE63d0WNGsw2PutsRf2ab8GKYLumBOkG+Ys+P4lpN
	 LKlE/2vjNww2zSiTKl/pIuXB8hpBhDxIAH5sK7XrbIoLVCYhFf6QuAVT8o3SfyXiVL
	 tlegBZVK8ci2716E8ofm3xS49LIu3Q4ez7MElzuMlaESUJKDwjGNEEbUYQ+/CDdPUH
	 GroQNHlCPr1WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13D03E1F666;
	Sat, 14 Oct 2023 01:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/7] netfilter: nf_tables: do not remove elements if set
 backend implements .abort
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724522507.6466.3383347310826066954.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 01:00:25 +0000
References: <20231012085724.15155-2-fw@strlen.de>
In-Reply-To: <20231012085724.15155-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 pablo@netfilter.org

Hello:

This series was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Thu, 12 Oct 2023 10:57:04 +0200 you wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> pipapo set backend maintains two copies of the datastructure, removing
> the elements from the copy that is going to be discarded slows down
> the abort path significantly, from several minutes to few seconds after
> this patch.
> 
> [...]

Here is the summary with links:
  - [net,1/7] netfilter: nf_tables: do not remove elements if set backend implements .abort
    https://git.kernel.org/netdev/net/c/ebd032fa8818
  - [net,2/7] netfilter: nfnetlink_log: silence bogus compiler warning
    https://git.kernel.org/netdev/net/c/2e1d17541097
  - [net,3/7] netfilter: nf_tables: Annotate struct nft_pipapo_match with __counted_by
    https://git.kernel.org/netdev/net/c/d51c42cdef5f
  - [net,4/7] netfilter: nf_tables: do not refresh timeout when resetting element
    https://git.kernel.org/netdev/net/c/4c90bba60c26
  - [net,5/7] nf_tables: fix NULL pointer dereference in nft_inner_init()
    https://git.kernel.org/netdev/net/c/52177bbf19e6
  - [net,6/7] nf_tables: fix NULL pointer dereference in nft_expr_inner_parse()
    https://git.kernel.org/netdev/net/c/505ce0630ad5
  - [net,7/7] netfilter: nft_payload: fix wrong mac header matching
    https://git.kernel.org/netdev/net/c/d351c1ea2de3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




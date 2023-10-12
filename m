Return-Path: <netdev+bounces-40213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555287C61EC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE9A2825B5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EBF62A;
	Thu, 12 Oct 2023 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsX/29bm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E97EF
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63D09C433CA;
	Thu, 12 Oct 2023 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697071229;
	bh=+Fxb+04u3GAnCvCgh89ui4EBZeVR68FztV6uRPFXUAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KsX/29bmwMFICi8khbKLftRHGvH5EipJ5qr1Sa7HM5QxZ6JuHtLxYwzFczojBhur4
	 ochjAUw4n6nOoSuLtm62ZqMVSfHgY9KARuo4+ltgwBbZwyBNRQAtagsk2XOHPAk+A0
	 9yOpgqwsQXLEgBKbZMPUK1qTN0D2qHLQCD6oZIhtUlxrzhz/pKcobT9HMmYjoWi2S1
	 aDiYiCqrTbC+C4w/eV5nr8XvNog8NXasEy5J0+r6lbKvEj4TArrpm+YhyUj/V6RA3b
	 ULAMMp/YIW+orwFScF1QNwLzLeIXZpkFez+ZPtGgy0l0elLUIehCUx+B7szvQ5v7KQ
	 W8w+/QixHl+MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5093AC595C4;
	Thu, 12 Oct 2023 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/8] netfilter: nf_tables: Always allocate
 nft_rule_dump_ctx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169707122932.23011.16635889161175071072.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 00:40:29 +0000
References: <20231010145343.12551-2-fw@strlen.de>
In-Reply-To: <20231010145343.12551-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 phil@nwl.cc, pablo@netfilter.org

Hello:

This series was applied to netdev/net-next.git (main)
by Florian Westphal <fw@strlen.de>:

On Tue, 10 Oct 2023 16:53:31 +0200 you wrote:
> From: Phil Sutter <phil@nwl.cc>
> 
> It will move into struct netlink_callback's scratch area later, just put
> nf_tables_dump_rules_start in shape to reduce churn later.
> 
> Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] netfilter: nf_tables: Always allocate nft_rule_dump_ctx
    https://git.kernel.org/netdev/net-next/c/afed2b54c540
  - [net-next,2/8] netfilter: nf_tables: Drop pointless memset when dumping rules
    https://git.kernel.org/netdev/net-next/c/30fa41a0f6df
  - [net-next,3/8] netfilter: nf_tables: Carry reset flag in nft_rule_dump_ctx
    https://git.kernel.org/netdev/net-next/c/405c8fd62d61
  - [net-next,4/8] netfilter: nf_tables: Carry s_idx in nft_rule_dump_ctx
    https://git.kernel.org/netdev/net-next/c/8194d599bc01
  - [net-next,5/8] netfilter: nf_tables: Don't allocate nft_rule_dump_ctx
    https://git.kernel.org/netdev/net-next/c/99ab9f84b85e
  - [net-next,6/8] netfilter: conntrack: simplify nf_conntrack_alter_reply
    https://git.kernel.org/netdev/net-next/c/8a23f4ab92f9
  - [net-next,7/8] netfilter: conntrack: prefer tcp_error_log to pr_debug
    https://git.kernel.org/netdev/net-next/c/6ac9c51eebe8
  - [net-next,8/8] netfilter: cleanup struct nft_table
    https://git.kernel.org/netdev/net-next/c/94ecde833be5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




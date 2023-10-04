Return-Path: <netdev+bounces-38092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F127B8EF2
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B5C8F281D00
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A41B241EA;
	Wed,  4 Oct 2023 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjqKOdwC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE4241E6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 884B8C433C7;
	Wed,  4 Oct 2023 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696455028;
	bh=PKLIN1crRYWBJUMODHzc6hZBbUNq1h2NBIRSnzC7bJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GjqKOdwCcYFOic9T6ObXXaxJHd5PBYZfVoSP0Kc56c4+gPgjWxVCLTxFEYtZ3xZ0+
	 LZ0bttA73tD9pMQHPR9JcUzzK3s1LENteP4OXHXhyeIJdLMgrdu1U6EO2IXfWtSWY/
	 CJLrAjnTxSEH3Er2uKj7TNMIfijr5IQUzmJkkMD29P9oN/65o5ZN9Zqf/0IJ9nUnYb
	 lhZtfWMBbda2eIuNyF2UxOZz00V/NusyIhtPlx1y6LZYIg/LJe0J6kgNiCSyQuLwTT
	 vVc9lw7SmB0NFLjVVh5Zllf0VZecQyRkz8NPtLdUsROU/COlmEpX0u8AEvSlEZqvgy
	 1HRYg+lvup03w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72689E632D6;
	Wed,  4 Oct 2023 21:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/4] netfilter: nf_nat: undo erroneous tcp edemux
 lookup after port clash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645502846.6604.14166144214217944082.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 21:30:28 +0000
References: <20230928144916.18339-2-fw@strlen.de>
In-Reply-To: <20230928144916.18339-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Florian Westphal <fw@strlen.de>:

On Thu, 28 Sep 2023 16:48:58 +0200 you wrote:
> In commit 03a3ca37e4c6 ("netfilter: nf_nat: undo erroneous tcp edemux lookup")
> I fixed a problem with source port clash resolution and DNAT.
> 
> A very similar issue exists with REDIRECT (DNAT to local address) and
> port rewrites.
> 
> Consider two port redirections done at prerouting hook:
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] netfilter: nf_nat: undo erroneous tcp edemux lookup after port clash
    https://git.kernel.org/netdev/net-next/c/e27c3295114b
  - [net-next,2/4] selftests: netfilter: test nat source port clash resolution interaction with tcp early demux
    https://git.kernel.org/netdev/net-next/c/117e149e26d1
  - [net-next,3/4] netfilter: nf_tables: missing extended netlink error in lookup functions
    https://git.kernel.org/netdev/net-next/c/aee1f692bfed
  - [net-next,4/4] netfilter: nf_tables: Utilize NLA_POLICY_NESTED_ARRAY
    https://git.kernel.org/netdev/net-next/c/013714bf3e12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-26052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B37776A99
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD83281DFB
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EC51DDCC;
	Wed,  9 Aug 2023 21:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE51D300
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86527C433C8;
	Wed,  9 Aug 2023 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691614823;
	bh=H8oo8nZSNgFGMR9+gLieC0pQb3wLGAefXHFHEUp61rY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jZ36Z8hUnZAneQ52+wgBzRoG2J2ovAIucJ0PEb6r5R7Rf0ZWmHPYNbK6D3PwSNNBm
	 2u+PCRRd2Rf1FRFXr0wTBiXbIHgtlink7h5ovzzkNBU8pwN80mfaIh0V0RCbVJK8+A
	 ClJXx6EaTVcV43Xnag3OvBncdQwMjKTP/FO4VdM5tSRmGBC0ah0R+P3PKQeA/bcXZ7
	 vdv9a5S7XsmTL5+2K5LkBbvNxih4ZwIoPH+h0ZQBaqGdzgV5KdYcsUeqqU+4VLj7ku
	 8tlSr+EAzCCw9VpfC3JhP0c/3K1sW40RRc0BsiquXd9SsorlrUgC4MI2flfJV5Xqln
	 fH8X1pFaYeNGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71D91E3308F;
	Wed,  9 Aug 2023 21:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next-next 1/5] netfilter: gre: Remove unused function
 declaration nf_ct_gre_keymap_flush()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161482346.5018.11233094341824783431.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 21:00:23 +0000
References: <20230808124159.19046-2-fw@strlen.de>
In-Reply-To: <20230808124159.19046-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 yuehaibing@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by Florian Westphal <fw@strlen.de>:

On Tue,  8 Aug 2023 14:41:44 +0200 you wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> 
> Commit a23f89a99906 ("netfilter: conntrack: nf_ct_gre_keymap_flush() removal")
> leave this unused, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> [...]

Here is the summary with links:
  - [next-next,1/5] netfilter: gre: Remove unused function declaration nf_ct_gre_keymap_flush()
    https://git.kernel.org/netdev/net-next/c/29cfda963f89
  - [next-next,2/5] netfilter: helper: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/529f63fa11eb
  - [next-next,3/5] netfilter: conntrack: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/172af3eab05f
  - [next-next,4/5] netfilter: h323: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/61e9ab294b39
  - [next-next,5/5] netfilter: nfnetlink_log: always add a timestamp
    https://git.kernel.org/netdev/net-next/c/1d85594fd3e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




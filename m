Return-Path: <netdev+bounces-42477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D857CED74
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5292B20F62
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CC393;
	Thu, 19 Oct 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIUyoCbl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9638C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C08C4C433CB;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697678424;
	bh=BKMtPoKMsj9COZd362TPZAYNq2agCc0tNSjTDQAx6hI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QIUyoCblL/F+Um2riWNjIrVHbCGCNAj7tkhgNSdl9YA1JS/WVtmFyarqslxxePP8+
	 3+5aBnBGSeJpQohQ+8l0bN83eN+0ZNg6DkLxkTog/wn0Thp78l4BOCESd6tmeV/kkL
	 hjEjWTifKW5ZEz/1kZsi4/fZBkM27uf+kMCh0Ki6suXjg/WHmjwXy/ot5C1UDFQ5zg
	 wAfKSvqDkByi623oPmYRcUVv7wZMVdlQLOxcPIBZtEu6Mx9mSyEDBre5r4lP+vwFVH
	 EOy6+xkCveafQA5TrgfpwztZxQ3yWdCtH21aWtnS4BW91oy9ZsPkPI0n+wy+3wlGFH
	 MXQQ4HluiOxCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7C73C04DD9;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/4] netfilter: nf_tables: audit log object reset once per
 table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767842468.18183.5666903207859330465.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:20:24 +0000
References: <20231018125605.27299-2-fw@strlen.de>
In-Reply-To: <20231018125605.27299-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 phil@nwl.cc, rgb@redhat.com, paul@paul-moore.com

Hello:

This series was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Wed, 18 Oct 2023 14:55:57 +0200 you wrote:
> From: Phil Sutter <phil@nwl.cc>
> 
> When resetting multiple objects at once (via dump request), emit a log
> message per table (or filled skb) and resurrect the 'entries' parameter
> to contain the number of objects being logged for.
> 
> To test the skb exhaustion path, perform some bulk counter and quota
> adds in the kselftest.
> 
> [...]

Here is the summary with links:
  - [net,1/4] netfilter: nf_tables: audit log object reset once per table
    https://git.kernel.org/netdev/net/c/1baf0152f770
  - [net,2/4] selftests: netfilter: Run nft_audit.sh in its own netns
    https://git.kernel.org/netdev/net/c/2e2d9c7d4d37
  - [net,3/4] netfilter: nft_set_rbtree: .deactivate fails if element has expired
    https://git.kernel.org/netdev/net/c/d111692a59c1
  - [net,4/4] netfilter: nf_tables: revert do not remove elements if set backend implements .abort
    https://git.kernel.org/netdev/net/c/f86fb94011ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




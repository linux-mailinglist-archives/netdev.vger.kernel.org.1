Return-Path: <netdev+bounces-42188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0617CD8E6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89B3281C58
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901518B15;
	Wed, 18 Oct 2023 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h42bS60I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63518B0B
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 10:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28AE0C433CA;
	Wed, 18 Oct 2023 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697623823;
	bh=WuXUZXR6Fqzg/9JZerRXRjWDA8H5BHBFcBiSCLvFMiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h42bS60IcySv71gfgESP05vUUViquk8C4qlcx5lEbXN3xF69+ZahfgceImdhNw/EY
	 0w8NaF4berxwJyWmn1biV0L4NKkEfqT2Z7T7Q7QnquDgP/yxw2v4YTTmMKE5GTO0nt
	 Aw1nbAs1ZkdLJ46JwdTjaPEaCJlBiqfzoIIVyYf9Jw/nzM0q99S3ydj37FnLnRw1T0
	 tumiZEsPCCqYjgjbIX4imqTw60VFmJr5tKFXCw12h5YSTlq+78i2x87C3M62NWBMJM
	 Kob6zHEeXE7ej5/SnXezlzHYl1Tu/Bw1zRJYMag63kVkHSNqRcN95hjcnew8iFlBOb
	 /ZbMF0A/98Fkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16674C04E27;
	Wed, 18 Oct 2023 10:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/7] netfilter: xt_mangle: only check verdict part of
 return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169762382308.3133.9060197209130107475.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 10:10:23 +0000
References: <20231018085118.10829-2-fw@strlen.de>
In-Reply-To: <20231018085118.10829-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Florian Westphal <fw@strlen.de>:

On Wed, 18 Oct 2023 10:51:05 +0200 you wrote:
> These checks assume that the caller only returns NF_DROP without
> any errno embedded in the upper bits.
> 
> This is fine right now, but followup patches will start to propagate
> such errors to allow kfree_skb_drop_reason() in the called functions,
> those would then indicate 'errno << 8 | NF_STOLEN'.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] netfilter: xt_mangle: only check verdict part of return value
    https://git.kernel.org/netdev/net-next/c/e15e5027106f
  - [net-next,2/7] netfilter: nf_tables: mask out non-verdict bits when checking return value
    https://git.kernel.org/netdev/net-next/c/4d26ab0086aa
  - [net-next,3/7] netfilter: conntrack: convert nf_conntrack_update to netfilter verdicts
    https://git.kernel.org/netdev/net-next/c/6291b3a67ad5
  - [net-next,4/7] netfilter: nf_nat: mask out non-verdict bits when checking return value
    https://git.kernel.org/netdev/net-next/c/35c038b0a4be
  - [net-next,5/7] netfilter: make nftables drops visible in net dropmonitor
    https://git.kernel.org/netdev/net-next/c/e0d4593140b0
  - [net-next,6/7] netfilter: bridge: convert br_netfilter to NF_DROP_REASON
    https://git.kernel.org/netdev/net-next/c/cf8b7c1a5be7
  - [net-next,7/7] netfilter: nf_tables: de-constify set commit ops function argument
    https://git.kernel.org/netdev/net-next/c/256001672153

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




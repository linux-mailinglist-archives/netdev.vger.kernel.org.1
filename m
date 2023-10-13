Return-Path: <netdev+bounces-40644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A898F7C81D4
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48ED3B20B2B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D310A35;
	Fri, 13 Oct 2023 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQGQGtLF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA010A17;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEB99C433CD;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697188827;
	bh=YTS5iQxhexnFfaL0aT98ztdUOHQwzGvFeKXVURjrcO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sQGQGtLFbwi1Mtm7ShZIjhcuWD2jYEqtlluW1Ti47QTKWhn+ZQgHlgCsdlx+a4fZO
	 uZTTWLFEMPjSDCucriVQXvQAGN61iWWz5CXeQOWDZPpnZ2xm4Md3EDDn9ivN+mr1Ye
	 RQpRM0tNd5R4Hid3v3M01utqtnvdqnKTtQRu7sHqP2LKPQPfMJY6ZMQAmDA/F1vGEp
	 l7OQo3ZRpKSsLtUKCe3yqWjYvprLe+Nd0nglGxMwc0N6k0OeK4Fle0MTtTmhPtNPXW
	 Ya0F9I1IDJ/5xE+1RJ1fiTPrbS0oHkORGZIkFYRrfw0Jr3SB+3XXpEGG2Vqs6nR2nt
	 v5rAHboRLQv9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94ECDE1F66B;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: wwan: t7xx: Add __counted_by for struct
 t7xx_fsm_event and use struct_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169718882760.6212.6580825166995181592.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:20:27 +0000
References: <ZSR0qh5dEV5qoBW4@work>
In-Reply-To: <ZSR0qh5dEV5qoBW4@work>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 9 Oct 2023 15:46:18 -0600 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> [...]

Here is the summary with links:
  - [next] net: wwan: t7xx: Add __counted_by for struct t7xx_fsm_event and use struct_size()
    https://git.kernel.org/netdev/net-next/c/2dd307189220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




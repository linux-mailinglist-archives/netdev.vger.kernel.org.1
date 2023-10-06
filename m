Return-Path: <netdev+bounces-38515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1447BB486
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DBF2822B5
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736314296;
	Fri,  6 Oct 2023 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5DeaUBr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F298134CC;
	Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7AEEC433C7;
	Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696585828;
	bh=DB25WW5JRRa7D1F/ujLNSDRPpW0Qqsm6WYlxIRg7JLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u5DeaUBrmspBK9rK4PoAasfnbBFyW/wP9HTAwKeDAF7gaZ6LJksMRU7Y2vtWkeWBn
	 7Wr7iAWbd0pcz9R8hAPSLAlZeLfqpJE5799o1mNs0vS9pYSaqc1IRpEdDnc73LiQKp
	 o25CK/qFA6sBtdoaWxoZ/gjelOdcaePlsfbQjXDRzxxz7qgoSd+w0G6VWv4yfAFAwR
	 A5e1P5VcNGd5fHttEBfr1MGEntUsaQg0mGY+pl0raRQT7Mmj0bAZKs8kqaieBjc7xW
	 OiNwXiYMqfBIkBx27mxZ1HW4ReeO2WyJrUB5xEfiSh8/mYi6vQgiExBYsiypcMgpP3
	 cZH/c+wMT2Bow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89CFBC64459;
	Fri,  6 Oct 2023 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfp: nsp: Annotate struct nfp_eth_table with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658582856.14501.12006275087364255603.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 09:50:28 +0000
References: <20231003231850.work.335-kees@kernel.org>
In-Reply-To: <20231003231850.work.335-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: horms@kernel.org, simon.horman@corigine.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 yinjun.zhang@corigine.com, leon@kernel.org, yu.xiao@corigine.com,
 sixiang.chen@corigine.com, oss-drivers@corigine.com, netdev@vger.kernel.org,
 louis.peens@corigine.com, gustavoars@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, trix@redhat.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Oct 2023 16:18:51 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfp_eth_table.
> 
> [...]

Here is the summary with links:
  - nfp: nsp: Annotate struct nfp_eth_table with __counted_by
    https://git.kernel.org/netdev/net-next/c/178e9bf9b57d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




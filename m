Return-Path: <netdev+bounces-111064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD0992FAA7
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B991F21CD5
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311416F29A;
	Fri, 12 Jul 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrvemSii"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870985C56;
	Fri, 12 Jul 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788633; cv=none; b=hAIsyexuQ8cln+Wb5C+RMpJw/MjnxEAiEIgQncRDxGuSwTDfGC+UPtO52gIWar8WuVMQrB4s0YbHi9VQQqBLBeil+E4JMgrY8Nd5S4ZuZBUISdWkxZVuTS4h9tsCGGr3eyDT5qvlrRa9u9jVxVWRj97jdsYEK67ciGQfdZagdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788633; c=relaxed/simple;
	bh=SAaCUedZF3vDz5KGr7sLfUtLuLG9b92/oB0dT/4Ub80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MoKD2MUiQPZtzkkBlhrtT+vW6UywnmA6z0U2WXy8EuHtdV6RCCmvHw0elN+m+ZLEinhIkpWn8N5JMBeaDEpP35pnl3dvVfScUtV+HWAgWE/4gY8QP/zSKCQguNp/YqweHNAGfblZlGV5kEWyg3lO5h0en8G8BxeXWqYapnQ+6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrvemSii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE5EC4AF07;
	Fri, 12 Jul 2024 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720788633;
	bh=SAaCUedZF3vDz5KGr7sLfUtLuLG9b92/oB0dT/4Ub80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LrvemSiiXMIYpJC22VdK22e6278criIQmXeVECfx+S86UjVeOc8rREoNuyLVLVPcJ
	 Ub8RrisJmcTILlgSAHue6ZPHnrblEJoMxeVBH++O5n0ohZkrUE7bfOFzovYZN6AxaN
	 ouGZ9o8jypC3fbjrqHwhpXNZFPKDB3LShV9JaLspopuRlcRi5veDtZ6yJ/4evJc52Z
	 GZUXRhSiPc3Oz+dyeVOtt5SjUXcSDtEOrf6zPiug336nH2f6h5hinu2BKbQ/+DFHdT
	 qXDlwPdQu8I7z87UWKqXcqmw+Uohs5rpXpMjTxEanp++st2pTKSAbfoERApLHLkwnN
	 EPvrZ2Ei/CMTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8663C43153;
	Fri, 12 Jul 2024 12:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2,0/5] Fixes for CPT and RSS configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172078863288.22035.7184629353044546071.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 12:50:32 +0000
References: <20240710075127.2274582-1-schalla@marvell.com>
In-Reply-To: <20240710075127.2274582-1-schalla@marvell.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 ndabilpuram@marvell.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 10 Jul 2024 13:21:22 +0530 you wrote:
> This series of patches fixes various issues related to CPT
> configuration and RSS configuration.
> 
> v1->v2:
> - Excluded the patch "octeontx2-af: reduce cpt flt interrupt vectors for
>   cn10kb" to submit it to net-next.
> - Addressed the review comments.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] octeontx2-af: replace cpt slot with lf id on reg write
    https://git.kernel.org/netdev/net/c/bc35e28af789
  - [net,v2,2/5] octeontx2-af: fix a issue with cpt_lf_alloc mailbox
    https://git.kernel.org/netdev/net/c/845fe19139ab
  - [net,v2,3/5] octeontx2-af: fix detection of IP layer
    https://git.kernel.org/netdev/net/c/404dc0fd6fb0
  - [net,v2,4/5] octeontx2-af: fix issue with IPv6 ext match for RSS
    https://git.kernel.org/netdev/net/c/e23ac1095b9e
  - [net,v2,5/5] octeontx2-af: fix issue with IPv4 match for RSS
    https://git.kernel.org/netdev/net/c/60795bbf0476

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




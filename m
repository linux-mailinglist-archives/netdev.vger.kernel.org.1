Return-Path: <netdev+bounces-144062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CC09C58AC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5927B60DAB
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCF321503E;
	Tue, 12 Nov 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="midmylww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE542139DB;
	Tue, 12 Nov 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410420; cv=none; b=HsdQD15AmoRaoLC0gCvem2cbwJQ0xc/8xTE0L7F0hiyr6cxPGNfSqaVb7wWjy0Yt4Op4aH1+97joKEFrhqcYWmwUgzNx2cZJbk8oAIH4TgD8ep29YahyDW5bawlOdokcAX+f30b1u9q9qYbBgZ2lZ8iZHwihrUEWTmerPLErONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410420; c=relaxed/simple;
	bh=fKs2r75/cAl/ZrCU2zDlJuBSedEVT9EwM2Fl5D3rmxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=daUJGp/MkLE5EXGySokF6DHKuWO2iZBONnMYduUWw63vsqs7JhE+EFjyfd/5AuiHu1k8NRGcUyWJ3D8RJWYRVEsRmto1Y5DxPd396k/lkFWcNvxU9t2UVtB1tqg2FJ21YwIKf+oX1yScR0++0vVRQiYRYtjkHib63rOC5koXeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=midmylww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3535C4CECD;
	Tue, 12 Nov 2024 11:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731410419;
	bh=fKs2r75/cAl/ZrCU2zDlJuBSedEVT9EwM2Fl5D3rmxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=midmylww6kqSVSfN6Sc0NJrjqgzXCKnImjERTHhY71vXDGcGZBUDX8UvAclmTb54L
	 2050ATlVZtSycPuXyD1BgQR6RIEx2+4XAZguqVwEpWMQzU7Ha9g6rNjZpl1mhuaQLb
	 PBY5aFWftkbB66rjYSe2LqMPsGbQP1LADKBYx/sVomVUyVb69R3OXsTQ/9ewEanZl2
	 xmm+FyZYZUBZd5auzmS2lbxDMFGn+KacPvMk/KQ1Meq3t1lRMwbv/6vaqjC7Wgmmpq
	 JqaNPByqbDqi9RohW0uFuuEjK1YLMDiubkxLF0lKyvKtu8kG7rtqo3WB/Dch2EKAdK
	 G2UJaeJUzgkjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F313809A80;
	Tue, 12 Nov 2024 11:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] net: Implement fault injection forcing skb
 reallocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173141043002.488443.17713500872713771818.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 11:20:30 +0000
References: <20241107-fault_v6-v6-1-1b82cb6ecacd@debian.org>
In-Reply-To: <20241107-fault_v6-v6-1-1b82cb6ecacd@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: corbet@lwn.net, akinobu.mita@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 akpm@linux-foundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 07 Nov 2024 08:11:44 -0800 you wrote:
> Introduce a fault injection mechanism to force skb reallocation. The
> primary goal is to catch bugs related to pointer invalidation after
> potential skb reallocation.
> 
> The fault injection mechanism aims to identify scenarios where callers
> retain pointers to various headers in the skb but fail to reload these
> pointers after calling a function that may reallocate the data. This
> type of bug can lead to memory corruption or crashes if the old,
> now-invalid pointers are used.
> 
> [...]

Here is the summary with links:
  - [net-next,v6] net: Implement fault injection forcing skb reallocation
    https://git.kernel.org/netdev/net-next/c/12079a59ce52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-247154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E153CF5178
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96209300C37D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFBD2FD697;
	Mon,  5 Jan 2026 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT0PyL0T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA029D29F
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635614; cv=none; b=DQAGzne6K1oEUq18PikvGXX60E9YbsEbuBaQQuo7jwgzAkX77pTGaqMgndZ78+FAuPf9odPYYYAC+Y+2FmMOeeArBdc/l3WP8Ah9BF80+fUb8vAfxuriyjlbcvDAKXCmIjGI0WLZSlNfpbqsUJio7k16PN87O98v4n7ZUgNjb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635614; c=relaxed/simple;
	bh=nABzmWxuB+rVqiUOBeWCAF53JK/C20rg+r1tYe4LRgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G2NKVKK9pexkOVqL5vK7c/+QZCogRxaFpgRppSys7OOLZ4DpQD/chJ9SxyXvSGJ+4tVUxSjhsbjFGJvpO590ljn1YD8pjgTnr4rZbUD1TfcT9W+2WhFRpHkbJs0qyKcVEOBYp6MEtlf+nAItWtG93YZmEMoDA8+QO/T3gbuMFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT0PyL0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33CDC116D0;
	Mon,  5 Jan 2026 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767635613;
	bh=nABzmWxuB+rVqiUOBeWCAF53JK/C20rg+r1tYe4LRgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gT0PyL0Ts9zxG3PyNTFIjd9qraHbDf7L2HCeqF6t/suJWfYU7Z1XpreNvs+eBNMBT
	 vt1EBpLZpwinFeUK6pMzKvPnI/hvfp1MICIGqeGgJb+7GlB0U+KZU7llIwfWVwBUWQ
	 uJ2D7QOnfTq/2dpurUZeUCnv2k8Vj8ZWdntnF7KeL4ubgvR9e2imSZBmy3jn72Vu7J
	 xWsqmAoHJNV2MuqTUVxAG2WrfIKEY3qpff1Qdn8LYTf0GRiKYDrAR7/MPZjvjjZI43
	 oVHIpDAf03K1TPL1FvCW0gbJjuRqLwkKfvkHabUBHLyj3nMtSrjCndw0u2rlOzMHqJ
	 tDxLB3dulHRxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8C7380A962;
	Mon,  5 Jan 2026 17:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] ethtool: Fix declaration after label compilation
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176763541204.1244814.16112254991041079076.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jan 2026 17:50:12 +0000
References: <20251231112533.303145-1-gal@nvidia.com>
In-Reply-To: <20251231112533.303145-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: mkubecek@suse.cz, c-vankar@ti.com, netdev@vger.kernel.org,
 cjubran@nvidia.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed, 31 Dec 2025 13:25:33 +0200 you wrote:
> Wrap case blocks in braces to allow variable declarations after case
> labels, fixing C89 compilation errors:
> 
>   am65-cpsw-nuss.c: In function 'cpsw_dump_ale':
>   am65-cpsw-nuss.c:423:4: error: a label can only be part of a statement and a declaration is not a statement
>       u32 oui_entry = cpsw_ale_get_oui_addr(ale_pos);
>       ^~~
>   am65-cpsw-nuss.c:432:4: error: a label can only be part of a statement and a declaration is not a statement
>       u32 vlan_entry_type = cpsw_ale_get_vlan_entry_type(ale_pos);
>       ^~~
> 
> [...]

Here is the summary with links:
  - [ethtool] ethtool: Fix declaration after label compilation error
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=8e5c615a319f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




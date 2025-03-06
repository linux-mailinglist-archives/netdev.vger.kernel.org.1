Return-Path: <netdev+bounces-172679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0DA55AF7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90326189419F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728C27E1A6;
	Thu,  6 Mar 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVXxkPya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CAB203709
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304402; cv=none; b=Sp4GU2uF+u8Hzhn6iwa0XlaNFBcq9ajRKR3E4Ql2t+SuxIDVZ3Epyq7spkCWcRpPOB3Apy823dHCXtyyIBeiOjZqGSOPMd2e3ush2JRz8YO9tn/EQRmbjqXISpm42NAH/F4tNuRsfLy4NB0PE+UmajdKULC9mkkcWx1i9PRCiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304402; c=relaxed/simple;
	bh=2O3gzSJqeBR3y1HxL0/bGENzdZ3TfPpcd0eLk42WfMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPSyKYDdYLd+rT9MahfjPMrxAwXoGgKUpFpjdO4BzrmMdA+OEYIQnn8KZVNjUqbrf1HurCCPROayDnWyisePhs0ljotd2+RFg+JE8WZxVFiB6qWLTHDx8/W2yHCLrjEJYQb4JDBno23y9exjtLOE2/Xw0ZbalaG9Y/KPCjrgKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVXxkPya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565ECC4CEE9;
	Thu,  6 Mar 2025 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741304401;
	bh=2O3gzSJqeBR3y1HxL0/bGENzdZ3TfPpcd0eLk42WfMc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZVXxkPya2mGhH1QWF+ZVQ8Epuqac4kRWlhQtmyLRjmKAbhGGsRoorCjKTqnOkfmGU
	 LVtF94dL2rLfg2tovneXQx2PX+TRhhxSwEl3SxLCUpG5RUAsdFuRoDumojc5Dn3a0n
	 ec4o9JCf3Mzsg7rgR6+S2RFVRvHzbMzmRVudQjQxnDSL8XQ+FtAXyof6Cbf2lcQb89
	 ioEItzSPR99P6EjPlaI7CQg5V5gAwtbV+RQRRJYPQaFDFDBZAU/JLjZdMnDOkuXxca
	 tm7J3IFI+4+VTpduJH2vN3jBnSNVdHP5LVJxsdWqSRSQX9/sk4figjx5Ulr/qRtAm3
	 8QamGmXmA+0KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABB3380CFF6;
	Thu,  6 Mar 2025 23:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in
 inet_ehash_locks_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130443449.1819102.9915692426332789444.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 23:40:34 +0000
References: <20250305130550.1865988-1-edumazet@google.com>
In-Reply-To: <20250305130550.1865988-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@amazon.com, kernelxing@tencent.com,
 horms@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Mar 2025 13:05:50 +0000 you wrote:
> We have platforms with 6 NUMA nodes and 480 cpus.
> 
> inet_ehash_locks_alloc() currently allocates a single 64KB page
> to hold all ehash spinlocks. This adds more pressure on a single node.
> 
> Change inet_ehash_locks_alloc() to use vmalloc() to spread
> the spinlocks on all online nodes, driven by NUMA policies.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
    https://git.kernel.org/netdev/net-next/c/f8ece40786c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-238829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55816C5FE1F
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 812AF4E985B
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA5224AF1;
	Sat, 15 Nov 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeoxIqlq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF7223DED
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173254; cv=none; b=ghWA88TOHKrejAA2OLxFvTxFRrozhXKyak6UmpkvV9g4tpIHEucfjSMFrdjAD1iUQfZMSqWCw94PTOPaAG+QBR8oylhQcyVDpJAcj1yKBEhZhZsR192APpG8v5sC3xEtOwlxqG6RZ7m3J3yHy6ZzhGNhR7R+BF+vd1fwSlw0NHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173254; c=relaxed/simple;
	bh=S6yaT1k4WLp9R8/g6v2pCNaBxbiNviufZ2niDy7psyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hSwhpgNPygyhKlAFDuwHKQcUK/aBDchON7051ZmtVCS1fjcLK0pTy7YabMNMKekdhQZefw7U0mwJk3EjmcTVi4VeC/UHccs6K6xAtg7wRUlOw25oFh0UpzO3DPkpQeg5jRsPRX8n4sH0Uvp9VBlvpu6oBvcvNSYU08DVlhwggZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeoxIqlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1C5C116B1;
	Sat, 15 Nov 2025 02:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173254;
	bh=S6yaT1k4WLp9R8/g6v2pCNaBxbiNviufZ2niDy7psyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VeoxIqlqKKkYlI7ETG5+jcQ2xuNUETcx6XMLaYNPTWeTvpzjd4g634qbESQTURd81
	 IxuFEHe9YyJwmOrn3qwk0vpIXZlKwTpEqxtW/GQRx3s1k/KxNNqtUb+/eRrm573i0B
	 3zgVUcehcZNS//pOk4bRJbjIlt5rFlRlXcGs2Ovsgbw+7M2GBqVaFenhBgSLVyQlnF
	 nVJ+7LSqzMDalWB/DJEWg1Fe5pOSCAzq02CIxzjbE2Ci4S81LaF72d5r9l64rk4jFk
	 /A0NSN3unUquL0tyVMG9pTfN0zisD9pbuAapeAWK0vi0ZrO8fW05JryL872jWboIaE
	 j50pQ016rFcJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC463A78A62;
	Sat, 15 Nov 2025 02:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: gro: inline tcp_gro_pull_header()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317322274.1911668.14704944620599055361.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:20:22 +0000
References: <20251113140358.58242-1-edumazet@google.com>
In-Reply-To: <20251113140358.58242-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 14:03:57 +0000 you wrote:
> tcp_gro_pull_header() is used in GRO fast path, inline it.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/gro.h      | 27 +++++++++++++++++++++++++++
>  include/net/tcp.h      |  1 -
>  net/ipv4/tcp_offload.c | 27 ---------------------------
>  3 files changed, 27 insertions(+), 28 deletions(-)

Here is the summary with links:
  - [net-next] tcp: gro: inline tcp_gro_pull_header()
    https://git.kernel.org/netdev/net-next/c/6d650ae9282b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-164193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7688DA2CDE2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DF7188A3EC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0D1E1A3F;
	Fri,  7 Feb 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnFzu0ke"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ACF1B0103
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959013; cv=none; b=tM3xClrbz4dQ4tQ3/bDrgNpEJW9Z2YOygNbwvCyCAMsR2oYRBdIWyAjLCszZGL0J5l2cYkv+Wd6VE23QiMLLfHuD2wFzbbhA8weLxA4vC4e9DTmaGoyQfMpBjwqnHqUYAmOTJk6V8IA7eltfABrh3/YtSEUmxGTtGer4Bwh3ojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959013; c=relaxed/simple;
	bh=gLY7t7f+t80zbBJzEsLQ1uGwk7RSdTuPVwQkOIIzuww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cY04yEADHQH8Hy1eupJhu115Xj/TI+aYHy01dqHt/ph13RoNGqEIZe5kS1A5qoHyK+w1aOMOpiR3IQe1ab6LR+8TLVCsJTgEYf5SAjYWCzCjA+CdztcBJrCt63GpXplojnqhKw42j99yxYcIVeJV3ABCmgKONyTqnrtjKolDcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnFzu0ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD624C4CEE2;
	Fri,  7 Feb 2025 20:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738959012;
	bh=gLY7t7f+t80zbBJzEsLQ1uGwk7RSdTuPVwQkOIIzuww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YnFzu0kejk7U4IshwqHAdZQ6sk2dgJTJwOL8sA/7DE/K5djUNqruQNe2JyKHq0+XH
	 oxgjLt+Zx+aLeY88bDBCX6J+FUniPoTzOf+GFfbwDwIZ6DLemS6pigqtxpz2HYUHzP
	 8LebRvnHI5RKoUvZpNK2w3ohMluP5GWI6Lw2bc+DW6hxqzQHJxFE3pw7vmfufAkDx8
	 KPz0+2bibCvBxQ9VkOqwOoWH8blihCen5qkn5P23DDcIExHzGZBb8U6VgefpCUfo2K
	 nna5PwUAbVxVViS2jDa4LcYUXwwTg/MP7VsyNEJoATj8/A3j/fZLN5DJxdKuF5Nj48
	 ASt2+nL68N6BQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB369380AAF4;
	Fri,  7 Feb 2025 20:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: do not export tcp_parse_mss_option() and
 tcp_mtup_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173895904054.2367164.5209279146820710284.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 20:10:40 +0000
References: <20250206093436.2609008-1-edumazet@google.com>
In-Reply-To: <20250206093436.2609008-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kuniyu@amazon.com, ncardwell@google.com,
 horms@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 09:34:36 +0000 you wrote:
> These two functions are not called from modules.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_input.c  | 1 -
>  net/ipv4/tcp_output.c | 1 -
>  2 files changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] tcp: do not export tcp_parse_mss_option() and tcp_mtup_init()
    https://git.kernel.org/netdev/net-next/c/d876ec8d3ed3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




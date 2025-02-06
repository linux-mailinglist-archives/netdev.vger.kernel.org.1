Return-Path: <netdev+bounces-163338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BAEA29F13
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383DA1684E1
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3B1156C74;
	Thu,  6 Feb 2025 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM7oZAD+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A07155757;
	Thu,  6 Feb 2025 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810808; cv=none; b=LzGCx3uvcB57nGsTq8Vp69ZwSrlvWJQuRD2q82lQ1mu0ltA5OLMvQ4Sq3AjWmhpKFX9R2XTFK6AKHzaDCcg8x1Q7s2Lv60lKvZFlb56yNMoE/X/sU4Z7AivNLZnKQxrxn/TYHK7fkT+er+GCIeXMC97BK3f2YBjiq7D5EfLV+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810808; c=relaxed/simple;
	bh=Xp8le9li6WKiZQJbIweZ5LHt6ALkLIF4/qCK8L8Kuac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XV6n9SWtuAodQuR/PoluJ+UwLasoxKOPtoivubrk+O21xauEMxw3R4dblJVMjULc2MWkW2nsVx2In58fXSrpsaVnnNOypwiPvCUWDKm+IhUh8HiR3oDRr1BqO4McNy7F447BMqvMYhv5/NUX+Ba+IW+cV41VCwyUuG8uEetteG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM7oZAD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E7CC4CEE3;
	Thu,  6 Feb 2025 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738810807;
	bh=Xp8le9li6WKiZQJbIweZ5LHt6ALkLIF4/qCK8L8Kuac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rM7oZAD+8ynogCoRuc/wSuVNUZ1m60GUkzQkTyf53F6jYxXo0OSWDu2X1PAL4pCAs
	 e26Fo0jkgXInxb+oK+VrSdo0Rt9iYiwJwFjWasa2sNtVup/25iKD3A7PYdOmXuJEz2
	 oGgSOAZ/U/BEHTErqIV4KnolL7ojLIczNHfAudeMJXjtB4gHm849EiuA1FIPmzn8KW
	 tJLMTUFrwW3waxweHmIbwN9JXx4kbN+ndB1GLSc+AHx6VVyl2MHyYDaW4ayQE21e0g
	 zc94SLBFSP8W/s7wepUEenWZFq777YuAjEE4XnxLuh6KCZb5WseemjjPib/Pw1Tdmb
	 x5hhDmDSixdpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2A380AAD0;
	Thu,  6 Feb 2025 03:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] ipv4: ip_gre: Fix set but not used warning in
 ipgre_err() if IPv4-only
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173881083474.983395.7645421188139514667.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 03:00:34 +0000
References: <d09113cfe2bfaca02f3dddf832fb5f48dd20958b.1738704881.git.geert@linux-m68k.org>
In-Reply-To: <d09113cfe2bfaca02f3dddf832fb5f48dd20958b.1738704881.git.geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Feb 2025 22:36:54 +0100 you wrote:
> if CONFIG_NET_IPGRE is enabled, but CONFIG_IPV6 is disabled:
> 
>     net/ipv4/ip_gre.c: In function ‘ipgre_err’:
>     net/ipv4/ip_gre.c:144:22: error: variable ‘data_len’ set but not used [-Werror=unused-but-set-variable]
>       144 |         unsigned int data_len = 0;
> 	  |                      ^~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next,v3] ipv4: ip_gre: Fix set but not used warning in ipgre_err() if IPv4-only
    https://git.kernel.org/netdev/net-next/c/50f37fc2a39c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




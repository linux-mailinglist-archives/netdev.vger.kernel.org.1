Return-Path: <netdev+bounces-197816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430CAD9EFA
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1F3AC068
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15BC2E3385;
	Sat, 14 Jun 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFfk+w5i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B162E62A2;
	Sat, 14 Jun 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749925802; cv=none; b=GKNaRKIAUSOAEEggVxGOC0252gq5UIo1V1PsQKcsnSVRH9jgA6IDKyf3mOFRCZjm6x2QARCeLGkug9zHzgTQJ1YtYbcEfpNXiq2nb53nTaYFUw8ELdpMgNKCnlrySl95Bv6bRR+/outDpXgYq4riwAkmpaFqs5H9GC2CaDm9R5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749925802; c=relaxed/simple;
	bh=ZOWX7BWpub6OqdK+2qdgNdaLd3Y1ksfzS7MpICVwCEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=afgw7ZOe6WAPADsPE1nPV0f74JeLWL6fhjrm1uXSpCghhzxY+1Kq5etJCO7I+sfw+liaTp/pFK0vrfrHODNPOcPlITNfZRySaC3q+EvmMJdtoxW5MmucI5TfqGSD/Xd+XHSdpO3JVTzaZ3ZmkjpNH8VwExAt95nLVrxP9tIrSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFfk+w5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E179C4CEEB;
	Sat, 14 Jun 2025 18:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749925802;
	bh=ZOWX7BWpub6OqdK+2qdgNdaLd3Y1ksfzS7MpICVwCEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kFfk+w5iSMt6D2lX4Hzhd9HRVt3vSdqRin5fWxHjTTsQuigt5EIhuS/hLAWowzqlG
	 wKSaYEFSpLW+jq7Lp8lg2NanE4zBZpKdva7yWD4qwTi4KSZkQ2rS1t1lYITXj+e3PI
	 oErcfZT0B8cjuahfAPo2Rgqq+NJeHpw5+uBehdknoLNcoYzKO/vpo/Q2OWWoKaTEaF
	 rea0f4cCd8z5Vjq7qHxponCCj+X/LxANLNZYCXNWsD8b0n3I1Pd4nXo+uRkHofnv5C
	 WHyKxEcuChumy/+tOGc8itaMWAkRh8rm3bbawaV1KzjieSW2GOPJWhgqPRgMU1nbtw
	 HTku+0HLw68NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD57380AAD0;
	Sat, 14 Jun 2025 18:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: amt: convert to use secs_to_jiffies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174992583150.1145273.16478965870565918025.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 18:30:31 +0000
References: <20250613102014.3070898-1-liyuesong@vivo.com>
In-Reply-To: <20250613102014.3070898-1-liyuesong@vivo.com>
To: Yuesong Li <liyuesong@vivo.com>
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 18:20:12 +0800 you wrote:
> Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
> use it to avoid scaling the time to msec.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> ---
>  drivers/net/amt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1] net: amt: convert to use secs_to_jiffies
    https://git.kernel.org/netdev/net-next/c/c969149bafbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




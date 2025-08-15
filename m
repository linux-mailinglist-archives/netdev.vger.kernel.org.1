Return-Path: <netdev+bounces-214140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BECB28592
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D35607CB9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9397256C88;
	Fri, 15 Aug 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJbEfqmz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74930DEDB;
	Fri, 15 Aug 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281344; cv=none; b=B7t7g9ylwAWOtvWXbDyYeULzMQcmJYxzDG87I9RHXzhGSQwhMv+clJpd1wrWFPFdpUDM3UnLNUkccWUYkoEL3S/xz/cPdPmbQ6nnYO67WDa0gCTJBqpxqKl0n1KVVBMzwWozgrb+2Ax4QlF8rSh4qY6hYJpAair3hjrhEXs1zG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281344; c=relaxed/simple;
	bh=bS90Ms9nCJY917WmfgiYxyBT6gp36bc88U6J5dUd+98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZzOtkexQdGTfA1xD/eIiQ1fNmmDqm3RO/mQuQ5Tz7Un8xchUJKq5Y9moYumJsnZOdig7y+oRu0WQGsdNxiLpN4McX4ZWpqbZlP/H2aRPkcBBPa3uKl6GpZ8FGwQ+tBcOKYd+ra8lxeFOcbzJlkIISMgeGpJyzYzze1RuwSptInA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJbEfqmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65874C4CEF5;
	Fri, 15 Aug 2025 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755281344;
	bh=bS90Ms9nCJY917WmfgiYxyBT6gp36bc88U6J5dUd+98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fJbEfqmzNiwI6Bu6bc2AxMjw33RDfTPMix+D+w/MW0F5Edn1OphyzNo1UvD1UYOUV
	 Yfiq2dlZsrhJ6We5i7ajr0G/FQBNnhNlnWpNTMfhQ2GXIYVUT74Pga1eKVURrGHUNH
	 7EUACAHw+X3zE+Iow5x9tGxhvXTxQqkmWBtK6SsG8HoZ11dirGRKvSV8PJj/vD41hK
	 79gGNW9l/GnW3EVnwf8T/emt7r/0e4XTkl5K1awtSti0en2wE3J6PndwVcfZbpmPeg
	 UumM6RIjdaIaclwVhEcSQJq9BGk/5C1oIeTmO+Ygo6YRWt2POCKmnWWFhswD+tEcKS
	 5pbjNRGeeA64g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD039D0C3D;
	Fri, 15 Aug 2025 18:09:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bridge: remove unused argument of
 br_multicast_query_expired()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175528135524.1165776.13820515858631559907.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 18:09:15 +0000
References: <20250814042355.1720755-1-wangliang74@huawei.com>
In-Reply-To: <20250814042355.1720755-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Aug 2025 12:23:55 +0800 you wrote:
> Since commit 67b746f94ff3 ("net: bridge: mcast: make sure querier
> port/address updates are consistent"), the argument 'querier' is unused,
> just get rid of it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/bridge/br_multicast.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] net: bridge: remove unused argument of br_multicast_query_expired()
    https://git.kernel.org/netdev/net-next/c/7de0eebbb4c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-75669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A1C86ADEC
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC691F247FD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8683BBF7;
	Wed, 28 Feb 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji2+e9CG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E63BBF4
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120431; cv=none; b=uoJqrltI/BUIds5SNEadfP8gIpUZtQ6tccu0EtfLJuRuMpGDdP+1o9aMCByTAXn6CbxA2PN2DBghktIwHkmWfd0L/UGOnBqxPHZjivYf0D5bWAnGUG8oz6LksTwHLiaPWH3lyns/7WOxkDHipLCRhM6TsvEnimd3ublNrhR+nSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120431; c=relaxed/simple;
	bh=Z8MGWhVcGlfRRHVPu1jwaP9WPKjRLbf04t8nBXeRvQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cXKCtBEC71jzgMXccTa6tizmG6YgVm3yDg375rPyBggAWIei0iAxAY9SE4I+3U2hFuXF75rOfOMcxDBweU1sNSTJzIjCRx7ei+ET9mAxDHOcCkIe/NwBrWrYW8BEOJg6DDXW14FRxbY5/7Bgfg1GuP1am7H6pSvLwEOuuwnUFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji2+e9CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61ADEC433B2;
	Wed, 28 Feb 2024 11:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709120431;
	bh=Z8MGWhVcGlfRRHVPu1jwaP9WPKjRLbf04t8nBXeRvQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ji2+e9CGYGrmAsXxI7BaioJeXCS6OWyUTMA0MGRZThdIndxsXYDAoQ07jJGV/zF0N
	 DjEXj8MrE/rTLTMJTkI/rCaP7JL/n3SslAPh7pyAXX1Aj+LYCUZYYNa+XUYT8WsmDQ
	 OHQFgjxvpEx8mxJthdizyZ9Uk9M/y5lTQmTsjnj2Z78qhi8z/atbUydPSHNUjJnlsk
	 iEl6lCfQ0f9oSZSsQtra0lOxAKLX5NOvBuflvoYFR2AhGWcNqy0o8JAwHs8QC/wO9q
	 1Y9iaJiAunCTCkRnMmSsgxSX2SZBsJCUoaGfFSzbRIBUpN2RNBhvXbEM1AyHSfmTQB
	 vaKgYmc6hpqLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C334D88FB1;
	Wed, 28 Feb 2024 11:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: raw: remove useless input parameter in
 rawv6_get/seticmpfilter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170912043124.13205.11630138334042324823.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 11:40:31 +0000
References: <20240227005745.3556353-1-shaozhengchao@huawei.com>
In-Reply-To: <20240227005745.3556353-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 27 Feb 2024 08:57:45 +0800 you wrote:
> The input parameter 'level' in rawv6_get/seticmpfilter is not used.
> Therefore, remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/ipv6/raw.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] ipv6: raw: remove useless input parameter in rawv6_get/seticmpfilter
    https://git.kernel.org/netdev/net-next/c/2e26b6dfade4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




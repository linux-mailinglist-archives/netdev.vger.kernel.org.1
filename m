Return-Path: <netdev+bounces-189412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 994C2AB205F
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F0C1BC7F3A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD2D267F57;
	Fri,  9 May 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9y9AYca"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A1267B96
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834609; cv=none; b=YNKC419zaGezpRLjhJ3S0u9o2eTBvn7Eu0p2t//avSj2aB4DGTDNF1sKN2dgruF01zYRysadPcnDsW/cIZmxwt6UgUTYR2FtEgyrRSa24Vn7eL6YxO+UjuYsfijHGvj4iL8aFqopY99JUu+waG0kvSHAeck152xm9eQgEt8giiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834609; c=relaxed/simple;
	bh=jQ0TUhKt+NsPUcfNifvIIvpLqaYN7CrkBXArlKoGNAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hJV1h3ojOKkIyOknW7hTuPdyPkSPyGmFUQ/QwjbtYwma/Xwo7OdiVeLM4ghKNhnZ74HMXcuxpRnDyc/jssYCWlN3ZN+KcjuXvY0GrFv2UkRO7Yu8HuHfNYVHHUVrCC+caaHsm0qCwonNopKyXg1e5i66p6Ivsg5Z5Suj/LIB07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9y9AYca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1B1C4CEED;
	Fri,  9 May 2025 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746834608;
	bh=jQ0TUhKt+NsPUcfNifvIIvpLqaYN7CrkBXArlKoGNAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y9y9AYcahh8mMCLRxsUy6aSsngS8ZD7aODjDkgXL0g0V62tfl9wf4fmTkj7k0szze
	 hdncpkElodioLSnBGG/JIVGvxtxsDbVu3QLpxlpym2fyjnbaPV7i7Sosea01ikQmjT
	 cGi47EP61xoYYmslGskjSsNP51NUiloPUXHrHmtrpNZE5dOIjnf5tGn32MZOfQhtru
	 WoyJVlbQ2WpMJL/mxLauYey557qRbU4E+Lgv84rKueRkvt1znBjLAACuLwdgBbYyRj
	 8ZM1QjxAsBwSb9om6AKb6KgOuzQXXjKETIy2DU+CwXLrCHSvlTKTuqOXoGRHTCqlgR
	 jl3TnEuutnb2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B99381091A;
	Fri,  9 May 2025 23:50:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683464701.3845363.17062737128371358602.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:50:47 +0000
References: <20250508103034.885536-1-gal@nvidia.com>
In-Reply-To: <20250508103034.885536-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org, andrew@lunn.ch, tariqt@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 May 2025 13:30:34 +0300 you wrote:
> Symmetric RSS hash requires that:
> * No other fields besides IP src/dst and/or L4 src/dst are set
> * If src is set, dst must also be set
> 
> This restriction was only enforced when RXNFC was configured after
> symmetric hash was enabled. In the opposite order of operations (RXNFC
> then symmetric enablement) the check was not performed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ethtool: Block setting of symmetric RSS when non-symmetric rx-flow-hash is requested
    https://git.kernel.org/netdev/net-next/c/1b2900db0119

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




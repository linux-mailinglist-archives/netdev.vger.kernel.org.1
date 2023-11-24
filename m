Return-Path: <netdev+bounces-50881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0D7F7713
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C457B2814BB
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552A2E3F0;
	Fri, 24 Nov 2023 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aahs5TFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3B2C1A3
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 15:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18A1CC433BB;
	Fri, 24 Nov 2023 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700838027;
	bh=F3BZyyEw8tY9U9Fp+5GtQnX6AWJdxdSxHwwVgJ97/Jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aahs5TFUHdOvn1qP3gjHLa+HvzCkk9xLyLAAxeJetDmIqG78IUtaXI8iFzpq91rp/
	 Ncf5NfIuop4H+hcCBsa4Kr5Jwk+2KKeQ8hU8DEvkospvnXSoK98wpsPlo/bx+zhomL
	 LLc8O3alYX7oHyBdoWBllJ+l7GtB15FmTU77e20Ez2ErhUbfE6kxxjFrLYQtsCrQqI
	 OR9x3NyhgBahVmhONzUkB9fWamJoUh5OdoQKRnExBVks/vrXnF3u44AmraqHSp0toq
	 0Ns6PPEmqfu4KvVjESnrhIaNwOfGAG5+cwt09Sjf+JnPJkfrmcJ3vJJGLx3flRt6hq
	 SH7Z20NXKr1Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 045B4C395FD;
	Fri, 24 Nov 2023 15:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: always append ULL/LL to range types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170083802701.22904.15354700207655430857.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 15:00:27 +0000
References: <20231122173323.1240211-1-kuba@kernel.org>
In-Reply-To: <20231122173323.1240211-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 09:33:23 -0800 you wrote:
> 32bit builds generate the following warning when we use a u32-max
> in range validation:
> 
>   warning: decimal constant 4294967295 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are very likely to produce unsigned long (and a warning) here
> 
> The range values are u64, slap ULL/LL on all of them just
> to avoid such noise.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: always append ULL/LL to range types
    https://git.kernel.org/netdev/net-next/c/8e3707975e04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




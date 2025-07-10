Return-Path: <netdev+bounces-205620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11FAFF6CD
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128161C82772
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272027F758;
	Thu, 10 Jul 2025 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpTl0ru2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C827F74E
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114590; cv=none; b=P1Q1eYhIXXyqKV8/1tC9jy25bCTZTTnUkbfZgP/b9mDRrniTcRvZTz/eLaiwtGA55Apc/bmcAAbu4NK446Y5c5d9UAUuhk8dDsdo0Op+WB3gxl5MCcDzdX+6MaVWwSIEVS12uD1ydr9bMbT3YHRHR7J+sUGg3QUzzeRPvvGXflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114590; c=relaxed/simple;
	bh=+WYhZLChgOtR2Uybu1PNVesfR8zXFQ4iRx/GFMrnFmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yo3rLIBH0Vk7xC12hm8/qOciqLg05duNx88M+JjYXAe+FaYqHNnH36PWTTLnXsKcz7MEejEjMf5Msvu32hvWG4LhQQWghKrVz+CHMi7esmS9kWswLjzmzGkv22nnkaDd7/u1mOUy0KpPmVAqwWqxyShRCbthw8eeNC3UU+69CqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpTl0ru2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C586BC4CEF0;
	Thu, 10 Jul 2025 02:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114589;
	bh=+WYhZLChgOtR2Uybu1PNVesfR8zXFQ4iRx/GFMrnFmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qpTl0ru27ciXxtlne7/f4jxFIZuSODzOAUvGVojIrranAflJuhJ70wCPfzBRS3lEB
	 CjIEAOy5hbwgFwyvuArCub6O+YQUZM+o/xo/obCxzImizSqtmZWKQ78L/050FUbSnx
	 he+X50YXziMiaik7trUl2tusxWLKvIXLrTIvIAzD08FsWkj7pKFZtZsXvUqOR/xEL3
	 8YcCtx2EDRCBk9hI6fQXofuQWp/IVzd5BrmzDUO1efx30vJYcrO+aBKm+2sB8E27lu
	 +7lLZvgFBRnRsN9bCw9LWVupj2798aKIHSP77ipxJ2ymSFZ8297Oe2/ql6885i1m+7
	 ++d9S1iQKAU0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF0383B261;
	Thu, 10 Jul 2025 02:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/tc-testing: Create test case for UAF
 scenario
 with DRR/NETEM/BLACKHOLE chain
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211461200.963219.14379555813823262635.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:30:12 +0000
References: <20250705203638.246350-1-victor@mojatatu.com>
In-Reply-To: <20250705203638.246350-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 pctammela@mojatatu.com, nnamrec@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Jul 2025 17:36:38 -0300 you wrote:
> Create a tdc test for the UAF scenario with DRR/NETEM/BLACKHOLE chain
> shared by Lion on his report [1].
> 
> [1] https://lore.kernel.org/netdev/45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com/
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net] selftests/tc-testing: Create test case for UAF scenario with DRR/NETEM/BLACKHOLE chain
    https://git.kernel.org/netdev/net/c/d55683866c79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




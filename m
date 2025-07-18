Return-Path: <netdev+bounces-208069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC7B09986
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E807BB4AC
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE6E1CEAB2;
	Fri, 18 Jul 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot3mlmhZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1070825
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804008; cv=none; b=faxYILvvOccOAoNjfwayUdBDZXK9Ltv7PoOw3TAD3tpbjuZSw+IzSc+bwgyONV9JJhkOQ6FPKjVvYWi7dsaUCwZGEBVQKFzsCGfmR2ns0xvzBM1whg5h3X3wTa2IS7MV2GUzrYpBP6zSSM4Lya53k6621Qhahdyy2W/iu8p+ICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804008; c=relaxed/simple;
	bh=dGaXJKOcicEz7YZpMobz0SayQH+ytrSQs9kRDAGbk0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VhtMavzUNMMArAEiqUgKXpYvF2iGM53nubR6i1VXd0QGtkIdqcqDHp478yLPgnrXX3d91/cdHALznlhXkjiQVGMLl6Lp7By74U4zWvMP6JT/rTOvJ9z+31ljijAaw0xcGNYF7bL3gy61UqpmQlrks9LEkbbBWCTkllxp/LGq4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot3mlmhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4C2C4CEE3;
	Fri, 18 Jul 2025 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804008;
	bh=dGaXJKOcicEz7YZpMobz0SayQH+ytrSQs9kRDAGbk0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ot3mlmhZF6wL5iy1IsR9lCo6GvrsdniWTF4cjori1Ai7eqUOYUS/9h1d9qotzZPi7
	 maBtaNSxg0H32ezNpKObDu/0hL+iyAhwWZE4rSdwZ1UaJ634j+Efu6KTu8GmKrgPWy
	 kZzR8L1z2p2rqj3I2m86eJmZ2xndgo0UOlNNDe19bqWw4PQJJklkptDU9Xkm7gXcmC
	 LKK9Y75vw3IRm29zTq9ZH+4FFvOHRnq2lqgVYoGAtsxT2ZzELmryjAAdBfLDsocDhv
	 3eRYOgrUTeX+QTg0luRlLqYUlkYH/FGECXJFhNOcd0PlnEUKARkFfN1MHICDSKk2dt
	 jH9PnJIlHf1fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA8383BA3C;
	Fri, 18 Jul 2025 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pcs: xpcs: mask readl() return value to 16
 bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280402798.2141855.16546175271917379292.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:00:27 +0000
References: <20250716030349.3796806-1-jchng@maxlinear.com>
In-Reply-To: <20250716030349.3796806-1-jchng@maxlinear.com>
To: Jack Ping Chng <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, fancer.lancer@gmail.com,
 yzhu@maxlinear.com, sureshnagaraj@maxlinear.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 11:03:49 +0800 you wrote:
> readl() returns 32-bit value but Clause 22/45 registers are 16-bit wide.
> Masking with 0xFFFF avoids using garbage upper bits.
> 
> Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
> ---
>  drivers/net/pcs/pcs-xpcs-plat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: pcs: xpcs: mask readl() return value to 16 bits
    https://git.kernel.org/netdev/net-next/c/2b0ba7b5b010

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




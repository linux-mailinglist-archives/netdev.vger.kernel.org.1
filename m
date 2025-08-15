Return-Path: <netdev+bounces-213897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE8B27440
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C625E1472
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0B19343B;
	Fri, 15 Aug 2025 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e98ZKKB0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73511922FA;
	Fri, 15 Aug 2025 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219018; cv=none; b=obi7E46+n9/esmbqUbn6Q751vWhm8sFTe7NITEy2oclbyWrPbl/zVsNyhm1aaHHBSPPIWwsj11lSVv6pm+fFC6LYbsX2mpqPHenXPvxwYChToviJR1jkpOeXaJNFd1APjGLpoiBijqHEZSb9okm+ZPYUYfN1kfbc8Yiq5+X4Qmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219018; c=relaxed/simple;
	bh=NaNqaP3C3jdeRHtc6S2034lmWD1zWpANl8x9Tuqx6HA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fd5TKFsic2/OLhUxz7ACz34k1ckdrPBBmOB4lmLNSqqqtPbgkeBE9clQbiKPHgUgG/M0eCQbwYFHpUbNLhow34NSVwRcQkHeDZKX2bZR6EsdMx5QgaCAKLcmZA+mFC6TpVR6/lUSpNBHdwhTRl8Xfbg+4rTBYoSqHhUEvNAgxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e98ZKKB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC5EC4CEED;
	Fri, 15 Aug 2025 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219017;
	bh=NaNqaP3C3jdeRHtc6S2034lmWD1zWpANl8x9Tuqx6HA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e98ZKKB0pXjmcaEYzAIscFu58rUG6Y8lvpgKOwqjqPYkN3A0TF+n9CxD8he/DlRo8
	 76XzSpyJNg/nEfKN+E0yuf0NvCRkHHbCSqk86R1etMhyc5xr6WyfJVh41XqP6M3BPy
	 9ZlWj0aFP2CQFljhkztrne8/qaLqxvyVdR5C7aTPJ7ktJXFKIrJqbsI31V2RL1PoXN
	 5+e1b37KdBIR2VjgXDPyOXiFfv58H59TIadTeGMqXHTb7zjtmkTj3Kf09AHfnH0Fxb
	 jjYm7MgVEk9oQuJmoMhIyaF/CaUojWjd+dvQkQ8NGzXP+F3cjgQg6GGD2xTxVOy6Vc
	 nO/m3V75bnWiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7D39D0C3E;
	Fri, 15 Aug 2025 00:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: remove unnecessary file,
 dentry,
 inode declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521902841.500228.2139598366894065654.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:28 +0000
References: <20250813181023.808528-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250813181023.808528-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 21:10:23 +0300 you wrote:
> These are present since commit d8652956cf37 ("net: dsa: realtek-smi: Add
> Realtek SMI driver") and never needed. Apparently the driver was not
> cleaned up sufficiently for submission.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/realtek/realtek.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: realtek: remove unnecessary file, dentry, inode declarations
    https://git.kernel.org/netdev/net-next/c/20e1b75b38fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




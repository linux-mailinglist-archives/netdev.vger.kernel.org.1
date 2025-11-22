Return-Path: <netdev+bounces-240936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F25C7C2C6
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 809A24E2915
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9492D3EF1;
	Sat, 22 Nov 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce7TiC/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341A2D3225;
	Sat, 22 Nov 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763778053; cv=none; b=nD/FgOpFuiFwnZO6bjGoHdsKLIt/eCVK7slwXZeIaTHyBmu6+BEYvyCwkHUkeO2x2df2ZZqldSOkimKY/2NLsgbYhG22hFcbPUa+YPe5MKQDmp/nqOsQsyrodGhiYpOzjitE4lk8bHPIvS8+EDzIGrMkQAggJuoU3/XtAJ2w2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763778053; c=relaxed/simple;
	bh=cAIhBIDG+uknqC80k+ti/fjYc/JLpzlYtGR0T2u5nMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e7lZCzU3k+cOZcj2+B3Af7r4Lh0iLJyN16w61TAbVZvnGKa/qYxcpAmOTPAUCRpXjs0EHnQD9r9F/2Jgxu2JFbTT1XuuOXJnDPv1LwvWs9SWrzoJj/Hjxx9Kv5OnjLV+iLetVxCu8LXmjL1ZaWhO/1Zp+nRLy4jY3XYIIl+TiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce7TiC/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4686FC116C6;
	Sat, 22 Nov 2025 02:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763778053;
	bh=cAIhBIDG+uknqC80k+ti/fjYc/JLpzlYtGR0T2u5nMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ce7TiC/S6GRAm+rn9B/m+e5M3dbpo+6cG7jzGpDh1hOINBsOby3e1QYdwq9u2x36L
	 6jcJaZTIOCCFp6NtihcpW6cyMV91A1OAZPq+FGsUpl/jpssc/Sq4c2tvrzu7TEoZ4B
	 VMeJBiwS/PEcLLcqGssIxvWOaizwbntsW0bxL7BKxb7+LDmUUkjSPGIBd1KUSEfmQ8
	 Qeq/Q9Uvfn9cCtrICLf1Q1JOvbndqB2MokXotwq/DXWK1MYq/jBctlzD/ZJAxG4sMG
	 LO1u9lyOO8/jEzwNxit2b9w+/La+pdlTLoXErWkMjQwj0xZW/xV9dJa3iTdP8/u3Jh
	 8r5L3QydlhrRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1EC3A78B25;
	Sat, 22 Nov 2025 02:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: Make local function static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377801750.2657243.10564171335258815272.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 02:20:17 +0000
References: <20251120115208.345578-1-slark_xiao@163.com>
In-Reply-To: <20251120115208.345578-1-slark_xiao@163.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Nov 2025 19:52:08 +0800 you wrote:
> This function was used in t7xx_hif_cldma.c only. Make it static
> as it should be.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.c | 2 +-
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - net: wwan: t7xx: Make local function static
    https://git.kernel.org/netdev/net-next/c/501253b61d84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




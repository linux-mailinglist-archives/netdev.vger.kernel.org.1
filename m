Return-Path: <netdev+bounces-126143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B970F96FEFF
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55331C22172
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23E1B7F4;
	Sat,  7 Sep 2024 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCmyE4Oy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081CB1A702;
	Sat,  7 Sep 2024 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672636; cv=none; b=WrjZugiv8CNpzDQDfjhgD1iWLIe1+3lgWsrbQ2HS8gGel2sKTYC/sJSaVNT7CptqeNfmZtoFC2Kd4WD82KyO8g/d30fH0kbj7G6Nxw9nuvr2EfwA7XiC/V+3FE3sedFkd7hcgkE/zJAfjYCI8JMOZO0m/m3Xtc7gaovRJfz8JbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672636; c=relaxed/simple;
	bh=VhrLkWFGLWZpyJuK7pjYjV84G5iehAZRfPrzuCLPyv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lNbjS5tWlYr0QmwzJw4DJcC9veLmiNK8QYvBHeJ56xzzD111b5ldbH1UWdX/VjRxE++qiyncZInnDS/jcLKXkNjmzYI62r7Z/UXyePSyAswWcKE0bhWM3EewlsPUHs62OHoyiax4vW8rgJXXkkt90Z9BG0zkI1dHyHoYkSg8VpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCmyE4Oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EB4C4CEC4;
	Sat,  7 Sep 2024 01:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672635;
	bh=VhrLkWFGLWZpyJuK7pjYjV84G5iehAZRfPrzuCLPyv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BCmyE4OyFywPhAJtG/EW7CflGMQwfTcoDfKUyY6QWxYO68Y/5RBKQ43QqbtQ1PhwZ
	 HyRgM1AnHt32raWr5e8OCYU1dU/euJGJw6GZHVwbXhzuygBRPvjXlDnoTU+IqTxUUi
	 vLBCL9Devwx29kqgxQpRdohr3FM9TcbErWUa3AO47TTi1XNZY1LxbcxNHIW9yK40KZ
	 jFRFBiRMZ2s6fA4NOpsGsaNUxgV0HpBJ/cugFstnOuTjKYAf2hXlfuKsF9oH+FThg9
	 J1u54OLeu4kdW6cT8s8rrxgwjgGH8y3pNYEKB7P/ssKxzOwHc9Kg9ez2vRHixbe+bO
	 QqtexAuUWP22w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE953805D82;
	Sat,  7 Sep 2024 01:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: qca83xx: use PHY_ID_MATCH_EXACT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567263651.2576623.8778004676474450322.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:30:36 +0000
References: <20240904205659.7470-1-rosenp@gmail.com>
In-Reply-To: <20240904205659.7470-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, ansuelsmth@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 13:56:59 -0700 you wrote:
> No need for the mask when there's already a macro for this.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/phy/qcom/qca83xx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Here is the summary with links:
  - net: phy: qca83xx: use PHY_ID_MATCH_EXACT
    https://git.kernel.org/netdev/net-next/c/cca0d69baf95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




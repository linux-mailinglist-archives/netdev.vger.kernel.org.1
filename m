Return-Path: <netdev+bounces-133400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E221995CF5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566F3283C98
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613512BB1B;
	Wed,  9 Oct 2024 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8g/pILb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383272B2D7;
	Wed,  9 Oct 2024 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437424; cv=none; b=Z/qOqVoO1fnGCtnHRB+jusfoVAqb6tcBuwaZUXL3jgRGseaQ+b3D4fFqUJIl9/BP8myb8eGb9nSuOGTQQsYfygVUvBBwGk6O+uKAhLm/Bh98AoE6w3OQLXNmGlT5p1Wqhc2VLqNPvSghwICuhfUwaVmXFMYu9M4/n+cm73DFBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437424; c=relaxed/simple;
	bh=10KLiDu7bPn2aGyoXScqazfu+mYTo3nfOXfqhE8rA40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YZryqBiF3YMunieeLOZrlGE0iL6p6gJO8oho+MUkZsB0MqSpFcJnOQNpxjbQA6lfcrwaVovQymW4wmQQirqRAut+hUOadjsLqWTRpdoWwCV6/RYTXu71vzwH4DpYp1dEUm1dMGSuRZdyg8unR30iuAYf17uI67C3I0Dp5GXIeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8g/pILb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C411AC4CEC7;
	Wed,  9 Oct 2024 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728437423;
	bh=10KLiDu7bPn2aGyoXScqazfu+mYTo3nfOXfqhE8rA40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t8g/pILbzfAHYULxVcTISvHwWGr/f+3FjQTxbLTVvBsTC9tS/+NHdcXdBNwguBMqV
	 XqCXwoqFgzdztmpOK/LBowvDMMFovhMl0GRDrUghbQ/TDOsod3/IH2MykGXLRqTd2C
	 jWqPa46X+Y5rGDjSFpQ1ci+rDtMj2tRHOYPePzW7dwh6xY79CkwgxebR7/uBBtQkIB
	 +qWNJhXY6DJHAQgdPtdB+gpsKWOc9PzbuzaEGc1sR6/qgX8TJouflw20FBuy1Kg+Iu
	 /JMPw8MkU4saauCC/gZVjFKHNRuv3n/QCGds/bBGvQLbcheEoYBpPL3FPzHmpPjY51
	 /rt5YMjCuz2Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDF3A8D14D;
	Wed,  9 Oct 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ibm: emac: mal: fix wrong goto
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172843742800.746583.16131100397682063916.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 01:30:28 +0000
References: <20241007235711.5714-1-rosenp@gmail.com>
In-Reply-To: <20241007235711.5714-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Oct 2024 16:57:11 -0700 you wrote:
> dcr_map is called in the previous if and therefore needs to be unmapped.
> 
> Fixes: 1ff0fcfcb1a6 ("ibm_newemac: Fix new MAL feature handling")
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/mal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: ibm: emac: mal: fix wrong goto
    https://git.kernel.org/netdev/net/c/08c8acc9d8f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




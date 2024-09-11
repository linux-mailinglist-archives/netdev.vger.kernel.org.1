Return-Path: <netdev+bounces-127185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E963974810
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608D91C2546D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F5136AF5;
	Wed, 11 Sep 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2a+dj/D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591FE2D057;
	Wed, 11 Sep 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020634; cv=none; b=bfSQN5rHaJZ12mslTLMGeSDcnUrlTm/Sg+waU3U3HplLMYxbAuzAMYR2LOKXZesF+G0sroNkzOZt00z2gZY0k33+K34VruJsj/s+itx+dRi44xkNbIvdJtspV+yyXyXf2VrmISaUWdKxLbDtI8t+lHK/95l1y9MnUz5IQ+hcq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020634; c=relaxed/simple;
	bh=Zu1/LbO49FyicMhfQbc0Lv7MfnCbRbL3IWMUf0NfjRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hNoX/yPKxdGrAAG+T9hKvZixVS1WLOZ2JL0PvrqLglsJxb2mbIji7pFe4yob3XzsNzpueRPsc9t5mGqQk+do0ywZT3qGWg3pOblYVFotA64Q6aIo14XFdwhFGmIemWz5VAxDPg6X30YDEdiyPrJCc4y/A+bUEblFbnqSNSgQZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2a+dj/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D8C4CED0;
	Wed, 11 Sep 2024 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020634;
	bh=Zu1/LbO49FyicMhfQbc0Lv7MfnCbRbL3IWMUf0NfjRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m2a+dj/Dpf8ecsbdrC44MyOBFVa29zYmdFZMfIz0txvDObjSvg+yHA1C/z561+3Rn
	 8c4SalYq71hKedWROhw1sWXiQLuFCcmVAhY80z0zz9sKwJ0gU17v3Vz5PITntP2+mj
	 VUiy2K+glHXoScoEbAKx2JY60dFavO2mitmkmtSUz7NAj2A97YfWLpGCm6a22raI3K
	 RHACB4BhCKCNJ3MHylv+i8k7+cfzjcs2nDmARn0EbCLokEUyHjzkOlFJXayGm8ApLK
	 DevMPv2qJMbm1/rK9LGsEjaM7OC7NXoJ6+V38dLM4sRi4VD4eBrATuwMlkZkdJHOzj
	 dySMLA8pSx1XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72C3A3822FA4;
	Wed, 11 Sep 2024 02:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: xilinx: axienet: Partial checksum
 offload improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172602063500.461532.10717864634728070031.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 02:10:35 +0000
References: <20240909161016.1149119-1-sean.anderson@linux.dev>
In-Reply-To: <20240909161016.1149119-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 michal.simek@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 12:10:12 -0400 you wrote:
> Partial checksum offload is not always used when it could be. Enable it
> in more cases.
> 
> Changes in v2:
> - Set RXCSUM in features
> - Expand commit message with testing methodology
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: xilinx: axienet: Remove unused checksum variables
    https://git.kernel.org/netdev/net-next/c/b1e455cd864c
  - [net-next,v2,2/4] net: xilinx: axienet: Enable NETIF_F_HW_CSUM for partial tx checksumming
    https://git.kernel.org/netdev/net-next/c/dd28f4c0e81f
  - [net-next,v2,3/4] net: xilinx: axienet: Set RXCSUM in features
    https://git.kernel.org/netdev/net-next/c/06c069ff2f70
  - [net-next,v2,4/4] net: xilinx: axienet: Relax partial rx checksum checks
    https://git.kernel.org/netdev/net-next/c/736f0c7a8ec2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




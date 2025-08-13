Return-Path: <netdev+bounces-213518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CDB257AA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53D99A1024
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8162BEC45;
	Wed, 13 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvjSMkAS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C42F60B0;
	Wed, 13 Aug 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128400; cv=none; b=NKziO7LYYrFCfSmSNSSOMFiopvdnpO3G/U+0hoI3Yq+ZGFti7DfX0eiICPzD0t7IFGWXLIuRCEf+WE/VrT8+eOI5lsaaNzYjjRlZ80KMFmGvCobLdz0BV8ydWcrwipnBTwtGXhceb8zNF2SJEGPnIApDbOHvreO32a1W8TX56lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128400; c=relaxed/simple;
	bh=siRdTSlDu6jh6aJq0hzfhFPIVLIosfMD+N1DFQND8cU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anMbTKAvk792JNZwzZ/XtA9/7A0+46TCAaY7qHEff/OMvdEr+HqVqeRBrGUDiRowYFV5fDcMyV3EFaoMAorg+czf3vuaERYOrpkH3wTWnWu3sKuvf7prGxZIQ5bhZIBpe0BNiITIC6BDEqfFfoz/Z6KSFOg+UPQp5ihk9HBeyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvjSMkAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B0AC4CEEB;
	Wed, 13 Aug 2025 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128399;
	bh=siRdTSlDu6jh6aJq0hzfhFPIVLIosfMD+N1DFQND8cU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvjSMkASkNkPfYvM1YfJ5lYkDtfG3yHdwl+JTqY5o8ERurNGU9dwBLZFWXUrLU4qc
	 w4i06iQ5eO4zLhEOh/sGtcHH9RjUp0z93HhgTU9+2WGNdZgAlPl1wW0b8PE6CYSSlk
	 rbe43qBJSCnlooiT8JlgDie2M5cfb1k1T5BeT0avYszXFfb3bJ6T6D0eM+svjsXune
	 Yrp7K+9C25/Xl40+0kcTlENBsZ+Z90caeDMQJaQ9xKns1CNcuSV3gY25vByCY8YTTS
	 +uDbCkVInKPaOlSaP0s3pcOdQhuxcswIudOgzzOR6dfFtuqeAhMlvjWyBqZ3T3cq0r
	 3pWqNCoq5UmXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7039D0C37;
	Wed, 13 Aug 2025 23:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] Refine stmmac code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175512841128.3818202.9781897016690238233.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 23:40:11 +0000
References: <20250811073506.27513-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250811073506.27513-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 15:35:03 +0800 you wrote:
> Here are three small patches to refine stmmac code when debugging and
> testing the problem "Failed to reset the dma".
> 
> v3:
>   -- Add a new patch to change the first parameter of fix_soc_reset().
>   -- Print an error message which gives a hint the PHY clock is missing.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: stmmac: Check stmmac_hw_setup() in stmmac_resume()
    https://git.kernel.org/netdev/net-next/c/6896c2449a18
  - [net-next,v3,2/3] net: stmmac: Change first parameter of fix_soc_reset()
    https://git.kernel.org/netdev/net-next/c/139235103f60
  - [net-next,v3,3/3] net: stmmac: Return early if invalid in loongson_dwmac_fix_reset()
    https://git.kernel.org/netdev/net-next/c/bfd9d893edfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




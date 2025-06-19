Return-Path: <netdev+bounces-199289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91DADFACC
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 03:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6678189E0F7
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FCA199EBB;
	Thu, 19 Jun 2025 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THoDMW7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD960191F91;
	Thu, 19 Jun 2025 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297178; cv=none; b=Tx4/AZHNMj7JwoLUQ80NKp45Pzgct8M3gChuK74qcV0lysgCfGgI1uLTPRRMCxmdnoh9MEaryyvfkOb8trUTVV4MGaX9XDaF3Yt30gWbZ5cFEYMDef6EDS4fkeGc61/wzZNemlcROhYCOzlOIiq8BpSfPuyX5uQtVF0KHe7c1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297178; c=relaxed/simple;
	bh=K8DUo9/YVURt0CuPVEJiGTxai1bzGGIZp7s3Bv/Jsp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NZ3EzoSRio9yuzx2Ucb13grMWvib+vlAx1O6LvcrEvBnH0l9m8PmaLM8DvoRbzzkFAE+8U2QINjBak0hX5y858h7MMZaJiBWFRFcDmMCXJ9sPrZkn0lr+VcjJ/CgjzQEaJ+YIQeej3zgcne4ny4ydgrsE/qrnbw2LBfJAbfkVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THoDMW7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC59C4CEE7;
	Thu, 19 Jun 2025 01:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750297178;
	bh=K8DUo9/YVURt0CuPVEJiGTxai1bzGGIZp7s3Bv/Jsp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=THoDMW7dBQ7ZbKXALhVbMpagP06mJQxj3tByiVTplZ7LjA3YhZqcqPMc3cziCfiIm
	 Z/mfsKMG7egSSVpZhbQsV4obSufTGYMmtvpwHGSyJ8XtK19XrNgrf1AcKkWoDwHbuj
	 nqUAcNTp4iK/8hK7DyqDshhhuya/7KxTAHiGrBIkoHT5w/15sXrfkqUtc8Vtlz7D/Q
	 57y19hb58STAOWSZUL9ApamNAvq1V46pLAsuEEEwOEI4/33/iF2SGLsSRCL1INtE6g
	 01UsSkENpFNxzi+Azc0b4euwBQxk/VZGI1ut+ppKvgqtgSl8tBdybx0UJuuN8dyfsm
	 UJ2OY1W46Kmcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF5D3806649;
	Thu, 19 Jun 2025 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: Remove inet_hashinfo2_free_mod()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175029720650.316257.6338936263736649985.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 01:40:06 +0000
References: <20250617130613.498659-1-yuehaibing@huawei.com>
In-Reply-To: <20250617130613.498659-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 21:06:13 +0800 you wrote:
> DCCP was removed, inet_hashinfo2_free_mod() is unused now.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/inet_hashtables.h | 6 ------
>  1 file changed, 6 deletions(-)

Here is the summary with links:
  - [net-next] tcp: Remove inet_hashinfo2_free_mod()
    https://git.kernel.org/netdev/net-next/c/a33556940b57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




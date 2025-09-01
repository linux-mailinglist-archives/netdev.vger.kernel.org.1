Return-Path: <netdev+bounces-218894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BCDB3EF88
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD92C20EC
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602527FD56;
	Mon,  1 Sep 2025 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTjx7sdH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171427FD51
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758020; cv=none; b=EBEgUjIvhZpaKLhfd9b4EKMDKsqh1ngRDD3SsaaAiiOCuZLeKvWjRHBixCw/vuPTKsElRVrmTne9IXqh7LEM8dLj4dwRLRfWsomTVeO7l12McaeJ7TXKzZChAKTYtWKQCM9kBW5+qTM0Vkf0A8hYvxR7kkkDQD14PdE/2uVhmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758020; c=relaxed/simple;
	bh=b+CTfrXwA9iq3oHu9AuIj6WOquP0sdHtMd5L2jfSAxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lH80YwOEGfbTC/i7A+GVqBsgksSrSE18rseZZypepZ781Dt2O2pMnloRpAgZMcf3yGCwh5JtVqLoxJreaHmbCaDByAmNTu4IQNmeBZ8cbJwVtmV4rw/5NmG8nXKykaVzlwIAkYxdV1e7xG66He2/Xh35NZTvUU1sUR9vmrDXuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTjx7sdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B526DC4CEF0;
	Mon,  1 Sep 2025 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758016;
	bh=b+CTfrXwA9iq3oHu9AuIj6WOquP0sdHtMd5L2jfSAxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZTjx7sdHI81a8UjX9R+dyR6cLXTuRipnmdXqZLRnYgq5n/o6cZQRUp5kvQ5PDk5Aw
	 vwbibTrTJRszJiAAAPJiRB9WW1Fb/6zInJGWg7QfVnhvHZX8nVJWpmKnAVopTGAzEs
	 5i/OapC15ltlCkg/yFtueqAg5cZdZdGWmp43mfSXHpLSz2HjBXxSYgNyvUT3AecRdl
	 TtBpreoRMIybgEFrtIhCSyhU4VoTaAjammkp1ZyzBe43zoxyzT+whiMaZPP+y2/caS
	 MawuCsPYyjlGRDPB1g4n84SHxUrYzsS3KAsDQIZkGCxXK4No8Wfih6tfObJf6Bt0Bt
	 Vi8dWHYLKBPhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB7383BF4E;
	Mon,  1 Sep 2025 20:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: mdio: update runtime PM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675802230.3872744.15747918532068269574.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:20:22 +0000
References: <E1urv09-00000000gJ1-3SxO@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1urv09-00000000gJ1-3SxO@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 10:02:29 +0100 you wrote:
> Commit 3c7826d0b106 ("net: stmmac: Separate C22 and C45 transactions
> for xgmac") missed a change that happened in commit e2d0acd40c87
> ("net: stmmac: using pm_runtime_resume_and_get instead of
> pm_runtime_get_sync").
> 
> Update the two clause 45 functions that didn't get switched to
> pm_runtime_resume_and_get().
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: mdio: update runtime PM
    https://git.kernel.org/netdev/net-next/c/ec0b1eeece28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




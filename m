Return-Path: <netdev+bounces-247520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB325CFB858
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06E36301050F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553C1E991B;
	Wed,  7 Jan 2026 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXzjhInh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1422147FB;
	Wed,  7 Jan 2026 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747815; cv=none; b=PJSjCxmXCZyZ4jY3XdFjK6r1siZ+ZezDeVKpbTKRK6zYJ1u/x8JdoLMkX/alKjxfOBod5iCISoXQvJ0Sjjmm7gus8Tf+VlM2NyxZgdEZz4qfgTNB7KlruquU13FCn8sXw9w7+sPMMNFrBgIB76bdjigo/yHE1sJMmdTi1/B/X4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747815; c=relaxed/simple;
	bh=fB75dTb2rJdv4IMaDFCrlOkgbI4r3UMH/ps0voROwWc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=po1Ex7IWgdy5GNpwWjAmM7tdIqNxMX/8wyfeh/RMjg5kudnCYwlejY2NC6Nvb6+hcyzbvBVsTsbHiBIZ2q1/svm+5BfYeolrVvSN6cw8SCHcvSsI2J+lcFBsJeXKGtyY37e3gJydwaG1mkDUjzvZ6gF9iNttr7ip1bI5WFVXhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXzjhInh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28ADC116C6;
	Wed,  7 Jan 2026 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767747815;
	bh=fB75dTb2rJdv4IMaDFCrlOkgbI4r3UMH/ps0voROwWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bXzjhInhjTu3N/dOZdDNhefemw5H4obSOoMFjkT/9tw48/67zDzyi/h02so2onnZZ
	 rjU3RNhmDjyO2XF15cz1Rq/ZSUScEU4yCO3hXD2j42ol5QF8Qs5bBfcsOoe9UsifLY
	 +ZkP7dD380HjtltHs+S+L2ghR54tOqlh8X/i5B24L22woQ9W5z7W3k8dYx2nAN5pPi
	 BamRnuLF+2Eco2Rb9Vax+knHaEi5zzC9MU0UPI3qA3KBlV9iAUmOoKElqG9MAa3eYe
	 7x6cnxChlJv/3jJKfs3xgwsrxJaMuI3C6L2nzXx8vOGpyiDvh2qwwv8dH3HH+xc2Ew
	 6DrxbUzL0Lfcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58DF380CEF5;
	Wed,  7 Jan 2026 01:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v4] net: wwan: mhi: Add network support for Foxconn
 T99W760
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774761228.2183630.14768387465308579538.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:00:12 +0000
References: <20260105022646.10630-1-slark_xiao@163.com>
In-Reply-To: <20260105022646.10630-1-slark_xiao@163.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 10:26:46 +0800 you wrote:
> T99W760 is designed based on Qualcomm SDX35 chip. It use similar
> architecture with SDX72/SDX75 chip. So we need to assign initial
> link id for this device to make sure network available.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: Add changes into same serials with MHI changes
> v3: Fix missing serial info
> v4: Rebase code and separate out wwan changes from previous
>     serials since MHI side has been applied
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: wwan: mhi: Add network support for Foxconn T99W760
    https://git.kernel.org/netdev/net-next/c/915a5f60ad94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




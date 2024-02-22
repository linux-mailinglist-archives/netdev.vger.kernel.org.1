Return-Path: <netdev+bounces-73859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85A85EE92
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A19D2842B3
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F438125A9;
	Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdVb/9Wc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC851173F
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564829; cv=none; b=CWRo7YAIt3zsHQwvp3Lif/BT8xYpl2I2+k+W5GaOkg7rZu7KLDSceYjdIxQ5EpaDx8kevl9h/U9ZnEejR2BMI7hL5qx5BTyI/5z8G8sRCBzGnzR4YAl3RHyvghn4vecSz64zok5n2A4lCqKroaPikZCEn03NOuga8BrxsCQoQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564829; c=relaxed/simple;
	bh=8wE7LSzSUzn3cp9Xg12UtGywrPGB+Nkpsbgk+oPArVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MN2UvAHIxypEnnhRN24eWP8svibUIn9GjHHyaJL0B93yqVmc18rLrVi4P7kDYdgQElo4vkIg4oa7yLeLnrcP29bRHkxtzlefnb6bE61hGX6YpDMUo8bl21MarILaAfoOxEDzR0Kolp2T4wP/90lN3wUYZhYvT6GKm5FnDMhXIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdVb/9Wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4A9FC43399;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708564828;
	bh=8wE7LSzSUzn3cp9Xg12UtGywrPGB+Nkpsbgk+oPArVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IdVb/9WcSY4lwLdC6Wv82xzQiLLh6qlFpc2+2cbo5NBE0ZhF5eA7tGeum5PadsDG2
	 ZbdQBraCG02x/HWDF55/KHz+gLRTDprn0mrNh1kGPTuv2+wLX8AH1lc7bOIWUP4v5m
	 AtId+M0/XPtFkTcth01Cgrrb5sLfi3JUaQVB3fewtdSPFv2GYyhnvSNpkMN8ahVBvG
	 Ppr0KMWnHGoBqi8WAibOEOI1mcNW+BcA4mlkmn1nFploEu2KSs0aUyS8RJFYInHLiH
	 +C0Sr7HZ2X0x7XmO937bBIOo40Y/3abGVST8HB7yq4TOECF3i4mzimdCNRJPuBGpOI
	 YiJofRxh/2wSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E833D84BC0;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: Fix EST offset for dwmac 5.10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170856482864.21333.14662830246754937684.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 01:20:28 +0000
References: <20240220-stmmac_est-v1-1-c41f9ae2e7b7@linutronix.de>
In-Reply-To: <20240220-stmmac_est-v1-1-c41f9ae2e7b7@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, andriy.shevchenko@linux.intel.com,
 rohan.g.thomas@intel.com, bigeasy@linutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 09:22:46 +0100 you wrote:
> Fix EST offset for dwmac 5.10.
> 
> Currently configuring Qbv doesn't work as expected. The schedule is
> configured, but never confirmed:
> 
> |[  128.250219] imx-dwmac 428a0000.ethernet eth1: configured EST
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: Fix EST offset for dwmac 5.10
    https://git.kernel.org/netdev/net/c/90d07e36d400

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




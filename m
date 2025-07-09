Return-Path: <netdev+bounces-205213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869FDAFDCF1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3221895566
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C118CC1D;
	Wed,  9 Jul 2025 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBxye0uM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3B1898F8
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024590; cv=none; b=gqKBjU+SsU41rLOg7FMid5G5reGyepNHOMr6pidSYqdPSq8wAn05e0bX0/g9waKKZD3poIPR0DqVZUOH0q8Mb2IWKXOGvyxsL2oOMFD4MIlawipJc07DkxTy5TKuntFfFBCfCQ/8D1GcPRxJEmZLTBEccfnI6Dj75Ngbxhr9lIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024590; c=relaxed/simple;
	bh=7dXDS5QBly9oO2sE1NM/JgPZtBGwsyEdMtJpZ+LZ7Tk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FsqHyAV/bYf0pTgycz16+WmKNkxk7ILuCk7OQ3knKc4Cr6Y+SF1XUOG+WSA5w06EFlAAd2zTisoNpFNtri5gGLyOvu8zIJrfRDVld7q+iZnEv5CfT61fkdxc4eEA81JIcK625z/KGftiClO8Zk7+hgUahV//nuTHevnDH0dB8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBxye0uM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E03C4CEED;
	Wed,  9 Jul 2025 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752024590;
	bh=7dXDS5QBly9oO2sE1NM/JgPZtBGwsyEdMtJpZ+LZ7Tk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hBxye0uMCrEUrTeWl/Qf/7v1u4kA0MVIgjCW4N8ffwujCLYS1JwAbATanCZtksnVH
	 ZW4QoF0m/I0TgKgFAqUz4gPFy2KEg3SwR6G38x/dCDa4qHhO29SB2jZ4Vi3EPdTGR9
	 ypdy370jSOrKTuTrHl6CkLehzNHQUqmevR5VgDD/yyaR0EPHamkM4UOAP71RtpijlD
	 4xZmxtKHhIR1g/y89Gq61JU4/Rh9qFDQgekmBdkznEVKu7fn6d2p5krt4EaAfUYT99
	 PbUfUfcHbdZUdLIC9u7t/+Uvqh9wEzB7wvHnq2LmKeCahh0IW52prFYf42kPnmRCHN
	 8GPS8n4NsR49Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71845380DBEE;
	Wed,  9 Jul 2025 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: stmmac: Fix interrupt handling for
 level-triggered
 mode in DWC_XGMAC2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202461300.186229.18400851039185559146.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 01:30:13 +0000
References: <20250703020449.105730-1-chenchuangyu@xiaomi.com>
In-Reply-To: <20250703020449.105730-1-chenchuangyu@xiaomi.com>
To: EricChan <chenchuangyu@xiaomi.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, fancer.lancer@gmail.com,
 guyinggang@loongson.cn, chenhuacai@kernel.org, si.yanteng@linux.dev,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, xiaojianfeng1@xiaomi.com,
 xiongliang@xiaomi.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Jul 2025 10:04:49 +0800 you wrote:
> According to the Synopsys Controller IP XGMAC-10G Ethernet MAC Databook
> v3.30a (section 2.7.2), when the INTM bit in the DMA_Mode register is set
> to 2, the sbd_perch_tx_intr_o[] and sbd_perch_rx_intr_o[] signals operate
> in level-triggered mode. However, in this configuration, the DMA does not
> assert the XGMAC_NIS status bit for Rx or Tx interrupt events.
> 
> This creates a functional regression where the condition
> if (likely(intr_status & XGMAC_NIS)) in dwxgmac2_dma_interrupt() will
> never evaluate to true, preventing proper interrupt handling for
> level-triggered mode. The hardware specification explicitly states that
> "The DMA does not assert the NIS status bit for the Rx or Tx interrupt
> events" (Synopsys DWC_XGMAC2 Databook v3.30a, sec. 2.7.2).
> 
> [...]

Here is the summary with links:
  - [v2] net: stmmac: Fix interrupt handling for level-triggered mode in DWC_XGMAC2
    https://git.kernel.org/netdev/net/c/78b7920a0335

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




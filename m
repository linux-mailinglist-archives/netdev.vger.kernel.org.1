Return-Path: <netdev+bounces-49495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C537B7F2362
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708F31F250D6
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1532610A1D;
	Tue, 21 Nov 2023 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxaAsi5j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C08C8C6;
	Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 575ECC433C9;
	Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700532025;
	bh=bmnu7rZL78TcXp+dlQU9LKtmJm149s70Jq6+OiDF0nI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CxaAsi5juaQkib6IE5gMbNX5bN/n5Gd+wlEli9sqWni7EPK/f/7FXg5ef4iZo7YiF
	 FsO0m8370nsh1FFxLDGV6/hnJSqr/4bQySUs+xiFxQbXRiapcKu1rtI+xdLtV73+yL
	 y/84IPcGJX8QZrOcdHpvUBaD52DUYACBi1t+uPXbwJMpaBGXOkyJRShmbirbPacs4I
	 hTFDFD1N3SzD/HRVo6ENnmif2sHfrfVbE6de2CplNpgpgxkNO38DGg2bRLgcfMcfNm
	 +6J0gOcy2S2jA5Ri2iwFYdIkb4N7Xmx1mUgp7+0laFPJV+7CBa9iwEqNm+88ZlvrYY
	 RkcITKnFqSVhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 399EDEAA957;
	Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/3] net: axienet: Introduce dmaengine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170053202523.14605.14081014495866819607.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 02:00:25 +0000
References: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, michal.simek@amd.com, linux@armlinux.org.uk,
 anirudha.sarangi@amd.com, harini.katakam@amd.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Nov 2023 00:26:50 +0530 you wrote:
> The axiethernet driver can use the dmaengine framework to communicate
> with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
> this dmaengine adoption is to reuse the in-kernel xilinx dma engine
> driver[1] and remove redundant dma programming sequence[2] from the
> ethernet driver. This simplifies the ethernet driver and also makes
> it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
> without any modification.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/3] dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
    https://git.kernel.org/netdev/net-next/c/5e63c5ef7a99
  - [net-next,v9,2/3] net: axienet: Preparatory changes for dmaengine support
    https://git.kernel.org/netdev/net-next/c/6b1b40f704fc
  - [net-next,v9,3/3] net: axienet: Introduce dmaengine support
    https://git.kernel.org/netdev/net-next/c/6a91b846af85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




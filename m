Return-Path: <netdev+bounces-136516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD09A1F81
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A4286262
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE7E1D9A43;
	Thu, 17 Oct 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTN0+hZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D21D9677;
	Thu, 17 Oct 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159825; cv=none; b=ZCU/XGc/ull83kYoD7XjUJBsxNSBCJ77fecMmaln/IHP8EPfmXQLQPhlmBd1dfQUZpWt5IWNKCl+O4z2akzNNmB+dfotQGJTtsAh8NWJv4wRNyLjfu21CNUIIgauDT4+gIyi7siOsZvb2OKLwBWJzVzChUQr/mgQEsUpVnqnPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159825; c=relaxed/simple;
	bh=qK9if0V62/LzQWBlKRcpC6PM3ji6S+P+acYeI9Zd+NQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqBYDv3kYV+WyJqb4L7CAIIWt97YgeNkr8aue+ldxAU/z7PAZO9r3Kp1z7aUFufI5MFoTLXaqrtVRANx5ggwUOc31X09LIQC1HZn8mixF03H/71lU9VQBkxUMiLptpWc6bwSylUJoT68jMvNL35Uu3e7xxZYMfN+ZZ8G/XYpJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTN0+hZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6080C4CEC3;
	Thu, 17 Oct 2024 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729159824;
	bh=qK9if0V62/LzQWBlKRcpC6PM3ji6S+P+acYeI9Zd+NQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HTN0+hZMAlW8S/EK0ddqXSUNYFqS6jkagxKBaGkgWkORYq4wAIKDNFokgX3kw2pAh
	 vRuu7QhDyDsdm1VfsbzFz+fTR3bh/zLIe8eD8lvF2GonjujhYEgY48KKRK1wFdH197
	 oeaatIKnXIdslu8lzCT0qtmKOVmVBkEEHeWQv2QcKCF2sKMKIM0G5xgZFMoqDRbld1
	 Xund5j1ZE1QwhX2R5HPI47tcYPjWdARJtTNsi0zFvVXhw6h+/QL5SlBsjK/+sUpWa6
	 LrwMl5rtHRqs5stcTO8DxIlkhbZu50KZT4SuRz+n95VjvSm4kqDuq5oNbMuqVqodpD
	 BMF3NdiYBet9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C123805CC0;
	Thu, 17 Oct 2024 10:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix memory corruption during
 fq dma init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172915983028.2422040.9005274302836584755.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 10:10:30 +0000
References: <20241015081755.31060-1-nbd@nbd.name>
In-Reply-To: <20241015081755.31060-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 frank-w@public-files.de, jacob.e.keller@intel.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 10:17:55 +0200 you wrote:
> The loop responsible for allocating up to MTK_FQ_DMA_LENGTH buffers must
> only touch as many descriptors, otherwise it ends up corrupting unrelated
> memory. Fix the loop iteration count accordingly.
> 
> Fixes: c57e55819443 ("net: ethernet: mtk_eth_soc: handle dma buffer size soc specific")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: fix memory corruption during fq dma init
    https://git.kernel.org/netdev/net/c/88806efc034a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




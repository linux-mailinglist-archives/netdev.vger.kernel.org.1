Return-Path: <netdev+bounces-186579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27872A9FCF9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5971A87AC9
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3620F062;
	Mon, 28 Apr 2025 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuUYy4aU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6015ECD7;
	Mon, 28 Apr 2025 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878790; cv=none; b=bUXJVUpbi5yeuQ23/BMSlLONSaRSbuDEqDczwxJ06knLMMzs69ng8onFp5Ltyn3u8yJ6PnM4ZHr4Pk5ZR9Dcvh1Wvy/CjBTLpz7yzanJ22lclznN/6PDWWVod5i71fzW+5LnolEFWDaTbOpLrwF7nqPB3guFbZfXqmUtUFpoUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878790; c=relaxed/simple;
	bh=TxMhwn7cp9w0K/g0g69tL17XWFr1iuc73PU8ZOzh1vs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i8UH86/Q7Zfsix6Y9SGjzlQ+YJha7InofryXAdNsv9bHooPgJSu3zUahu1y0sH6tOrpWoAG1a6xyDmcEmADPhyLlDojCgn9CeFK4Hq4WtSfkjflhuSuodAJByFwee7b9UhMoutgzPMuYc9F1Lr1upmgfczbvm86ZptlUo77sK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuUYy4aU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0BCC4CEEA;
	Mon, 28 Apr 2025 22:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745878790;
	bh=TxMhwn7cp9w0K/g0g69tL17XWFr1iuc73PU8ZOzh1vs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NuUYy4aUE66I9IE1M+lRnbwMpt9VnTfcHul8i50csGbSqZIItacXLie/5/FuW7l8H
	 lVelmmXsW6zLylokc7yopTAOcuwuVohTWMpvkimOZ8WuSuJbJx6HshS0pcDcpEjqXD
	 94DxjoY3puWJujUcwPseP/5KjGEPzHasoSoZ/sSfMdnN/ePROntkvqRd5FPAVMf/nc
	 T18fhnOyG1V2cEFsk+VQPrDDOKp211bMvx5qgiblD1qcAQTFTdRMF12+NSTjJLjMHI
	 44PnWlfeOcAv+uqj2wXUTlFeCvvzK+CB2lj1reQk9C01HHdus7pCYNbRVVwjzj2qiQ
	 XEkkAMMYGF91A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D213822D43;
	Mon, 28 Apr 2025 22:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: sync mtk_clks_source_name
 array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174587882900.1063939.12238416302643279123.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 22:20:29 +0000
References: <d075e706ff1cebc07f9ec666736d0b32782fd487.1745555321.git.daniel@makrotopia.org>
In-Reply-To: <d075e706ff1cebc07f9ec666736d0b32782fd487.1745555321.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 05:29:53 +0100 you wrote:
> When removing the clock bits for clocks which aren't used by the
> Ethernet driver their names should also have been removed from the
> mtk_clks_source_name array.
> 
> Remove them now as enum mtk_clks_map needs to match the
> mtk_clks_source_name array so the driver can make sure that all required
> clocks are present and correctly name missing clocks.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: sync mtk_clks_source_name array
    https://git.kernel.org/netdev/net/c/8c47d5753a11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




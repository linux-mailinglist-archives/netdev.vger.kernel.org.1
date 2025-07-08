Return-Path: <netdev+bounces-204774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD1AFC086
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FAD4A39E9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABBA21D5BB;
	Tue,  8 Jul 2025 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP6Ty18x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323221D5A9;
	Tue,  8 Jul 2025 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940620; cv=none; b=ORI0t5iJqkfvTXayQ5d972f6mJhjc8w4Fl8SbhtHPtQgU2BT448gEKWjrFsVG+A8rZGgf9j52TuDi9/pIlnqZq57ahV7XZTvM3pOGX5WXPgm7FWkhAKXYiaHvMxkZEqCMeTelSXDHKjCczRlWZYrEtNjCU7ogBaIlv96ClMQkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940620; c=relaxed/simple;
	bh=bXK8Vbo1zdACd3ZW/ULDyQH1f9e6jRdr9Mb4rY6CHgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pi7cO06PIdAGxbgG+Qu+B36GGOr22yCVT6AX2xEaxTjr7xsH/u4woYh24/KPgDe/IVhzxzEQx49jW7w0Dl7LVHrieZ5CEcVyHvdJTVlN2k9NZjS9WkA6OsFjBu9sDRTcCeITJhmdnD5JzjmF76JiVFbHaQuQT9TvQkCniyZJxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP6Ty18x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC5AC4CEE3;
	Tue,  8 Jul 2025 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940620;
	bh=bXK8Vbo1zdACd3ZW/ULDyQH1f9e6jRdr9Mb4rY6CHgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UP6Ty18x4RGP9fOidquag4eQonfL5u8sVJ5F2600jcB8s+SSm/b0FHOx8Wi1VMdBI
	 L+Hsf5CpZjkE5Eh23vxkt8oUtL4zvvX2nsDEh0bAbmIetQBIG14XNd5CJpaUW52zkQ
	 uAnaeONVQKyHe13oWoFDvYYD2P9g1xgRPLukxQ9rR6fnzNn0N24aQ0o2SdgOO7OcCw
	 kBiS+ljohGllM9rftHfO8D8m/VFMlXAbk8QObNFQ/20l7JRGChMR9McKxoOsPCPuXr
	 8y3j/vj/bQZzq/OuF4e+tvckWjPn+CdD/38vb38gC0TFaFiARTIeZFpksM3lYZcdlx
	 9PCWqFANoCxww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3402A38111DD;
	Tue,  8 Jul 2025 02:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] net: ethernet: mtk_eth_soc: improve
 device
 tree handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194064274.3543842.9948316724629188569.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:10:42 +0000
References: <cover.1751461762.git.daniel@makrotopia.org>
In-Reply-To: <cover.1751461762.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, frank-w@public-files.de, ericwouds@gmail.com,
 eladwf@gmail.com, bc-bocun.chen@mediatek.com, skylake.huang@mediatek.com,
 sean.wang@mediatek.com, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Jul 2025 14:14:20 +0100 you wrote:
> This series further improves the mtk_eth_soc driver in preparation to
> complete upstream support for the MediaTek MT7988 SoC family.
> 
> Frank Wunderlich's previous attempt to have the ethernet node included
> in mt7988a.dtsi and cover support for MT7988 in the device tree bindings
> was criticized for the way mtk_eth_soc references SRAM in device tree[1].
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: ethernet: mtk_eth_soc: improve support for named interrupts
    https://git.kernel.org/netdev/net-next/c/e81d36d48880
  - [net-next,v5,2/3] net: ethernet: mtk_eth_soc: fix kernel-doc comment
    https://git.kernel.org/netdev/net-next/c/d717d32f517f
  - [net-next,v5,3/3] net: ethernet: mtk_eth_soc: use generic allocator for SRAM
    https://git.kernel.org/netdev/net-next/c/04c7aaccdcf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




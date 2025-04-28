Return-Path: <netdev+bounces-186567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576BEA9FC01
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E7C1A87945
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257FA212D9E;
	Mon, 28 Apr 2025 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HubL+k3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4081EB5DA;
	Mon, 28 Apr 2025 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874599; cv=none; b=h05GUPssSy1S6R8rmlrFzlsJ+WW0oCKbXx/g1fvSNixF7jf+hJp6HHJT1FpYBAzNQU4kAgJzql5j2jIsg2OIo73472oxVtt0maMlIyoG8wP857mT000pGD0Q+g6spVL+WxvBYtnMEZFhxAesVZQNRrFaw57FPOocMc5zSMFCG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874599; c=relaxed/simple;
	bh=Pi2yQYBdc6hU9/vt/IT9BpJTIquxO2vFToRhiSbnuF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E1/pPE2TicGfpXz12iPtFpDDBfzUFIn+vXd5SvALuZl4gTItPCWdRMrM+Xtdh+k/d/aeY3xSA7n7g+ayoxRnRtpo4fR3i4SADn0A2QadOsVMglo14xbYubEYyASHHecocyQT0Rhh/30jghcre+/BkRigbmGbwohWBTeuhRoqH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HubL+k3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BE7C4CEE4;
	Mon, 28 Apr 2025 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745874598;
	bh=Pi2yQYBdc6hU9/vt/IT9BpJTIquxO2vFToRhiSbnuF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HubL+k3q7ykyTdAA0ITRlYnSdHU4VApB9AL6ch5oBD2fodKWWk7rVScQnOaHx5GMO
	 jetbvzhGY9LOC0tBP2p27Adltk+E6zddrwl2DYjELRclglE+mlRlsMdkcL07IaKa1V
	 mx0bqSqo8NIprYwHpUTY/pojELjJkBZuaNuNzE11KA1M0xUpbxN7c5qGxw9ozVDp+I
	 jQKc6T0b3xwg32AbHyrXST8hheZzBG1Dg7U8eoMEbvYRlm+pGTzv8tsmJbaRPOsarS
	 RF4Gyqzq7VahGSDErgp+zPR2m/y+tt8ydqkOvJxBzAQNBn9N3bgwUzP5mtsiPXSda8
	 M2BxUOQ2fLQMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9F3822D43;
	Mon, 28 Apr 2025 21:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/3] net: stmmac: dwmac-loongson: Add
 Loongson-2K3000 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174587463698.1046038.16843919205334954022.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 21:10:36 +0000
References: <20250424072209.3134762-1-chenhuacai@loongson.cn>
In-Reply-To: <20250424072209.3134762-1-chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: chenhuacai@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 si.yanteng@linux.dev, chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dongbiao@loongson.cn,
 zhangbaoqi@loongson.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 15:22:06 +0800 you wrote:
> This series add stmmac driver support for Loongson-2K3000/Loongson-3B6000M,
> which introduces a new CORE ID (0x12) and a new PCI device ID (0x7a23). The
> new core reduces channel numbers from 8 to 4, but checksum is supported for
> all channels.
> 
> V1 -> V2:
> 1. Use correct coding style.
> 2. Add Tested-by and Reviewed-by.
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/3] net: stmmac: dwmac-loongson: Move queue number init to common function
    (no matching commit)
  - [net-next,V3,2/3] net: stmmac: dwmac-loongson: Add new multi-chan IP core support
    https://git.kernel.org/netdev/net-next/c/2725fc2e0b61
  - [net-next,V3,3/3] net: stmmac: dwmac-loongson: Add new GMAC's PCI device ID support
    https://git.kernel.org/netdev/net-next/c/ef1179f78119

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




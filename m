Return-Path: <netdev+bounces-188330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6788AAC347
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D7C3B085F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE427CCD7;
	Tue,  6 May 2025 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7L5EbSz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009127CB31;
	Tue,  6 May 2025 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532795; cv=none; b=eCcZQdIjHPZBnLBL5oBT8KVEr+ozZSkxPn7CXLcK5CxH0VW0RrpEXXbveyL7jfmhrbrRWsorsrWYx09sgM67mSLyjxjFsonSFy0aUyOR5XMcYnQ6tARokdsn4BnmuatI6JpxWgxDaCBYF5G9ige/WHQtjaAz35b3SV5LJkXNo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532795; c=relaxed/simple;
	bh=7Sg/XeS6j36e1f9i8iczSP4VRhrz2+oSrIEypk8cmQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rdlXK3dSKLgRenFB2uHEGWZflj4PAgYHX6sPYIXvmz6iUHnfZo0hhM+VUIkiBdJYK2dboZJcrJWhiyVmcN08t98SNJJ0wfJ6lxW1cnADz4A/Xgz+Qx5NwzkFIbaPtuMmAV/RcVt+oehCnsPxw3jbV1s8GMICAQWKK6uPKlePOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7L5EbSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4C6C4CEE4;
	Tue,  6 May 2025 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746532795;
	bh=7Sg/XeS6j36e1f9i8iczSP4VRhrz2+oSrIEypk8cmQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p7L5EbSz9jf4lgXejuBDmiHsIB8vp2yrK00DAaLNIfQzP3YUtZLKpLTAaKBy1QoNL
	 DVzKr9nJsY+/7E9ibfhlKaXo/FRxqU6XQIPOnhY+gUdksQkRjw2hnyQZ10AleXI+LW
	 1hz5vBWeetFITqYFZaP8cz1q/1uynNJKPiSNzPaKVCLWjcQ569G1AyIGhSd4McjWWC
	 gNvgvWqAReYkUWfmZY8Lh2WrXIsNsG0GJJmgsHuPV24p0vf4Zt8WMsPlnYApSti+mK
	 zimRmcP5z+xAmwjiu2gckR9w/qYJ0J9/DZs3JojQrMn8wAYRTveWq5gZYuiMC0+8/L
	 LFkdteZ2LTMAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB9380CFD7;
	Tue,  6 May 2025 12:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net: ethernet: mtk_eth_soc: reset all TX queues
 on DMA free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174653283451.1493761.12837257504091062082.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 12:00:34 +0000
References: <c9ff9adceac4f152239a0f65c397f13547639175.1746406763.git.daniel@makrotopia.org>
In-Reply-To: <c9ff9adceac4f152239a0f65c397f13547639175.1746406763.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, eladwf@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 5 May 2025 02:07:32 +0100 you wrote:
> The purpose of resetting the TX queue is to reset the byte and packet
> count as well as to clear the software flow control XOFF bit.
> 
> MediaTek developers pointed out that netdev_reset_queue would only
> resets queue 0 of the network device.
> 
> Queues that are not reset may cause unexpected issues.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: ethernet: mtk_eth_soc: reset all TX queues on DMA free
    https://git.kernel.org/netdev/net/c/4db6c75124d8
  - [net,v2,2/2] net: ethernet: mtk_eth_soc: do not reset PSE when setting FE
    https://git.kernel.org/netdev/net/c/e8716b5b0dff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




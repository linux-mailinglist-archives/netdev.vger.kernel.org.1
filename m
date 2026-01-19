Return-Path: <netdev+bounces-251125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A0D3ABEC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4159E3032EC8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C65387579;
	Mon, 19 Jan 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWo/1Rst"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21604387570;
	Mon, 19 Jan 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832579; cv=none; b=AkGWfgJeTXTCZobXfAuB4egDIfpg+U5HLH4srISSAjRdASIyXljCF2BhSTrUkriAdcTisU0R5/OLhUctmV8QrZb2NUKbbXLgljtBXiWzx6ZY83KuoHLITApyM2eDbU160q1uLrksXJZXb7OkHcCxUks206blZzGmzX6p2Er0isQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832579; c=relaxed/simple;
	bh=fiqL2210uT1qUhHAJ17YtkjmIE+maRxzVtmI/uPQI3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fMiDgTdYenpItsSltH6b7dt4vOdCFjCKHLrZISramke7rG97JSP82K4oShv9FDTa/tWyMp0eS07KukCtWtJIkZgocz8xKCb1upVuae2nsNscWYMe+4nWnY/l3EnO5JMsCYRkchS6Q03agh+fXnUmQ7+Vq3GxL3TmeHNw7Abps1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWo/1Rst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27D3C19423;
	Mon, 19 Jan 2026 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832579;
	bh=fiqL2210uT1qUhHAJ17YtkjmIE+maRxzVtmI/uPQI3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oWo/1RstEV3QGFIHLofwpXfSlzA18z/g+p0TFR6bZeSqWafgyI9QJKAvTvVUlVMCd
	 +SqHpeYukNxFS1oR0pv8Z2vk6oNlxkQJ3KRSsVrlRR9ASslMvw82/G6E10pim7A1OP
	 acLPnWHbo8jSQjKRrOgUyxQztN+XC6UVMMOhCUpN8tljKtDyxeb1+1gE/xO04Cjf4g
	 dSp9cLkVihm9sTBCU7upA6tXsa+5iwB47ZqOn34XEDXTirYbSigxo3A8pRQB28KMW/
	 se1nrHUJ7FubjkzSG3vdfm7/vg0PQmaS6AQJyUtJ6Ytat9QB5w5WdDO6KYLG7aDmKj
	 rPW4sOwcKr7Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29BD3A55FAF;
	Mon, 19 Jan 2026 14:19:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: convert drivers to .get_rx_ring_count
 (part 2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883236852.1426077.755495066523870761.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:19:28 +0000
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
In-Reply-To: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name,
 sean.wang@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, shayagr@amazon.com,
 akiyano@amazon.com, darinzon@amazon.com, saeedb@amazon.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 Shyam-sundar.S-k@amd.com, Raju.Rangoju@amd.com, bharat@chelsio.com,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jan 2026 06:37:47 -0800 you wrote:
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
> 
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: benet: convert to use .get_rx_ring_count
    (no matching commit)
  - [net-next,2/9] net: tsnep: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/efa375c44090
  - [net-next,3/9] net: mediatek: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/e33bd8dd7f1f
  - [net-next,4/9] net: ena: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/289f714a084c
  - [net-next,5/9] net: lan743x: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/05ba3044865d
  - [net-next,6/9] net: xgbe: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/507353bf84fc
  - [net-next,7/9] net: cxgb4: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/ceec168d03db
  - [net-next,8/9] net: macb: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/d1c7ed5dfa35
  - [net-next,9/9] net: txgbe: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/c4279332f479

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-200475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37470AE5911
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5813AC109
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733941D86DC;
	Tue, 24 Jun 2025 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbApFGTx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC71C84DF;
	Tue, 24 Jun 2025 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750727985; cv=none; b=uSxKo+osAfDmQV9/+C3hSPZEWvNJPnu7e0pySoVkRfj9x5YKgecPPhBGNWimq8SrmncRdddY90+xi04vrI6OkD8iqOIwsebiJQKoJtFSwBLoyGS34ZKqRihswVtVaCbrMQG5E5QWAiICuVjqRxSwFLecM/+a8w7/rhZm6w+4Wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750727985; c=relaxed/simple;
	bh=i8HmAnFDktLAN6p9Nv9fj36EDKY0uQqypdcdnsV1cUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K76xKHZxvjxz2Uvp8m4sOUjtTKw9lG60T7QTKkWdo+8Iv/LI4Y06aTiMgMsS2uIce+FFiqdpB/dsfVN2QuRrqpJsasTvSmSCVXSfWjewiGofivDf+1HoUHsc64HxXSIZxO13IKc37MRCMIyY3w8/S00s4Ln2IDKBn7I8dRrA00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbApFGTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4619C4CEF3;
	Tue, 24 Jun 2025 01:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750727984;
	bh=i8HmAnFDktLAN6p9Nv9fj36EDKY0uQqypdcdnsV1cUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qbApFGTxhNc7UDhHKJ6J3UJL7OJd4o9QzP04wE6FkvuMWVkHWcMPGiR4XeEhNt/jt
	 Hm7XfNrXcBTbOyvml0OjsO7A5senyOlKulf7qbDc0gGriU7VfqDi6IWwa2LpHL4yzP
	 eK99+RUI+1DmZhKSI8BvenGL+bVwY1Y8WkBSTih7Lsqtu2ADfL7JHkXQtoi3FsH24Z
	 1291NiwRQsGbpvbC2yBqJUZXUhCrq/vlj75dbhjJkwFMqZNViC4BhQdrTYnBymlQbU
	 JOmCCL1QYq132gIQfwfOiakDt4uED1sNUxCjXIbdKRY2PKwdZJJvx+nKnERCTYwunC
	 oPtTLXkOyNigQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBE5239FEB7D;
	Tue, 24 Jun 2025 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v6 0/4] rework IRQ handling in mtk_eth_soc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072801175.3355543.2001178239431704817.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 01:20:11 +0000
References: <20250619132125.78368-1-linux@fw-web.de>
In-Reply-To: <20250619132125.78368-1-linux@fw-web.de>
To: Frank Wunderlich <linux@fw-web.de>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, frank-w@public-files.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 horms@kernel.org, daniel@makrotopia.org, arinc.unal@arinc9.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 15:21:20 +0200 you wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This series introduces named IRQs while keeping the index based way
> for older dts.
> Further it makes some cleanup like adding consts for index access and
> avoids loading first IRQ which was not used on non SHARED_INT SoCs.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/4] net: ethernet: mtk_eth_soc: support named IRQs
    https://git.kernel.org/netdev/net-next/c/ee85b483fefb
  - [net-next,v6,2/4] net: ethernet: mtk_eth_soc: add consts for irq index
    https://git.kernel.org/netdev/net-next/c/498190100992
  - [net-next,v6,3/4] net: ethernet: mtk_eth_soc: skip first IRQ if not used
    https://git.kernel.org/netdev/net-next/c/9c0feca0a68b
  - [net-next,v6,4/4] net: ethernet: mtk_eth_soc: only use legacy mode on missing IRQ name
    https://git.kernel.org/netdev/net-next/c/070e98dd4e26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




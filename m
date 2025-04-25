Return-Path: <netdev+bounces-185792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5B0A9BBB9
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3557E1BA2123
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252AE10E9;
	Fri, 25 Apr 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpmvdOz3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E3A29;
	Fri, 25 Apr 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540398; cv=none; b=vFmtzdCGoqXHBQSnxH7qAUrD6fvoN9GQoPKRKzsEgaIkltptMMYBytAkyQBWSiNzYTZTTDXWN9tek7jGuXhZnnWxQcc3jXWGxumyCIhGxD7gFp54xREAaJ33cOdHosfR46GVNvpzcAm3dDdDrXVg+iW1Jbnaqtt94kPiA4AA6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540398; c=relaxed/simple;
	bh=mmlr8E+H2BDZ4gjGcxUcUsDxQyLSFFeNX6bcoSlckCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qT0BnpW1OXJegKnmgp+HYDQELql3GF6h8kVraOFP09Kk7biDzq68blUmSgNdCuTzsaqpo1vDqhuKLphG61T0Z7003c2yZSxM9VQVlmXZMpfwNQXTR79tV9k5A4U5EnVOHwsNSUL+Iqg/Apc+lxnZcOZYKvRVnAfx+ki56NRN69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpmvdOz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57518C4CEE3;
	Fri, 25 Apr 2025 00:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745540397;
	bh=mmlr8E+H2BDZ4gjGcxUcUsDxQyLSFFeNX6bcoSlckCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bpmvdOz3hpFfd9dFJJ+Cm04wvVLxiAHWnQTe6CBbj62VG4MWXjgDdslVkHee6hqzJ
	 8qOm2AqSkP2hrsHAxOEDGwjnO7Hg6bM3/d0qV/ujpi6HST1RpLlwa7wyZA8CnxN+wc
	 ns0Fhmma9AVyKsmovC89lWFoO8pUSpN43UkZGIXt1tM8Fi+lwAekX2VA9wKxjRTP0I
	 JINyV2k8lLHKrv7d26Djn8j1s8qZjKRFrMO44Hve/sLCLLC8PFVkoSpQJFqQUeQwk1
	 2zbodRONWWR19noqWVfzb1b/rV5Epf+5VIwuUx0VUY2h4T9c8AvF9y/BKmyS2uFN0s
	 VbekrryogvMLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA2380CFD9;
	Fri, 25 Apr 2025 00:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ethernet: mtk_eth_soc: convert cap_bit in
 mtk_eth_muxc struct to u64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174554043598.3528880.12217864359987980717.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 00:20:35 +0000
References: <ded98b0d716c3203017a7a92151516ec2bf1abee.1745369249.git.daniel@makrotopia.org>
In-Reply-To: <ded98b0d716c3203017a7a92151516ec2bf1abee.1745369249.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 01:48:02 +0100 you wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> With commit 51a4df60db5c2 ("net: ethernet: mtk_eth_soc: convert caps in
> mtk_soc_data struct to u64") the capabilities bitfield was converted to
> a 64-bit value, but a cap_bit in struct mtk_eth_muxc which is used to
> store a full bitfield (rather than the bit number, as the name would
> suggest) still holds only a 32-bit value.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ethernet: mtk_eth_soc: convert cap_bit in mtk_eth_muxc struct to u64
    https://git.kernel.org/netdev/net-next/c/ffb0c5c4cf66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




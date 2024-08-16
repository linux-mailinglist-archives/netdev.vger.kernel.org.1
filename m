Return-Path: <netdev+bounces-119276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3521955093
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799C5287D07
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4459F1C3F29;
	Fri, 16 Aug 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuP/0Xi6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7F1C233D;
	Fri, 16 Aug 2024 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831840; cv=none; b=GELYGXCbLG3xTYpNxfYpzIIlJzFeIjNebIMhZAmVLkkYas4dXvE8o2MnmOK4TFfXg9wt/RDmcM5Ty8yM/3gBPfXQrc8Zxl7oTyAbg9SidD/r5jVLaHmwTHazoEcBBdQtlmwc2EKVD+VEJOQhr/sNkoF042VbcKdsiFT/5vW5Yls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831840; c=relaxed/simple;
	bh=zVSWKO5JPnWSE1h3k2VU/7U4V5+RPNpKwGivKePi7Gc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h9ltSi4KYopm8MyDoYwolX+Dz2m9oV5Y3VZcXTjyFWoQmiptEgDXYhMo83mRcTJSLoyAkjYxxngXqIbH3QZZ4lTa93PrWC6qeWXq7FlZjWOAloKRoyOetJzuTiZuiGUJ+tpA71xthZTBlUkRGhGOBnoKEI5vTVVimYsEvN36skQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuP/0Xi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7118DC32782;
	Fri, 16 Aug 2024 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723831839;
	bh=zVSWKO5JPnWSE1h3k2VU/7U4V5+RPNpKwGivKePi7Gc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CuP/0Xi6vX4U6E6tp+w9+9Dg0wi6ahKiXoXN+o45b9ib6vZXa97dLrSTPjNR9IHsN
	 8fZdjWxa3ccMh/I7uSmwjQ3T6nC78E2ugltTVnj55GZX2CA7bPIzyOY+OmAl4ewEWm
	 07RwRlYmE7awiiG5VnYcYms7XNqEqbH7qNykSYzs73xwLLzKnqGNnFob7zSG4qtNMV
	 QUyaMVDe2q3seV93IkjZGISEbGmJkQUsRi9et+CRoTT+ZOWDz5LfN/sBI9tP7jkpLE
	 qB/BrQilacCpUcFlGlXI2syedHw+829WXhK1a5Zvcoh7IEFtVhsEIKVV/M2imxdAU2
	 F90rqy7cBNKow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1D938232A9;
	Fri, 16 Aug 2024 18:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] ipv6: Add
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172383183868.3593066.6873916327349164311.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 18:10:38 +0000
References: <20240813-ipv6_addr-helpers-v2-0-5c974f8cca3e@kernel.org>
In-Reply-To: <20240813-ipv6_addr-helpers-v2-0-5c974f8cca3e@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Aug 2024 14:33:46 +0100 you wrote:
> Hi,
> 
> This series adds and uses some new helpers,
> ipv6_addr_{cpu_to_be32,be32_to_cpu}, which are intended to assist in
> byte order manipulation of IPv6 addresses stored as as arrays.
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] ipv6: Add ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
    https://git.kernel.org/netdev/net-next/c/f40a455d01f8
  - [net-next,v2,2/3] net: ethernet: mtk_eth_soc: Use ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
    https://git.kernel.org/netdev/net-next/c/b908c722133e
  - [net-next,v2,3/3] net: hns3: Use ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
    https://git.kernel.org/netdev/net-next/c/c7be6e70d20c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




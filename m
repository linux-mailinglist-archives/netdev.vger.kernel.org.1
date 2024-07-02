Return-Path: <netdev+bounces-108496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB2F923F7B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B02B286214
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18621B4C5E;
	Tue,  2 Jul 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPM95ljN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666B38F83;
	Tue,  2 Jul 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928229; cv=none; b=FG1X0vA8DWiwIeCKLcqkKUuzOFmjnsz/gT3cqzlNXIBpfNJuWwV7xYqJmLq8NatLcPimlfQ9k2QuVwtrY1uOk0yuhY009UvR+9a6+1PaSsjaUMLSfsc124OU/fi+okhGX2R4n3d4gMdWHB08H/j7akL1OgNB5t+w22Mkzd8ADhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928229; c=relaxed/simple;
	bh=fbUnMj+W+KQMyuUsKadHUYxc1aaxyEkdq8ydp6tjVnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DQDU2QnB2QAdB6SJdEeElfLHXEpRxpO452VhEdEb/GiAieZ6MPL0Uy3kNFRW42wBsU3ZKGYGXG5ShpbChrTKUd2HTir+PU/FyYYmfZDvqRdDexZgxL/gF6OZRu5E+w2qCExadOre0BlZDgvEIVzBexWlOuN25HS040bRNRrWKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPM95ljN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F8BDC2BD10;
	Tue,  2 Jul 2024 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928229;
	bh=fbUnMj+W+KQMyuUsKadHUYxc1aaxyEkdq8ydp6tjVnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oPM95ljNuijlOVg8nG40F5xP4JJsGa6p43c02Lbe93XEu1UtYWu2xPA9kzSiT6HM7
	 pyW6BwM1lzAyd3yiG7uqc1mEmme6sUbWPpawi7oWcmY9SCdyhXyQraLxbnvYIkEdPA
	 GBw9pJXYNhmcXppAQXWmWaMOsReUrZgE7OEKC3AdSRLItvAI+DL7kksV/RbYh0UTUn
	 omV62BoS2jb7cE6saoaXrgB5OGCSIevNAFedTDfXB4Y5zktrGufmjwMQQB1R0pB408
	 +B8drJYG4wjpxd9XDD9npRld5iAneVn2GXXefI9tPbtZz7WxGDOr6imDj3NWla3iGL
	 /5XkES7RhzwiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1809C43331;
	Tue,  2 Jul 2024 13:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH v2 0/2] Fixes for stm32-dwmac driver fails to probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171992822898.3744.15499171958760914768.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 13:50:28 +0000
References: <20240701064838.425521-1-christophe.roullier@foss.st.com>
In-Reply-To: <20240701064838.425521-1-christophe.roullier@foss.st.com>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, joabreu@synopsys.com, lgirdwood@gmail.com,
 broonie@kernel.org, marex@denx.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 1 Jul 2024 08:48:36 +0200 you wrote:
> Mark Brown found issue during stm32-dwmac probe:
> 
> For the past few days networking has been broken on the Avenger 96, a
> stm32mp157a based platform.  The stm32-dwmac driver fails to probe:
> 
> <6>[    1.894271] stm32-dwmac 5800a000.ethernet: IRQ eth_wake_irq not found
> <6>[    1.899694] stm32-dwmac 5800a000.ethernet: IRQ eth_lpi not found
> <6>[    1.905849] stm32-dwmac 5800a000.ethernet: IRQ sfty not found
> <3>[    1.912304] stm32-dwmac 5800a000.ethernet: Unable to parse OF data
> <3>[    1.918393] stm32-dwmac 5800a000.ethernet: probe with driver stm32-dwmac failed with error -75
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: dwmac-stm32: Add test to verify if ETHCK is used before checking clk rate
    https://git.kernel.org/netdev/net-next/c/3cd1d4651ceb
  - [net-next,v2,2/2] net: stmmac: dwmac-stm32: update err status in case different of stm32mp13
    https://git.kernel.org/netdev/net-next/c/f8dbe58e2f1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




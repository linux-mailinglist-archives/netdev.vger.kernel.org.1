Return-Path: <netdev+bounces-232751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E677C088B7
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBBB1C21062
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23EE259CA9;
	Sat, 25 Oct 2025 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU/IWdhw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74492580E1;
	Sat, 25 Oct 2025 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358262; cv=none; b=m3vkwEBPhk4p6DR+jziBgFt7ZqZG2dmHrP62RO80O5GDGgix0kOkZReAdxHgo4aVBqUPpXdQXSAOkqZRTp69KmlswkvwRK0u8qpsSKlXy29JiwSIVW0/YulZLwFQRQd1mfikFczFfkBVxi5XyPuPusJ2OT/5RDWNBT4Rhgm9zds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358262; c=relaxed/simple;
	bh=EJ/Aqtc+3CNTqVJNJQJ98eezwGN+8vLTVQDAuZan1Yw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OcM5POxvafJ2vTZI5IuUEfnYiQZrSvjSMmnhHlXflpS4g5/yUqbTj3GjlH4xbPQp2zj67otFIXYQ+Muge8CeeN5HB0s5J+T+H8Yl6gnI+RlyV3Y/jbI3763MoZeo58suEM/wd4EUE29rUQ9NcIuue6rjRgf0deCVGugXYWswfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU/IWdhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFCEC4CEF1;
	Sat, 25 Oct 2025 02:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761358262;
	bh=EJ/Aqtc+3CNTqVJNJQJ98eezwGN+8vLTVQDAuZan1Yw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sU/IWdhwzB32/JIa1gMSB5YRGpBBP4f3dotAQoI/K9H1vQpCO5ij3NwrUtuOmipxX
	 +HsxEGNAATmwzhEb7rUeqkVyXqZOEGRg+iQIZchXWkzATZdmPFtNvWRshd5A1Mnwsn
	 6dyLrmK9ZX7/mpIGwAeQS4J+TX32TDEuNsIDz26zvS8kIVk/iJchyWVbKNBPRRdSz8
	 A2IMLYCMhdnuPCaIJxdzxRfn/3cpngKsH88zV99UhwN1srxF0W/Qo7exoLDEsiFOOu
	 oWh7auGWXNMTbgS4ZytjLWPQYUfCsfXmG16OccgXompon9CF5JEs89280v2FRXWVo9
	 Yy9V/SkexXZwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE8380AA59;
	Sat, 25 Oct 2025 02:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] DWMAC support for Rockchip RK3506
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135824149.4124588.13375979090680382599.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 02:10:41 +0000
References: <20251023111213.298860-1-heiko@sntech.de>
In-Reply-To: <20251023111213.298860-1-heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, jonas@kwiboo.se

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 13:12:07 +0200 you wrote:
> Some cleanups to the DT binding for Rockchip variants of the dwmac
> and adding the RK3506 support on top.
> 
> As well as the driver-glue needed for setting up the correct RMII
> speed seitings.
> 
> changes in v2:
> - add Conor's Acks to dt-bindings
> - add Andrew's Reviews to first 3 patches
>   I didn't add the driver Review, as I did address Jonas' comments
> - adapt to Jonas' comments in the driver
> - add a patch for a MAINTAINERS entry (Jakub)
> 
> [...]

Here is the summary with links:
  - [v2,1/5] dt-bindings: net: snps,dwmac: move rk3399 line to its correct position
    https://git.kernel.org/netdev/net-next/c/32dd679b88d5
  - [v2,2/5] dt-bindings: net: snps,dwmac: Sync list of Rockchip compatibles
    https://git.kernel.org/netdev/net-next/c/e774c91dca45
  - [v2,3/5] dt-bindings: net: rockchip-dwmac: Add compatible string for RK3506
    https://git.kernel.org/netdev/net-next/c/4a667bec74b3
  - [v2,4/5] ethernet: stmmac: dwmac-rk: Add RK3506 GMAC support
    https://git.kernel.org/netdev/net-next/c/2010163a8ea4
  - [v2,5/5] MAINTAINERS: add dwmac-rk glue driver to the main Rockchip entry
    https://git.kernel.org/netdev/net-next/c/384d84263295

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




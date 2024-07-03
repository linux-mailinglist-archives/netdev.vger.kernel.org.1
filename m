Return-Path: <netdev+bounces-108771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735D92553B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58516283B32
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEDF13A24A;
	Wed,  3 Jul 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjfaniJ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BB136994;
	Wed,  3 Jul 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994830; cv=none; b=q3iNGSmhv188BW3RzDwrjb1Ey9CuCO4H4O3HPQCIhvkL5IjxP3Y5uwm61rtpdaV5QKnSkTjvU7QXXj88ELlqhwSBqr5oWMWRMjNpNbgmwHgLJ2HpanfS/cNe+BOlgNk/GyrBLbPF1tKFEiB3fdoEmxQEleOyePwGj5n9Vhh+rX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994830; c=relaxed/simple;
	bh=OYdYcPe2Zdp9kYpLNbfwbNFJOwEuDDiyscRtThzVsLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qa8JVHgqY3s0WirtBSGpq5z9j/4OKBXXMErc29HDQdgKXBYwAoV1J9q42b6m1UfGl1amGPDaOPixhkgAdKSbhKCiiNj72AUhoBY+gWAuXMPW4RnSYH4P+G8xsVw7hgy4KV2V5PX7AWoE1M9ROJqZU7DcaD8NOWmGU5xrf+r7r5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjfaniJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CAE6C4AF0E;
	Wed,  3 Jul 2024 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719994830;
	bh=OYdYcPe2Zdp9kYpLNbfwbNFJOwEuDDiyscRtThzVsLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZjfaniJ3gy1cGkqz5SG6k5qocQAGwbrgKLOXNy11h1RtTQw4DaiIkHcp2hbmYzwV0
	 XIrXCt7t54+5UozpdYMnVnJRHgYjX0IbTK7nEU947l3gVBSpi2IIIc63k0WQQogExx
	 6XQs43vVB1Z+yPvIsbyEMhcEWWelkF7dUJ0nwXLmejo6A+CCGLzGbwgfd6mJ+sOv8M
	 Dj6ha0Jo/OrV6GkVvpo56qmLxKfY5YkGXARo3Khhl71UWIvnsNk+mYjaby3hrkHa6r
	 KOMSJCXkUzDsYBFEzYdjnrs46108vMM0gaerCkgnU65rFR53hje3hYzJ1B4oHB6mO6
	 IEpxPzyVe2/yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3147FC43446;
	Wed,  3 Jul 2024 08:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/3] net: dsa: microchip: lan9371/2: add 100BaseTX
 PHY support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171999483019.7447.10721989007829003930.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 08:20:30 +0000
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
In-Reply-To: <20240701085343.3042567-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 l.stach@pengutronix.de, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  1 Jul 2024 10:53:41 +0200 you wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> On the LAN9371 and LAN9372, the 4th internal PHY is a 100BaseTX PHY
> instead of a 100BaseT1 PHY. The 100BaseTX PHYs have a different base
> register offset.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: dsa: microchip: lan9371/2: add 100BaseTX PHY support
    https://git.kernel.org/netdev/net-next/c/8d7330b3a9c6
  - [net-next,v2,2/3] net: dsa: microchip: lan937x: disable in-band status support for RGMII interfaces
    https://git.kernel.org/netdev/net-next/c/c3db39468a42
  - [net-next,v2,3/3] net: dsa: microchip: lan937x: disable VPHY support
    https://git.kernel.org/netdev/net-next/c/2e3ed20c17e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <netdev+bounces-226829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE1BA578E
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190B8175EF2
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA821E7C12;
	Sat, 27 Sep 2025 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0WWEEyy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB11DDC2B;
	Sat, 27 Sep 2025 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935417; cv=none; b=jzuhtmWSG/ASznnsg9CnSYfQbY1WJ+MmYBoFe8ka/T2TOD36hg+lLMC01GOn9K0sU1cDCMB+kAosHV+wujcM9vju4vVr1z3r+N8C60mYAC4If7Y5NQDXIusg4qiz2blVwUXNULLfASDAiFFlXqhWg5LvYjHiOCfklZypGc4kmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935417; c=relaxed/simple;
	bh=0J0tV4CB+tQRTTAMsLsdana1I3o4U8r+DAWbuwPSW7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UTfazDFAoK3N4NvyH7002kqtGr/qhF22lXRBkxznfnk88/AV4lArr14aVY0TwOFs3WjSXB2GhTmkuvCQarxqEPkntykNAU3yt3ffrb4MeZHG2eGye9YGRwW3A/AeuNfgOxcxxzEhVBx4Pb+hvsIr451YHGp0ElYUsbSLBsn8Lvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0WWEEyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1207C4CEF4;
	Sat, 27 Sep 2025 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758935416;
	bh=0J0tV4CB+tQRTTAMsLsdana1I3o4U8r+DAWbuwPSW7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S0WWEEyyM7fUe7u/3nXHswvJ1hyBatIjGW0cnLYPkj8oJUyhkOdQ7PpWohBSc8Nst
	 GJ1AA0S4VSB0PpuaoBWrfrVdvRY1tF5DrMwRKGFu9AvtmWJ7LDMTYryub7lWitM4aO
	 +l2j3/5jdTuNqhFs+NDt5V6CAEdoJ85NzDWjfOPYhjdBypgDYFJ8LOVevOdd3PgnPC
	 V7x4CaU9E54+C5xtPHgS8a5hSLjJ59GTSJjRMgz+u8eAjQARjMuxHyGVIpXlAN1M7O
	 Ww4zf2kzW2qEi8WHUKbIbEVfyUkn7g+QO2QUmsOPCv09i9cjCLAYNjL6WTU+ws8lPe
	 xBn2PXBkrDX+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5B39D0C3F;
	Sat, 27 Sep 2025 01:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/5] net: macb: various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893541200.113130.9375181178984989682.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 01:10:12 +0000
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
In-Reply-To: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 geert@linux-m68k.org, harini.katakam@xilinx.com, richardcochran@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 tawfik.bayouk@mobileye.com, krzysztof.kozlowski@linaro.org,
 sean.anderson@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Sep 2025 18:00:22 +0200 you wrote:
> This would have been a RESEND if it wasn't for that oneline RCT fix.
> Rebased and tested on the latest net/main as well, still working fine
> on EyeQ5 hardware.
> 
> Fix a few disparate topics in MACB:
> 
> [PATCH net v6 1/5] dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
> [PATCH net v6 2/5] net: macb: remove illusion about TBQPH/RBQPH being per-queue
> [PATCH net v6 3/5] net: macb: move ring size computation to functions
> [PATCH net v6 4/5] net: macb: single dma_alloc_coherent() for DMA descriptors
> [PATCH net v6 5/5] net: macb: avoid dealing with endianness in macb_set_hwaddr()
> 
> [...]

Here is the summary with links:
  - [net,v6,1/5] dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
    https://git.kernel.org/netdev/net/c/9665aa15ef8b
  - [net,v6,2/5] net: macb: remove illusion about TBQPH/RBQPH being per-queue
    https://git.kernel.org/netdev/net/c/fca3dc859b20
  - [net,v6,3/5] net: macb: move ring size computation to functions
    https://git.kernel.org/netdev/net/c/92d4256fafd8
  - [net,v6,4/5] net: macb: single dma_alloc_coherent() for DMA descriptors
    https://git.kernel.org/netdev/net/c/78d901897b3c
  - [net,v6,5/5] net: macb: avoid dealing with endianness in macb_set_hwaddr()
    https://git.kernel.org/netdev/net/c/70a5ce8bc945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




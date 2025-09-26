Return-Path: <netdev+bounces-226809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BFFBA5503
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81331326CD2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD430CB35;
	Fri, 26 Sep 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKRrWxnV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F629D26C;
	Fri, 26 Sep 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925229; cv=none; b=kIDUxgHUr912Vw7RdmYHKQOWbbUKnPtUuvwnRO+hnTCmzTmIUxvjIBIfYEHOBsro2m95A11k5QgPtRoU3KvwqyZhsDDoVoq2rrNn/f/g+lRFQ560eSbgeW7VBryej6KiEc9ZbXhtma8GB+dkPpQaw0gaMLHgIQ1WS1z/FYKmo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925229; c=relaxed/simple;
	bh=Mn3UMaJfnruXtRtYCrhAg9D+oTiCU8m67M2/1hao6II=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HTzmriUPsEz+7T5+cnvDnyw4yfiP9oP3g3r5lXk6Sezx9vFYMEjS2WQYd5z1i/+MqeEnh7jP41KJ8YSeOpWe+Q5jRS64demQDGeavNSs8A+e6aSTJaSvL/8+CO6bLlCcmcR8ff+KYnrAI27QonuOukA0OiUq/O2AgA5/h4h6Jrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKRrWxnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCF1C4CEF7;
	Fri, 26 Sep 2025 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925229;
	bh=Mn3UMaJfnruXtRtYCrhAg9D+oTiCU8m67M2/1hao6II=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BKRrWxnVjbC9fVex2Q0QqOjaUUpQQZvcOO3sm32kWHQWuUS35HPoCEX/eNSRBoDaP
	 2PqDTLb3ZPVD/5ulHwbPb2ELHUPoF4YGigYibE+tTVWBXjvHTNz5aRkFbCbyRTBmvM
	 IhsXIQr0iEj6E5nCEM7uL9uRJ2L9u32HDgr4xz7gLBJVyuvpuxfOnXw+uaQ797Ef/m
	 ogWWIfVzbDMzUmuY8PVllaGFgt1VBWJlPR9RqYeT3t411LpXUmydMmQ4DuHk7vcL+m
	 bppaMUvfPn2CArUCuGjaMZTzXC73NG6s46oJ3U0pdpD+gYgGGexg5lmMA+RWpHPUWV
	 vhfQvpvRDFcKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDFE39D0C3F;
	Fri, 26 Sep 2025 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Mainline Protonic PRT8ML board
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892522449.77570.18183487624787267544.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:20:24 +0000
References: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
In-Reply-To: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, shengjiu.wang@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Frank.Li@nxp.com,
 david@protonic.nl, l.stach@pengutronix.de, o.rempel@pengutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 10:34:11 +0200 you wrote:
> This series adds the Protonic PRT8ML device tree as well as some minor
> corrections to the devicetree bindings used.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
> Changes in v3:
> - Add comment on the intentional limitation to 100Mbps RGMII
> - Link to v2: https://lore.kernel.org/r/20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de
> 
> [...]

Here is the summary with links:
  - [v3,1/3] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios property
    https://git.kernel.org/netdev/net-next/c/8d5868f8c1b2
  - [v3,2/3] dt-bindings: arm: fsl: Add Protonic PRT8ML
    (no matching commit)
  - [v3,3/3] arm64: dts: add Protonic PRT8ML board
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




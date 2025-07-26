Return-Path: <netdev+bounces-210248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD2B127C5
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400B53ADE84
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D21262FC5;
	Fri, 25 Jul 2025 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jesXExFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743E2620E4;
	Fri, 25 Jul 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487997; cv=none; b=RMo2Bcxmc8ZXqirtcPRBHjbcP0IfahjsyV5VoP2CWA900yXfUyt1vtHJhJFcCFAcSWFrH+ZBqgb8G056e7CrZo582IxXZbqM7JUk8YPgLes1jbQqm2XoJGNnIx36XWbtKx7yUgu1UiOfHQ7o4EnAb7xnrV/orPaiMSMA1p08k40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487997; c=relaxed/simple;
	bh=aWagL43nzO3VnFNpASht2nxBuHJFMqurTi8Xfa3eL1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sZTYBk0pW6mZfpqMSIUrtOeYOS/7Ee7y+QNR++yaFPZJhE304TRgDbiYgmuPzDwqiw8NhX5lL0CqRjbLmE2Wp3nIjJl+AySXII1TAwwq3zLvl93NM9V/csTUu3i5EyQbjTiTZkV9FvF6WaML+5ZglG3tniv6o2vxALPC1ezfSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jesXExFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D3EC4CEE7;
	Fri, 25 Jul 2025 23:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753487997;
	bh=aWagL43nzO3VnFNpASht2nxBuHJFMqurTi8Xfa3eL1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jesXExFDdeul9WCN5G39/ib4nkocPTDnI/yeEIpfsW8Lz+DJykYp2TOdeGmRjGptT
	 x92BA46355IUA7dRi7Y8UMlSR36Pf2O0t1buP5Z9ZSRIea6lJu0LxYw0y8Tf4UDLEW
	 FGMqBmM0WEu4R5RARdWHsW/B0kg9E1MxNu90rJ5XI4jFgmQWfCh3A+DSuwAizPP3zx
	 tERKyuOmyQT6oOGb3dUneQaDjnjTWs7//Dmak4RGSTX3OGcV3PlqVreruRpxinVTrb
	 okRPYR1MXiNUH18pMY5ZuKYOak2sSkk0apz9PeRdBXCCph5YfZlOE1Qy01gsYFRcUx
	 +EhKf9EJ/C2jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC74383BF4E;
	Sat, 26 Jul 2025 00:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] arm64: dts: socfpga: enable ethernet support for
 Agilex5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348801475.3451765.4389353168084644772.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 00:00:14 +0000
References: <20250724154052.205706-1-matthew.gerlach@altera.com>
In-Reply-To: <20250724154052.205706-1-matthew.gerlach@altera.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 dinguyen@kernel.org, maxime.chevallier@bootlin.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 08:40:47 -0700 you wrote:
> This patch set enables ethernet support for the Agilex5 family of SOCFPGAs,
> and specifically enables gmac2 on the Agilex5 SOCFPGA Premium Development
> Kit.
> 
> Patch 1 defines Agilex5 compatibility string in the device tree bindings.
> 
> Patch 2 defines the base gmac nodes it the Agilex5 DTSI.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] dt-bindings: net: altr,socfpga-stmmac: Add compatible string for Agilex5
    https://git.kernel.org/netdev/net-next/c/92068a32f978
  - [v2,2/4] arm64: dts: Agilex5 Add gmac nodes to DTSI for Agilex5
    (no matching commit)
  - [v2,3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the Agilex5 dev kit
    (no matching commit)
  - [v2,4/4] net: stmmac: dwmac-socfpga: Add xgmac support for Agilex5
    https://git.kernel.org/netdev/net-next/c/a5e290aab8fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



